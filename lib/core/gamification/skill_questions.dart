/// How a skill self-rating (0-10) is derived: instead of a free slider, the
/// developer answers a fixed set of key questions about that skill. Marking
/// "Não sei" never scores — only a confident "Sim" counts, same as an
/// explicit "Não". A bonus criterion rewards real-world reps: having
/// shipped more than [SkillAssessment.projectsThreshold] projects with the
/// skill is required to reach the top of the scale.
library;

enum SkillAnswer { yes, no, unknown }

extension SkillAnswerX on SkillAnswer {
  String get label => switch (this) {
    SkillAnswer.yes => 'Sim',
    SkillAnswer.no => 'Não',
    SkillAnswer.unknown => 'Não sei',
  };

  static SkillAnswer fromName(String? name) {
    return SkillAnswer.values.firstWhere(
      (a) => a.name == name,
      orElse: () => SkillAnswer.unknown,
    );
  }
}

class SkillQuestion {
  final String id;
  final String Function(String skillName) prompt;
  const SkillQuestion({required this.id, required this.prompt});
}

abstract class SkillAssessment {
  static const List<SkillQuestion> questions = [
    SkillQuestion(id: 'aplicou_producao', prompt: _appliedInProduction),
    SkillQuestion(id: 'entende_funcionamento', prompt: _understandsInternals),
    SkillQuestion(id: 'ensinaria', prompt: _wouldTeachSomeoneElse),
    SkillQuestion(id: 'resolveu_problema_complexo', prompt: _solvedHardProblem),
  ];

  /// More than this many projects earns the extra "reps" point.
  static const int projectsThreshold = 3;

  static int get totalCriteria => questions.length + 1;

  static String _appliedInProduction(String skill) =>
      'Você já aplicou "$skill" em um projeto real (produção)?';

  static String _understandsInternals(String skill) =>
      'Você entende como "$skill" funciona por trás dos panos — não só '
      'como usar?';

  static String _wouldTeachSomeoneElse(String skill) =>
      'Você se sentiria confortável ensinando "$skill" para outra pessoa '
      'do time?';

  static String _solvedHardProblem(String skill) =>
      'Você já resolveu um problema complexo ou debugou algo difícil '
      'envolvendo "$skill"?';

  static String projectsQuestion(String skill) =>
      'Em quantos projetos você já trabalhou desenvolvendo ou usando '
      '"$skill"?';

  /// Turns yes/no/unknown answers plus a project count into a 0-10 rating.
  /// Only "Sim" answers score; "Não" and "Não sei" both contribute nothing.
  /// Reaching 10/10 requires answering every question "Sim" AND having
  /// worked on more than [projectsThreshold] projects.
  static int computeRating({
    required Map<String, SkillAnswer> answers,
    required int projectsCount,
  }) {
    final yesCount = questions
        .where((q) => answers[q.id] == SkillAnswer.yes)
        .length;
    final projectsPoint = projectsCount > projectsThreshold ? 1 : 0;
    final scored = yesCount + projectsPoint;
    return ((scored / totalCriteria) * 10).round();
  }
}
