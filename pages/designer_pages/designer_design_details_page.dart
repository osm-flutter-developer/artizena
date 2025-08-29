
import 'package:flutter/material.dart';
import 'package:glassify/database/models/design.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:provider/provider.dart';




class DesignerDesignDetailsPage extends StatefulWidget {
  final Design design;
  const DesignerDesignDetailsPage({super.key, required this.design});

  @override
  State<DesignerDesignDetailsPage> createState() => _DesignerDesignDetailsPageState();

}

class _DesignerDesignDetailsPageState extends State<DesignerDesignDetailsPage> {
  late Design design;

  @override
  void initState() {
    super.initState();
    design = widget.design;
  }

  @override
  void didUpdateWidget(covariant DesignerDesignDetailsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.design != oldWidget.design) {
      design = widget.design;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppDataProvider>();
    final localization = provider.localization;
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // final textDirection = Directionality.of(context);
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(design.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1.0,
            children: [
              Container(
                height: 570,
                padding: const EdgeInsets.only(right: 20),
                alignment: Alignment.center,
                child: FlutterLogo(size: 400),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '.',
                    style: textTheme.titleLarge?.copyWith(color: colors.primary, fontSize: 40),
                  ),
                  Text(
                    '.',
                    style: textTheme.titleLarge?.copyWith(fontSize: 40),
                  ),
                  Text(
                    '.',
                    style: textTheme.titleLarge?.copyWith(fontSize: 40),
                  ),
                ],
              ),
              Text(
                design.description,
              ),
              Align(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10.0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: colors.primary, width: 0.75),
                        ),
                        child: Tooltip(
                          message: localization.likesLabel,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localization.formatNumber(design.likers.length),
                                textDirection: TextDirection.ltr,
                                style: textTheme.bodyLarge,
                              ),
                              Icon(Icons.thumb_up, size: 22, color: colors.brightness == Brightness.light ? colors.onTertiary : colors.tertiary),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: colors.primary, width: 0.75),
                        ),
                        child: Tooltip(
                          message: localization.dislikesLabel,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localization.formatNumber(design.dislikers.length),
                                textDirection: TextDirection.ltr,
                                style: textTheme.bodyLarge,
                              ),
                              Icon(Icons.thumb_down, size: 22, color: colors.error),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: colors.primary, width: 0.75),
                        ),
                        child: Tooltip(
                          message: localization.transactionLabel,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localization.formatNumber(design.transactions.length),
                                textDirection: TextDirection.ltr,
                                style: textTheme.bodyLarge,
                              ),
                              Icon(Icons.track_changes, size: 22, color: colors.secondary),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10.0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: colors.primary, width: 0.75),
                        ),
                        child: Tooltip(
                          message: localization.commentLabel,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localization.formatNumber(design.comments.length),
                                textDirection: TextDirection.ltr,
                                style: textTheme.bodyLarge,
                              ),
                              Icon(Icons.comment_bank_outlined, size: 22, color: colors.brightness == Brightness.light ? colors.primary : colors.secondary),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: colors.primary, width: 0.75),
                        ),
                        child: Tooltip(
                          message: localization.reportThisPost,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localization.formatNumber(design.reports.length),
                                textDirection: TextDirection.ltr,
                                style: textTheme.bodyLarge,
                              ),
                              Icon(Icons.bug_report, size: 22, color: colors.brightness == Brightness.light ? colors.errorContainer : colors.onErrorContainer),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: colors.primary, width: 0.75),
                        ),
                        child: Tooltip(
                          message: localization.ratingLabel,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localization.formatNumber(design.reports.length),
                                textDirection: TextDirection.ltr,
                                style: textTheme.bodyLarge,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star_sharp, size: 22, color: colors.error),
                                  Icon(Icons.star_sharp, size: 22, color: colors.error),
                                  Icon(Icons.star_sharp, size: 22, color: colors.error),
                                  Icon(Icons.star_sharp, size: 22, color: colors.error),
                                  Icon(Icons.star_sharp, size: 22, color: colors.error),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [

                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: colors.primary, width: 0.75),
                        ),
                        child: Tooltip(
                          message: localization.reviewsLabel,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localization.formatNumber(design.reports.length),
                                textDirection: TextDirection.ltr,
                                style: textTheme.bodyLarge,
                              ),
                              Icon(Icons.rate_review_sharp, size: 22, color: colors.tertiary),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
