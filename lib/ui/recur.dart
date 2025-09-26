import 'package:flutter/material.dart';

class RecurringPaymentScreen extends StatefulWidget {
  const RecurringPaymentScreen({super.key});

  @override
  State<RecurringPaymentScreen> createState() => _RecurringPaymentScreenState();
}

class _RecurringPaymentScreenState extends State<RecurringPaymentScreen> {
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedFrequency;
  String? _selectedDuration;
  int _selectedNavIndex = 1; // Payments tab is selected

  final List<String> _frequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  final List<String> _durations = [
    '1 Month',
    '3 Months',
    '6 Months',
    '1 Year',
    'Until Canceled',
  ];

  // Sample data for summary (will be replaced by actual form data)
  String _summaryRecipient = 'Sarah Miller';
  String _summaryAmount = '\$50.00';
  String _summaryFrequency = 'Monthly';
  String _summaryDuration = 'Until Canceled';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: isDark
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Recurring Payment',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF111827),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // Balance the back button
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Fields
                  _buildTextField(
                    controller: _recipientController,
                    hintText: "Recipient",
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

                  _buildDropdownField(
                    value: _selectedFrequency,
                    items: _frequencies,
                    hintText: "Frequency",
                    isDark: isDark,
                    onChanged: (value) {
                      setState(() {
                        _selectedFrequency = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  _buildDropdownField(
                    value: _selectedDuration,
                    items: _durations,
                    hintText: "Duration",
                    isDark: isDark,
                    onChanged: (value) {
                      setState(() {
                        _selectedDuration = value;
                      });
                    },
                  ),

                  const SizedBox(height: 32),

                  // Summary Section
                  Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF1173D4,
                      ).withOpacity(isDark ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          'Recipient',
                          _recipientController.text.isNotEmpty
                              ? _recipientController.text
                              : _summaryRecipient,
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow(
                          'Amount',
                          _amountController.text.isNotEmpty
                              ? '\$${_amountController.text}'
                              : _summaryAmount,
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow(
                          'Frequency',
                          _selectedFrequency ?? _summaryFrequency,
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow(
                          'Duration',
                          _selectedDuration ?? _summaryDuration,
                          isDark,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Footer with Confirm Button and Navigation
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF101922) : const Color(0xFFF6F7F8),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Confirm Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          _showConfirmationDialog();
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
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bottom Navigation
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: const Color(
                            0xFF1173D4,
                          ).withOpacity(isDark ? 0.3 : 0.2),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isDark,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: (value) {
        setState(() {}); // Update summary in real-time
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
        ),
        filled: true,
        fillColor: const Color(0xFF1173D4).withOpacity(isDark ? 0.2 : 0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1173D4), width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      style: TextStyle(color: isDark ? Colors.white : const Color(0xFF111827)),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required String hintText,
    required bool isDark,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1173D4).withOpacity(isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF1173D4), width: 2),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
        dropdownColor: isDark ? const Color(0xFF1F2937) : Colors.white,
        style: TextStyle(
          color: isDark ? Colors.white : const Color(0xFF111827),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : const Color(0xFF111827),
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
          Icon(
            icon,
            color: isSelected
                ? const Color(0xFF1173D4)
                : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? const Color(0xFF1173D4)
                  : (isDark
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF6B7280)),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Recurring Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please confirm the following recurring payment setup:',
              ),
              const SizedBox(height: 16),
              Text(
                'Recipient: ${_recipientController.text.isNotEmpty ? _recipientController.text : _summaryRecipient}',
              ),
              Text(
                'Amount: ${_amountController.text.isNotEmpty ? '\$${_amountController.text}' : _summaryAmount}',
              ),
              Text('Frequency: ${_selectedFrequency ?? _summaryFrequency}'),
              Text('Duration: ${_selectedDuration ?? _summaryDuration}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Recurring payment setup successfully!'),
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
      case 1: // Payments
        Navigator.pushReplacementNamed(context, '/paynow');
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
    super.dispose();
  }
}
