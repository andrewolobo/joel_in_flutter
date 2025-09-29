import 'package:flutter/material.dart';
import 'ui/splash_screen.dart';
import 'ui/chat.dart';
import 'ui/recur.dart';
import 'ui/paynow.dart';
import 'ui/playground.dart';

void main() {
  runApp(const TransactionsApp());
}

class TransactionsApp extends StatelessWidget {
  const TransactionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transactions',
      theme: ThemeData(
        primaryColor: const Color(0xFF1173D4),
        scaffoldBackgroundColor: const Color(0xFFF6F7F8),
        fontFamily: 'Manrope',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1173D4),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFF1173D4),
        scaffoldBackgroundColor: const Color(0xFF101922),
        fontFamily: 'Manrope',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1173D4),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const TransactionsScreen(),
        '/chat': (context) => const ChatPage(),
        '/recurring': (context) => const RecurringPaymentScreen(),
        '/paynow': (context) => const PayNowScreen(),
        '/playground': (context) => const PlaygroundScreen(),
      },
    );
  }
}

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTabIndex = 0; // 0: All, 1: Income, 2: Expenses
  int _selectedNavIndex = 0; // Home is selected

  final List<String> _tabs = ['All', 'Income', 'Expenses'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          // Sticky Header
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF101922).withOpacity(0.8)
                  : const Color(0xFFF6F7F8).withOpacity(0.8),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Transactions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the back button
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search transactions',
                        hintStyle: TextStyle(
                          color: isDark
                              ? Colors.white.withOpacity(0.5)
                              : Colors.black.withOpacity(0.5),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: isDark
                              ? Colors.white.withOpacity(0.5)
                              : Colors.black.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: isDark
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF1173D4),
                            width: 2,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),

                  // Tabs
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isDark
                              ? Colors.white.withOpacity(0.1)
                              : Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                    child: Row(
                      children: _tabs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tab = entry.value;
                        final isSelected = _selectedTabIndex == index;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTabIndex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: isSelected
                                        ? const Color(0xFF1173D4)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                tab,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? const Color(0xFF1173D4)
                                      : (isDark
                                            ? Colors.white.withOpacity(0.6)
                                            : Colors.black.withOpacity(0.6)),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Transactions
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Today Section
                      _buildTransactionSection('Today', [
                        _TransactionItem(
                          icon: Icons.shopping_cart,
                          title: 'Fresh Foods Market',
                          subtitle: 'Groceries',
                          amount: '-\$45.20',
                          isPositive: false,
                        ),
                        _TransactionItem(
                          icon: Icons.directions_car,
                          title: 'RideShare',
                          subtitle: 'Transportation',
                          amount: '-\$12.50',
                          isPositive: false,
                        ),
                      ], isDark),

                      const SizedBox(height: 24),

                      // Yesterday Section
                      _buildTransactionSection('Yesterday', [
                        _TransactionItem(
                          icon: Icons.restaurant,
                          title: 'The Cozy Corner Cafe',
                          subtitle: 'Dining',
                          amount: '-\$28.75',
                          isPositive: false,
                        ),
                        _TransactionItem(
                          icon: Icons.movie,
                          title: 'Cinema City',
                          subtitle: 'Entertainment',
                          amount: '-\$15.00',
                          isPositive: false,
                        ),
                        _TransactionItem(
                          icon: Icons.work,
                          title: 'Acme Corp',
                          subtitle: 'Salary',
                          amount: '+\$2,500.00',
                          isPositive: true,
                        ),
                      ], isDark),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Navigation
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF101922).withOpacity(0.8)
                  : const Color(0xFFF6F7F8).withOpacity(0.8),
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.home, 'Home', isDark),
                    _buildNavItem(1, Icons.credit_card, 'Payments', isDark),
                    _buildNavItem(2, Icons.chat_bubble_outline, 'Chat', isDark),
                    _buildNavItem(3, Icons.settings, 'Settings', isDark),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionSection(
    String title,
    List<_TransactionItem> transactions,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        ...transactions.map(
          (transaction) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    transaction.icon,
                    color: isDark ? Colors.white : Colors.black,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        transaction.subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? Colors.white.withOpacity(0.6)
                              : Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  transaction.amount,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: transaction.isPositive
                        ? Colors.green
                        : (isDark ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, bool isDark) {
    final isSelected = _selectedNavIndex == index;

    return GestureDetector(
      onTap: () {
        _handleNavigation(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 32,
            child: Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF1173D4)
                  : (isDark
                        ? Colors.white.withOpacity(0.6)
                        : Colors.black.withOpacity(0.6)),
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? const Color(0xFF1173D4)
                  : (isDark
                        ? Colors.white.withOpacity(0.6)
                        : Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNavigation(int index) {
    if (index == _selectedNavIndex) return; // Already on current page

    switch (index) {
      case 0: // Home - already here (transactions)
        setState(() {
          _selectedNavIndex = index;
        });
        break;
      case 1: // Payments
        Navigator.pushNamed(context, '/paynow');
        break;
      case 2: // Chat
        Navigator.pushNamed(context, '/chat');
        break;
      case 3: // Settings
        // Handle settings navigation if needed
        Navigator.pushNamed(context, '/playground');
        // setState(() {
        //   _selectedNavIndex = index;
        // });
        break;
      default:
        throw UnimplementedError();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _TransactionItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final bool isPositive;

  _TransactionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isPositive,
  });
}
