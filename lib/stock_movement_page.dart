import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
import 'stock_movement_history_page.dart';

class StockMovementPage extends StatefulWidget {
  final bool initialIsStockIn;

  const StockMovementPage({super.key, this.initialIsStockIn = true});

  @override
  State<StockMovementPage> createState() => _StockMovementPageState();
}

class _StockMovementPageState extends State<StockMovementPage> {
  late bool _isStockIn;
  String _selectedProduct = 'Vitamin C Serum';
  DateTime _selectedDate = DateTime(2026, 11, 16);
  late String _selectedReason;

  final TextEditingController _quantityController = TextEditingController(
    text: '10',
  );
  final TextEditingController _remarksController = TextEditingController();

  static const List<String> _products = [
    'Vitamin C Serum',
    'Hyaluronic filler 2ml',
    'Peptide serum • Batch PS-67',
    'Skinflix Brightening Serum',
    'Sunscreen SPF 30',
    'Nitrile gloves (M)',
  ];

  static const List<({String code, String label})> _reasons = [
    (code: 'R', label: 'Received'),
    (code: 'S', label: 'Sold'),
    (code: 'T', label: 'Team Purchase'),
    (code: 'X', label: 'Expired/Damaged'),
    (code: 'P', label: 'Professional'),
    (code: 'D', label: 'Demo'),
    (code: 'F', label: 'Free'),
  ];

  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    _isStockIn = widget.initialIsStockIn;
    _selectedReason = _isStockIn ? 'Received' : 'Sold';
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  int get _quantity => int.tryParse(_quantityController.text.trim()) ?? 0;

  void _stepQuantity() {
    final current = _quantity;
    if (_isStockIn) {
      _quantityController.text = '${current + 1}';
    } else if (current > 1) {
      _quantityController.text = '${current - 1}';
    }
    setState(() {});
  }

  String get _currentReasonCode {
    return _reasons
        .firstWhere(
          (r) => r.label == _selectedReason,
          orElse: () => _reasons.first,
        )
        .code;
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_months[date.month - 1]} ${date.year}';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _setMovementType(bool isStockIn) {
    setState(() {
      _isStockIn = isStockIn;
      if (_isStockIn && _selectedReason == 'Sold') {
        _selectedReason = 'Received';
      } else if (!_isStockIn && _selectedReason == 'Received') {
        _selectedReason = 'Sold';
      }
    });
  }

  void _handleSave() {
    final qty = _quantity;
    if (qty <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Enter a valid quantity',
            style: inter(12, w: FontWeight.w500, c: kWhite),
          ),
          backgroundColor: Colors.red.shade700,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final typeLabel = _isStockIn ? 'Stock In' : 'Stock Out';
    final sign = _isStockIn ? '+' : '-';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$typeLabel recorded ($sign$qty): $_selectedProduct',
          style: inter(12, w: FontWeight.w500, c: kWhite),
        ),
        backgroundColor: kDark,
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  Widget _darkBadge({required Widget child}) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: inter(12, w: FontWeight.w500, c: Colors.black54),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Bar (Matches Inventory & History screens)
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
                        'Add Stock Movement',
                        style: playfair(22, w: FontWeight.w600, c: kDark),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StockMovementHistoryPage(),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.history, color: kDark, size: 26),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable Form Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stock In / Stock Out Toggle Tabs
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _setMovementType(true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 11,
                                ),
                                decoration: BoxDecoration(
                                  color: _isStockIn
                                      ? kDark
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: Text(
                                  'Stock In',
                                  textAlign: TextAlign.center,
                                  style: inter(
                                    13,
                                    w: FontWeight.w600,
                                    c: _isStockIn ? kWhite : kDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _setMovementType(false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 11,
                                ),
                                decoration: BoxDecoration(
                                  color: !_isStockIn
                                      ? kDark
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: Text(
                                  'Stock Out',
                                  textAlign: TextAlign.center,
                                  style: inter(
                                    13,
                                    w: FontWeight.w600,
                                    c: !_isStockIn ? kWhite : kDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Product Dropdown
                    _fieldLabel('Product'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedProduct,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: kDark,
                          ),
                          style: inter(13, w: FontWeight.w500, c: kDark),
                          items: _products
                              .map(
                                (product) => DropdownMenuItem<String>(
                                  value: product,
                                  child: Text(product),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedProduct = value);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Quantity Input Card (+ for Stock In, - for Stock Out)
                    _fieldLabel('Quantity'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          _darkBadge(
                            child: Text(
                              '#',
                              style: inter(18, w: FontWeight.w700, c: kWhite),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _quantityController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: inter(14, w: FontWeight.w600, c: kDark),
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: inter(14, c: Colors.black38),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isStockIn ? Icons.add : Icons.remove,
                              size: 22,
                              color: kDark,
                            ),
                            onPressed: _stepQuantity,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Movement Date Field
                    _fieldLabel('Movement Date'),
                    GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            _darkBadge(
                              child: const Icon(
                                Icons.calendar_month_outlined,
                                size: 20,
                                color: kWhite,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _formatDate(_selectedDate),
                                textAlign: TextAlign.center,
                                style: inter(13, w: FontWeight.w500, c: kDark),
                              ),
                            ),
                            const SizedBox(width: 38),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Movement Reason Dropdown
                    _fieldLabel('Movement Reason'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          _darkBadge(
                            child: Text(
                              _currentReasonCode,
                              style: inter(15, w: FontWeight.w700, c: kWhite),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedReason,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: kDark,
                                ),
                                style: inter(13, w: FontWeight.w500, c: kDark),
                                selectedItemBuilder: (context) => _reasons
                                    .map(
                                      (r) => Center(
                                        child: Text(
                                          r.label,
                                          style: inter(
                                            13,
                                            w: FontWeight.w500,
                                            c: kDark,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                items: _reasons
                                    .map(
                                      (r) => DropdownMenuItem<String>(
                                        value: r.label,
                                        child: Text('${r.code} — ${r.label}'),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() => _selectedReason = value);
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Remarks / Notes Box
                    _fieldLabel('Remarks / Notes'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        controller: _remarksController,
                        maxLines: 4,
                        style: inter(13, c: kDark),
                        decoration: InputDecoration(
                          hintText: 'Add optional notes...',
                          hintStyle: inter(12, c: Colors.black38),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Info Notice
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 16,
                          color: Color(0xFF4CAF50),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Stock will be updated after save the movement.',
                            style: inter(11, c: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),

                    // Cancel and Save Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: kWhite,
                                foregroundColor: kDark,
                                side: const BorderSide(color: Colors.black38),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: inter(13, w: FontWeight.w500, c: kDark),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: ElevatedButton.icon(
                              onPressed: _handleSave,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kDark,
                                foregroundColor: kWhite,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.save_outlined, size: 18),
                              label: Text(
                                'Save',
                                style: inter(13, w: FontWeight.w600, c: kWhite),
                              ),
                            ),
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
}
