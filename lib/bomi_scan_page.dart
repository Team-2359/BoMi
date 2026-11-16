import 'package:flutter/material.dart';

import '../theme.dart';

class BoMIScanPage extends StatelessWidget {
  const BoMIScanPage({super.key});

  static const Color primaryGreen = Color(0xFF167D68);
  static const Color lightGreen = Color(0xFFE8F5F0);
  static const Color primaryPurple = Color(0xFF7952C7);
  static const Color lightPurple = Color(0xFFF0EAFE);
  static const Color warningOrange = Color(0xFFAD741E);
  static const Color lightOrange = Color(0xFFFFF3DC);

  @override
  Widget build(BuildContext context) {
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
                    Text('BoMI Scan', style: playfair(26, w: FontWeight.w700)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: lightPurple,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: primaryPurple.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        'AI',
                        style: inter(11, w: FontWeight.w700, c: primaryPurple),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.history_rounded,
                          size: 20,
                          color: kDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice to Inventory',
                      style: inter(
                        13,
                        w: FontWeight.w500,
                        c: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: primaryPurple.withValues(alpha: 0.4),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryPurple.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: lightPurple,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 36,
                              color: primaryPurple,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Tap to scan or upload\nsupplier invoice',
                            textAlign: TextAlign.center,
                            style: inter(
                              15,
                              w: FontWeight.w700,
                            ).copyWith(height: 1.3),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'PDF, JPG, PNG',
                            style: inter(
                              11,
                              w: FontWeight.w500,
                              c: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Text(
                          'DRAFT STOCK ENTRY',
                          style: inter(
                            12,
                            w: FontWeight.w700,
                            c: Colors.black87,
                          ).copyWith(letterSpacing: 0.5),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: lightPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'AI draft',
                            style: inter(
                              10,
                              w: FontWeight.w700,
                              c: primaryPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          const _DraftItemRow(
                            name: 'Skinflix Brightening Serum',
                            quantity: 'x10',
                          ),
                          const SizedBox(height: 10),
                          const _DraftItemRow(
                            name: 'Skinflix Serum',
                            quantity: 'x30',
                          ),
                          const SizedBox(height: 10),
                          const _DraftItemRow(
                            name: 'Sunscreen SPF 30',
                            quantity: 'x5',
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(height: 1, color: Color(0xFFF0F0F0)),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Unmatched: line 4',
                                  style: inter(
                                    13,
                                    w: FontWeight.w500,
                                    c: warningOrange,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: lightOrange,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Review',
                                    style: inter(
                                      11,
                                      w: FontWeight.w700,
                                      c: warningOrange,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: lightOrange,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '?',
                                    style: inter(
                                      11,
                                      w: FontWeight.w700,
                                      c: warningOrange,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 14,
                          color: primaryGreen,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Stock updates only after approved',
                          style: inter(
                            11,
                            w: FontWeight.w500,
                            c: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.donut_large_rounded,
                            color: primaryGreen,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AI Confidence: 92%',
                                  style: inter(
                                    12,
                                    w: FontWeight.w700,
                                    c: primaryGreen,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Most items match supplier invoice format',
                                  style: inter(
                                    11,
                                    c: primaryGreen.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined, size: 18),
                            label: const Text('Edit lines'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: primaryGreen,
                              side: const BorderSide(
                                color: primaryGreen,
                                width: 1,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.check, size: 18),
                            label: const Text('Approve & update'),
                            style: FilledButton.styleFrom(
                              backgroundColor: primaryGreen,
                              foregroundColor: kWhite,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
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

class _DraftItemRow extends StatelessWidget {
  final String name;
  final String quantity;

  const _DraftItemRow({required this.name, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: inter(13, w: FontWeight.w500, c: Colors.black87),
          ),
        ),
        Text(
          quantity,
          style: inter(13, w: FontWeight.w700, c: Colors.black87),
        ),
      ],
    );
  }
}
