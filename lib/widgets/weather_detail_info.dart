import 'package:flutter/material.dart';

class WeatherDetailInfo extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const WeatherDetailInfo({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 8.0,
              ),
              Text(value),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
