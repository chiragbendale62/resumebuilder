import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer_null_safe/full_pdf_viewer_scaffold.dart';
import 'package:get/get.dart';
import 'package:resumebuilderapp/app/modules/preview_resume_page/preview_resume_controller.dart';
import 'package:share_plus/share_plus.dart';

class PreviewResumePage extends GetView<PreviewResumeController> {
  PreviewResumePage({super.key});

  final preResController = Get.find<PreviewResumeController>();

  _shareFile() async {
    Share.shareXFiles(
      [XFile(preResController.pathPDF.value)],
      subject: 'Share Resume PDF',
      text: preResController.pathPDF.value.substring(preResController.pathPDF.value.lastIndexOf("/") + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewResumeController>(
      builder: (controller) => PDFViewerScaffold(
        appBar: AppBar(
          title: const Text("Preview"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _shareFile,
            ),
          ],
        ),
        path: preResController.pathPDF.value,
      ),
    );
  }
}
