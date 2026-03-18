import 'package:flutter/material.dart';
import '../workouts/workout_day_detail_screen.dart';
import '../../services/mock_data_service.dart';
import 'package:intl/intl.dart';

class ClientWorkoutPlanScreen extends StatelessWidget {
  const ClientWorkoutPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> split = [
      {'day': 'Monday', 'focus': 'Upper Body Power', 'exercises': '6'},
      {'day': 'Tuesday', 'focus': 'Lower Body Power', 'exercises': '5'},
      {'day': 'Wednesday', 'focus': 'Rest / Active Recovery', 'exercises': '0'},
      {'day': 'Thursday', 'focus': 'Upper Body Hypertrophy', 'exercises': '7'},
      {'day': 'Friday', 'focus': 'Lower Body Hypertrophy', 'exercises': '6'},
    ];

    final String today = DateFormat('EEEE').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('MY TRAINING PLAN', style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.w400, fontSize: 13)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: split.length,
          itemBuilder: (context, index) {
            final day = split[index];
            final bool isRest = day['focus']!.contains('Rest');
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                onTap: isRest ? null : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutDayDetailScreen(dayData: day, isReadOnly: true),
                    ),
                  );
                },
                leading: Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isRest ? Colors.white12 : const Color(0xFFCCFF00),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                title: Row(
                  children: [
                    Text(day['day']!, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
                    if (day['day'] == 'Monday') // Hardcoded for demo as "Today"
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCCFF00),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('TODAY', style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.w400)),
                      ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(day['focus']!, style: TextStyle(color: isRest ? Colors.white24 : Colors.white60, fontSize: 12, fontWeight: FontWeight.w300)),
                    if (!isRest) ...[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: LinearProgressIndicator(
                                value: MockDataService.getWorkoutDoneCount(day['day']!) / double.parse(day['exercises']!),
                                backgroundColor: Colors.white.withOpacity(0.05),
                                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFCCFF00)),
                                minHeight: 2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${MockDataService.getWorkoutDoneCount(day['day']!)}/${day['exercises']} done',
                            style: const TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                trailing: isRest ? null : const Icon(Icons.chevron_right, color: Colors.white10, size: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
