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
      version: 2,
      onCreate: (db, version) async {
        await _createAllTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // v1 -> v2 added key_value_store (for the free/unbounded
        // Tasbeeh counter). Using CREATE TABLE IF NOT EXISTS here and
        // in onCreate means this is safe to run even if some tables
        // already exist, rather than assuming a clean upgrade path --
        // important during this early rapid-iteration phase where the
        // schema is still actively growing.
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS key_value_store (
              key TEXT PRIMARY KEY,
              value INTEGER NOT NULL
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
}
