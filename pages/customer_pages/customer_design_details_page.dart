
import 'package:flutter/material.dart';
import 'package:glassify/database/models/design.dart';
import 'package:glassify/database/models/designer.dart';
import 'package:glassify/pages/design_comments_page.dart';
import 'package:glassify/providers/glassify_user_data_provider.dart';
import 'package:glassify/widgets/animated_number.dart';
import 'package:glassify/widgets/customer_card_design.dart';
import 'package:glassify/pages/customer_pages/customer_designer_page.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/widgets/opacity_button.dart';
import 'package:provider/provider.dart';



class CustomerDesignDetailsPage extends StatefulWidget {
  final Design design;
  const CustomerDesignDetailsPage({super.key, required this.design});

  @override
  State<CustomerDesignDetailsPage> createState() => _CustomerDesignDetailsPageState();
}

class _CustomerDesignDetailsPageState extends State<CustomerDesignDetailsPage> with SingleTickerProviderStateMixin {
  late Design design;
  final _hasNotifications = ValueNotifier(false), _hasFollowed = ValueNotifier(false);
  late AnimationController _animationController;
  bool _isAnimated = false, _hasFavorite = false;
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    design = widget.design;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void didUpdateWidget(covariant CustomerDesignDetailsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.design != oldWidget.design) {
      design = widget.design;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _hasNotifications.dispose();
    _hasFollowed.dispose();
    super.dispose();
  }

  void _toggleIcon() {
    setState(() {
      _isAnimated = !_isAnimated;
      _isAnimated ? _animationController.forward() : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppDataProvider>();
    final localization = provider.localization;
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textDirection = Directionality.of(context);
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final userCart = context.read<UserDataProvider>().userCart;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(localization.designLabel),
        toolbarHeight: 50,
        actions: [
          InkWell(
            // splashColor: colors.onPrimary.withValues(alpha: 0.40),
            borderRadius: BorderRadius.circular(10),
            child: Tooltip(
              message: localization.likesLabel,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Icon(
                  _hasFavorite ? Icons.favorite : Icons.favorite_outline,
                  size: 27,
                  color: colors.error,
                  // color: _hasFavorite
                  //     ? (colors.brightness == Brightness.light ? colors.error : colors.onErrorContainer)
                  //     : (colors.brightness == Brightness.light ? colors.error : colors.onErrorContainer),
                ),
              ),
            ),
            onTap: () => setState(() => _hasFavorite = !_hasFavorite),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 4.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 570,
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              child: FlutterLogo(size: 400),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextCounter(
                    counter: design.likers.length,
                    locale: provider.locale!,
                    style: textTheme.titleSmall,
                    icon1: Icons.thumb_up,
                    icon2: Icons.thumb_up_outlined,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
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
                  ),
                  TextCounter(
                    counter: design.dislikers.length,
                    locale: provider.locale!,
                    style: textTheme.titleSmall,
                    icon1: Icons.thumb_down,
                    icon2: Icons.thumb_down_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0),
              child: Text(
                design.title,
                style: textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                spacing: 15,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.ideographic,
                          children: [
                            Text(
                              localization.getCurrencySymbol(provider.country!.currencySymbol),
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              localization.formatCurrency(widget.design.price),
                              style: textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Text(
                          localization.priceLabel,
                          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.hardware_rounded, size: 20),
                      onPressed: () { },
                      label: Text(
                        localization.buyDesignButton.toUpperCase(),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: colors.brightness == Brightness.light ? BorderSide.none : BorderSide(color: colors.onPrimary, width: 1.50),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => userCart.containsDesignInCart(design) ? userCart.removeDesignFromCart(design) : userCart.addToDesignCart(design));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.surfaceContainer,
                      foregroundColor: colors.brightness == Brightness.light && !userCart.containsDesignInCart(design) ? colors.primary : colors.onPrimary,
                      side: BorderSide(
                        color: userCart.containsDesignInCart(design) ? colors.tertiary : colors.primary,
                        width: userCart.containsDesignInCart(design) ? 2 : 1,
                      ),
                    ),
                    child: Icon(
                      userCart.containsDesignInCart(design) ? Icons.shopping_cart_checkout_rounded : Icons.add_shopping_cart_rounded,
                      size: 25,
                      color: userCart.containsDesignInCart(design) ? colors.tertiary : colors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                localization.describeDesign,
                style: textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            SizedBox(
                              width: 60, height: 60,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  final designer = Designer(
                                    rowId: design.designerId.split('/').last,
                                    designerName: localization.designerNameLabel,
                                    userId: '28346klsudf', userName: 'User Name', password: '', email: 'helloworld@gmail.com',
                                    joinedDate: DateTime.now(),
                                    posts: {}, followers: {}, transactions: {}, reviews: {}, countRating: 3,
                                  );
                                  Navigator.push(context, CardSlideRoute(builder: (_) => CustomerDesignerPage(designer: designer)));
                                },
                                child: Dialog(
                                  backgroundColor: colors.surfaceContainer,
                                  surfaceTintColor: Colors.transparent,
                                  shape: CircleBorder(
                                    side: BorderSide(color: colors.primary),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: FlutterLogo(size: 70),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: colors.primary,
                              child: Icon(Icons.person_4_rounded, color: colors.onPrimary),
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
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber.shade600),
                                Icon(Icons.star, color: Colors.amber.shade600),
                                Icon(Icons.star, color: Colors.amber.shade600),
                                Icon(Icons.star, color: Colors.amber.shade600),
                                Icon(Icons.star, color: Colors.amber.shade600),
                                const SizedBox(width: 10),
                                Text(
                                  localization.formatNumber(5),
                                ),
                              ],
                            ),
                            Text('${localization.formatNumber(10)} ${localization.commentLabel}',
                              style: textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: 15.0,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _hasNotifications,
                        builder: (context, value, child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                              backgroundColor: _hasNotifications.value ? colors.primary : colors.surfaceContainer,
                              foregroundColor: colors.brightness == Brightness.light && !_hasNotifications.value ? colors.primary : colors.onPrimary,
                              side: _hasNotifications.value && colors.brightness == Brightness.light ? BorderSide.none : BorderSide(
                                color: _hasNotifications.value ? colors.onPrimary : colors.primary,
                              ),
                              minimumSize: const Size(65, 32),
                            ),
                            onPressed: () => _hasNotifications.value = !_hasNotifications.value,
                            child: Tooltip(
                              message: localization.notificationsLabel,
                              child: Icon(
                                _hasNotifications.value ? Icons.notifications_active_rounded : Icons.notifications_off_rounded,
                                size: 26,
                              ),
                            ),
                          );
                        }
                      ),
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
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                spacing: 10.0,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 1),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization.formatNumber(design.designer?.posts.length ?? 30),
                        textDirection: TextDirection.ltr,
                        style: textTheme.bodyLarge,
                      ),
                      Text(
                        localization.postsLabel,
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization.formatNumber(design.transactions.length),
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
                      ValueListenableBuilder(
                        valueListenable: _hasFollowed,
                        builder: (_, value, child) {
                          return AnimatedNumber(
                            counter: design.designer?.followers.length ?? 2 * 3 + (_hasFollowed.value ? 1 : 0),
                            style: textTheme.bodyLarge,
                          );
                        },
                      ),
                      Text(
                        localization.followersLabel,
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: _hasFollowed,
                    builder: (_, value, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1),
                          backgroundColor: _hasFollowed.value ? colors.primary : colors.surfaceContainer,
                          foregroundColor: colors.brightness == Brightness.light && !_hasFollowed.value ? colors.primary : colors.onPrimary,
                          side: _hasFollowed.value && colors.brightness == Brightness.light ? BorderSide.none : BorderSide(
                            color: _hasFollowed.value ? colors.onPrimary : colors.primary,
                            width: _hasFollowed.value ? 2.0 : 1.0,
                          ),
                          minimumSize: Size(100, 37),
                        ),
                        onPressed: () => _hasFollowed.value = !_hasFollowed.value,
                        child: Text(
                          _hasFollowed.value ? localization.followedDesignerLabel : localization.followDesignerLabel,
                          // style: textTheme.titleSmall,
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.formatPostedDate(design.lastReport?.date ?? DateTime(2025, 5, 14)),
                    style: textTheme.bodyMedium,
                  ),
                  OpacityButton(
                    child: Text(
                      localization.reportThisPost,
                      style: textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline),
                    ),
                    onPressed: () { },
                  )
                ],
              ),
            ),
            Divider(thickness: 2.0, endIndent: 5.0, indent: 5.0, color: colors.outline),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OpacityButton(
                    onPressed: _onTapComments,
                    child: Row(
                      children: [
                        Text(
                          localization.formatNumber(design.comments.length),
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          localization.commentLabel,
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: colors.brightness == Brightness.light ? colors.primaryContainer : colors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    onTap: _onTapComments,
                    child: Tooltip(
                      message: '${localization.formatNumber(design.comments.length)} ${localization.commentLabel}',
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        // child: Icon(Icons.chevron_right, size: 28, color: colors.onPrimaryContainer),
                        child: AnimatedIcon(
                          textDirection: textDirection == TextDirection.ltr ? TextDirection.rtl : TextDirection.ltr,
                          icon: AnimatedIcons.menu_arrow,
                          progress: _animationController,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 2.0, endIndent: 5.0, indent: 5.0, color: colors.outline),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                localization.similarDesigns,
                style: textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Align(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 25,
                  runSpacing: 20,
                  children: List.generate(16, (index) {
                    return SizedBox(
                      width: ((orientation == Orientation.portrait ? size.width : size.height) - 40) / 2 ,
                      height: 320,
                      child: CustomerCardDesign(design: design),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapComments() async {
    _toggleIcon();
    await showModalBottomSheet(context: context, builder: (_) => DesignComments(design: design),
      backgroundColor: Colors.transparent,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 800),
      ),
    );
    _toggleIcon();
  }

}

