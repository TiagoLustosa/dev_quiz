import 'package:dev_quiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:dev_quiz/core/app_colors.dart';
import 'package:dev_quiz/home/home_controller.dart';
import 'package:dev_quiz/home/home_state.dart';
import 'package:dev_quiz/home/widgets/appbar/app_bar_widget.dart';
import 'package:dev_quiz/home/widgets/level_button/leve_button_widget.dart';
import 'package:dev_quiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.getUser();
    controller.getQuizzes();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success) {
      return Scaffold(
        appBar: AppBarWidget(
          user: controller.user!,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LeveButtonWidget(
                    label: 'Fácil',
                  ),
                  LeveButtonWidget(
                    label: 'Médio',
                  ),
                  LeveButtonWidget(
                    label: 'Difícil',
                  ),
                  LeveButtonWidget(
                    label: 'Perito',
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                  child: GridView.count(
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      crossAxisCount: 2,
                      children: controller.quizzes!
                          .map(
                            (e) => QuizCardWidget(
                              title: e.title,
                              percent: e.questionAnswered / e.questions.length,
                              completed:
                                  '${e.questionAnswered}/${e.questions.length}',
                            ),
                          )
                          .toList()))
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
          body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
        ),
      ));
    }
  }
}
