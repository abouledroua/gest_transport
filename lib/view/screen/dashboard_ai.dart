import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'myscreen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) => MyScreen(
    title: "dashboard".tr,
    child: Expanded(
      child: ListView(
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        children: [
          // Dashboard Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dashboard Overview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _InfoCard(title: 'Total Transports', value: '128'),
                    _InfoCard(title: 'Revenue', value: '\$12,500'),
                    _InfoCard(title: 'Drivers Active', value: '14'),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: const Center(
                    child: Text('Flow Chart Placeholder'), // Integrate fl_chart here later
                  ),
                ),
                const Text('Dashboard Overview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _InfoCard(title: 'Total Transports', value: '128'),
                    _InfoCard(title: 'Revenue', value: '\$12,500'),
                    _InfoCard(title: 'Drivers Active', value: '14'),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: const Center(
                    child: Text('Flow Chart Placeholder'), // Integrate fl_chart here later
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Container titleWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Expanded(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: const [
              Text('Username'),
              SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) => Card(
    elevation: 2,
    child: Container(
      padding: const EdgeInsets.all(20),
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}
