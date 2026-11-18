import 'package:flutter/material.dart';

import '../theme.dart';
import 'item_details_page.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _searchQuery = '';

  static const List<_InventoryItem> _items = [
    _InventoryItem(
      initials: 'Hf',
      name: 'Hyaluronic filler',
      category: 'Treatment',
      unitText: '12 Units',
      minText: null,
      stockLabel: 'Stock : 4',
      progress: 0.24,
      status: 'Low',
    ),
    _InventoryItem(
      initials: 'VC',
      name: 'Vitamin C serum',
      category: 'Skincare',
      unitText: '4 boxes',
      minText: '• Min 10',
      stockLabel: 'Stock : 40',
      progress: 0.62,
      status: 'In stock',
    ),
    _InventoryItem(
      initials: 'Ng',
      name: 'Nitrile gloves (M)',
      category: 'Treatment',
      unitText: '6 packs',
      minText: '• Min 12',
      stockLabel: 'Stock : 21',
      progress: 0.45,
      status: 'Expiring',
    ),
  ];

  List<_InventoryItem> get _filteredItems {
    return _items.where((item) {
      final matchesCategory =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      final q = _searchQuery.trim().toLowerCase();
      final matchesQuery =
          q.isEmpty ||
          item.name.toLowerCase().contains(q) ||
          item.initials.toLowerCase().contains(q);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openItemDetails() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const ItemDetailsPage()),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: kWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter by Category',
                  style: playfair(18, w: FontWeight.w700, c: kDark),
                ),
                const SizedBox(height: 12),
                ...['All', 'Skincare', 'Treatment'].map((cat) {
                  final selected = _selectedCategory == cat;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      cat,
                      style: inter(
                        14,
                        w: selected ? FontWeight.w600 : FontWeight.w400,
                        c: kDark,
                      ),
                    ),
                    trailing: selected
                        ? const Icon(Icons.check_circle, color: kDark)
                        : null,
                    onTap: () {
                      setState(() => _selectedCategory = cat);
                      Navigator.pop(sheetContext);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = _filteredItems;

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Bar (matches BoMI Insight, BoMI Scan & Alerts height)
            Container(
              width: double.infinity,
              color: kWhite,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
              child: SizedBox(
                height: 34,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Inventory',
                      style: playfair(24, w: FontWeight.w700, c: kDark),
                    ),
                  ],
                ),
              ),
            ),

            // Body Content
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subtitle + total items count
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Find stock and keep up to dates',
                              style: inter(
                                12,
                                w: FontWeight.w400,
                                c: const Color(0xFF8E8E93),
                              ),
                            ),
                            Text(
                              '167 items',
                              style: inter(
                                11,
                                w: FontWeight.w400,
                                c: const Color(0xFF8E8E93),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Search bar with filter sliders icon
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) =>
                                setState(() => _searchQuery = value),
                            style: inter(13, w: FontWeight.w400, c: kDark),
                            decoration: InputDecoration(
                              hintText: 'Search item...',
                              hintStyle: inter(
                                13,
                                w: FontWeight.w400,
                                c: const Color(0xFF8E8E93),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xFF8E8E93),
                                size: 22,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.tune,
                                  color: Color(0xFFD1D5DB),
                                  size: 20,
                                ),
                                onPressed: _showFilterSheet,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // 3 Category tabs: All, Skincare, Treatment
                        Row(
                          children: ['All', 'Skincare', 'Treatment'].map((
                            category,
                          ) {
                            final selected = _selectedCategory == category;
                            final isLast = category == 'Treatment';
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: isLast ? 0 : 10,
                                ),
                                child: GestureDetector(
                                  onTap: () => setState(
                                    () => _selectedCategory = category,
                                  ),
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selected ? kDark : kWhite,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x05000000),
                                          blurRadius: 6,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      category,
                                      style: inter(
                                        12,
                                        w: selected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        c: selected ? kWhite : kDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 14),

                        // Item cards list
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(bottom: 140),
                            itemCount: visibleItems.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return _InventoryCard(
                                item: visibleItems[index],
                                onTap: _openItemDetails,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Teal circular + floating button above bottom nav bar
                  Positioned(
                    right: 22,
                    bottom: 96,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(
                                'Add new inventory item',
                                style: inter(13, w: FontWeight.w500, c: kWhite),
                              ),
                              backgroundColor: kDark,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFF5D8A8C),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.add, color: kWhite, size: 28),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InventoryItem {
  final String initials;
  final String name;
  final String category;
  final String unitText;
  final String? minText;
  final String stockLabel;
  final double progress;
  final String status;

  const _InventoryItem({
    required this.initials,
    required this.name,
    required this.category,
    required this.unitText,
    required this.minText,
    required this.stockLabel,
    required this.progress,
    required this.status,
  });
}

class _InventoryCard extends StatelessWidget {
  final _InventoryItem item;
  final VoidCallback onTap;

  const _InventoryCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color badgeBg;
    Color badgeBorder;
    Color accentColor;

    if (item.status == 'Low') {
      badgeBg = const Color(0xFFFDECEC);
      badgeBorder = const Color(0xFFEF5350);
      accentColor = const Color(0xFFFF2D20);
    } else if (item.status == 'Expiring') {
      badgeBg = const Color(0xFFFEF6DC);
      badgeBorder = const Color(0xFFE6A800);
      accentColor = const Color(0xFFD99B00);
    } else {
      badgeBg = const Color(0xFFE6F7ED);
      badgeBorder = const Color(0xFF4CAF50);
      accentColor = const Color(0xFF28C76F);
    }

    return Material(
      color: kWhite,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left grey initials box
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  item.initials,
                  style: inter(18, w: FontWeight.w700, c: kDark),
                ),
              ),
              const SizedBox(width: 14),

              // Right details + progress bar
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: inter(14, w: FontWeight.w700, c: kDark),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: badgeBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: badgeBorder, width: 1),
                          ),
                          child: Text(
                            item.status,
                            style: inter(
                              10,
                              w: FontWeight.w500,
                              c: accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.unitText,
                      style: inter(
                        11,
                        w: FontWeight.w400,
                        c: const Color(0xFF6B7280),
                      ),
                    ),
                    if (item.minText != null) ...[
                      const SizedBox(height: 1),
                      Text(
                        item.minText!,
                        style: inter(
                          10,
                          w: FontWeight.w400,
                          c: const Color(0xFF8E8E93),
                        ),
                      ),
                    ] else
                      const SizedBox(height: 10),
                    const SizedBox(height: 6),

                    // Progress bar + Stock count + right chevron
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: item.progress,
                              minHeight: 7,
                              backgroundColor: const Color(0xFFEEEEEE),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                accentColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item.stockLabel,
                          style: inter(10, w: FontWeight.w600, c: accentColor),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: Color(0xFF8E8E93),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
