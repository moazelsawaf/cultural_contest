import 'package:cultural_contest/providers/quiz_provider.dart';
import 'package:cultural_contest/screens/quiz_screen/local_widgets/primary_button.dart';
import 'package:cultural_contest/screens/quiz_screen/quiz_screen.dart';
import 'package:cultural_contest/screens/quiz_setup_screen/local_widgets/text_input.dart';
import 'package:cultural_contest/widgets/background.dart';
import 'package:cultural_contest/widgets/credits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class QuizSetupScreen extends StatelessWidget {
  QuizSetupScreen({
    Key key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  void _start(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final data = _formKey.currentState.value;

      final _quizProvider = context.read<QuizProvider>();

      _quizProvider.firstTeamName = data['firstTeamName'];
      _quizProvider.secondTeamName = data['secondTeamName'];
      _quizProvider.questionTime = int.parse(data['questionTime']);
      _quizProvider.quizQuestions = int.parse(data['quizQuestions']);
      _quizProvider.questionScore = double.parse(data['questionScore']);

      _quizProvider.filterQuestions();

      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return const QuizScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'المسابقة الثقافية',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 48,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 48),
                          TextInput(
                            name: 'firstTeamName',
                            hint: 'اسم الفريق الأول',
                            validator: FormBuilderValidators.required(context),
                          ),
                          const SizedBox(height: 16),
                          TextInput(
                            name: 'secondTeamName',
                            hint: 'اسم الفريق الثاني',
                            validator: FormBuilderValidators.required(context),
                          ),
                          const SizedBox(height: 16),
                          TextInput(
                            name: 'questionTime',
                            hint: 'وقت السؤال ( ثواني )',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.numeric(context),
                              FormBuilderValidators.integer(context),
                            ]),
                          ),
                          const SizedBox(height: 16),
                          TextInput(
                            name: 'quizQuestions',
                            hint: 'عدد الأسئلة',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.numeric(context),
                              FormBuilderValidators.integer(context),
                              (String numberOfQuestions) {
                                if (int.parse(numberOfQuestions) % 5 != 0) {
                                  return 'يجب ان يكون عدد الاسئلة من مضاعفات الخمسة';
                                }
                                return null;
                              }
                            ]),
                          ),
                          const SizedBox(height: 16),
                          TextInput(
                            name: 'questionScore',
                            hint: 'درجة السؤال',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.numeric(context),
                            ]),
                          ),
                          const SizedBox(height: 16),
                          PrimaryButton(
                            label: 'بدء المسابقة',
                            onPressed: () => _start(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Credits(textColor: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
