import 'package:flutter/material.dart';
import 'package:jobapp/router.dart';

void main() {
  runApp(JobApp());
}

class JobApp extends StatelessWidget {
  JobApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = JobAppRouter();
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
