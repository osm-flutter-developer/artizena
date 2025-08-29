
import 'package:flutter/material.dart';
import 'package:glassify/pages/customer_pages/customer_main_page.dart';
import 'package:glassify/pages/designer_pages/designer_main_page.dart';
import 'package:glassify/pages/system_user_pages/system_user_main_page.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/widgets/customer_card_design.dart';
import 'package:glassify/widgets/opacity_button.dart';
import 'package:provider/provider.dart';



class UserLoginPage extends StatefulWidget {
  final dynamic user;
  const UserLoginPage({super.key, required this.user});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  _UserType? userType = _UserType.customer;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final localization = context.read<AppDataProvider>().localization;
    final theme = Theme.of(context);
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.signInLabel,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.colorScheme.surface,
        actions: [
          InkWell(
            splashColor: theme.colorScheme.onPrimary.withValues(alpha: 0.40),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Tooltip(
              message: localization.countryLabel,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Icon(Icons.question_mark_rounded,
                  textDirection: Directionality.of(context) == TextDirection.ltr ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),
            ),
            onTap: () { },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      child: Text(
                        localization.appName,
                        style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(Icons.gas_meter, size: 80),
                    const SizedBox(height: 50),
                    Row(
                      spacing: 10,
                      children: _UserType.values.map((userType) {
                        final isSelected = userType == this.userType;
                        return Expanded(
                          child: ChoiceChip(
                            showCheckmark: false,
                            selectedColor: colors.primary,
                            backgroundColor: colors.surfaceContainer,
                            selected: isSelected,
                            padding: const EdgeInsets.all(0),
                            labelPadding: const EdgeInsets.all(0),
                            labelStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: isSelected ? colors.onPrimary : colors.onSurface,
                            ),
                            onSelected: (value) {
                              if(value) setState(() => this.userType = userType);
                            },
                            label: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(userType.iconData,
                                    color: isSelected ? colors.onPrimary : colors.onSurface,
                                  ),
                                  Text(
                                    localization.getUserNameLabel(userType.name),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      // children: [
                      //   buildUserContainer(userName: localization.customerNameLabel, icon: Icon(Icons.person), userType: _UserType.customer),
                      //   buildUserContainer(userName: localization.designerNameLabel, icon: Icon(Icons.person_4), userType: _UserType.designer),
                      //   buildUserContainer(userName: localization.systemUserLabel, icon: Icon(Icons.person_2), userType: _UserType.systemUser),
                      // ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 45.0,
                      child: TextField(
                        controller: userNameController,
                        style: theme.textTheme.titleSmall,
                        textAlignVertical: TextAlignVertical.bottom,
                        cursorHeight: 18,
                        decoration: InputDecoration(
                          labelText: localization.userNameLabel,
                          labelStyle: theme.textTheme.titleMedium,
                          hintText: localization.enterUserNameLabel,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 45.0,
                      child: TextField(
                        controller: passwordController,
                        style: theme.textTheme.titleSmall,
                        textAlignVertical: TextAlignVertical.bottom,
                        obscureText: !_showPassword,
                        cursorHeight: 18,
                        obscuringCharacter: _showPassword ? '•' : '*',
                        decoration: InputDecoration(
                          labelText: localization.passwordLabel,
                          labelStyle: theme.textTheme.titleMedium,
                          hintText: localization.enterPasswordLabel,
                          hintStyle: theme.textTheme.bodyMedium,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            child: Tooltip(
                              message: localization.passwordLabel,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                child: Icon(_showPassword ? Icons.visibility_sharp : Icons.visibility_off_sharp,
                                  size: 20,
                                ),
                              ),
                            ),
                            onTap: () => setState(() => _showPassword = !_showPassword),
                          ),
                        ),
                        textInputAction: TextInputAction.go,
                        // onEditingComplete: _onUserLoginPage,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OpacityButton(
                          child: Text(
                            localization.forgetPasswordLabel,
                            // textAlign: TextAlign.start,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () { },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LayoutBuilder(
                      builder: (_, con) {
                        // print('max width: ${con.maxWidth}');
                        return ElevatedButton.icon(
                          icon: Icon(Icons.login, size: 28),
                          label: Text(localization.signInLabel,
                            style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(con.maxWidth, 45),
                            minimumSize: Size(200, 45),
                            maximumSize: Size(400, 45),
                            side: BorderSide.none,
                          ),
                          onPressed: _onUserLoginPage,
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const SizedBox(width: 5),
                        OpacityButton(
                          child: Text(
                            localization.createAccountLabel,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () { },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      spacing: 20,
                      children: [
                        SizedBox(
                          width: 110,
                          child: Column(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () { },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  // height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surfaceContainer,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.phone,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                              Text(localization.freePhoneNumberLabel),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: Column(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () { },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  // height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surfaceContainer,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.place_outlined,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                              Text(localization.servicePoints),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 120.0,
                          child: Column(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () { },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  // height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surfaceContainer,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.chat_bubble_outline,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                              Text(localization.customersService,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserContainer({required String userName, required Icon icon, required _UserType userType}) {
    final isSelected = this.userType == userType;
    final colors = Theme.of(context).colorScheme;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() => this.userType = userType);
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainer,
            border: Border.all(
              color: isSelected ? colors.outlineVariant : colors.onSurface,
              width: 1.50,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon.icon,
                color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              Text(
                userName,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onUserLoginPage() async {
    // if(userNameController.text.isEmpty) {
    //   return;
    // }
    // if(passwordController.text.isEmpty) {
    //   return;
    // }
    switch(userType!) {
      case _UserType.customer:
        Navigator.pushReplacement(context, CardSlideRoute(builder: (_) =>CustomerMainPage())); break;
      case _UserType.designer:
        Navigator.pushReplacement(context, CardSlideRoute(builder: (_) =>DesignerMainPage())); break;
      case _UserType.systemUser:
        Navigator.pushReplacement(context, CardSlideRoute(builder: (_) =>SystemUserMainPage())); break;
    }
  }

}


enum _UserType {
  customer(iconData: Icons.person_rounded),
  designer(iconData: Icons.person_4_rounded),
  systemUser(iconData: Icons.person_2_rounded);

  final IconData iconData;
  const _UserType({required this.iconData});
}
