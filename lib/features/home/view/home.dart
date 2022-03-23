import 'package:diabetapp/resources/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:diabetapp/features/nutrients/nutrients.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n!.appName,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: NutrientsPage(),
      ),
    );
  }
}
