
import 'package:flutter/material.dart';
import 'package:glassify/database/models/designer.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/widgets/opacity_button.dart';
import 'package:provider/provider.dart';



class CustomerChatDetailsPage extends StatefulWidget {
  final Designer designer;
  const CustomerChatDetailsPage({super.key, required this.designer});

  @override
  State<CustomerChatDetailsPage> createState() => _CustomerChatDetailsPageState();

}

class _CustomerChatDetailsPageState extends State<CustomerChatDetailsPage> {
  late Designer _designer;
  final _chatController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _designer = widget.designer;
  }

  @override
  void didUpdateWidget(covariant CustomerChatDetailsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _designer = widget.designer;
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = context.read<AppDataProvider>();
    final localization = provider.localization;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        leading: Align(
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: FlutterLogo(),
          ),
        ),
        centerTitle: true,
        title: SizedBox(
          height: 50,
          child: InkWell(
            onTap: () { },
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _designer.designerName,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      ' ${localization.describeDesign}',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [],
            onSelected: (value) { },
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(localization.chatsLabel),
                ),
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () { },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: CircleBorder(),
                      padding: const EdgeInsets.all(0.0),
                      fixedSize: Size(40, 40),
                      minimumSize: Size(45, 45),
                    ),
                    child: ValueListenableBuilder(
                      builder: (_, value, child) {
                        return AnimatedSwitcher(
                          transitionBuilder: (child, animationController) {
                            return FadeTransition(
                              opacity: Tween<double>(begin: 0.10, end: 1.0).animate(animationController),
                              child: ScaleTransition(
                                scale: Tween<double>(begin: 0.10, end: 1.0).animate(animationController),
                                child: child,
                              ),
                            );
                          },
                          duration: const Duration(milliseconds: 400),
                          child: Icon(
                            _chatController.text.isNotEmpty ? Icons.send_rounded : Icons.mic_rounded,
                            size: 26,
                            textDirection: Directionality.of(context) == TextDirection.rtl ? TextDirection.ltr : TextDirection.rtl,
                            key: ValueKey((_chatController.text.isNotEmpty ? Icons.send_rounded : Icons.mic_rounded).toString()),
                          ),
                        );
                      },
                      valueListenable: _chatController,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: _chatController,
                      builder: (_, value, child) {
                        final incrementHeight = _chatController.text.split('\n').isEmpty ? 0 : (_chatController.text.split('\n').length - 1) * 15;
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 45 + (incrementHeight > 45.0 ? 45.0 : incrementHeight.toDouble()),
                          ),
                          child: TextField(
                            controller: _chatController,
                            style: textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w500,
                              height: 1.25
                            ),
                            cursorHeight: 18,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: localization.writeMessage,
                              hintStyle: textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: colors.onSurface,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                              contentPadding: const EdgeInsets.only(right: 15, left: 15, top: 7, bottom: 10),
                              constraints: BoxConstraints(maxWidth: 80),
                              suffixIcon: _chatController.text.isNotEmpty ? SizedBox(width: 1, height: 0) : Container(
                                padding: const EdgeInsetsDirectional.only(start: 5),
                                height: 40,
                                width: 80,
                                child: Row(
                                  children: [
                                    OpacityButton(
                                      child: Icon(Icons.camera_alt_sharp),
                                      onPressed: () { },
                                    ),
                                    const SizedBox(width: 10),
                                    OpacityButton(
                                      child: Icon(Icons.attach_file),
                                      onPressed: () { },
                                    )
                                  ],
                                ),
                              ),
                            ),
                            cursorColor: colors.tertiary,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          )
      ),
    );
  }
}
