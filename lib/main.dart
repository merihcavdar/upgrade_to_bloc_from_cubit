import 'package:bloc_cubit/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'posts_view.dart';

void main() {
  runApp(const MyApp());
}

// bloc -> business logic component
// cubit is much easier to use and get started
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<PostsBloc>(
        create: (context) => PostsBloc()..add(LoadPostsEvent()),
        child: const PostsView(),
      ),
    );
  }
}
