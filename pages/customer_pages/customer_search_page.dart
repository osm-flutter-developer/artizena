
import 'package:flutter/material.dart';
import 'package:glassify/database/models/design.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/providers/countries.dart';
import 'package:glassify/providers/glassify_user_data_provider.dart';
import 'package:glassify/widgets/customer_card_design.dart';
import 'package:provider/provider.dart';



class CustomerSearchPage extends StatefulWidget {
  const CustomerSearchPage({super.key});

  @override
  State<CustomerSearchPage> createState() => _CustomerSearchPageState();
}

class _CustomerSearchPageState extends State<CustomerSearchPage> {
  final _searchController = TextEditingController();
  int _selectedIndex = -1;
  String currentOrder = 'most recent';
  bool canShowDraggable = false;


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final provider = context.read<AppDataProvider>();
    final localization = provider.localization;

    final borderColor = colors.brightness == Brightness.light ? colors.outlineVariant : colors.outline;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.appName,
          style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Icon(Icons.manage_search_rounded, size: 30),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_rounded),
            onPressed: () { },
          ),
          const SizedBox(width: 5.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) {
            if(index == 0) {
              return Column(
                spacing: 5,
                children: [
                  const SizedBox(height: 10),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    color: colors.surfaceContainerLowest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: borderColor, width: 0.80),
                    ),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Container(
                            width: 50.50,
                            height: 44,
                            margin: const EdgeInsetsDirectional.only(start: 1.0),
                            decoration: BoxDecoration(
                              color: colors.tertiary,
                              borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(8), bottomStart: Radius.circular(8)),
                            ),
                            child: InkWell(
                              onTap: () { },
                              child: Icon(Icons.search_rounded, color: colors.onTertiary),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              cursorHeight: 18,
                              style: textTheme.titleSmall,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: localization.searchHere,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                                isDense: true
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          color: colors.surfaceContainerLowest,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(color: borderColor, width: 0.80),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            splashColor: colors.tertiary,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => FilterSearch(),
                                backgroundColor: Colors.transparent,
                                showDragHandle: true,
                                sheetAnimationStyle: AnimationStyle(
                                  duration: const Duration(milliseconds: 800),
                                ),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadiusDirectional.circular(15),
                                ),
                                constraints: BoxConstraints(
                                  maxHeight: MediaQuery.of(context).size.height * 0.90,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.50),
                              child: Row(
                                children: [
                                  Icon(Icons.tune_rounded, size: 25),
                                  const SizedBox(width: 12),
                                  CircleAvatar(
                                    backgroundColor: colors.tertiary,
                                    radius: 10,
                                    child: Text('6',
                                      style: textTheme.displayMedium?.copyWith(color: colors.onTertiary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ...List.generate(6, (index) {
                          final isSelected = _selectedIndex == index;
                          return FilterChip(
                            shape: RoundedRectangleBorder(
                              side: isSelected ? BorderSide.none : BorderSide(color: borderColor),
                              borderRadius: BorderRadiusDirectional.all(Radius.circular(15)),
                            ),
                            padding: const EdgeInsets.symmetric(),
                            showCheckmark: false,
                            selectedColor: colors.tertiary,
                            backgroundColor: colors.surfaceContainerLowest,
                            labelStyle: TextStyle(
                              color: isSelected ? colors.onTertiary : null,
                            ),
                            selected: index == _selectedIndex,
                            onSelected: (hasSelected) {
                              setState(() => _selectedIndex = hasSelected ? index : -1);
                            },
                            // labelPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                            label: Text(
                              '${localization.categoryLabel} ${localization.formatNumber(index + 1)}',
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localization.getDesignLabel(withPrefix: false, counter: 24),
                          style: textTheme.titleSmall,
                        ),
                        Card(
                          color: colors.surfaceContainerLowest,
                          margin: const EdgeInsetsDirectional.only(end: 0),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.50, color: borderColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DropdownButton<String>(
                            dropdownColor: colors.surfaceContainerLowest,
                            padding: const EdgeInsets.all(5),
                            borderRadius: BorderRadius.circular(15),
                            isDense: true,
                            value: currentOrder,
                            underline: SizedBox.shrink(),
                            icon: SizedBox.shrink(),
                            menuWidth: 212,
                            selectedItemBuilder: (_) => [
                              buildMenuItem(localization.mostRecentLabel, textTheme.labelMedium!, borderColor),
                              buildMenuItem(localization.mostRelevantLabel, textTheme.labelMedium!, borderColor),
                              buildMenuItem(localization.priceLowToHighLabel, textTheme.labelMedium!, borderColor),
                              buildMenuItem(localization.priceHighToLowLabel, textTheme.labelMedium!, borderColor),
                              buildMenuItem(localization.mostPopularLabel, textTheme.labelMedium!, borderColor),
                            ],
                            items: [
                              buildDropdownMenuItem('most recent', localization.mostRecentLabel, textTheme.labelMedium!, colors.tertiary, borderColor),
                              buildDropdownMenuItem('most relevant', localization.mostRelevantLabel, textTheme.labelMedium!, colors.tertiary, borderColor),
                              buildDropdownMenuItem('price low to high', localization.priceLowToHighLabel, textTheme.labelMedium!, colors.tertiary, borderColor),
                              buildDropdownMenuItem('price high to low', localization.priceHighToLowLabel, textTheme.labelMedium!, colors.tertiary, borderColor),
                              buildDropdownMenuItem('most popular', localization.mostPopularLabel, textTheme.labelMedium!, colors.tertiary, null),
                            ],
                            onChanged: (value) => setState(() => currentOrder = value!),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                ],
              );
            }
            return Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: LayoutBuilder(
                  builder: (_, con) {
                    const spacing = 25.0, defaultWidth = 180.0;
                    final width = con.maxWidth >= 590 ? defaultWidth : (con.maxWidth - spacing) / 2;
                    return Wrap(
                      alignment: WrapAlignment.start,
                      spacing: spacing,
                      runSpacing: 20,
                      children: List.generate(12, (index) {
                        final design = Design(
                          rowId: 'glassify-${index + 3}-glassify',
                          date: DateTime(2025, 6, ((index + 2) % 31) + 1),
                          title: '${localization.categoryLabel} ${index + 2}',
                          description: '${localization.describeDesign} ${localization.categoryLabel} ${index + 2}',
                          designerId: context.read<UserDataProvider>().currentUser?.rowId ?? '23423',
                          imagePath: '', otherImagesPaths: {}, transactions: {},
                          likers: {}, dislikers: {}, comments: {},
                          price: (index * 20) + 21, currency: provider.country!.currencySymbol,
                        );
                        return SizedBox(
                          width: width,
                          height: 320,
                          child: CustomerCardDesign(design: design),
                        );
                      }),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildMenuItem(String data, TextStyle style, Color borderColor) {
    return SizedBox(
      width: 165,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 5.0),
              child: Text(data, style: style, overflow: TextOverflow.ellipsis),
            ),
          ),
          VerticalDivider(width: 2, thickness: 0.50, color: borderColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.keyboard_arrow_down_rounded, size: 20),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildDropdownMenuItem(String value, String data, TextStyle style, Color activeColor, Color? borderColor) {
    return DropdownMenuItem<String>(
      value: value,
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                activeColor: activeColor,
                value: value,
                groupValue: currentOrder,
                onChanged: (value) {
                  Navigator.pop(context);
                  setState(() => currentOrder = value!);
                },
              ),
              Text(data, style: style, overflow: TextOverflow.ellipsis),
            ],
          ),
          if(borderColor != null) Divider(height: 0, thickness: 0.50, color: borderColor),
        ],
      ),
    );
  }
}


class FilterSearch extends StatefulWidget {
  const FilterSearch({super.key});

  @override
  State<FilterSearch> createState() => _FilterSearchState();

}

class _FilterSearchState extends State<FilterSearch> {

  late final List<Filter> filters;

  @override
  void initState() {
    super.initState();
    final localization = context.read<AppDataProvider>().localization;
    filters = [
      Filter(
        filterType: localization.priceLabel,
        subTypes: [
          SubFilter(filterName: localization.priceHighToLowLabel),
          SubFilter(filterName: localization.priceLowToHighLabel),
        ],
      ),
      Filter(
        filterType: localization.modelLabel,
        subTypes: [],
      ),
      Filter(
        filterType: localization.designLabel,
        subTypes: [
          SubFilter(filterName: localization.logoLabel),
          SubFilter(filterName: localization.decorateLabel),
          SubFilter(filterName: localization.graphicLabel),
        ],
      ),
      Filter(
        filterType: localization.colorLabel,
        subTypes: [],
      ),
      Filter(
        filterType: localization.originLabel,
        subTypes: [
          ...GlassifyCountry.countries.map((country) {
            return SubFilter(filterName: localization.getCountryName(country.countryCode));
          })
        ],
      ),
      Filter(
        filterType: localization.listingTypeLabel,
        subTypes: [
          SubFilter(filterName: localization.mostRelevantLabel),
          SubFilter(filterName: localization.mostRecentLabel),
          SubFilter(filterName: localization.mostPopularLabel),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.read<AppDataProvider>().localization;
    return Material(
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(15)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              ExpansionPanelList(
                expansionCallback: (index, hasExpanded) {
                  setState(() => filters[index].hasExpanded = hasExpanded);
                },
                expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 4.0),
                dividerColor: Theme.of(context).colorScheme.outline,
                children: List.generate(filters.length, (filterIndex) {
                  return ExpansionPanel(
                    canTapOnHeader: filters[filterIndex].subTypes.isNotEmpty,
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                    isExpanded: filters[filterIndex].subTypes.isNotEmpty ? filters[filterIndex].hasExpanded : false,
                    body: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        spacing: 5.0,
                        children: List.generate(filters[filterIndex].subTypes.length, (subIndex) {
                          return SizedBox(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Theme.of(context).colorScheme.outline),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                                  overlayColor: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () => setState(() => filters[filterIndex].subTypes[subIndex].hasSelected = !filters[filterIndex].subTypes[subIndex].hasSelected),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 30, width: 40,
                                      child: Checkbox(
                                        activeColor: Theme.of(context).colorScheme.primary,
                                        value: filters[filterIndex].subTypes[subIndex].hasSelected,
                                        onChanged: (value) => setState(() => filters[filterIndex].subTypes[subIndex].hasSelected = value ?? false),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        filters[filterIndex].subTypes[subIndex].filterName,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    headerBuilder: (_, value) {
                      return Container(
                        margin: const EdgeInsets.all(0.0),
                        color: Colors.transparent, // Theme.of(context).colorScheme.surfaceContainer,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              filters[filterIndex].filterType,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                      );
                    }
                  );
                }),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                label: Text(
                  localization.filterDesignsLabel,
                ),
                icon: Icon(Icons.filter_1_rounded),
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  foregroundColor: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Filter {
  final String filterType;
  final List<SubFilter> subTypes;

  Filter({required this.filterType, required this.subTypes, this.hasExpanded = false});

  bool hasExpanded = false;
}


class SubFilter {
  final String filterName;
  SubFilter({required this.filterName, this.hasSelected = false});

  bool hasSelected = false;
}
