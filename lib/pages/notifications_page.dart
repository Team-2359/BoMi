import 'package:flutter/material.dart';

import '../theme.dart';

enum _NotificationCategory { lowStock, expiring, info }

class _NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final _NotificationCategory category;
  bool isRead;

  _NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.category,
    this.isRead = false,
  });
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String _selectedTab = 'All';

  static const List<String> _tabs = ['All', 'Low stock', 'Expiring'];

  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      id: 'n1',
      title: 'Skinflix Brightening',
      subtitle: '3 boxes remaining',
      timeAgo: '5 min ago',
      category: _NotificationCategory.lowStock,
      isRead: false,
    ),
    _NotificationItem(
      id: 'n2',
      title: 'Vitamin C Booster',
      subtitle: '14 bottles • expires 16 Oct 2026',
      timeAgo: '50 min ago',
      category: _NotificationCategory.expiring,
      isRead: false,
    ),
    _NotificationItem(
      id: 'n3',
      title: 'New supplier catalogue',
      subtitle: 'MedSupply added 11 items',
      timeAgo: '3 hr ago',
      category: _NotificationCategory.info,
      isRead: true,
    ),
    _NotificationItem(
      id: 'n4',
      title: 'Sunscreen SPF 50',
      subtitle: '4 pack remaining',
      timeAgo: 'Yesterday, 3:30pm',
      category: _NotificationCategory.lowStock,
      isRead: true,
    ),
  ];

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  int get _lowStockCount => _notifications
      .where((n) => n.category == _NotificationCategory.lowStock)
      .length;

  int get _expiringCount => _notifications
      .where((n) => n.category == _NotificationCategory.expiring)
      .length;

  int _badgeCountForTab(String tab) {
    switch (tab) {
      case 'Low stock':
        return _lowStockCount;
      case 'Expiring':
        return _expiringCount;
      default:
        return _unreadCount;
    }
  }

  List<_NotificationItem> get _filteredNotifications {
    switch (_selectedTab) {
      case 'Low stock':
        return _notifications
            .where((n) => n.category == _NotificationCategory.lowStock)
            .toList();
      case 'Expiring':
        return _notifications
            .where((n) => n.category == _NotificationCategory.expiring)
            .toList();
      default:
        return _notifications;
    }
  }

  void _markAsRead(_NotificationItem item) {
    if (!item.isRead) {
      setState(() {
        item.isRead = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = _filteredNotifications;

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
                    Text(
                      'Home',
                      style: playfair(24, w: FontWeight.w600, c: kDark),
                    ),
                  ],
                ),
              ),
            ),

            // Section Header & Filter Tabs
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$_unreadCount Unread',
                              style: inter(12, c: Colors.black54),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Notifications',
                              style: inter(22, w: FontWeight.w700, c: kDark),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          size: 26,
                          color: kDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Three Filter Tabs
                  Row(
                    children: List.generate(_tabs.length, (index) {
                      final tab = _tabs[index];
                      final isSelected = _selectedTab == tab;
                      final badgeCount = _badgeCountForTab(tab);

                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: index < _tabs.length - 1 ? 10 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedTab = tab),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              decoration: BoxDecoration(
                                color: isSelected ? kDark : kWhite,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tab,
                                    style: inter(
                                      12.5,
                                      w: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      c: isSelected ? kWhite : kDark,
                                    ),
                                  ),
                                  if (badgeCount > 0) ...[
                                    const SizedBox(width: 4),
                                    Transform.translate(
                                      offset: const Offset(0, -5),
                                      child: Container(
                                        width: 17,
                                        height: 17,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE53935),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '$badgeCount',
                                          style: inter(
                                            9.5,
                                            w: FontWeight.w700,
                                            c: kWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
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

            // Notification Cards List
            Expanded(
              child: visibleItems.isEmpty
                  ? Center(
                      child: Text(
                        'No notifications',
                        style: inter(13, c: Colors.black45),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                      itemCount: visibleItems.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = visibleItems[index];
                        return _NotificationCard(
                          item: item,
                          onTap: () => _markAsRead(item),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final _NotificationItem item;
  final VoidCallback onTap;

  const _NotificationCard({required this.item, required this.onTap});

  Color get _panelBgColor {
    switch (item.category) {
      case _NotificationCategory.lowStock:
        return item.isRead ? const Color(0xFFFCF3F2) : const Color(0xFFFDE8E6);
      case _NotificationCategory.expiring:
        return item.isRead ? const Color(0xFFFEF7EC) : const Color(0xFFFEE8C8);
      case _NotificationCategory.info:
        return item.isRead ? const Color(0xFFFAF3F3) : const Color(0xFFF5EBEB);
    }
  }

  Color get _iconColor {
    switch (item.category) {
      case _NotificationCategory.lowStock:
        return item.isRead ? const Color(0xFFF0A8A6) : const Color(0xFFE53935);
      case _NotificationCategory.expiring:
        return item.isRead ? const Color(0xFFF7C48B) : const Color(0xFFF58220);
      case _NotificationCategory.info:
        return item.isRead ? const Color(0xFFA5D6A7) : const Color(0xFF66BB6A);
    }
  }

  IconData get _iconData {
    switch (item.category) {
      case _NotificationCategory.lowStock:
        return Icons.warning_amber_rounded;
      case _NotificationCategory.expiring:
        return Icons.access_time_rounded;
      case _NotificationCategory.info:
        return Icons.info_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleColor = item.isRead ? Colors.black45 : kDark;
    final subtitleColor = item.isRead ? Colors.black38 : Colors.black54;
    final timeColor = item.isRead ? Colors.black26 : Colors.black45;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: item.isRead ? kWhite.withValues(alpha: 0.72) : kWhite,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tinted Left Icon Panel
                Container(
                  width: 80,
                  color: _panelBgColor,
                  alignment: Alignment.center,
                  child: Icon(_iconData, size: 36, color: _iconColor),
                ),

                // Content & Unread Indicator Dot
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                style: inter(
                                  14,
                                  w: FontWeight.w700,
                                  c: titleColor,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item.subtitle,
                                style: inter(11.5, c: subtitleColor),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item.timeAgo,
                                style: inter(10.5, c: timeColor),
                              ),
                            ],
                          ),
                        ),
                        if (!item.isRead) ...[
                          const SizedBox(width: 10),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0E6B5C),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
