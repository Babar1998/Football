part of 'home_page_bloc.dart';

class HomePageState {
  final int currentIndex;

  HomePageState({
    this.currentIndex = 0,
  });

  //This ApiClient must be with DI
  List<News> get news => ApiClient().getNews();

  MatchResult get latestResult => ApiClient().getLatestResult();

  HomePageState copyWith({
    int? currentIndex,
  }) {
    return HomePageState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
