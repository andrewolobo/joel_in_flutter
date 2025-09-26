import 'package:flutter/material.dart';

class PayNowScreen extends StatefulWidget {
  const PayNowScreen({super.key});

  @override
  State<PayNowScreen> createState() => _PayNowScreenState();
}

class _PayNowScreenState extends State<PayNowScreen> {
  String _selectedPaymentType = 'direct';
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _noteController = TextEditingController();
  int _selectedNavIndex = 1; // Payments tab is selected

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          // Sticky Header
          Container(
            color: isDark
                ? const Color(0xFF101922).withOpacity(0.8)
                : const Color(0xFFF6F7F8).withOpacity(0.8),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDark ? Colors.white : const Color(0xFF1E293B),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Pay Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF0F172A),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Payment Type Section
                  Text(
                    'Payment Type',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildPaymentTypeOption(
                          'direct',
                          'Direct',
                          isDark,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildPaymentTypeOption(
                          'utility',
                          'Utility',
                          isDark,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Payment Details Section
                  Text(
                    'Payment Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Input Fields
                  _buildTextField(
                    controller: _recipientController,
                    hintText: "Recipient's Name",
                    isDark: isDark,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _amountController,
                    hintText: "Amount",
                    isDark: isDark,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _paymentMethodController,
                    hintText: "Payment Method",
                    isDark: isDark,
                    suffixIcon: Icon(
                      Icons.unfold_more,
                      color: isDark
                          ? const Color(0xFF64748B)
                          : const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _noteController,
                    hintText: "Add a note (optional)",
                    isDark: isDark,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),

          // Footer with Confirm Button and Navigation
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF101922) : const Color(0xFFF6F7F8),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.05),
                  offset: const Offset(0, -1),
                  blurRadius: 0,
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Buttons
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Set Up Recurring Payment Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/recurring');
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF1173D4),
                              side: const BorderSide(
                                color: Color(0xFF1173D4),
                                width: 2,
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Set Up Recurring Payment',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Confirm Payment Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle payment confirmation
                              _showPaymentConfirmation();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1173D4),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Confirm Payment',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Navigation
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNavItem(0, Icons.home_outlined, 'Home', isDark),
                          _buildNavItem(
                            1,
                            Icons.credit_card,
                            'Payments',
                            isDark,
                          ),
                          _buildNavItem(
                            2,
                            Icons.chat_bubble_outline,
                            'Chat',
                            isDark,
                          ),
                          _buildNavItem(
                            3,
                            Icons.settings_outlined,
                            'Settings',
                            isDark,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTypeOption(String value, String label, bool isDark) {
    final isSelected = _selectedPaymentType == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentType = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E293B).withOpacity(0.5)
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1173D4)
                : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1173D4).withOpacity(0.5),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF1173D4)
                      : (isDark
                            ? const Color(0xFF64748B)
                            : const Color(0xFF94A3B8)),
                  width: 2,
                ),
                color: isSelected
                    ? const Color(0xFF1173D4)
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.circle, size: 8, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? const Color(0xFFE2E8F0)
                    : const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isDark,
    Widget? suffixIcon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: isDark
            ? const Color(0xFF1E293B).withOpacity(0.5)
            : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1173D4), width: 2),
        ),
      ),
      style: TextStyle(color: isDark ? Colors.white : const Color(0xFF0F172A)),
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
          Icon(
            icon,
            color: isSelected
                ? const Color(0xFF1173D4)
                : (isDark ? const Color(0xFF64748B) : const Color(0xFF6B7280)),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? const Color(0xFF1173D4)
                  : (isDark
                        ? const Color(0xFF64748B)
                        : const Color(0xFF6B7280)),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment Type: ${_selectedPaymentType.toUpperCase()}'),
              if (_recipientController.text.isNotEmpty)
                Text('Recipient: ${_recipientController.text}'),
              if (_amountController.text.isNotEmpty)
                Text('Amount: ${_amountController.text}'),
              if (_paymentMethodController.text.isNotEmpty)
                Text('Payment Method: ${_paymentMethodController.text}'),
              if (_noteController.text.isNotEmpty)
                Text('Note: ${_noteController.text}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle actual payment processing here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment processed successfully!'),
                    backgroundColor: Color(0xFF1173D4),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1173D4),
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _handleNavigation(int index) {
    if (index == _selectedNavIndex) return; // Already on current page

    switch (index) {
      case 0: // Home
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 1: // Payments - already here
        setState(() {
          _selectedNavIndex = index;
        });
        break;
      case 2: // Chat
        Navigator.pushReplacementNamed(context, '/chat');
        break;
      case 3: // Settings
        // Handle settings navigation if needed
        setState(() {
          _selectedNavIndex = index;
        });
        break;
      default:
        throw UnimplementedError();
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _paymentMethodController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
