
import 'package:flutter/material.dart';
import 'package:glassify/database/models/design.dart';
import 'package:glassify/pages/designer_pages/designer_design_details_page.dart';
import 'package:glassify/widgets/customer_card_design.dart';
import 'package:glassify/widgets/opacity_button.dart';


class DesignerCardDesign extends StatelessWidget {
  final Design design;
  const DesignerCardDesign({super.key, required this.design});


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      spacing: 0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: OpacityButton(
            duration: const Duration(milliseconds: 500),
            child: Dialog(
              backgroundColor: colors.surfaceContainer,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(0.0),
              shape: ContinuousRectangleBorder(
                side: BorderSide(color: colors.outlineVariant, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: FlutterLogo(size: 270),
            ),
            onPressed: () {
              Navigator.push(context, CardSlideRoute(
                builder: (_) => DesignerDesignDetailsPage(design: design),
              ));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 5.0),
          child: Text(
            design.title,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

}






