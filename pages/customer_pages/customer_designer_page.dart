
import 'package:flutter/material.dart';
import 'package:glassify/database/models/design.dart';
import 'package:glassify/database/models/designer.dart';
import 'package:glassify/providers/glassify_user_data_provider.dart';
import 'package:glassify/widgets/animated_number.dart';
import 'package:glassify/widgets/customer_card_design.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:provider/provider.dart';



class CustomerDesignerPage extends StatefulWidget {
  final Designer designer;
  const CustomerDesignerPage({super.key, required this.designer});

  @override
  State<CustomerDesignerPage> createState() => _CustomerDesignerPageState();

}

class _CustomerDesignerPageState extends State<CustomerDesignerPage> {
  bool _hasNotifications = false;
  bool _hasFollowed = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppDataProvider>();
    final localization = provider.localization;
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.designerNameLabel,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              minimumSize: const Size(65, 32),
              backgroundColor: _hasNotifications ? colors.primary : colors.surfaceContainer,
              foregroundColor: colors.brightness == Brightness.light && !_hasNotifications ? colors.primary : colors.onPrimary,
              side: _hasNotifications && colors.brightness == Brightness.light ? BorderSide.none : BorderSide(
                color: _hasNotifications ? colors.onPrimary : colors.primary,
              ),
              // backgroundColor: _hasNotifications ? colors.primary : colors.surface,
              // foregroundColor: _hasNotifications ? colors.onPrimary : colors.primary,
              // side: _hasNotifications ? BorderSide.none : BorderSide(
              //   color: _hasNotifications ? colors.onPrimary : colors.primary,
              // ),
            ),
            onPressed: () {
              setState(() => _hasNotifications = !_hasNotifications);
            },
            child: Tooltip(
              message: localization.notificationsLabel,
              child: Icon(
                _hasNotifications ? Icons.notifications_on_rounded : Icons.notifications_off_rounded,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              backgroundColor: colors.primary,
              minimumSize: const Size(65, 32),
              side: colors.brightness == Brightness.light ? BorderSide.none : BorderSide(color: colors.onPrimary),
            ),
            onPressed: () {
              // setState(() => _hasChats = !_hasChats);
            },
            child: Tooltip(
              message: localization.chatsLabel,
              child: Icon(
                Icons.message_rounded,
                size: 26,
                color: colors.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          width: 60, height: 60,
                          decoration: BoxDecoration(
                            color: colors.surfaceContainer,
                            border: Border.all(color: colors.primary, width: 0.70),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: FlutterLogo(size: 50),
                          ),
                        ),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: colors.primary,
                          child: Icon(Icons.person_4_rounded, color: colors.onPrimary, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(localization.designerNameLabel,
                          style: textTheme.titleSmall,
                        ),
                        Text(
                          localization.designerNameLabel
                        ),
                        Text('${localization.formatNumber(10)} ${localization.reviewsLabel}',
                          style: textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.star, color: Colors.amber.shade700),
                          Icon(Icons.star, color: Colors.amber.shade700),
                          Icon(Icons.star, color: Colors.amber.shade700),
                          Icon(Icons.star, color: Colors.amber.shade700),
                          Icon(Icons.star, color: Colors.amber.shade700),
                          const SizedBox(width: 10),
                          Text(localization.formatNumber(5)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                spacing: 10.0,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${localization.formatNumber(5)} ${localization.ratingLabel}',
                          textDirection: TextDirection.ltr,
                          style: textTheme.bodyLarge,
                        ),
                        Text(
                          '${localization.formatNumber(widget.designer.reviews.length)} ${localization.reviewsLabel}',
                          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization.formatNumber(widget.designer.transactions.length),
                        style: textTheme.bodyLarge,
                      ),
                      Text(
                        localization.transactionLabel,
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedNumber(
                        counter: widget.designer.followers.length,
                        style: textTheme.bodyLarge,
                      ),
                      Text(
                        localization.followersLabel,
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1),
                        // backgroundColor: _hasFollowed ? colors.primary : colors.surfaceContainer,
                        // foregroundColor: _hasFollowed ? colors.onPrimary : colors.tertiary,
                        backgroundColor: _hasFollowed ? colors.primary : colors.surfaceContainer,
                        foregroundColor: colors.brightness == Brightness.light && !_hasFollowed ? colors.primary : colors.onPrimary,
                        // side: _hasFollowed ? BorderSide.none : BorderSide(
                        //   color: _hasFollowed ? colors.onPrimary : colors.primary,
                        //   width: _hasFollowed ? 2.0 : 1.0,
                        // ),
                        side: _hasFollowed && colors.brightness == Brightness.light ? BorderSide.none : BorderSide(
                          color: _hasFollowed ? colors.onPrimary : colors.primary,
                          width: _hasFollowed ? 2.0 : 1.0,
                        ),
                        minimumSize: Size(100, 37),
                      ),
                      onPressed: () {
                        setState(() => _hasFollowed = !_hasFollowed);
                      },
                      child: Text(
                        _hasFollowed ? localization.followedDesignerLabel : localization.followDesignerLabel,
                        // style: textTheme.titleSmall,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              GridView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 15.0, crossAxisSpacing: 20.0, childAspectRatio: 0.60),
                itemBuilder: (_, index) {
                  final design = Design(
                    rowId: 'glassify-${index + 3}-glassify',
                    date: DateTime(2025, 6, ((index + 2) % 31) + 1),
                    title: '${localization.categoryLabel} ${index + 2}',
                    description: '${localization.describeDesign} ${localization.categoryLabel} ${index + 2}',
                    designerId: context.read<UserDataProvider>().currentUser?.rowId ?? '23423',
                    imagePath: '', otherImagesPaths: {}, transactions: {},
                    likers: {}, dislikers: {}, comments: {},
                    price: index * 20, currency: provider.country!.currencySymbol,
                  );
                  return CustomerCardDesign(design: design);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
