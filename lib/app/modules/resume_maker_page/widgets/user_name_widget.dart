import 'package:flutter/material.dart';
import 'package:resumebuilderapp/app/utils/app_colors.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final _bloc = ResumeMakerBlocProvider.of(context);
    var pageOffset = 0.0;
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      right: 0,
      left: MediaQuery.of(context).size.width * 0.3,
      child: Transform.scale(
        scale: _getScaleOffset(pageOffset),
        child: Opacity(
            opacity: _getOpactity(pageOffset),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'name',
                  // profile != null ? profile.name : '',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: MediaQuery.of(context).size.shortestSide * 0.06,
                    letterSpacing: 0.8,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
                Text(
                  'designation',
                  // _bloc.profile != null ? _bloc.profile.designation : '',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: MediaQuery.of(context).size.shortestSide * 0.04,
                    letterSpacing: 0.8,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
              ],
            )),
      ),
    );
  }

  double _getOpactity(double pageOffset) {
    if (pageOffset < 1) {
      return 0;
    } else if (pageOffset >= 1 && pageOffset < 2) {
      return pageOffset - 1;
    } else if (pageOffset >= 8 && pageOffset <= 9) {
      return 9 - pageOffset;
    } else {
      return 1;
    }
  }

  double _getScaleOffset(double pageOffset) {
    if (pageOffset < 1) {
      return 0;
    } else if (pageOffset >= 1 && pageOffset < 2) {
      return pageOffset - 1;
    } else if (pageOffset >= 8 && pageOffset <= 9) {
      return 9 - pageOffset;
    } else {
      return 1;
    }
  }
}
