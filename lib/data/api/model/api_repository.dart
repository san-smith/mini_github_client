class ApiRepository {
  static const _NAME = 'name';
  static const _DESCRIPTION = 'description';
  static const _LANGUAGE = 'language';
  static const _STARGAZERS_COUNT = 'stargazers_count';

  final String name;
  final String description;
  final String language;
  final int stargazersCount;

  ApiRepository.fromMap(Map<String, dynamic> map)
      : name = map[_NAME],
        description = map[_DESCRIPTION] ?? '',
        language = map[_LANGUAGE],
        stargazersCount = map[_STARGAZERS_COUNT];
}
