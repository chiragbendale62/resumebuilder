import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_controller.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/onboarding_header_text.dart';
import 'package:resumebuilderapp/app/utils/app_colors.dart';

class LanguageTab extends StatefulWidget {
  const LanguageTab({super.key});

  @override
  _LanguageTabState createState() => _LanguageTabState();
}

class _LanguageTabState extends State<LanguageTab> {
  var resumeCtrl = Get.find<ResumeMakerController>();
  final TextEditingController summaryController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const OnBoardingHeaderText(text: 'Language'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipOval(
                  child: Container(
                      height: 32,
                      width: 32,
                      color: Theme.of(context).primaryColor,
                      child: IconButton(
                        padding: const EdgeInsets.all(4),
                        color: Colors.white,
                        onPressed: () => _showAddLanguageDialog(null, 0),
                        icon: const Icon(Icons.add),
                      )),
                ),
              ),
            ],
          ),
          Expanded(child: _buildLanguageList()),
        ],
      ),
    );
  }

  Widget _buildLanguageList() {
    // final bloc = ResumeMakerBlocProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: resumeCtrl.languageList.isEmpty
          ? Container(
              child: const Text('No language added'),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return resumeCtrl.languageList[index] != null
                    ? _LanguageCard(
                        language: resumeCtrl.languageList[index],
                        onTap: () => _showAddLanguageDialog(
                          resumeCtrl.languageList[index],
                          index,
                        ),
                      )
                    : const Offstage();
              },
              itemCount: resumeCtrl.languageList.length,
            ),
    );
  }

  Future _showAddLanguageDialog(Language? tempLanguage, int index) async {
    // Language language = await Navigator.of(context).push(
    //   MaterialPageRoute<Language>(
    //       builder: (BuildContext context) {
    //         return AddLanguageDialog(
    //           language: tempLanguage,
    //         );
    //       },
    //       fullscreenDialog: true),
    // );

    // if (language != null) {
    //   final bloc = ResumeMakerBlocProvider.of(context);
    //   if (tempLanguage != null) {
    //     bloc.languageList[index] = language;
    //   } else {
    //     bloc.languageList.add(language);
    //   }

    //   bloc.languageList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
    //   bloc.languageListModifiedSink.add(language);
    // }
  }
}

class _LanguageCard extends StatelessWidget {
  final Language language;
  final void Function()? onTap;

  const _LanguageCard({
    required this.language,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(language.toString()),
      background: Container(
          padding: const EdgeInsets.only(right: 20.0),
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Text('Delete', textAlign: TextAlign.right, style: TextStyle(color: Colors.white)),
          )),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // final bloc = ResumeMakerBlocProvider.of(context);
        // bloc.languageList.remove(language);
        // bloc.languageListModifiedSink.add(language);
        // bloc.languageList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
      },
      child: _tapableContent(context),
    );
  }

  _tapableContent(BuildContext context) => InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    language != null ? language.name : '',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: MediaQuery.of(context).size.shortestSide * 0.05,
                        letterSpacing: 0.8),
                    softWrap: true,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    language != null ? language.level : '',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: MediaQuery.of(context).size.shortestSide * 0.04,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8),
                    softWrap: true,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
