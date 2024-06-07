
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// pullTest

void main() {
  runApp(
    MaterialApp.router(
      routerConfig: _router,
    ),
  );
}

class ExtraData {
  final int number;
  final String str;

  ExtraData({required this.number, required this.str});
}

final _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return const FirstScreen();
    },
    routes: [
      GoRoute(
        path: 'second',
        builder: (context, state) {
          final ExtraData? extraData = state.extra as ExtraData?;
          final number = extraData?.number ?? 0;
          final str = extraData?.str ?? "";
          return SecondScreen(number: number,str: str,);
        },
        routes: [
          GoRoute(
            path: 'third',
            builder: (context, state) {
              final ExtraData? extraData = state.extra as ExtraData?;
              final number = extraData?.number ?? 0;
              final str = extraData?.str ?? "";

              return ThirdScreen(number: number,str: str,);
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
  final TextEditingController _controller = TextEditingController(); 
  
  int _number = 0;
  String _str = "";
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('firstScreen'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '文章を入力してください'
              ),
              onChanged: (value) {
                setState(() {
                  _str = _controller.text;  
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _number++;
                });
              }, child: const Text('文章を保存')),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/');
              },
              child: const Text('firstからfirstへ'),
            ),
            ElevatedButton(
              onPressed: () {
                final ExtraData extraData = ExtraData(number: _number, str: _str);
                GoRouter.of(context).push('/second', extra: extraData,);
              },
              child: const Text('firstからsecondへ'),
            ),
            ElevatedButton(
              onPressed: () {
                final ExtraData extraData = ExtraData(number: _number, str: _str);
                GoRouter.of(context).go('/second/third', extra: extraData);
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
  const SecondScreen({super.key, required this.number,required this.str});
  final String str;
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
            Text('str: $str'),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/second');
              },
              child: const Text('secondからsecondへ'),
            ),
            ElevatedButton(
              onPressed: () {
                final ExtraData extraData = ExtraData(number: number, str: str);
                GoRouter.of(context).push('/second/third', extra: extraData);
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
  const ThirdScreen({super.key, required this.number, required this.str,});
  final String str;
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
            Text('str: $str'),
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
