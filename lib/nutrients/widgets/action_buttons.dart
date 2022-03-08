import 'package:diabetapp/nutrients/bloc/nutrients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    Key? key,
    required this.width,
    required this.bloc,
    required this.scrollTop,
    required this.scrollBottom,
    required this.iconSize,
    required this.formKey,
    required this.cleanControllers,
  }) : super(key: key);

  final double width;
  final NutrientsBloc bloc;
  final void Function() scrollTop;
  final void Function() scrollBottom;
  final void Function() cleanControllers;
  final double iconSize;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        color: Colors.pink,
        width: width,
        child: Row(
          children: [
            SizedBox(
              width: width / 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.close),
                    iconSize: iconSize,
                    onPressed: () {
                      bloc.add(NutrientsCleanIngredientsEvent(
                          scrollingTop: scrollTop));
                      cleanControllers();
                    }),
              ),
            ),
            if (context.watch<NutrientsBloc>().state.status ==
                NutrientsStatus.loading)
              Container(
                width: width / 2,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            else
              Container(
                width: width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IconButton(
                    iconSize: 32,
                    icon: Icon(
                      Icons.check,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        bloc.add(NutrientsGetResultEvent(
                          scrollingBottom: scrollBottom,
                          scrollingTop: scrollTop,
                        ));
                      }
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
