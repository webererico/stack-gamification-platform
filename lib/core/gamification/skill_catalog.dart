/// Static catalog of suggested skills per tech stack.
///
/// This seeds every developer's skill list when they join a squad. Users can
/// still add custom skills that aren't in the catalog for their stack.
abstract class SkillCatalog {
  static const Map<String, List<String>> byStack = {
    'Flutter': [
      'Widgets & Layout',
      'Gerenciamento de Estado',
      'Navegação (go_router)',
      'Firebase',
      'Subscriptions / IAP',
      'Animações',
      'Testes',
      'Performance',
      'Arquitetura',
      'CI/CD Mobile',
    ],
    'Backend': [
      'APIs REST',
      'Banco de Dados',
      'Autenticação',
      'Mensageria',
      'Testes',
      'Performance',
      'Cloud / Infra',
      'Arquitetura',
      'Segurança',
      'CI/CD',
    ],
    'DevOps': [
      'CI/CD',
      'Containers',
      'Orquestração (K8s)',
      'Cloud (AWS/GCP/Azure)',
      'Observabilidade',
      'Infra as Code',
      'Segurança',
      'Redes',
      'Automação',
      'Gestão de Custos',
    ],
    'Design': [
      'UI Design',
      'UX Research',
      'Design System',
      'Prototipação',
      'Acessibilidade',
      'Motion Design',
      'Handoff para Dev',
      'Testes de Usabilidade',
    ],
    'QA': [
      'Testes Manuais',
      'Automação de Testes',
      'Testes de API',
      'Testes de Performance',
      'CI/CD para QA',
      'Gestão de Bugs',
      'Testes Mobile',
      'Acessibilidade',
    ],
    'Data': [
      'SQL',
      'ETL / Pipelines',
      'Modelagem de Dados',
      'BI / Dashboards',
      'Python / Pandas',
      'Machine Learning',
      'Big Data',
      'Governança de Dados',
    ],
  };

  static List<String> get availableStacks => byStack.keys.toList();

  static List<String> skillsFor(String stack) => byStack[stack] ?? const [];
}
