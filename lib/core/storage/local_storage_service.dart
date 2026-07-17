// ============================================================
// Zawiyah — Local Storage Service (Offline Architecture foundation)
// lib/core/storage/local_storage_service.dart
//
// ENCRYPTION SCOPE DECISION: only USER-GENERATED data is encrypted at
// rest -- personal Collections, counter progress, any future notes.
// The Sacred Content Layer (Qur'an, Mafatih, Nahjul Balagha, etc.) is
// public-domain religious text with no confidentiality requirement,
// so it is NOT encrypted -- doing so would add overhead for no privacy
// benefit. This service is therefore for USER DATA ONLY; the Sacred
// Content Layer gets its own separate, unencrypted local
// store/asset-based system (not built yet -- comes with the Download
// System / Source Library feature work).
//
// Uses sqflite for structured user data (counter progress per item,
// Collections metadata) and flutter_secure_storage only for anything
// that genuinely needs OS-level encryption (currently nothing meets
// that bar, but the seam exists for e.g. a future account/sync
// credential).
// ============================================================

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'zawiyah_user_data.db');
    return openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await _createAllTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS key_value_store (
              key TEXT PRIMARY KEY,
              value INTEGER NOT NULL
            )
          ''');
        }
        if (oldVersion < 3) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS string_kv_store (
              key TEXT PRIMARY KEY,
              value TEXT NOT NULL
            )
          ''');
        }
      },
    );
  }

  Future<void> _createAllTables(Database db) async {
        // Counter progress -- one row per counter ID (e.g.
        // "fatima_lanat_100"), persisting current tap count. Content
        // IDs reference the (separate, unencrypted) Sacred Content
        // Layer -- never the content itself.
        await db.execute('''
          CREATE TABLE IF NOT EXISTS counter_progress (
            content_id TEXT PRIMARY KEY,
            current_count INTEGER NOT NULL DEFAULT 0,
            max_count INTEGER NOT NULL,
            last_updated TEXT NOT NULL
          )
        ''');

        // Personal Collections -- user-created worship routines,
        // referencing stable content IDs (not duplicating content),
        // per the Offline Content Architecture decision.
        await db.execute('''
          CREATE TABLE IF NOT EXISTS collections (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            created_at TEXT NOT NULL,
            is_shared_anonymously INTEGER NOT NULL DEFAULT 0
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS collection_items (
            collection_id TEXT NOT NULL,
            content_id TEXT NOT NULL,
            sort_order INTEGER NOT NULL,
            FOREIGN KEY (collection_id) REFERENCES collections (id)
          )
        ''');

        // Simple key-value store -- currently only used for the free/
        // unbounded Tasbeeh counter, which (unlike structured A'mal
        // counters) has no max_count to cap it, so it doesn't fit the
        // counter_progress table's schema.
        await db.execute('''
          CREATE TABLE IF NOT EXISTS key_value_store (
            key TEXT PRIMARY KEY,
            value INTEGER NOT NULL
          )
        ''');

        // Separate string-valued store for settings like selected
        // role, onboarding completion, notification category toggles
        // (stored as '1'/'0' strings for simplicity alongside role
        // name strings) -- kept distinct from key_value_store since
        // that table's value column is INTEGER-typed.
        await db.execute('''
          CREATE TABLE IF NOT EXISTS string_kv_store (
            key TEXT PRIMARY KEY,
            value TEXT NOT NULL
          )
        ''');
  }

  Future<int> getCounterProgress(String contentId) async {
    final db = await database;
    final rows = await db.query(
      'counter_progress',
      where: 'content_id = ?',
      whereArgs: [contentId],
    );
    if (rows.isEmpty) return 0;
    return rows.first['current_count'] as int;
  }

  Future<void> setCounterProgress({
    required String contentId,
    required int currentCount,
    required int maxCount,
  }) async {
    final db = await database;
    await db.insert(
      'counter_progress',
      {
        'content_id': contentId,
        'current_count': currentCount,
        'max_count': maxCount,
        'last_updated': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Resets every counter's progress to zero -- used by the "Reset
  /// counters" toolbar button. Rather than deleting rows, this sets
  /// current_count to 0 in place so max_count history is preserved.
  Future<void> resetAllCounters() async {
    final db = await database;
    await db.update(
      'counter_progress',
      {
        'current_count': 0,
        'last_updated': DateTime.now().toIso8601String(),
      },
    );
  }

  // ── Free/unbounded counter (Tasbeeh quick counter) ──────────

  Future<int> getFreeCounter() async {
    final db = await database;
    final rows = await db.query(
      'key_value_store',
      where: 'key = ?',
      whereArgs: ['free_tasbeeh_counter'],
    );
    if (rows.isEmpty) return 0;
    return rows.first['value'] as int;
  }

  Future<void> setFreeCounter(int value) async {
    final db = await database;
    await db.insert(
      'key_value_store',
      {'key': 'free_tasbeeh_counter', 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ── Hijri date manual adjustment ─────────────────────────────
  // Moon-sighting varies by region/method/marja' -- the calculated
  // Hijri date won't always match local observance, so users can
  // nudge it by a day in either direction.

  Future<int> getHijriDayOffset() async {
    final db = await database;
    final rows = await db.query('key_value_store',
        where: 'key = ?', whereArgs: ['hijri_day_offset']);
    if (rows.isEmpty) return 0;
    return rows.first['value'] as int;
  }

  Future<void> setHijriDayOffset(int offset) async {
    final db = await database;
    await db.insert(
      'key_value_store',
      {'key': 'hijri_day_offset', 'value': offset},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ── Collections ──────────────────────────────────────────

  Future<void> createCollection(String id, String title) async {
    final db = await database;
    await db.insert(
      'collections',
      {
        'id': id,
        'title': title,
        'created_at': DateTime.now().toIso8601String(),
        'is_shared_anonymously': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, Object?>>> listCollectionRows() async {
    final db = await database;
    return db.query('collections', orderBy: 'created_at DESC');
  }

  Future<List<String>> getCollectionContentIds(String collectionId) async {
    final db = await database;
    final rows = await db.query(
      'collection_items',
      where: 'collection_id = ?',
      whereArgs: [collectionId],
      orderBy: 'sort_order ASC',
    );
    return rows.map((r) => r['content_id'] as String).toList();
  }

  Future<void> addContentToCollection({
    required String collectionId,
    required String contentId,
  }) async {
    final db = await database;
    final existing = await getCollectionContentIds(collectionId);
    if (existing.contains(contentId)) return; // avoid duplicates
    await db.insert('collection_items', {
      'collection_id': collectionId,
      'content_id': contentId,
      'sort_order': existing.length,
    });
  }

  Future<void> removeContentFromCollection({
    required String collectionId,
    required String contentId,
  }) async {
    final db = await database;
    await db.delete(
      'collection_items',
      where: 'collection_id = ? AND content_id = ?',
      whereArgs: [collectionId, contentId],
    );
  }

  Future<void> deleteCollection(String collectionId) async {
    final db = await database;
    await db.delete('collection_items',
        where: 'collection_id = ?', whereArgs: [collectionId]);
    await db.delete('collections', where: 'id = ?', whereArgs: [collectionId]);
  }

  // ── String settings (onboarding, role, notification toggles) ──

  Future<String?> getString(String key) async {
    final db = await database;
    final rows = await db.query('string_kv_store',
        where: 'key = ?', whereArgs: [key]);
    if (rows.isEmpty) return null;
    return rows.first['value'] as String;
  }

  Future<void> setString(String key, String value) async {
    final db = await database;
    await db.insert(
      'string_kv_store',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
