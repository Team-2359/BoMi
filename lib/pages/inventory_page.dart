import 'package:flutter/material.dart';

import '../theme.dart';

enum _StockStatus { low, inStock, expiring }

class _InventoryItem {
  final String initials;
  final String name;
  final String category;
  final String unitSummary;
  final String? minLabel;
  final int currentStock;
  final double progress;
  final _StockStatus status;

  const _InventoryItem({
    required this.initials,
    required this.name,
    required this.category,
    required this.unitSummary,
    this.minLabel,
    required this.currentStock,
    required this.progress,
    required this.status,
  });
}

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  static const List<String> _categories = ['All', 'Skincare', 'Treatment'];

  static const List<_InventoryItem> _allItems = [
    _InventoryItem(
      initials: 'Hf',
      name: 'Hyaluronic filler',
      category: 'Treatment',
      unitSummary: '12 Units',
      currentStock: 4,
      progress: 0.28,
      status: _StockStatus.low,
    ),
    _InventoryItem(
      initials: 'VC',
      name: 'Vitamin C serum',
      category: 'Skincare',
      unitSummary: '4 boxes',
      minLabel: 'Min 10',
      currentStock: 40,
      progress: 0.62,
      status: _StockStatus.inStock,
    ),
    _InventoryItem(
      initials: 'Ng',
      name: 'Nitrile gloves (M)',
      category: 'Treatment',
      unitSummary: '6 packs',
      minLabel: 'Min 12',
      currentStock: 21,
      progress: 0.44,
      status: _StockStatus.expiring,
    ),
    _InventoryItem(
      initials: 'Ps',
      name: 'Peptide serum',
      category: 'Skincare',
      unitSummary: '8 bottles',
      minLabel: 'Min 10',
      currentStock: 18,
      progress: 0.55,
      status: _StockStatus.inStock,
    ),
    _InventoryItem(
      initials: 'Ss',
      name: 'Sunscreen SPF 30',
      category: 'Skincare',
      unitSummary: '5 tubes',
      minLabel: 'Min 8',
      currentStock: 5,
      progress: 0.30,
      status: _StockStatus.low,
    ),
  ];

  List<_InventoryItem> get _filteredItems {
    return _allItems.where((item) {
      final matchesCategory =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      final query = _searchQuery.trim().toLowerCase();
      final matchesQuery =
          query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Bar
                Container(
                  width: double.infinity,
                  color: kWhite,
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  child: SizedBox(
                    height: 36,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Inventory',
                        style: playfair(26, w: FontWeight.w700),
                      ),
                    ),
                  ),
                ),

                // Subtitle, Search Bar & Category Filter Pills
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Find stock and keep up to dates',
                            style: inter(12, c: Colors.black54),
                          ),
                          Text(
                            '167 items',
                            style: inter(11, c: Colors.black45),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Search Bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              color: Colors.black45,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) =>
                                    setState(() => _searchQuery = value),
                                style: inter(13, c: kDark),
                                decoration: InputDecoration(
                                  hintText: 'Search item...',
                                  hintStyle: inter(13, c: Colors.black45),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                  ),
                                ),
                              ),
                            ),
                            if (_searchQuery.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 18,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            const Icon(
                              Icons.tune_rounded,
                              color: Colors.black38,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Category Filter Pills
                      Row(
                        children: List.generate(_categories.length, (index) {
                          final category = _categories[index];
                          final isSelected = _selectedCategory == category;

                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: index < _categories.length - 1 ? 10 : 0,
                              ),
                              child: GestureDetector(
                                onTap: () => setState(
                                  () => _selectedCategory = category,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected ? kDark : kWhite,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.03,
                                        ),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    category,
                                    textAlign: TextAlign.center,
                                    style: inter(
                                      13,
                                      w: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      c: isSelected ? kWhite : kDark,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),

                // Scrollable Product Cards List
                Expanded(
                  child: items.isEmpty
                      ? Center(
                          child: Text(
                            'No items found',
                            style: inter(13, c: Colors.black45),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
                          itemCount: items.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return _InventoryCard(
                              item: items[index],
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Selected ${items[index].name}',
                                      style: inter(
                                        12,
                                        w: FontWeight.w500,
                                        c: kWhite,
                                      ),
                                    ),
                                    backgroundColor: kDark,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),

            // Floating Circular Plus Button
            Positioned(
              right: 20,
              bottom: 102,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Add new inventory item',
                        style: inter(12, w: FontWeight.w500, c: kWhite),
                      ),
                      backgroundColor: kDark,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF618F94),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add_rounded, color: kWhite, size: 28),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InventoryCard extends StatelessWidget {
  final _InventoryItem item;
  final VoidCallback onTap;

  const _InventoryCard({required this.item, required this.onTap});

  Color get _accentColor {
    switch (item.status) {
      case _StockStatus.low:
        return const Color(0xFFE53935);
      case _StockStatus.inStock:
        return const Color(0xFF16695C);
      case _StockStatus.expiring:
        return const Color(0xFFD99B26);
    }
  }

  Color get _pillBgColor {
    switch (item.status) {
      case _StockStatus.low:
        return const Color(0xFFFDECEA);
      case _StockStatus.inStock:
        return const Color(0xFFE3F1EC);
      case _StockStatus.expiring:
        return const Color(0xFFFEF5E0);
    }
  }

  String get _statusLabel {
    switch (item.status) {
      case _StockStatus.low:
        return 'Low';
      case _StockStatus.inStock:
        return 'In stock';
      case _StockStatus.expiring:
        return 'Expiring';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFECECEC),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                item.initials,
                style: inter(16, w: FontWeight.w700, c: kDark),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: inter(14, w: FontWeight.w700, c: kDark),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _pillBgColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _accentColor.withValues(alpha: 0.7),
                            width: 0.9,
                          ),
                        ),
                        child: Text(
                          _statusLabel,
                          style: inter(10, w: FontWeight.w600, c: _accentColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(item.unitSummary, style: inter(11, c: Colors.black54)),
                  if (item.minLabel != null) ...[
                    const SizedBox(height: 1),
                    Text(
                      '• ${item.minLabel}',
                      style: inter(10, c: Colors.black45),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 7,
                          decoration: BoxDecoration(
                            color: const Color(0xFFBDBDBD),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: item.progress.clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _accentColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Stock : ${item.currentStock}',
                        style: inter(10, w: FontWeight.w600, c: _accentColor),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: Colors.black38,
                      ),
                    ],
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
