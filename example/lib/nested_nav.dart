import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  static const title = 'GoRouter Example: Nested Navigation';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: title,
      );

  late final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (_) => '/0',
      ),
      GoRoute(
        path: '/:fid',
        builder: (context, state) => FamilyTabsScreen(
          key: state.pageKey,
          index: int.parse(state.params['fid']!),
        ),
      ),
    ],
  );
}

class FamilyTabsScreen extends StatefulWidget {
  const FamilyTabsScreen({required this.index, Key? key})
      : super(key: key);

  final int index;

  @override
  _FamilyTabsScreenState createState() => _FamilyTabsScreenState();
}

const numPages = 3;
class _FamilyTabsScreenState extends State<FamilyTabsScreen> {

  int activeIndex = 0;

  @override
  void didUpdateWidget(FamilyTabsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    activeIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Counter(),
          actions: [0, 1, 2].map((e) => ElevatedButton(
            onPressed: () {
              _tap(context, e);
            },
            child: Text(e.toString()),
          )).toList(),
        ),
        body: Text(activeIndex.toString()),
      );

  void _tap(BuildContext context, int index) =>
      context.go('/$index');
}


class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: () {
        setState(() {
          count++;
        });
      },
      child: Text('$count'),
    );
}
