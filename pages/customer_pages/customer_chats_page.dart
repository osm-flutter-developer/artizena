
import 'package:flutter/material.dart';
import 'package:glassify/database/models/designer.dart';
import 'package:glassify/pages/customer_pages/customer_chat_details_page.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/widgets/customer_card_design.dart';
import 'package:provider/provider.dart';



class CustomerChatsPage extends StatefulWidget {

  const CustomerChatsPage({super.key});

  @override
  State<CustomerChatsPage> createState() => _CustomerChatsPageState();
}

class _CustomerChatsPageState extends State<CustomerChatsPage> {

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppDataProvider>();
    final locale = provider.locale;
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
                    final designer = Designer(
                      rowId: 'de-${index + 3}',
                      designerName: '${locale.localization.designerNameLabel} ${index + 1}',
                      userId: 'de-${index}signer-${index * 5}',
                      userName: 'UserName', password: null,
                      email: null,
                      posts: {}, followers: {}, transactions: {}, reviews: {},
                      countRating: 4,
                      joinedDate: DateTime(2024, 4, index % 31 + 1),
                    );
                    Navigator.push(context, CardSlideRoute(builder: (_) =>CustomerChatDetailsPage(designer: designer)));
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
                        backgroundColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        child: Icon(Icons.person_4, size: 55),
                      ),
                    ),
                  ),
                  title: Text('${locale!.localization.designerNameLabel} ${index + 1}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.mark_chat_read, size: 15),
                      const SizedBox(width: 5),
                      Text('${locale.localization.notificationsLabel}${index + 1}',
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
