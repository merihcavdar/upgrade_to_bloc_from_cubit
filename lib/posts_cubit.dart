import 'package:flutter_bloc/flutter_bloc.dart';
import 'post.dart';
import 'data_service.dart';

class PostsCubit extends Cubit<List<Post>> {
  final _dataService = DataService();
  PostsCubit() : super([]);

  void getPosts() async => emit(await _dataService.getPosts());
}

abstract class PostsEvent {}

class LoadPostsEvent extends PostsEvent {}

class PullToRefreshEvent extends PostsEvent {}

abstract class PostsState {}

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  final List<Post> posts;

  LoadedPostsState({required this.posts});
}

class FailedToLoadPostsState extends PostsState {
  final Object error;

  FailedToLoadPostsState({required this.error});
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final _dataService = DataService();

  PostsBloc() : super(LoadingPostsState());

  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    // ignore: unrelated_type_equality_checks
    if (event == LoadPostsEvent || event is PullToRefreshEvent) {
      yield LoadingPostsState();

      try {
        final posts = await _dataService.getPosts();
        yield LoadedPostsState(posts: posts);
      } catch (e) {
        yield FailedToLoadPostsState(error: e);
      }
    }
  }
}
