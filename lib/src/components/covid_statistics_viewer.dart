import 'package:flutter/material.dart';
import 'package:public_api_app/src/canvas/arrow_clip_path.dart';
import 'package:public_api_app/src/constant/color_constant.dart';
import 'package:public_api_app/src/utils/data_utils.dart';

class CovidStatisticsViewer extends StatelessWidget {
  final String title;
  final double addedCount;
  final ArrowDirection upDown;
  final double totalCount;
  final bool dense;
  final Color titleColor;
  final Color subValueColor;
  final double spacing;

  CovidStatisticsViewer({
    Key? key,
    required this.title,
    required this.addedCount,
    required this.upDown,
    required this.totalCount,
    this.dense = false,
    this.titleColor = ColorConstant.primaryGreyColor,
    this.subValueColor = Colors.black,
    this.spacing = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;
    switch (upDown) {
      case ArrowDirection.UP:
        color = ColorConstant.primaryRedColor;
        break;
      case ArrowDirection.MIDDLE:
        // TODO: Handle this case.
        break;
      case ArrowDirection.DOWN:
        color = ColorConstant.primaryBlueColor;
        // TODO: Handle this case.
        break;
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: titleColor, fontSize: dense ? 14 : 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                clipper: ArrowClipPath(direction: upDown),
                child: Container(
                  width: dense ? 10 : 20,
                  height: dense ? 10 : 20,
                  color: color,
                ),
              ),
              SizedBox(width: spacing),
              Text(
                DataUtils.numberFormat(addedCount),
                style: TextStyle(
                    color: color,
                    fontSize: dense ? 25 : 50,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: spacing * 0.5),
          Text(
            DataUtils.numberFormat(totalCount),
            style: TextStyle(color: subValueColor, fontSize: dense ? 15 : 20),
          ),
        ],
      ),
    );
  }
}
