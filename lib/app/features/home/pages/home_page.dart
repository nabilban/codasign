import 'package:codasign/app/features/home/widgets/home_bottom_widgets.dart';
import 'package:codasign/app/features/home/widgets/home_top_widgets.dart';
import 'package:codasign/app/ui/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSection(),
                QuickActionsSection(),
                SignaturesSection(),
                DocumentsSection(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
