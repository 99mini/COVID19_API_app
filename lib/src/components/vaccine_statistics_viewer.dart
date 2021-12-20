import 'package:flutter/material.dart';
import 'package:public_api_app/src/canvas/arrow_clip_path.dart';
import 'package:public_api_app/src/constant/color_constant.dart';
import 'package:public_api_app/src/utils/data_utils.dart';

class VaccineStatisticsViewer extends StatelessWidget {
  final String title;
  final double addedCount;
  final double totalCount;
  final bool dense;
  final Color titleColor;
  final Color subValueColor;
  final double spacing;

  VaccineStatisticsViewer({
    Key? key,
    required this.title,
    required this.addedCount,
    required this.totalCount,
    this.dense = false,
    this.titleColor = ColorConstant.primaryGreyColor,
    this.subValueColor = ColorConstant.primaryBlueColor,
    this.spacing = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: titleColor, fontSize: dense ? 14 : 18),
          ),
          Text(
            DataUtils.percentFormat(totalCount / 50000000),
            style: TextStyle(
                color: subValueColor,
                fontSize: dense ? 25 : 50,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: spacing * 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                clipper: ArrowClipPath(direction: ArrowDirection.UP),
                child: Container(
                  padding: EdgeInsets.only(right: spacing),
                  width: dense ? 10 : 20,
                  height: dense ? 10 : 20,
                  color: titleColor,
                ),
              ),
              SizedBox(width: spacing),
              Text(
                DataUtils.numberFormat(addedCount),
                style: TextStyle(
                  color: titleColor,
                  fontSize: dense ? 15 : 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
