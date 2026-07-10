// ============================================================
// Zawiyah — AI Abstraction Layer
// lib/core/ai/ai_provider.dart
//
// Nothing else in the app talks to Claude (or any AI provider)
// directly -- every call goes through this interface. This is
// deliberately an INTERNAL seam inside Zawiyah's own codebase, not
// a literal cross-project "WorldMind SDK" package -- building a real
// shared SDK today would mean designing a public API with zero second
// consumer to validate it against (MotoMind doesn't currently share
// this code). If/when a second WorldMind app genuinely needs the same
// abstraction, THIS is the interface to extract into a real shared
// package -- the seam is already in the right shape for that, it's
// just not prematurely packaged.
//
// STRICT SCOPE, per the Constitution (Article VII) and the Zawiyah
// Technical Build Specification: this interface may only ever be used
// for explain / translate / summarise / cross-reference / organise /
// personalise-navigation. It must NEVER be used to generate canonical
// sacred text, invent hadith, issue fatwas, or replace scholarly
// judgement -- callers are responsible for only invoking this for
// permitted operations; see AiContribution for the labeled categories
// this maps to in the Provenance model.
// ============================================================

/// The category of AI contribution being requested, matching the
/// "AI Contribution" layer of the Provenance model (Constitution
/// Article VIII, Zawiyah Provenance design decision). Every AI call
/// in the app must be tagged with one of these so the UI can always
/// show the user what the AI actually did.
enum AiContributionType {
  translation,
  summary,
  crossReference,
  organisation,
}

/// A single request to the AI abstraction layer. `sourceContent` should
/// always be authenticated source material already retrieved from the
/// Sacred Content Layer / Knowledge Layer -- this interface is for
/// explaining/organising EXISTING authenticated content, never for
/// generating new religious content from a bare prompt.
class AiRequest {
  final AiContributionType contributionType;
  final String sourceContent;
  final String instruction;
  final String targetLanguageCode; // e.g. 'en', 'ur', 'ar'

  const AiRequest({
    required this.contributionType,
    required this.sourceContent,
    required this.instruction,
    required this.targetLanguageCode,
  });
}

/// The AI's response, always paired with the contribution type so the
/// UI can render it inside the correct Provenance label rather than
/// as unlabelled text.
class AiResponse {
  final AiContributionType contributionType;
  final String content;
  final DateTime generatedAt;

  const AiResponse({
    required this.contributionType,
    required this.content,
    required this.generatedAt,
  });
}

/// The abstraction itself. `ClaudeAiProvider` (ai_provider_claude.dart)
/// is the only implementation for now; future providers (ChatGPT,
/// Gemini, local models) would implement this same interface, letting
/// the rest of the app remain provider-agnostic.
abstract class AiProvider {
  Future<AiResponse> request(AiRequest request);
}
