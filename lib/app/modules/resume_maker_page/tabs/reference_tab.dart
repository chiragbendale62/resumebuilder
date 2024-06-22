import 'package:flutter/material.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/onboarding_header_text.dart';
import 'package:resumebuilderapp/app/utils/app_colors.dart';

class ReferenceTab extends StatefulWidget {
  const ReferenceTab({super.key});

  @override
  _ReferenceTabState createState() => _ReferenceTabState();
}

class _ReferenceTabState extends State<ReferenceTab> {
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
              const OnBoardingHeaderText(text: 'Reference'),
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
                        onPressed: () => _showAddReferenceDialog(null, 0),
                        icon: const Icon(Icons.add),
                      )),
                ),
              ),
            ],
          ),
          Expanded(child: _buildReferenceList()),
        ],
      ),
    );
  }

  Widget _buildReferenceList() {
    // final bloc = ResumeMakerBlocProvider.of(context);
    var referenceList = [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: referenceList.isEmpty
          ? Container(
              child: const Text('No reference added'),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return referenceList[index] != null
                    ? _ReferenceCard(
                        reference: referenceList[index],
                        onTap: () => _showAddReferenceDialog(
                          referenceList[index],
                          index,
                        ),
                      )
                    : const Offstage();
              },
              itemCount: referenceList.length,
            ),
    );
  }

  Future _showAddReferenceDialog(Reference? tempReference, int? index) async {
    // Reference reference = await Navigator.of(context).push(
    //   MaterialPageRoute<Reference>(
    //       builder: (BuildContext context) {
    //         return AddReferenceDialog(
    //           reference: tempReference,
    //         );
    //       },
    //       fullscreenDialog: true),
    // );

    // final bloc = ResumeMakerBlocProvider.of(context);
    // bloc.referenceList[index] = reference;

    // bloc.referenceList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
    // bloc.referenceListModifiedSink.add(reference);
  }
}

class _ReferenceCard extends StatelessWidget {
  final Reference reference;
  final void Function()? onTap;

  const _ReferenceCard({
    required this.reference,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(reference.toString()),
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
        // bloc.referenceList.remove(reference);
        // bloc.referenceListModifiedSink.add(reference);
        // bloc.referenceList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
      },
      child: _tapableContent(context),
    );
  }

  _tapableContent(BuildContext context) => SizedBox(
        width: double.infinity,
        child: InkWell(
          onTap: onTap,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    reference != null ? reference.name : '',
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
                    reference != null ? '${reference.designation} at ${reference.company}' : '',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: MediaQuery.of(context).size.shortestSide * 0.04,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8),
                    softWrap: true,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    reference != null ? reference.email : '',
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
