import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(
    MaterialApp.router(
      routerConfig: _router,
    ),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const FirstScreen(),
      routes: [
        GoRoute(
          path: 'second',
          builder: (context, state) => const SecondScreen(),
          routes: [
            GoRoute(
              path: 'third',
              builder: (context, state) => const ThirdScreen(),
            ),
          ],
        ),
      ],
    ),
  ]);

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('firstScreen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () { 
              GoRouter.of(context).go('/second');
            },
             child: const Text('firstからsecondへ'),
            ),
            ElevatedButton(onPressed: () {
              GoRouter.of(context).go('/second/third');
            },
             child: const Text('firstからthirdへ'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/second/third');
              }, 
              child: const Text('secondからthirdへ'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pop();
              }, 
              child: const Text('戻る'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirdScreen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('戻る'),
              ),
          ],
        ),
      ),
    );
  }
}
