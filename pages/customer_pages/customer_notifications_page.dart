
import 'package:flutter/material.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:provider/provider.dart';



class CustomerNotificationsPage extends StatefulWidget {
  const CustomerNotificationsPage({super.key});

  @override
  State<CustomerNotificationsPage> createState() => _CustomerNotificationsPageState();
}

class _CustomerNotificationsPageState extends State<CustomerNotificationsPage> {

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppDataProvider>();
    final localization = provider.localization;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.notificationsLabel,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

              ],
            ),
          )
      ),
    );
  }
}
