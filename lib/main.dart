import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Test

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
          builder: (context, state) {
            final number = state.extra as int? ?? 0;
            return SecondScreen(number: number);
          },
          routes: [
            GoRoute(
              path: 'third',
              builder: (context, state) {
                final number = state.extra as int? ?? 0;
                return ThirdScreen(number: number);
              },
            ),
          ],
        ),
      ],
    ),
  ]);

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final int _number = 4;

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
              GoRouter.of(context).push('/');
            },
             child: const Text('firstからfirstへ'),
            ),
            ElevatedButton(onPressed: () {
              GoRouter.of(context).push('/second', extra: _number);
            },
             child: const Text('firstからsecondへ'),
            ),
            ElevatedButton(onPressed: () {
              GoRouter.of(context).go('/second/third', extra: _number);
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
  const SecondScreen({super.key, required this.number});

  final int number;

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
            Text('numbet: $number'),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/second');
              }, 
              child: const Text('secondからsecondへ'),
            ),
            ElevatedButton(
              onPressed: () {
                final newNumber = number + 5;
                GoRouter.of(context).push('/second/third', extra: newNumber);
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
  const ThirdScreen({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirdScreen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('number: $number'),
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
