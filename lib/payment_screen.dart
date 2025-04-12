import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: '1',
      name: 'Credit/Debit Card',
      icon: Icons.credit_card,
      isSelected: true,
    ),
    PaymentMethod(
      id: '2',
      name: 'Bank Transfer',
      icon: Icons.account_balance,
      isSelected: false,
    ),
    PaymentMethod(
      id: '3',
      name: 'E-Wallet',
      icon: Icons.account_balance_wallet,
      isSelected: false,
    ),
  ];

  final List<PaymentHistory> _paymentHistory = [
    PaymentHistory(
      id: '1',
      title: 'Tajwid Basics Course',
      amount: 150000,
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: 'Completed',
    ),
    PaymentHistory(
      id: '2',
      title: 'Quran Memorization Session',
      amount: 200000,
      date: DateTime.now().subtract(const Duration(days: 10)),
      status: 'Completed',
    ),
    PaymentHistory(
      id: '3',
      title: 'Tafsir Session',
      amount: 175000,
      date: DateTime.now().subtract(const Duration(days: 15)),
      status: 'Completed',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: const TabBar(
              labelColor: Color(0xFF1F7A54),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF1F7A54),
              tabs: [Tab(text: 'Payment'), Tab(text: 'History')],
            ),
          ),
        ),
        body: TabBarView(children: [_buildPaymentTab(), _buildHistoryTab()]),
      ),
    );
  }

  Widget _buildPaymentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F7A54),
            ),
          ),
          const SizedBox(height: 16),
          ..._paymentMethods.map((method) => _buildPaymentMethodCard(method)),
          const SizedBox(height: 24),
          const Text(
            'Payment Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F7A54),
            ),
          ),
          const SizedBox(height: 16),
          _buildPaymentDetailsCard(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F7A54),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                _showPaymentConfirmationDialog(context);
              },
              child: const Text(
                'Pay Now',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          setState(() {
            for (var m in _paymentMethods) {
              m.isSelected = m.id == method.id;
            }
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(method.icon, color: const Color(0xFF1F7A54), size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  method.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Radio<bool>(
                value: true,
                groupValue: method.isSelected,
                onChanged: (value) {
                  setState(() {
                    for (var m in _paymentMethods) {
                      m.isSelected = m.id == method.id;
                    }
                  });
                },
                activeColor: const Color(0xFF1F7A54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildPaymentDetailRow('Package', 'Tilawah Monthly Subscription'),
            const Divider(height: 24),
            _buildPaymentDetailRow('Duration', '1 Month'),
            const Divider(height: 24),
            _buildPaymentDetailRow('Price', 'Rp 350,000'),
            const Divider(height: 24),
            _buildPaymentDetailRow('Discount', 'Rp 50,000'),
            const Divider(height: 24),
            _buildPaymentDetailRow('Total', 'Rp 300,000', isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailRow(
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? const Color(0xFF1F7A54) : Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? const Color(0xFF1F7A54) : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return _paymentHistory.isEmpty
        ? const Center(child: Text('No payment history'))
        : ListView.builder(
          itemCount: _paymentHistory.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            return _buildHistoryCard(_paymentHistory[index]);
          },
        );
  }

  Widget _buildHistoryCard(PaymentHistory history) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    history.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F7A54),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F7A54).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    history.status,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1F7A54),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Rp ${history.amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${history.date.day}/${history.date.month}/${history.date.year}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Receipt download coming soon'),
                        backgroundColor: Color(0xFF1F7A54),
                      ),
                    );
                  },
                  child: const Text(
                    'Download Receipt',
                    style: TextStyle(color: Color(0xFF1F7A54)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Payment'),
            content: const Text(
              'Are you sure you want to proceed with the payment of Rp 300,000?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F7A54),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _showPaymentSuccessDialog(context);
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
    );
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Payment Successful'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF1F7A54),
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your payment has been processed successfully!',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Transaction ID: TRX12345678',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F7A54),
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
            ],
          ),
    );
  }
}

class PaymentMethod {
  final String id;
  final String name;
  final IconData icon;
  bool isSelected;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.isSelected,
  });
}

class PaymentHistory {
  final String id;
  final String title;
  final int amount;
  final DateTime date;
  final String status;

  PaymentHistory({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
  });
}
