
import 'package:flutter/material.dart';
import 'package:glassify/pages/customer_pages/customer_chats_page.dart';
import 'package:glassify/pages/customer_pages/customer_notifications_page.dart';
import 'package:glassify/pages/app_settings_page.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/widgets/customer_card_design.dart';
import 'package:provider/provider.dart';


class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = context.read<AppDataProvider>();
    final localization = provider.localization;
    final colors = Theme.of(context).colorScheme;
    final design = 10;
    final borderColor = colors.brightness == Brightness.light ? colors.outlineVariant : colors.outline;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.surfaceContainerLowest,
              foregroundColor: colors.error,
              side: BorderSide(color: borderColor),
              shape: CircleBorder(),
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () { },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Tooltip(
                message: localization.likesLabel,
                child: Icon(Icons.favorite, size: 27),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.surfaceContainerLowest,
              foregroundColor: colors.onSurface,
              side: BorderSide(color: borderColor),
              shape: CircleBorder(),
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () {
              Navigator.push(context, CardDownRoute(builder: (_) => AppSettingsPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Tooltip(
                message: localization.settingsLabel,
                child: Icon(Icons.settings_rounded, size: 27),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            SizedBox(
                              width: 80, height: 80,
                              child: Dialog(
                                backgroundColor: colors.surfaceContainer,
                                surfaceTintColor: Colors.transparent,
                                shape: CircleBorder(
                                  side: BorderSide(color: colors.primary),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: FlutterLogo(size: 100),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: colors.primary,
                              child: Icon(Icons.person_sharp, color: colors.onPrimary, size: 20),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: [
                            Text(localization.designerNameLabel,
                              style: textTheme.titleMedium,
                            ),
                            Text(localization.joinedIn,
                              style: textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0, top: 4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.surfaceContainerLowest,
                        foregroundColor: colors.onSurface,
                        side: BorderSide(color: borderColor),
                        shape: CircleBorder(),
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        // Navigator.push(context, CardDownRoute(builder: (_) => AppSettingsPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Tooltip(
                          message: localization.editProfileLabel,
                          child: Icon(Icons.edit_rounded, size: 27),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 20.0,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: colors.primary, width: 0.75),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localization.formatNumber((design + 1) * 5),
                            style: textTheme.bodyLarge,
                          ),
                          Text(
                            localization.transactionLabel,
                            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: colors.primary, width: 0.75),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localization.formatNumber((design + 1) * 3),
                            style: textTheme.bodyLarge,
                          ),
                          Text(
                            localization.followedDesignerLabel,
                            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: colors.primary, width: 0.75),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localization.formatNumber((design + 1) * 8),
                            style: textTheme.bodyLarge,
                          ),
                          Text(
                            localization.likesLabel,
                            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.chat_sharp, size: 20),
                      onPressed: () {
                        Navigator.push(context, CardSlideRoute(builder: (_) => CustomerChatsPage()));
                      },
                      label: Text(
                        localization.chatsLabel.toUpperCase(),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.transparent, width: 1.50),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.notifications_on, size: 20),
                      onPressed: () {
                        Navigator.push(context, CardSlideRoute(builder: (_) => CustomerNotificationsPage()));
                      },
                      label: Text(
                        localization.notificationsLabel.toUpperCase(),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.transparent, width: 1.50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
            ListTile(
              title: Text(localization.phoneNumberLabel,
                style: textTheme.labelMedium,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              onTap: () { },
            ),
            const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
            ListTile(
              title: Text(localization.changePasswordLabel,
                style: textTheme.labelMedium,
              ),
              contentPadding: const EdgeInsetsDirectional.only(start: 15, end: 10),
              onTap: () { },
            ),
            const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
            ListTile(
              title: Text(localization.deleteAccountLabel,
                style: textTheme.labelMedium,
              ),
              contentPadding: const EdgeInsetsDirectional.only(start: 15, end: 10),
              onTap: () { },
            ),
            const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
            ListTile(
              title: Text(localization.signOutLabel,
                style: textTheme.labelMedium,
              ),
              contentPadding: const EdgeInsetsDirectional.only(start: 15, end: 10),
              onTap: () { },
            ),
            const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
          ],
        ),
      ),
    );
  }

}


