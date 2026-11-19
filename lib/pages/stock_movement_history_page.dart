import 'package:flutter/material.dart';

import '../theme.dart';

class StockMovementHistoryPage extends StatefulWidget {
  const StockMovementHistoryPage({super.key});

  @override
  State<StockMovementHistoryPage> createState() =>
      _StockMovementHistoryPageState();
}

class _StockMovementHistoryPageState extends State<StockMovementHistoryPage> {
  String _selectedTab = 'All';
  String _selectedDateRange = 'Last 30 days';
  int _currentPage = 6;
  static const int _totalPages = 7;

  static const List<_MovementRecord> _records = [
    _MovementRecord(
      initials: 'Hc',
      productName: 'Hydrating Cleanser (P001)',
      timestamp: '26 Oct 2026, 10:30 AM',
      isStockIn: true,
      deltaText: '+11',
      reason: 'Received (Scan #S1235)',
      staff: 'Sarah',
      newBalance: 48,
    ),
    _MovementRecord(
      initials: 'S',
      productName: 'Serum (P002)',
      timestamp: '26 Oct 2026, 10:30 AM',
      isStockIn: true,
      deltaText: '+10',
      reason: 'Received (Scan #S1234)',
      staff: 'Rarah',
      newBalance: 67,
    ),
    _MovementRecord(
      initials: 'Vc',
      productName: 'Vitamin C (P003)',
      timestamp: '26 Oct 2026, 10:31 AM',
      isStockIn: false,
      deltaText: '-7',
      reason: 'Received (Scan #S1236)',
      staff: 'Parah',
      newBalance: 60,
    ),
  ];

  List<_MovementRecord> get _filteredRecords {
    if (_selectedTab == 'In') {
      return _records.where((r) => r.isStockIn).toList();
    }
    if (_selectedTab == 'Out') {
      return _records.where((r) => !r.isStockIn).toList();
    }
    return _records;
  }

  int get _totalCount {
    if (_selectedTab == 'In') return 36;
    if (_selectedTab == 'Out') return 22;
    return 58;
  }

  void _openFilterSheet() {
    const options = ['Today', 'Last 7 days', 'Last 30 days', 'All time'];
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
                  'Filter by Date Range',
                  style: playfair(18, w: FontWeight.w700, c: kDark),
                ),
                const SizedBox(height: 12),
                ...options.map((option) {
                  final selected = _selectedDateRange == option;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      option,
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
                      setState(() {
                        _selectedDateRange = option;
                        _currentPage = 1;
                      });
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
    final visibleRecords = _filteredRecords;

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kDark),
          onPressed: () => Navigator.maybePop(context),
        ),
        titleSpacing: 0,
        title: Text(
          'Movement History',
          style: playfair(20, w: FontWeight.w500, c: kDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: kDark, size: 26),
            tooltip: 'Filter',
            onPressed: _openFilterSheet,
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3-tab filter bar: All, In, Out
              Row(
                children: ['All', 'In', 'Out'].map((tab) {
                  final isSelected = _selectedTab == tab;
                  final isLast = tab == 'Out';
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: isLast ? 0 : 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTab = tab;
                            _currentPage = tab == 'All' ? 6 : 1;
                          });
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? kDark : kWhite,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x06000000),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            tab,
                            style: inter(
                              13,
                              w: isSelected ? FontWeight.w600 : FontWeight.w500,
                              c: isSelected ? kWhite : kDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Total Movements counter
              Text(
                'Total Movements : $_totalCount',
                style: inter(
                  13,
                  w: FontWeight.w400,
                  c: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 10),

              // Movement cards list
              Expanded(
                child: ListView.separated(
                  itemCount: visibleRecords.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _MovementCard(record: visibleRecords[index]);
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Bottom dark pill pagination bar
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const ShapeDecoration(
                  color: kDark,
                  shape: StadiumBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: _currentPage > 1
                            ? const Color(0xFFD1D5DB)
                            : const Color(0xFF6B7280),
                        size: 26,
                      ),
                      onPressed: _currentPage > 1
                          ? () => setState(() => _currentPage--)
                          : null,
                    ),
                    Text(
                      'Page $_currentPage of $_totalPages',
                      style: inter(13, w: FontWeight.w600, c: kWhite),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        color: _currentPage < _totalPages
                            ? const Color(0xFFD1D5DB)
                            : const Color(0xFF6B7280),
                        size: 26,
                      ),
                      onPressed: _currentPage < _totalPages
                          ? () => setState(() => _currentPage++)
                          : null,
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

class _MovementRecord {
  final String initials;
  final String productName;
  final String timestamp;
  final bool isStockIn;
  final String deltaText;
  final String reason;
  final String staff;
  final int newBalance;

  const _MovementRecord({
    required this.initials,
    required this.productName,
    required this.timestamp,
    required this.isStockIn,
    required this.deltaText,
    required this.reason,
    required this.staff,
    required this.newBalance,
  });
}

class _MovementCard extends StatelessWidget {
  final _MovementRecord record;

  const _MovementCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final accentColor = record.isStockIn
        ? const Color(0xFF28C76F)
        : const Color(0xFFFF3B30);
    final statusLabel = record.isStockIn ? 'Stock-in' : 'Stock-Out';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top timestamp + Stock-in / Stock-Out status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                record.timestamp,
                style: inter(
                  11,
                  w: FontWeight.w400,
                  c: const Color(0xFF9CA3AF),
                ),
              ),
              Text(
                statusLabel,
                style: inter(11, w: FontWeight.w600, c: accentColor),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Avatar + Product details + Circular quantity delta badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  record.initials,
                  style: inter(16, w: FontWeight.w700, c: kDark),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.productName,
                      style: inter(13, w: FontWeight.w700, c: kDark),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Reason : ${record.reason}',
                      style: inter(
                        11,
                        w: FontWeight.w400,
                        c: const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Staff : ${record.staff}',
                      style: inter(
                        11,
                        w: FontWeight.w400,
                        c: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
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

          // Bottom balance footer
          Text(
            'New Balance : ${record.newBalance} units',
            style: inter(11, w: FontWeight.w400, c: const Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }
}
