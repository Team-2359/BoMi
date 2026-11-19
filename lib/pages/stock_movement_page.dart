import 'package:flutter/material.dart';

import '../theme.dart';
import 'stock_movement_history_page.dart';

class StockMovementPage extends StatefulWidget {
  final bool initialIsStockOut;

  const StockMovementPage({super.key, this.initialIsStockOut = false});

  @override
  State<StockMovementPage> createState() => _StockMovementPageState();
}

class _StockMovementPageState extends State<StockMovementPage> {
  late bool _isStockOut;
  late _ProductOption _selectedProduct;
  int _quantity = 10;
  DateTime _movementDate = DateTime(2026, 11, 16);
  DateTime _expiryDate = DateTime(2028, 10, 29);
  late _ReasonOption _selectedReason;
  final TextEditingController _remarksController = TextEditingController();

  static const List<_ProductOption> _products = [
    _ProductOption(
      name: 'Vitamin C Serum',
      unit: 'btl',
      currentStock: 14,
      minStock: 10,
    ),
    _ProductOption(
      name: 'Hyaluronic Filler',
      unit: 'box',
      currentStock: 4,
      minStock: 12,
    ),
    _ProductOption(
      name: 'Hydrating Cleanser',
      unit: 'unit',
      currentStock: 48,
      minStock: 15,
    ),
    _ProductOption(
      name: 'Nitrile Gloves (M)',
      unit: 'pack',
      currentStock: 6,
      minStock: 12,
    ),
  ];

  static const List<_ReasonOption> _reasons = [
    _ReasonOption(code: 'R', label: 'Received'),
    _ReasonOption(code: 'S', label: 'Sold'),
    _ReasonOption(code: 'T', label: 'Team Purchase'),
    _ReasonOption(code: 'X', label: 'Expired / Damaged'),
    _ReasonOption(code: 'P', label: 'Professional'),
    _ReasonOption(code: 'D', label: 'Demo'),
    _ReasonOption(code: 'F', label: 'Free'),
  ];

  @override
  void initState() {
    super.initState();
    _isStockOut = widget.initialIsStockOut;
    _selectedProduct = _products.first;
    _selectedReason = _isStockOut ? _reasons[1] : _reasons.first;
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  int get _projectedStock {
    return _isStockOut
        ? _selectedProduct.currentStock - _quantity
        : _selectedProduct.currentStock + _quantity;
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  void _switchMovementType(bool isOut) {
    if (_isStockOut == isOut) return;
    setState(() {
      _isStockOut = isOut;
      _selectedReason = isOut ? _reasons[1] : _reasons.first;
    });
  }

  Future<void> _pickDate({required bool isMovementDate}) async {
    final initial = isMovementDate ? _movementDate : _expiryDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kDark,
              onPrimary: kWhite,
              onSurface: kDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isMovementDate) {
          _movementDate = picked;
        } else {
          _expiryDate = picked;
        }
      });
    }
  }

  Future<void> _editQuantityDialog() async {
    final controller = TextEditingController(text: '$_quantity');
    final result = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: kWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Enter Quantity (${_selectedProduct.unit})',
            style: playfair(18, w: FontWeight.w700, c: kDark),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            style: inter(15, w: FontWeight.w600, c: kDark),
            decoration: InputDecoration(
              hintText: 'Quantity',
              hintStyle: inter(13, c: const Color(0xFF9CA3AF)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: inter(
                  13,
                  w: FontWeight.w500,
                  c: const Color(0xFF6B7280),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final parsed = int.tryParse(controller.text.trim());
                if (parsed != null && parsed > 0) {
                  Navigator.pop(dialogContext, parsed);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kDark,
                foregroundColor: kWhite,
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Apply',
                style: inter(13, w: FontWeight.w600, c: kWhite),
              ),
            ),
          ],
        );
      },
    );
    controller.dispose();
    if (result != null && result > 0) {
      setState(() => _quantity = result);
    }
  }

  void _showProductPicker() {
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
                  'Select Product',
                  style: playfair(18, w: FontWeight.w700, c: kDark),
                ),
                const SizedBox(height: 12),
                ..._products.map((product) {
                  final selected = product.name == _selectedProduct.name;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      product.name,
                      style: inter(
                        14,
                        w: selected ? FontWeight.w600 : FontWeight.w400,
                        c: kDark,
                      ),
                    ),
                    subtitle: Text(
                      'Current stock: ${product.currentStock} ${product.unit}',
                      style: inter(12, c: const Color(0xFF6B7280)),
                    ),
                    trailing: selected
                        ? const Icon(Icons.check_circle, color: kDark)
                        : null,
                    onTap: () {
                      setState(() => _selectedProduct = product);
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

  void _showReasonPicker() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: kWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Movement Reason',
                  style: playfair(18, w: FontWeight.w700, c: kDark),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _reasons.map((reason) {
                        final selected = reason.code == _selectedReason.code;
                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: kDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              reason.code,
                              style: inter(13, w: FontWeight.w700, c: kWhite),
                            ),
                          ),
                          title: Text(
                            reason.label,
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
                            setState(() => _selectedReason = reason);
                            Navigator.pop(sheetContext);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveMovement() {
    if (_quantity <= 0) {
      _showSnackBar('Enter a valid quantity.');
      return;
    }
    if (_isStockOut && _quantity > _selectedProduct.currentStock) {
      _showSnackBar('Quantity cannot exceed available stock.');
      return;
    }

    final typeLabel = _isStockOut ? 'Stock Out' : 'Stock In';
    _showSnackBar(
      '$typeLabel saved: $_quantity ${_selectedProduct.unit} of ${_selectedProduct.name} (New stock: $_projectedStock ${_selectedProduct.unit}).',
    );
    Navigator.maybePop(context);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: inter(13, w: FontWeight.w500, c: kWhite),
          ),
          backgroundColor: kDark,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final isWarning = _projectedStock < _selectedProduct.minStock;
    final bannerBg = isWarning
        ? const Color(0xFFFCE8E8)
        : const Color(0xFFE3F4EA);
    final bannerAccent = isWarning
        ? const Color(0xFFC62828)
        : const Color(0xFF2E7D32);
    final bannerSubColor = isWarning
        ? const Color(0xFFB71C1C)
        : const Color(0xFF6B8E78);

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
          'Add Stock Movement',
          style: playfair(20, w: FontWeight.w500, c: kDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: kDark, size: 26),
            tooltip: 'Movement History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => const StockMovementHistoryPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stock In / Stock Out segmented pill toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x06000000),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _TypeToggleTab(
                        label: 'Stock In',
                        icon: Icons.south_west,
                        selected: !_isStockOut,
                        onTap: () => _switchMovementType(false),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _TypeToggleTab(
                        label: 'Stock Out',
                        icon: Icons.north_east,
                        selected: _isStockOut,
                        onTap: () => _switchMovementType(true),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Product label + dropdown
              Text(
                'Product',
                style: inter(
                  12,
                  w: FontWeight.w400,
                  c: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 6),
              Material(
                color: kWhite,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: _showProductPicker,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedProduct.name,
                          style: inter(13, w: FontWeight.w500, c: kDark),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: kDark,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Current stock indicator row
              Row(
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    size: 18,
                    color: kDark,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Current stock',
                    style: inter(
                      11,
                      w: FontWeight.w400,
                      c: const Color(0xFF6B7280),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_selectedProduct.currentStock} ${_selectedProduct.unit}',
                    style: inter(12, w: FontWeight.w700, c: kDark),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Quantity field with dark # badge and + button
              Text(
                'Quantity: ${_selectedProduct.unit}',
                style: inter(
                  12,
                  w: FontWeight.w400,
                  c: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x06000000),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: _editQuantityDialog,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: kDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '#',
                          style: inter(18, w: FontWeight.w700, c: kWhite),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: _editQuantityDialog,
                        child: Text(
                          '$_quantity',
                          textAlign: TextAlign.center,
                          style: inter(14, w: FontWeight.w500, c: kDark),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => setState(() => _quantity++),
                      child: const SizedBox(
                        width: 36,
                        height: 36,
                        child: Icon(Icons.add, color: kDark, size: 22),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Movement Date & Expiry Date 2-column row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Movement Date',
                          style: inter(
                            12,
                            w: FontWeight.w400,
                            c: const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 6),
                        _DateFieldCard(
                          dateText: _formatDate(_movementDate),
                          onTap: () => _pickDate(isMovementDate: true),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry Date',
                          style: inter(
                            12,
                            w: FontWeight.w400,
                            c: const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 6),
                        _DateFieldCard(
                          dateText: _formatDate(_expiryDate),
                          onTap: () => _pickDate(isMovementDate: false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Movement Reason dropdown with dark code badge
              Text(
                'Movement Reason',
                style: inter(
                  12,
                  w: FontWeight.w400,
                  c: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 6),
              Material(
                color: kWhite,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: _showReasonPicker,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 7,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: kDark,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _selectedReason.code,
                            style: inter(14, w: FontWeight.w700, c: kWhite),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _selectedReason.label,
                            textAlign: TextAlign.center,
                            style: inter(13, w: FontWeight.w500, c: kDark),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: kDark,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Stock after movement preview card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: bannerBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Stock after movement',
                          style: inter(11, w: FontWeight.w700, c: bannerAccent),
                        ),
                        Text(
                          '$_projectedStock ${_selectedProduct.unit}',
                          style: inter(12, w: FontWeight.w700, c: bannerAccent),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      isWarning
                          ? 'Below minimum stock level (${_selectedProduct.minStock} ${_selectedProduct.unit})'
                          : 'Minimum stock level met',
                      style: inter(10, w: FontWeight.w400, c: bannerSubColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Remarks / Notes multi-line input
              Text(
                'Remarks / Notes',
                style: inter(
                  12,
                  w: FontWeight.w400,
                  c: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x06000000),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _remarksController,
                  maxLines: 3,
                  style: inter(13, w: FontWeight.w400, c: kDark),
                  decoration: InputDecoration(
                    hintText: 'Optional',
                    hintStyle: inter(
                      12,
                      w: FontWeight.w400,
                      c: const Color(0xFF9CA3AF),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(14),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Helper note
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Color(0xFF34C759),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Stock will be updated after save the movement.',
                      style: inter(
                        11,
                        w: FontWeight.w400,
                        c: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Bottom Cancel and Save stadium buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: OutlinedButton(
                        onPressed: () => Navigator.maybePop(context),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: kWhite,
                          foregroundColor: kDark,
                          side: const BorderSide(
                            color: Color(0xFF6B7280),
                            width: 1,
                          ),
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          'Cancel',
                          style: inter(13, w: FontWeight.w500, c: kDark),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton.icon(
                        onPressed: _saveMovement,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kDark,
                          foregroundColor: kWhite,
                          elevation: 0,
                          shape: const StadiumBorder(),
                        ),
                        icon: const Icon(Icons.save, size: 18, color: kWhite),
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
    );
  }
}

class _TypeToggleTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TypeToggleTab({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: selected ? kDark : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: selected ? kWhite : kDark),
            const SizedBox(width: 6),
            Text(
              label,
              style: inter(
                12,
                w: selected ? FontWeight.w600 : FontWeight.w500,
                c: selected ? kWhite : kDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateFieldCard extends StatelessWidget {
  final String dateText;
  final VoidCallback onTap;

  const _DateFieldCard({required this.dateText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kWhite,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: kDark,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: kWhite,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  dateText,
                  style: inter(12, w: FontWeight.w500, c: kDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductOption {
  final String name;
  final String unit;
  final int currentStock;
  final int minStock;

  const _ProductOption({
    required this.name,
    required this.unit,
    required this.currentStock,
    required this.minStock,
  });
}

class _ReasonOption {
  final String code;
  final String label;

  const _ReasonOption({required this.code, required this.label});
}
