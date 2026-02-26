class OrganiBotResponseModel {
  final List<OrganiBotCandidate> candidates;

  OrganiBotResponseModel({required this.candidates});

  factory OrganiBotResponseModel.fromJson(Map<String, dynamic> json) {
    final rawCandidates = json['candidates'] ?? json['responses'] ?? [];
    if (rawCandidates is! List) return OrganiBotResponseModel(candidates: []);

    return OrganiBotResponseModel(
      candidates: rawCandidates
          .map((e) {
            if (e is! Map<String, dynamic>) return null;
            return OrganiBotCandidate.fromJson(e);
          })
          .whereType<OrganiBotCandidate>()
          .toList(),
    );
  }

  String get firstText {
    for (var candidate in candidates) {
      final text = candidate.fullText;
      if (text.isNotEmpty) return text;

      // Fallback if content.parts is empty, check direct content.text
      final directText = candidate.directText;
      if (directText.isNotEmpty) return directText;
    }
    return 'No response from API';
  }
}

class OrganiBotCandidate {
  final OrganiBotContent content;
  final String? finishReason;
  final String? rawText; // fallback if content.parts is empty

  OrganiBotCandidate({required this.content, this.finishReason, this.rawText});

  factory OrganiBotCandidate.fromJson(Map<String, dynamic> json) {
    // If content.parts exists, use it
    final contentJson = json['content'] ?? {};
    final content = OrganiBotContent.fromJson(contentJson);

    // If parts are empty, check for text directly
    String? fallbackText;
    if (content.parts.isEmpty) {
      fallbackText = json['content']?['text'] as String? ?? json['text'] as String?;
    }

    return OrganiBotCandidate(
      content: content,
      finishReason: json['finishReason'] as String?,
      rawText: fallbackText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.toJson(),
      'finishReason': finishReason,
      'rawText': rawText,
    };
  }

  String get fullText => content.fullText;

  String get directText => rawText ?? '';
}

class OrganiBotContent {
  final List<OrganiBotPart> parts;

  OrganiBotContent({required this.parts});

  factory OrganiBotContent.fromJson(Map<String, dynamic> json) {
    final partsList = json['parts'] as List<dynamic>? ?? [];
    return OrganiBotContent(
      parts: partsList
          .map((e) => e is Map<String, dynamic> ? OrganiBotPart.fromJson(e) : null)
          .whereType<OrganiBotPart>()
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'parts': parts.map((e) => e.toJson()).toList()};
  }

  String get fullText => parts.map((e) => e.text ?? '').join();
}

class OrganiBotPart {
  final String? text;
  OrganiBotPart({this.text});
  factory OrganiBotPart.fromJson(Map<String, dynamic> json) {
    return OrganiBotPart(text: json['text'] as String?);
  }
  Map<String, dynamic> toJson() => {'text': text};
}