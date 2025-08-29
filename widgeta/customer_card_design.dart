
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassify/database/models/design.dart';
import 'package:glassify/pages/customer_pages/customer_design_details_page.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/providers/locales/glassify_locale.dart';
import 'package:glassify/widgets/animated_number.dart';
import 'package:glassify/widgets/shake_button.dart';
import 'package:provider/provider.dart';


class CustomerCardDesign extends StatefulWidget {
  final Design design;
  const CustomerCardDesign({super.key, required this.design});

  @override
  State<CustomerCardDesign> createState() => _CustomerCardDesignState();

}

class _CustomerCardDesignState extends State<CustomerCardDesign> {

  bool hasLike = false, _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final provider = context.read<AppDataProvider>();
    final localization = provider.localization;
    return Column(
      spacing: 0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.push(context, CardSlideRoute(
                    builder: (_) => CustomerDesignDetailsPage(design: widget.design),
                  ));
                },
                onHighlightChanged: (value) => setState(() => _isPressed = value),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _isPressed ? 0.50 : 1.0,
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
                    child: FlutterLogo(size: 250),
                  ),
                ),
              ),
              if(widget.design.comments.length % 4 == 0) Container(
                margin: const EdgeInsetsDirectional.only(bottom: 20, start: 10),
                alignment: Alignment.center,
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  color: colors.brightness == Brightness.light ? colors.error : colors.errorContainer,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  '${localization.discountLabel} ${localization.formatNumber(10)}%',
                  style: TextStyle(fontSize: 10, color: colors.brightness == Brightness.light ? colors.onError : colors.onErrorContainer),
                ),
              ),
              Positioned.directional(
                textDirection: Directionality.of(context) == TextDirection.rtl ? TextDirection.ltr : TextDirection.rtl,
                start: 3, top: 15.0,
                child: ScaleButton(
                  onPressed: () async {
                    if(!hasLike) await HapticFeedback.lightImpact();
                    setState(() => hasLike = !hasLike);
                  },
                  canScale: hasLike,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Icon(hasLike ? Icons.favorite : Icons.favorite_outline,
                      color: colors.error,
                    ),
                  )
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 30,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 5.0),
                  child: Text(
                    widget.design.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              TextCounter(
                counter: widget.design.likers.length,
                locale: provider.locale!,
                icon1: Icons.thumb_up,
                icon2: Icons.thumb_up_outlined,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 2.0,
                children: [
                  Tooltip(
                    message: localization.buyDesignButton,
                    child: Icon(Icons.flash_on, color: colors.tertiary, size: 18),
                  ),
                  Tooltip(
                    message: localization.chatsLabel,
                    child: Icon(Icons.chat_rounded, color: colors.tertiary, size: 18),
                  ),
                ],
              ),
              if(widget.design.comments.length % 4 == 0) Text(
                localization.formatNumber(widget.design.price),
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.lineThrough,
                  decorationStyle: TextDecorationStyle.wavy,
                  decorationColor: colors.error,
                  decorationThickness: 2.0
                ),
              ),
              Row(
                textDirection: TextDirection.ltr,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    localization.getCurrencySymbol(provider.country!.currencySymbol),
                    style: TextStyle(fontSize: 9.50, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    widget.design.comments.length % 4 == 0 ? localization.formatCurrency(widget.design.price - (widget.design.price / 100) * 10) : localization.formatCurrency(widget.design.price),
                    style: Theme.of(context).textTheme.titleSmall,
                    textDirection: TextDirection.ltr,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

}


class TextCounter extends StatefulWidget {
  final int counter;
  final GlassifyLocale locale;
  final TextStyle? style;
  final IconData icon1;
  final IconData icon2;

  const TextCounter({super.key,
    required this.counter,
    required this.locale,
    this.style,
    required this.icon1,
    required this.icon2,
  });

  @override
  State<TextCounter> createState() => _TextCounterState();

}

class _TextCounterState extends State<TextCounter> {
  bool hasLike = false;
  final counterValue = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    setState(() => counterValue.value = widget.counter);
  }

  @override
  void dispose() {
    counterValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListenableBuilder(
          listenable: counterValue,
          builder: (_, child) {
            return AnimatedNumber(counter: counterValue.value);
          },
        ),
        const SizedBox(width: 3),
        ShakeHorizontalButton(
          canShake: hasLike,
          child: Tooltip(
            message: widget.locale.localization.likesLabel,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Icon(
                hasLike ? widget.icon1 : widget.icon2,
                color: Theme.of(context).colorScheme.secondary,
                size: 22,
              ),
            ),
          ),
          onPressed: () async {
            hasLike = !hasLike;
            if(hasLike) await HapticFeedback.lightImpact();
            setState(() => counterValue.value += hasLike ? 1 : -1);
            // if(hasLike) {
            //   final player = context.read<AppDataProvider>().audioPlayer;
            //   await player.setAsset('assets/sounds/pop-331049.mp3');
            //   await player.seek(Duration.zero);
            //   await player.play();
            // }
          },
        ),
      ],
    );
  }
}





class CardSlideRoute<T> extends MaterialPageRoute<T> {
  CardSlideRoute({required super.builder}) : super();

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 350);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Directionality.of(context) == TextDirection.rtl ? Offset(-1, 0) : Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

}


class CardDownRoute<T> extends MaterialPageRoute<T> {
  CardDownRoute({required super.builder}) : super();

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 350);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

}