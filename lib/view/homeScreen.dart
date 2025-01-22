import 'package:flutter/material.dart';
import 'package:ocr_app/view/widgets/optionItem.dart';
import 'package:ocr_app/view_models/homeViewModel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Homeviewmodel(context),
      child: Consumer<Homeviewmodel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Select an option'),
              actions: [],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: value.homeOptionList
                      .map(
                        (e) => OptionItem(
                          icon: e['icon'],
                          title: e['title'],
                          onTap: e['action'],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
