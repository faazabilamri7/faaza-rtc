import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<CourseSchedule> _schedules = [
    CourseSchedule(
      id: '1',
      title: 'Tajwid Basics',
      instructor: 'Ustadz Ahmad',
      date: DateTime.now().add(const Duration(days: 1)),
      startTime: '09:00',
      endTime: '10:30',
      status: 'Upcoming',
    ),
    CourseSchedule(
      id: '2',
      title: 'Quran Memorization',
      instructor: 'Ustadzah Fatimah',
      date: DateTime.now().add(const Duration(days: 2)),
      startTime: '14:00',
      endTime: '15:30',
      status: 'Upcoming',
    ),
    CourseSchedule(
      id: '3',
      title: 'Tafsir Session',
      instructor: 'Ustadz Mahmud',
      date: DateTime.now().add(const Duration(days: 3)),
      startTime: '19:00',
      endTime: '20:30',
      status: 'Upcoming',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child:
                _schedules.isEmpty
                    ? const Center(child: Text('No schedules found'))
                    : ListView.builder(
                      itemCount: _schedules.length,
                      itemBuilder: (context, index) {
                        return _buildScheduleCard(_schedules[index]);
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1F7A54),
        onPressed: () {
          _showAddEditScheduleDialog(context);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFF8F7F2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Course Schedule',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F7A54),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search courses...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Filter feature coming soon'),
                        backgroundColor: Color(0xFF1F7A54),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(CourseSchedule schedule) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
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
                    schedule.title,
                    style: const TextStyle(
                      fontSize: 18,
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
                    schedule.status,
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
              'Instructor: ${schedule.instructor}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${schedule.date.day}/${schedule.date.month}/${schedule.date.year}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${schedule.startTime} - ${schedule.endTime}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _showAddEditScheduleDialog(context, schedule: schedule);
                  },
                  child: const Text('Edit'),
                ),
                TextButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, schedule);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F7A54),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Join feature coming soon'),
                        backgroundColor: Color(0xFF1F7A54),
                      ),
                    );
                  },
                  child: const Text('Join'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEditScheduleDialog(
    BuildContext context, {
    CourseSchedule? schedule,
  }) {
    final _titleController = TextEditingController(text: schedule?.title ?? '');
    final _instructorController = TextEditingController(
      text: schedule?.instructor ?? '',
    );
    final _dateController = TextEditingController(
      text:
          schedule != null
              ? '${schedule.date.day}/${schedule.date.month}/${schedule.date.year}'
              : '',
    );
    final _startTimeController = TextEditingController(
      text: schedule?.startTime ?? '',
    );
    final _endTimeController = TextEditingController(
      text: schedule?.endTime ?? '',
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              schedule == null ? 'Add New Schedule' : 'Edit Schedule',
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Course Title',
                    ),
                  ),
                  TextField(
                    controller: _instructorController,
                    decoration: const InputDecoration(labelText: 'Instructor'),
                  ),
                  TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date (DD/MM/YYYY)',
                    ),
                    onTap: () async {
                      // Date picker would be implemented here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Date picker coming soon'),
                          backgroundColor: Color(0xFF1F7A54),
                        ),
                      );
                    },
                  ),
                  TextField(
                    controller: _startTimeController,
                    decoration: const InputDecoration(labelText: 'Start Time'),
                    onTap: () {
                      // Time picker would be implemented here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Time picker coming soon'),
                          backgroundColor: Color(0xFF1F7A54),
                        ),
                      );
                    },
                  ),
                  TextField(
                    controller: _endTimeController,
                    decoration: const InputDecoration(labelText: 'End Time'),
                    onTap: () {
                      // Time picker would be implemented here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Time picker coming soon'),
                          backgroundColor: Color(0xFF1F7A54),
                        ),
                      );
                    },
                  ),
                ],
              ),
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
                  // Save logic would be implemented here
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        schedule == null
                            ? 'Schedule added'
                            : 'Schedule updated',
                      ),
                      backgroundColor: const Color(0xFF1F7A54),
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    CourseSchedule schedule,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Schedule'),
            content: Text(
              'Are you sure you want to delete "${schedule.title}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Delete logic would be implemented here
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Schedule deleted'),
                      backgroundColor: Color(0xFF1F7A54),
                    ),
                  );
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}

class CourseSchedule {
  final String id;
  final String title;
  final String instructor;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String status;

  CourseSchedule({
    required this.id,
    required this.title,
    required this.instructor,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
  });
}
