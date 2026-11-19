import 'package:flutter/material.dart';

import '../theme.dart';

class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({super.key});

  void _showSnackBar(BuildContext context, String message) {
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

  void _showAdjustStockDialog(BuildContext context) {
    int quantity = 10;
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: kWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Adjust Stock',
                style: playfair(18, w: FontWeight.w700, c: kDark),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Foam Cleanser (P0067)',
                    style: inter(13, w: FontWeight.w600, c: kDark),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Set corrected physical box count:',
                    style: inter(
                      12,
                      w: FontWeight.w400,
                      c: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: quantity > 0
                            ? () => setState(() => quantity--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                        color: kDark,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '$quantity Boxes',
                          style: inter(16, w: FontWeight.w700, c: kDark),
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => quantity++),
                        icon: const Icon(Icons.add_circle_outline),
                        color: kDark,
                      ),
                    ],
                  ),
                ],
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
                    Navigator.pop(dialogContext);
                    _showSnackBar(
                      context,
                      'Stock adjusted to $quantity Boxes for Foam Cleanser.',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kDark,
                    foregroundColor: kWhite,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Save',
                    style: inter(13, w: FontWeight.w600, c: kWhite),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          'Item Details',
          style: playfair(20, w: FontWeight.w500, c: kDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: kDark, size: 24),
            tooltip: 'Movement History',
            onPressed: () => _showSnackBar(
              context,
              'Viewing movement history for Foam Cleanser (P0067)',
            ),
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
              // Product Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'FC',
                        style: inter(24, w: FontWeight.w700, c: kDark),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Foam Cleanser\n(P0067)',
                            style: inter(16, w: FontWeight.w700, c: kDark),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Category: Skincare',
                            style: inter(
                              12,
                              w: FontWeight.w400,
                              c: const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Section Header: Stock Information
              Text(
                'Stock Information',
                style: inter(
                  12,
                  w: FontWeight.w500,
                  c: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 8),

              // Stock Information Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current stock',
                                style: inter(
                                  12,
                                  w: FontWeight.w500,
                                  c: const Color(0xFF4B5563),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '10 Boxes',
                                style: playfair(
                                  22,
                                  w: FontWeight.w700,
                                  c: kDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F5EA),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF34C759),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'In stock',
                            style: inter(
                              12,
                              w: FontWeight.w600,
                              c: const Color(0xFF28A745),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Minimum stock',
                          style: inter(
                            12,
                            w: FontWeight.w400,
                            c: const Color(0xFF6B7280),
                          ),
                        ),
                        Text(
                          '5 boxes',
                          style: inter(13, w: FontWeight.w700, c: kDark),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFF0F0F0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Expiry date',
                          style: inter(
                            12,
                            w: FontWeight.w400,
                            c: const Color(0xFF6B7280),
                          ),
                        ),
                        Text(
                          '30 Jun 2027',
                          style: inter(13, w: FontWeight.w700, c: kDark),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // 2-Column Quick Action Cards
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.add_circle,
                      iconColor: const Color(0xFF34C759),
                      title: 'Stock In',
                      subtitle: 'Receive Stock',
                      onTap: () => _showSnackBar(
                        context,
                        'Record Stock In for Foam Cleanser',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.remove_circle,
                      iconColor: const Color(0xFFFF3B30),
                      title: 'Stock Out',
                      subtitle: 'Remove Stock',
                      onTap: () => _showSnackBar(
                        context,
                        'Record Stock Out for Foam Cleanser',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Full-Width Dark Pill Button: Adjust Stock
              Material(
                color: kDark,
                shape: const StadiumBorder(),
                child: InkWell(
                  customBorder: const StadiumBorder(),
                  onTap: () => _showAdjustStockDialog(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.tune, color: kWhite, size: 22),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Adjust Stock',
                                style: inter(14, w: FontWeight.w600, c: kWhite),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Correct item quantity',
                                style: inter(
                                  10,
                                  w: FontWeight.w400,
                                  c: const Color(0xFFD1D5DB),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF9CA3AF),
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Section Header: Recent movement
              Text(
                'Recent movement',
                style: inter(13, w: FontWeight.w600, c: kDark),
              ),
              const SizedBox(height: 10),

              // Vertical Timeline List
              const _MovementTimelineItem(
                dotColor: Color(0xFF34C759),
                title: 'Stock In (+5)',
                badgeText: '10 boxes',
                badgeBg: Color(0xFFE3F5EA),
                badgeTextColor: Color(0xFF28A745),
                subtitle: 'BoMI Scan - INV-0932',
                timestamp: 'Nurul • Today, 14:10',
              ),
              const _MovementTimelineItem(
                dotColor: Color(0xFFFF3B30),
                title: 'Stock Out (-1)',
                badgeText: '-1 boxes',
                badgeBg: Color(0xFFFCE8E8),
                badgeTextColor: Color(0xFFE53935),
                subtitle: 'Used in treatment',
                timestamp: 'Dr. Aina • Today, 11:30',
              ),
              const _MovementTimelineItem(
                dotColor: Color(0xFFFF3B30),
                title: 'Stock Out (-2)',
                badgeText: '-2 boxes',
                badgeBg: Color(0xFFFCE8E8),
                badgeTextColor: Color(0xFFE53935),
                subtitle: 'Used in treatment',
                timestamp: 'Dr. Aina • Yesterday, 9:30',
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kWhite,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color(0x06000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(height: 6),
              Text(
                title,
                style: inter(13, w: FontWeight.w700, c: kDark),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: inter(
                  10,
                  w: FontWeight.w400,
                  c: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MovementTimelineItem extends StatelessWidget {
  final Color dotColor;
  final String title;
  final String badgeText;
  final Color badgeBg;
  final Color badgeTextColor;
  final String subtitle;
  final String timestamp;
  final bool isLast;

  const _MovementTimelineItem({
    required this.dotColor,
    required this.title,
    required this.badgeText,
    required this.badgeBg,
    required this.badgeTextColor,
    required this.subtitle,
    required this.timestamp,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                const SizedBox(height: 5),
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Container(width: 1.5, color: const Color(0xFFD1D5DB)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: inter(13, w: FontWeight.w700, c: kDark),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: badgeBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          badgeText,
                          style: inter(
                            10,
                            w: FontWeight.w600,
                            c: badgeTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: inter(
                      12,
                      w: FontWeight.w400,
                      c: const Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    timestamp,
                    style: inter(
                      11,
                      w: FontWeight.w400,
                      c: const Color(0xFF9CA3AF),
                    ),
                  ),
                  if (!isLast) ...[
                    const SizedBox(height: 10),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFECECEC),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
