
import 'package:flutter/material.dart';
import 'package:glassify/database/models/client.dart';
import 'package:glassify/pages/designer_pages/designer_chat_details_page.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/widgets/customer_card_design.dart';
import 'package:provider/provider.dart';



class DesignerChatsPage extends StatefulWidget {
  const DesignerChatsPage({super.key});

  @override
  State<DesignerChatsPage> createState() => _DesignerChatsPageState();
}

class _DesignerChatsPageState extends State<DesignerChatsPage> {
  List customers = [];

  @override
  Widget build(BuildContext context) {
    final locale = context.read<AppDataProvider>().locale;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale?.localization.chatsLabel ?? '',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.50),
              child: ListTile(
                splashColor: colors.brightness == Brightness.light ? colors.tertiary : colors.onTertiary,
                contentPadding: const EdgeInsets.symmetric(),
                onTap: () {
                  final client = Client(rowId: 'ab-${index + 3}', clientName: '${locale.localization.customerNameLabel} ${index + 1}', joinedDate: DateTime.now(), userId: 'ab-${index}dg-${index * 5}', userName: 'UserName', password: null, email: null, );
                  Navigator.push(context, CardSlideRoute(builder: (_) =>DesignerChatDetailsPage(client: client)));
                },
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: SizedBox(
                    height: 57,
                    width: 57,
                    child: Dialog(
                      insetPadding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: colors.primary, width: 1.0),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      backgroundColor: colors.surfaceContainer,
                      surfaceTintColor: Colors.transparent,
                      child: Icon(Icons.person, size: 55),
                    ),
                  ),
                ),
                title: Text('${locale!.localization.customerNameLabel} ${index + 1}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.mark_chat_read, size: 15, color: colors.onSurface),
                    const SizedBox(width: 5),
                    Text('${locale.localization.notificationsLabel} ${index + 1}',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ],
                )
              ),
            );
          },
        ),
      ),
    );
  }
}
