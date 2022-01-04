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
class _FamilyTabsScreenState extends State<FamilyTabsScreen>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: numPages,
      vsync: this,
      initialIndex: widget.index,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FamilyTabsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.index = widget.index;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(App.title),
          bottom: TabBar(
            controller: _controller,
            tabs: [
              for (int i = 0; i < numPages; ++i)
                Tab(text: i.toString())
            ],
            onTap: (index) => _tap(context, index),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            for (int i = 0; i < numPages; ++i)
              Text(i.toString())
          ],
        ),
      );

  void _tap(BuildContext context, int index) =>
      context.go('/$index');
}
