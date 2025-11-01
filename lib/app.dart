import 'package:flutter/material.dart';

import 'features/home/home_screen.dart';
import 'features/worlds/world_map_screen.dart';
import 'features/stories/story_library_screen.dart';
import 'features/lessons/lesson_flow_screen.dart';
import 'l10n/app_localizations.dart';

enum AppRoute {
  home('/'),
  worlds('/worlds'),
  storyLibrary('/stories');

  const AppRoute(this.path);
  final String path;
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case '/worlds':
      return MaterialPageRoute(builder: (_) => const WorldMapScreen());
    case '/stories':
      return MaterialPageRoute(builder: (_) => const StoryLibraryScreen());
    case LessonFlowScreen.routeName:
      final args = settings.arguments;
      if (args is LessonFlowArgs) {
        return MaterialPageRoute(
          builder: (_) => LessonFlowScreen(args: args),
        );
      }
      break;
  }
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      body: Center(child: Text(context.l10n.errorRouteNotFound)),
    ),
  );
}
