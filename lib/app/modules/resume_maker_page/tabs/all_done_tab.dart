import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resumebuilderapp/app/modules/preview_resume_page/preview_resume_page.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_controller.dart';
import 'package:resumebuilderapp/app/utils/app_colors.dart';
import 'package:resumebuilderapp/app/widgets/rounded_button.dart';

class AllDoneTab extends StatefulWidget {
  const AllDoneTab({super.key});

  @override
  State<AllDoneTab> createState() => _AllDoneTabState();
}

class _AllDoneTabState extends State<AllDoneTab> {
  var resumeCtrl = Get.find<ResumeMakerController>();

  bool isButtonVisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
      child: _buildContent(context),
    );
  }

  _buildContent(BuildContext context) {
    // final resumeCtrl = ResumeMakerresumeCtrlProvider.of(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            'You are finished with data filling.\n\nClick on preview to see your resume.',
            style: TextStyle(
                color: AppColors.black, fontSize: MediaQuery.of(context).size.shortestSide * 0.05, letterSpacing: 0.8),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        isButtonVisible
            ? RoundedButton(
                text: 'See Preview',
                onPressed: () => _createFile(context),
              )
            : Column(
                children: <Widget>[
                  const CircularProgressIndicator(),
                  Text(
                    'Preparing your resume ...',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.shortestSide * 0.04),
                  )
                ],
              ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }

  _createFile(BuildContext context) async {
    // final resumeCtrl = ResumeMakerresumeCtrlProvider.of(context);
    resumeCtrl.previewButtonVisibility(false);
    resumeCtrl.createPdf().then((val) {
      _previewPdfFile(context, resumeCtrl.profile!.name);
    });
  }

  _previewPdfFile(BuildContext context, String name) {
    getApplicationDocumentsDirectory().then((value) {
      // final resumeCtrl = ResumeMakerresumeCtrlProvider.of(context);
      resumeCtrl.previewButtonVisibility(true);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PDFScreen(pathPDF: '${value.path}/${name.replaceAll(' ', '_')}.pdf')),
      // );
      Get.to(
        () => PreviewResumePage(),
        arguments: '${value.path}/${name.replaceAll(' ', '_')}.pdf',
      );
    });
  }
}
