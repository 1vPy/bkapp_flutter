class GenresUtil {
  static final GenresUtil instance = new GenresUtil._internal();
  static final Map<int, String> map = new Map();

  GenresUtil._internal() {
    List<MapEntry<int, String>> genresList = new List();
    genresList.add(new MapEntry(28, "动作"));
    genresList.add(new MapEntry(12, "冒险"));
    genresList.add(new MapEntry(16, "动画"));
    genresList.add(new MapEntry(35, "喜剧"));
    genresList.add(new MapEntry(80, "犯罪"));
    genresList.add(new MapEntry(99, "纪录"));
    genresList.add(new MapEntry(18, "剧情"));
    genresList.add(new MapEntry(10751, "家庭"));
    genresList.add(new MapEntry(14, "奇幻"));
    genresList.add(new MapEntry(36, "历史"));
    genresList.add(new MapEntry(27, "恐怖"));
    genresList.add(new MapEntry(10402, "音乐"));
    genresList.add(new MapEntry(9648, "悬疑"));
    genresList.add(new MapEntry(10749, "爱情"));
    genresList.add(new MapEntry(878, "科幻"));
    genresList.add(new MapEntry(10770, "电视电影"));
    genresList.add(new MapEntry(53, "惊悚"));
    genresList.add(new MapEntry(10752, "战争"));
    genresList.add(new MapEntry(37, "西部"));
    map.addEntries(genresList);
  }

  factory GenresUtil() {
    return instance;
  }

  String getGenre(int key) {
    return map.containsKey(key) ? map[key] : "";
  }

  String id2Genres(List<int> ids) {
    String genres = '';
    if (ids.length == 0) {
      return '无';
    }
    ids.forEach((int i) {
      genres = genres + getGenre(i) + '/';
    });
    return genres.substring(0, genres.length - 1);
  }
}
