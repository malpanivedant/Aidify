import 'package:flutter/material.dart';

import 'bloc.dart';

class BlocBuilder extends StatelessWidget {
  final Widget Function() builder;
  final Bloc bloc;
  const BlocBuilder({Key? key, required this.bloc, required this.builder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        initialData: bloc.state,
        builder: (context, snapshot) {
          return builder();
        },
    );
  }
}
