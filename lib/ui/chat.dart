import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Define colors similar to the HTML version
  static const Color primaryColor = Color(0xFF1173D4);
  static const Color backgroundDark = Color(0xFF101922);
  static const Color chatBubbleUserDark = Color(0xFF3B82F6);
  static const Color chatBubbleBotDark = Color(0xFF1F2937);
  static const Color cardBackgroundDark = Color(0xFF1E293B);
  static const Color inputBackgroundDark = Color(0xFF1E293B);
  static const Color textLight = Color(0xFFE5E7EB);
  static const Color textMutedDark = Color(0xFF6B7280);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      body: Column(
        children: [
          // Header
          _buildHeader(),

          // Chat messages
          Expanded(child: _buildChatArea()),

          // Footer with input and navigation
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: slate800, width: 1)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, color: slate300),
            ),
            const Text(
              'Chat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle, color: slate300),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatArea() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        controller: _scrollController,
        children: [
          // Bot message
          _buildBotMessage(),
          const SizedBox(height: 24),

          // User message
          _buildUserMessage(),
          const SizedBox(height: 24),

          // Payment card
          _buildPaymentCard(),
        ],
      ),
    );
  }

  Widget _buildBotMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bot avatar
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAgi51J8qKEdCbi2G4Ee-2vHWf9DjdDArkT_o3GqY2jWptEAmy5J2AVlERUI1fa38v36rHV2OsQPL1UaeSw4cLE4myzcNV1gH5NeAV49hT50LlTyLmtDdOfdAxv4SZTaPCzlTeG2B0470-ynos5ApATAfFJpaNGuo_5jACsq9fwgzCaBRMDZDH7TTpOnM3ulpUESOqoN_j8uiolz2V6FJq4nGkBhldaRBeu8BSP0apUFtD0QVb3QE-IMHMMA_Vb84F2X-DsBE2jnw01',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FinBot',
                style: TextStyle(fontSize: 14, color: textMutedDark),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: chatBubbleBotDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  "Hi there, I'm FinBot, your personal finance assistant. How can I help you today?",
                  style: TextStyle(color: textLight),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Alex',
                style: TextStyle(fontSize: 14, color: textMutedDark),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: chatBubbleUserDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  "Hi FinBot, I'd like to set up payments for my bills.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDTK55mRgbmdgZGEI2mRoC4YWRnfycHnlWycGsZMnDdz36_j_lbslLrDGb8U3Dt7SxWAzXmptA2cuBFVIltAzb11CNZ0l7Q33HoMFNSo9qRdCA7ibur_f5mO9xcRtVbEumRYimB3reDo48w842MqmVD2nKKhCZbiEQrQ78dtBehUCpY4W9lEdHsAqxGnkvi4tHSCmEoOgcUmvF4iKOtQO4BmPNZMEvUzwHI2__FD_aua97SoHNGMAnGa5lkg21Ph-JIvMZ48VvYH5L4',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundDark,
        border: Border.all(color: slate800),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Set up Payments',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Manage your bills and recurring payments easily.',
                  style: TextStyle(color: slate400, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to payments page
              Navigator.pushNamed(context, '/paynow');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text(
              'Go to Payments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: backgroundDark,
      child: Column(
        children: [
          // Input area
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAyjYEAbkXE8yry2GgUoopoAkcNtH0pkIiYmx8Krf4HlrQND68F3lrtNmMU89b9splfOAYAQqI97H5V8JjqJPcRFsRqDNg30CjNBELLe4S90NoEK64m_x2w0OOPnWD2Bskjb3_L_bxIi9kuTsSd-UP0KiRKX-ffUFvbvwaN2pqogd3R08GYD6Yog5DbMbYrZ56_rUFo7LN5WoMe717j4qwS92H-1DikDEHnmFr3yh9tKV_3DyvcML9Uk4SaAvz0AFB_1LdPbE8EHqoI',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: inputBackgroundDark,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            style: const TextStyle(color: textLight),
                            decoration: const InputDecoration(
                              hintText: 'Type a message...',
                              hintStyle: TextStyle(color: slate400),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.attach_file, color: slate400),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      _sendMessage();
                    },
                    icon: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Bottom navigation
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: slate800, width: 1)),
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Home', false),
                  _buildNavItem(Icons.credit_card, 'Payments', false),
                  _buildNavItem(Icons.chat, 'Chat', true),
                  _buildNavItem(Icons.settings, 'Settings', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        // Handle navigation
        switch (label.toLowerCase()) {
          case 'home':
            Navigator.pushReplacementNamed(context, '/');
            break;
          case 'payments':
            Navigator.pushReplacementNamed(context, '/paynow');
            break;
          case 'chat':
            // Already on chat page
            break;
          default:
            throw UnimplementedError();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? primaryColor : slate400, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? primaryColor : slate400,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      // Add message sending logic here
      print('Sending message: ${_messageController.text}');
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
