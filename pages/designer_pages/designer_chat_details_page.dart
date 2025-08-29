
import 'package:flutter/material.dart';
import 'package:glassify/database/models/client.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/widgets/opacity_button.dart';
import 'package:provider/provider.dart';



class DesignerChatDetailsPage extends StatefulWidget {
  final Client client;
  const DesignerChatDetailsPage({super.key, required this.client});

  @override
  State<DesignerChatDetailsPage> createState() => _DesignerChatDetailsPageState();

}

class _DesignerChatDetailsPageState extends State<DesignerChatDetailsPage> {
  late Client _client;

  final _chatController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _client = widget.client;
  }

  @override
  void didUpdateWidget(covariant DesignerChatDetailsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _client = widget.client;
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
        toolbarHeight: 55,
        leading: Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape: CircleBorder(),
          child: FlutterLogo(),
        ),
        title: ListTile(
          contentPadding: const EdgeInsets.all(0.0),
          title: Text(
            _client.clientName,
          ),
          subtitle: Text(
            localization.customersService,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
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
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          _chatController.text.isNotEmpty ? Icons.send : Icons.mic,
                          size: 26,
                          textDirection: Directionality.of(context) == TextDirection.rtl ? TextDirection.ltr : TextDirection.rtl,
                          key: ValueKey((_chatController.text.isNotEmpty ? Icons.send : Icons.mic).toString()),
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
                      return Container(
                        constraints: BoxConstraints(
                          maxHeight: 45 + (incrementHeight > 45.0 ? 45.0 : incrementHeight.toDouble()),
                        ),
                        child: TextField(
                          controller: _chatController,
                          style: textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w500),
                          cursorHeight: 18,
                          maxLines: null,
                          // maxLength: 120,
                          // textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            hintText: localization.writeMessage,
                            hintStyle: textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.w300,
                              color: colors.onSurface,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
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
