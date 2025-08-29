
import 'package:flutter/material.dart';
import 'package:glassify/database/models/design.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:provider/provider.dart';



class DesignComments extends StatefulWidget {
  final Design design;
  const DesignComments({super.key, required this.design});

  @override
  State<DesignComments> createState() => _DesignCommentsState();
}

class _DesignCommentsState extends State<DesignComments> {
  Design get design => widget.design;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final provider = context.read<AppDataProvider>();
    final localization = provider.localization;
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Dialog(
        backgroundColor: colors.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        insetAnimationDuration: const Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.onSurface,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              if(design.comments.isEmpty) SizedBox(
                child: Center(
                  child: Text(
                    localization.beFirstToComment,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              if(design.comments.isNotEmpty) Expanded(
                child: ListView.builder(
                  itemCount: design.comments.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40, height: 40,
                            child: Dialog(
                              backgroundColor: colors.surfaceContainer,
                              surfaceTintColor: Colors.transparent,
                              shape: CircleBorder(
                                side: BorderSide(color: colors.tertiary),
                              ),
                              insetPadding: const EdgeInsets.all(0.0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(35),
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: FlutterLogo(size: 50),
                                    ),
                                    Icon(Icons.shopping_bag, color: colors.tertiary, size: 18),
                                  ],
                                ),
                                onTap: () {
                                  // Navigator.push(context, CardSlideRoute(builder: (_) =>DesignerPage(designer: null)));
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(localization.designerNameLabel,
                                      style: textTheme.titleSmall,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(localization.formatPostedDate(DateTime(2024, index % 12, index % 30)),
                                      style: textTheme.labelSmall?.copyWith(
                                        color: colors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 4.0),
                                  child: Text('${'${localization.commentLabel} ' * 3}......................',
                                    style: textTheme.labelSmall?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: colors.onSurface,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              Container(
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: () { },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        shape: CircleBorder(),
                        padding: const EdgeInsets.all(0.0),
                        fixedSize: Size(30, 35),
                        minimumSize: Size(35, 35),
                      ),
                      child: Icon(Icons.arrow_upward, size: 22),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        style: textTheme.titleSmall,
                        cursorHeight: 17,
                        // textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintText: localization.writeComment,
                          hintStyle: textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                            color: colors.onSurface,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}