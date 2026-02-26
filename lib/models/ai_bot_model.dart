class OrganiBotResponseModel {
  final List<OrganiBotCandidate> candidates;

  OrganiBotResponseModel({required this.candidates});

  factory OrganiBotResponseModel.fromJson(Map<String, dynamic> json) {
    return OrganiBotResponseModel(
      candidates: (json['candidates'] as List<dynamic>?)
              ?.map((e) => OrganiBotCandidate.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidates': candidates.map((e) => e.toJson()).toList(),
    };
  }

  /// Helper to get first response text directly
  String get firstText =>
      candidates.isNotEmpty ? candidates.first.content.fullText : '';
}

class OrganiBotCandidate {
  final OrganiBotContent content;
  final String? finishReason;

  OrganiBotCandidate({
    required this.content,
    this.finishReason,
  });

  factory OrganiBotCandidate.fromJson(Map<String, dynamic> json) {
    return OrganiBotCandidate(
      content: OrganiBotContent.fromJson(json['content'] ?? {}),
      finishReason: json['finishReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.toJson(),
      'finishReason': finishReason,
    };
  }
}

class OrganiBotContent {
  final List<OrganiBotPart> parts;

  OrganiBotContent({required this.parts});

  factory OrganiBotContent.fromJson(Map<String, dynamic> json) {
    return OrganiBotContent(
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => OrganiBotPart.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parts': parts.map((e) => e.toJson()).toList(),
    };
  }

  /// Combine all parts text
  String get fullText =>
      parts.map((e) => e.text ?? '').join();
}

class OrganiBotPart {
  final String? text;

  OrganiBotPart({this.text});

  factory OrganiBotPart.fromJson(Map<String, dynamic> json) {
    return OrganiBotPart(
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}