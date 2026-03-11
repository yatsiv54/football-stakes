

enum OutcomeType { home, draw, away }
enum PickStatus { wait, win, lose }

class PickEntity {
  final String id; 
  final String matchId;
  final double stake;
  final OutcomeType outcomeType;
  final String? note;
  final int confidence;
  final bool remind;
  final DateTime whenComplete;
  final PickStatus status;
  final double odd;

  PickEntity({
    required this.id, 
    required this.matchId,
    required this.stake,
    required this.outcomeType,
    this.note,
    required this.confidence,
    required this.remind,
    required this.whenComplete,
    required this.status,
    required this.odd,
  });

  PickEntity copyWith({
    String? id, 
    String? matchId,
    double? stake,
    OutcomeType? outcomeType,
    String? note,
    int? confidence,
    bool? remind,
    DateTime? whenComplete,
    PickStatus? status,
    double? odd,
  }) {
    return PickEntity(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      stake: stake ?? this.stake,
      outcomeType: outcomeType ?? this.outcomeType,
      note: note ?? this.note,
      confidence: confidence ?? this.confidence,
      remind: remind ?? this.remind,
      whenComplete: whenComplete ?? this.whenComplete,
      status: status ?? this.status,
      odd: odd ?? this.odd,
    );
  }
  
  factory PickEntity.fromJson(Map<String, dynamic> json) {
    return PickEntity(
      
      
      id: json['id'] ?? '${json['matchId']}_${json['outcomeType']}_${json['stake']}', 
      
      matchId: json['matchId'],
      stake: (json['stake'] as num).toDouble(),
      outcomeType: OutcomeType.values[json['outcomeType']],
      note: json['note'],
      confidence: json['confidence'],
      remind: json['remind'],
      whenComplete: DateTime.parse(json['whenComplete']),
      status: PickStatus.values[json['status']],
      odd: (json['odd'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'matchId': matchId,
      'stake': stake,
      'outcomeType': outcomeType.index, 
      'note': note,
      'confidence': confidence,
      'remind': remind,
      'whenComplete': whenComplete.toIso8601String(), 
      'status': status.index, 
      'odd': odd,
    };
  }
}