import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(App());

// GlobalKey globalKey = GlobalKey();

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  static const title = 'GoRouter Example: Declarative Routes';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: title,
      );

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (_) => '/0',
      ),
      GoRoute(
        path: '/0',
        builder: (context, state) => PageScreen(
          pageIndex: 0,
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '/1',
        builder: (context, state) => PageScreen(
          pageIndex: 1,
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '/2',
        builder: (context, state) => PageScreen(
          pageIndex: 2,
          key: state.pageKey,
        ),
      ),
      // using this instead of the above three makes the appbar stay on
      // GoRoute(
      //   path: '/:index',
      //   builder: (context, state) => PageScreen(
      //     pageIndex: int.parse(state.params['index']!),
      //     key: state.pageKey,
      //   ),
      // ),

    ],
  );
}

class PageScreen extends StatefulWidget {
  const PageScreen({required this.pageIndex, Key? key}) : super(key: key);

  final int pageIndex;

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  int target = 0;

  @override
  void didUpdateWidget(covariant PageScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    target = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Counter(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Page $target'),
              ElevatedButton(
                onPressed: () => context.go('/${target + 1}'),
                child: Text('Go to ${target + 1}'),
              ),
            ],
          ),
        ),
      );
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
    child: Text('The top widget that stays with it state: $count'),
  );
}
