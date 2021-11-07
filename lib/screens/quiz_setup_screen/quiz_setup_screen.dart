import 'package:cultural_contest/providers/quiz_provider.dart';
import 'package:cultural_contest/screens/quiz_screen/local_widgets/primary_button.dart';
import 'package:cultural_contest/screens/quiz_screen/quiz_screen.dart';
import 'package:cultural_contest/screens/quiz_setup_screen/local_widgets/text_input.dart';
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

  QuizProvider _quizProvider;

  void _start(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final data = _formKey.currentState.value;

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
    _quizProvider = context.read<QuizProvider>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.65), BlendMode.srcOver),
            image: const AssetImage('assets/images/wallpapers/1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 3),
                child: Padding(
                  padding: const EdgeInsets.all(24),
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
                          hint: 'First Team Name',
                          validator: FormBuilderValidators.required(context),
                        ),
                        const SizedBox(height: 16),
                        TextInput(
                          name: 'secondTeamName',
                          hint: 'Second Team Name',
                          validator: FormBuilderValidators.required(context),
                        ),
                        const SizedBox(height: 16),
                        TextInput(
                          name: 'questionTime',
                          hint: 'Single Question Time (seconds)',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.integer(context),
                          ]),
                        ),
                        const SizedBox(height: 16),
                        TextInput(
                          name: 'quizQuestions',
                          hint: 'Number of Questions',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.integer(context),
                            (String numberOfQuestions) {
                              if (int.parse(numberOfQuestions) % 5 != 0) {
                                return 'The number of questions must be divisable by 5';
                              }
                              return null;
                            }
                          ]),
                        ),
                        const SizedBox(height: 16),
                        TextInput(
                          name: 'questionScore',
                          hint: 'Question Score',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                          ]),
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          label: 'Start Contest',
                          onPressed: () => _start(context),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Credits()
          ],
        ),
      ),
    );
  }
}
