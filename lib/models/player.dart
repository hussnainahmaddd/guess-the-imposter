class Player {
  final String id;
  String name;
  bool isImposter;
  String? assignedQuestion;
  String? avatarPath;

  Player({
    required this.id,
    required this.name,
    this.isImposter = false,
    this.assignedQuestion,
    this.avatarPath,
  });
}
