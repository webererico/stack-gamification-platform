class Squad {
  final String id;
  final String name;
  final String stack;
  final int memberCount;

  const Squad({
    required this.id,
    required this.name,
    required this.stack,
    this.memberCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'stack': stack, 'memberCount': memberCount};
  }

  factory Squad.fromMap(String id, Map<String, dynamic> map) {
    return Squad(
      id: id,
      name: map['name'] as String? ?? '',
      stack: map['stack'] as String? ?? '',
      memberCount: (map['memberCount'] as num?)?.toInt() ?? 0,
    );
  }
}
