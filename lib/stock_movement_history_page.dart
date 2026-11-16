import 'package:flutter/material.dart';

import '../theme.dart';

class _MovementRecord {
  final int page;
  final String timestamp;
  final String initials;
  final String productName;
  final String productCode;
  final String categoryKey;
  final bool isStockIn;
  final String deltaText;
  final String reasonText;
  final String staffName;
  final String newBalanceText;

  const _MovementRecord({
    required this.page,
    required this.timestamp,
    required this.initials,
    required this.productName,
    required this.productCode,
    required this.categoryKey,
    required this.isStockIn,
    required this.deltaText,
    required this.reasonText,
    required this.staffName,
    required this.newBalanceText,
  });
}

class StockMovementHistoryPage extends StatefulWidget {
  const StockMovementHistoryPage({super.key});

  @override
  State<StockMovementHistoryPage> createState() =>
      _StockMovementHistoryPageState();
}

class _StockMovementHistoryPageState extends State<StockMovementHistoryPage> {
  String _selectedDateRange = 'Last 30 days';
  String _selectedType = 'All types';
  String _selectedCategory = 'All products';
  int _currentPage = 6;

  static const int _defaultTotalPages = 7;
  static const int _pageSize = 3;

  static const List<String> _dateRanges = [
    'Last 30 days',
    'Last 7 days',
    'Last 90 days',
    'All time',
  ];

  static const List<String> _movementTypes = [
    'All types',
    'Stock-in',
    'Stock-Out',
  ];

  static const List<String> _categories = [
    'All products',
    'Hydrating Cleanser',
    'Serum',
    'Vitamin C',
  ];

  static const List<_MovementRecord> _allRecords = [
    // Page 1
    _MovementRecord(
      page: 1,
      timestamp: '20 Oct 2026, 09:15 AM',
      initials: 'Hc',
      productName: 'Hydrating Cleanser',
      productCode: 'P001',
      categoryKey: 'Hydrating Cleanser',
      isStockIn: true,
      deltaText: '+12',
      reasonText: 'Reason : Received (Scan #S1220)',
      staffName: 'Sarah',
      newBalanceText: 'New Balance : 35 units',
    ),
    _MovementRecord(
      page: 1,
      timestamp: '20 Oct 2026, 11:40 AM',
      initials: 'S',
      productName: 'Serum',
      productCode: 'P002',
      categoryKey: 'Serum',
      isStockIn: false,
      deltaText: '-4',
      reasonText: 'Reason : Sold (Manual)',
      staffName: 'Sarah',
      newBalanceText: 'New Balance : 53 units',
    ),
    _MovementRecord(
      page: 1,
      timestamp: '21 Oct 2026, 02:10 PM',
      initials: 'Vc',
      productName: 'Vitamin C',
      productCode: 'P003',
      categoryKey: 'Vitamin C',
      isStockIn: true,
      deltaText: '+15',
      reasonText: 'Reason : Received (Scan #S1222)',
      staffName: 'Rarah',
      newBalanceText: 'New Balance : 72 units',
    ),

    // Page 2
    _MovementRecord(
      page: 2,
      timestamp: '22 Oct 2026, 10:05 AM',
      initials: 'Hc',
      productName: 'Hydrating Cleanser',
      productCode: 'P001',
      categoryKey: 'Hydrating Cleanser',
      isStockIn: false,
      deltaText: '-3',
      reasonText: 'Reason : Professional (Manual)',
      staffName: 'Parah',
      newBalanceText: 'New Balance : 32 units',
    ),
    _MovementRecord(
      page: 2,
      timestamp: '22 Oct 2026, 03:20 PM',
      initials: 'S',
      productName: 'Serum',
      productCode: 'P002',
      categoryKey: 'Serum',
      isStockIn: true,
      deltaText: '+8',
      reasonText: 'Reason : Received (Scan #S1225)',
      staffName: 'Sarah',
      newBalanceText: 'New Balance : 61 units',
    ),
    _MovementRecord(
      page: 2,
      timestamp: '23 Oct 2026, 01:45 PM',
      initials: 'Vc',
      productName: 'Vitamin C',
      productCode: 'P003',
      categoryKey: 'Vitamin C',
      isStockIn: false,
      deltaText: '-5',
      reasonText: 'Reason : Sold (Manual)',
      staffName: 'Rarah',
      newBalanceText: 'New Balance : 67 units',
    ),

    // Page 3
    _MovementRecord(
      page: 3,
      timestamp: '24 Oct 2026, 09:30 AM',
      initials: 'Hc',
      productName: 'Hydrating Cleanser',
      productCode: 'P001',
      categoryKey: 'Hydrating Cleanser',
      isStockIn: true,
      deltaText: '+9',
      reasonText: 'Reason : Received (Scan #S1228)',
      staffName: 'Sarah',
      newBalanceText: 'New Balance : 41 units',
    ),
    _MovementRecord(
      page: 3,
      timestamp: '24 Oct 2026, 12:15 PM',
      initials: 'S',
      productName: 'Serum',
      productCode: 'P002',
      categoryKey: 'Serum',
      isStockIn: false,
      deltaText: '-4',
      reasonText: 'Reason : Demo (Manual)',
      staffName: 'Parah',
      newBalanceText: 'New Balance : 57 units',
    ),
    _MovementRecord(
      page: 3,
      timestamp: '24 Oct 2026, 04:50 PM',
      initials: 'Vc',
      productName: 'Vitamin C',
      productCode: 'P003',
      categoryKey: 'Vitamin C',
      isStockIn: true,
      deltaText: '+6',
      reasonText: 'Reason : Received (Scan #S1229)',
      staffName: 'Sarah',
      newBalanceText: 'New Balance : 73 units',
    ),

    // Page 4
    _MovementRecord(
      page: 4,
      timestamp: '25 Oct 2026, 10:10 AM',
      initials: 'Hc',
      productName: 'Hydrating Cleanser',
      productCode: 'P001',
      categoryKey: 'Hydrating Cleanser',
      isStockIn: false,
      deltaText: '-4',
      reasonText: 'Reason : Sold (Manual)',
      staffName: 'Rarah',
      newBalanceText: 'New Balance : 37 units',
    ),
    _MovementRecord(
      page: 4,
      timestamp: '25 Oct 2026, 01:30 PM',
      initials: 'S',
      productName: 'Serum',
      productCode: 'P002',
      categoryKey: 'Serum',
      isStockIn: true,
      deltaText: '+5',
      reasonText: 'Reason : Received (Scan #S1231)',
      staffName: 'Sarah',
      newBalanceText: 'New Balance : 62 units',
    ),
    _MovementRecord(
      page: 4,
      timestamp: '25 Oct 2026, 05:00 PM',
      initials: 'Vc',
      productName: 'Vitamin C',
      productCode: 'P003',
      categoryKey: 'Vitamin C',
      isStockIn: false,
      deltaText: '-6',
      reasonText: 'Reason : Sold (Manual)',
      staffName: 'Parah',
      newBalanceText: 'New Balance : 67 units',
    ),

    // Page 5
    _MovementRecord(
      page: 5,
      timestamp: '26 Oct 2026, 08:45 AM',
      initials: 'Hc',
      productName: 'Hydrating Cleanser',
      productCode: 'P001',
      categoryKey: 'Hydrating Cleanser',
      isStockIn: false,
      deltaText: '-2',
      reasonText: 'Reason : Sold (Manual)',
      staffName: 'Sarah',
      newBalanceText: 'New Balance : 37 units',
    ),
    _MovementRecord(
      page: 5,
      timestamp: '26 Oct 2026, 09:20 AM',
      initials: 'S',
      productName: 'Serum',
      productCode: 'P002',
      categoryKey: 'Serum',
      isStockIn: false,
      deltaText: '-5',
      reasonText: 'Reason : Professional (Manual)',
      staffName: 'Rarah',
      newBalanceText: 'New Balance : 57 units',
    ),
    _MovementRecord(
      page: 5,
      timestamp: '26 Oct 2026, 09:55 AM',
      initials: 'Vc',
      productName: 'Vitamin C',
      productCode: 'P003',
      categoryKey: 'Vitamin C',
      isStockIn: true,
      deltaText: '+3',
      reasonText: 'Reason : Received (Scan #S1233)',
      staffName: 'Sarah',
      newBalanceText: 'New Balance : 67 units',
    ),

    // Page 6 (Matches wireframe layout)
    _MovementRecord(
      page: 6,
      timestamp: '26 Oct 2026, 10:30 AM',
      initials: 'Hc',
      productName: 'Hydrating Cleanser',
      productCode: 'P001',
      categoryKey: 'Hydrating Cleanser',
      isStockIn: true,
      deltaText: '+11',
      reasonText: 'Reason : Received (Scan #S1235)',
      staffName: 'Sarah',
      newBalanceText: 'New Balance : 48 units',
    ),
    _MovementRecord(
      page: 6,
      timestamp: '26 Oct 2026, 10:30 AM',
      initials: 'S',
      productName: 'Serum',
      productCode: 'P002',
      categoryKey: 'Serum',
      isStockIn: true,
      deltaText: '+10',
      reasonText: 'Reason : Received (Scan #S1234)',
      staffName: 'Rarah',
      newBalanceText: 'New Balance : 67 units',
    ),
    _MovementRecord(
      page: 6,
      timestamp: '26 Oct 2026, 10:31 AM',
      initials: 'Vc',
      productName: 'Vitamin C',
      productCode: 'P003',
      categoryKey: 'Vitamin C',
      isStockIn: false,
      deltaText: '-7',
      reasonText: 'Reason : Received (Scan #S1236)',
      staffName: 'Parah',
      newBalanceText: 'New Balance : 60 units',
    ),

    // Page 7
    _MovementRecord(
      page: 7,
      timestamp: '26 Oct 2026, 11:15 AM',
      initials: 'Hc',
      productName: 'Hydrating Cleanser',
      productCode: 'P001',
      categoryKey: 'Hydrating Cleanser',
      isStockIn: true,
      deltaText: '+6',
      reasonText: 'Reason : Received (Scan #S1237)',
      staffName: 'Sarah',
      newBalanceText: 'New Balance : 54 units',
    ),
  ];

  bool get _isUnfiltered =>
      _selectedDateRange == 'Last 30 days' &&
      _selectedType == 'All types' &&
      _selectedCategory == 'All products';

  List<_MovementRecord> get _filteredRecords {
    return _allRecords.where((record) {
      final matchesType =
          _selectedType == 'All types' ||
          (_selectedType == 'Stock-in' && record.isStockIn) ||
          (_selectedType == 'Stock-Out' && !record.isStockIn);

      final matchesCategory =
          _selectedCategory == 'All products' ||
          record.categoryKey == _selectedCategory;

      return matchesType && matchesCategory;
    }).toList();
  }

  int get _totalPages {
    if (_isUnfiltered) return _defaultTotalPages;
    final count = _filteredRecords.length;
    if (count == 0) return 1;
    return (count / _pageSize).ceil();
  }

  List<_MovementRecord> get _visibleRecords {
    final filtered = _filteredRecords;
    if (_isUnfiltered) {
      return filtered.where((r) => r.page == _currentPage).toList();
    }
    final start = (_currentPage - 1) * _pageSize;
    if (start >= filtered.length) return const [];
    final end = (start + _pageSize).clamp(0, filtered.length);
    return filtered.sublist(start, end);
  }

  int get _displayedTotalCount => _isUnfiltered ? 58 : _filteredRecords.length;

  void _goToPage(int page) {
    final maxPage = _totalPages;
    if (page < 1 || page > maxPage || page == _currentPage) return;
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    final records = _visibleRecords;
    final totalPages = _totalPages;

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Bar
            Container(
              width: double.infinity,
              color: kWhite,
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: SizedBox(
                height: 36,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.arrow_back, color: kDark, size: 22),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Stock Movement History',
                        style: playfair(22, w: FontWeight.w600, c: kDark),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Labeled Filter Dropdowns & Total Count
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _LabeledDropdownFilter(
                          label: 'Date range',
                          value: _selectedDateRange,
                          items: _dateRanges,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedDateRange = val;
                                _currentPage =
                                    val == 'Last 30 days' && _isUnfiltered
                                    ? 6
                                    : 1;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _LabeledDropdownFilter(
                          label: 'Types',
                          value: _selectedType,
                          items: _movementTypes,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedType = val;
                                _currentPage =
                                    val == 'All types' && _isUnfiltered ? 6 : 1;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _LabeledDropdownFilter(
                          label: 'Categories',
                          value: _selectedCategory,
                          items: _categories,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedCategory = val;
                                _currentPage =
                                    val == 'All products' && _isUnfiltered
                                    ? 6
                                    : 1;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Total Movements : $_displayedTotalCount',
                    style: inter(12, w: FontWeight.w500, c: Colors.black54),
                  ),
                ],
              ),
            ),

            // Scrollable Movement Cards List
            Expanded(
              child: records.isEmpty
                  ? Center(
                      child: Text(
                        'No stock movements yet',
                        style: inter(13, c: Colors.black45),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                      itemCount: records.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return _MovementHistoryCard(record: records[index]);
                      },
                    ),
            ),

            // Dark Rounded Pill Pagination Bar
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: kDark,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.14),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _currentPage > 1
                            ? () => _goToPage(_currentPage - 1)
                            : null,
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          size: 28,
                          color: _currentPage > 1
                              ? Colors.white70
                              : Colors.white24,
                        ),
                      ),
                      Text(
                        'Page $_currentPage of $totalPages',
                        style: inter(13, w: FontWeight.w700, c: kWhite),
                      ),
                      IconButton(
                        onPressed: _currentPage < totalPages
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                        icon: Icon(
                          Icons.chevron_right_rounded,
                          size: 28,
                          color: _currentPage < totalPages
                              ? Colors.white70
                              : Colors.white24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledDropdownFilter extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _LabeledDropdownFilter({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 5),
          child: Text(
            label,
            style: inter(10.5, w: FontWeight.w500, c: Colors.black45),
          ),
        ),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              isDense: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: Colors.black54,
              ),
              style: inter(11, w: FontWeight.w500, c: kDark),
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        style: inter(11, w: FontWeight.w500, c: kDark),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _MovementHistoryCard extends StatelessWidget {
  final _MovementRecord record;

  const _MovementHistoryCard({required this.record});

  static const Color _stockInTeal = Color(0xFF538E93);
  static const Color _stockOutRed = Color(0xFFFF2626);

  @override
  Widget build(BuildContext context) {
    final badgeColor = record.isStockIn ? _stockInTeal : _stockOutRed;
    final statusText = record.isStockIn ? 'Stock-in' : 'Stock-Out';

    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(record.timestamp, style: inter(11, c: Colors.black45)),
              Text(
                statusText,
                style: inter(11, w: FontWeight.w600, c: badgeColor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Initials Avatar Badge
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFECECEC),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  record.initials,
                  style: inter(16, w: FontWeight.w700, c: kDark),
                ),
              ),
              const SizedBox(width: 12),

              // Product Info, Reason & Staff
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${record.productName} (${record.productCode})',
                      style: inter(13.5, w: FontWeight.w700, c: kDark),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      record.reasonText,
                      style: inter(11.5, c: Colors.black54),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Staff : ${record.staffName}',
                      style: inter(11.5, c: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Circular Quantity Delta Badge
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  record.deltaText,
                  style: inter(12, w: FontWeight.w700, c: kWhite),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
          ),
          Text(
            record.newBalanceText,
            style: inter(11.5, w: FontWeight.w500, c: Colors.black54),
          ),
        ],
      ),
    );
  }
}
