import 'package:faaza_stream_rtc/call_screen.dart';
import 'package:faaza_stream_rtc/config.dart';
import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class TilawahScreen extends StatefulWidget {
  const TilawahScreen({super.key});

  @override
  State<TilawahScreen> createState() => _TilawahScreenState();
}

class _TilawahScreenState extends State<TilawahScreen> {
  final List<TilawahTeacher> _teachers = [
    TilawahTeacher(
      id: '1',
      name: 'Ustadz Ahmad Fauzi',
      specialty: 'Tajwid & Tahsin',
      rating: 4.9,
      // imageUrl: 'assets/teacher1.svg',
      availability: 'Available Now',
    ),
    TilawahTeacher(
      id: '2',
      name: 'Ustadzah Fatimah',
      specialty: 'Quran Memorization',
      rating: 4.8,
      // imageUrl: 'assets/teacher2.svg',
      availability: 'Available at 14:00',
    ),
    TilawahTeacher(
      id: '3',
      name: 'Ustadz Mahmud',
      specialty: 'Tafsir & Tajwid',
      rating: 4.7,
      // imageUrl: 'assets/teacher3.svg',
      availability: 'Available at 19:00',
    ),
  ];

  final List<String> _surahList = [
    'Al-Fatihah',
    'Al-Baqarah',
    'Ali-Imran',
    'An-Nisa',
    'Al-Maidah',
    'Al-An\'am',
    'Al-A\'raf',
    'Al-Anfal',
    'At-Tawbah',
    'Yunus',
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
              tabs: [Tab(text: 'Teachers'), Tab(text: 'My Sessions')],
            ),
          ),
        ),
        body: TabBarView(
          children: [_buildTeachersTab(), _buildMySessionsTab()],
        ),
      ),
    );
  }

  Widget _buildTeachersTab() {
    return Column(
      children: [
        _buildSearchAndFilter(),
        Expanded(
          child: ListView.builder(
            itemCount: _teachers.length,
            itemBuilder: (context, index) {
              return _buildTeacherCard(_teachers[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFF8F7F2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Find a Tilawah Teacher',
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
                    hintText: 'Search teachers...',
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

  Widget _buildTeacherCard(TilawahTeacher teacher) {
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
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F7A54).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF1F7A54),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teacher.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F7A54),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        teacher.specialty,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFFC99645),
                            size: 16,
                          ),
                          Text(
                            ' ${teacher.rating}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
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
                    teacher.availability,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1F7A54),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1F7A54)),
                  ),
                  onPressed: () {
                    _showTeacherProfileDialog(context, teacher);
                  },
                  child: const Text(
                    'View Profile',
                    style: TextStyle(color: Color(0xFF1F7A54)),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F7A54),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _showBookSessionDialog(context, teacher);
                  },
                  child: const Text('Book Session'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMySessionsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.menu_book, size: 80, color: Color(0xFF1F7A54)),
          const SizedBox(height: 24),
          const Text(
            'No Tilawah Sessions Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F7A54),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Book a session with one of our qualified teachers',
            style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F7A54),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            onPressed: () {
              DefaultTabController.of(context).animateTo(0);
            },
            child: const Text('Find a Teacher'),
          ),
        ],
      ),
    );
  }

  void _showTeacherProfileDialog(BuildContext context, TilawahTeacher teacher) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(teacher.name),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F7A54).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF1F7A54),
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFC99645),
                        size: 16,
                      ),
                      Text(
                        ' ${teacher.rating}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Specialty:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(teacher.specialty),
                  const SizedBox(height: 8),
                  const Text(
                    'Availability:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(teacher.availability),
                  const SizedBox(height: 8),
                  const Text(
                    'About:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Experienced Quran teacher with expertise in proper pronunciation and recitation techniques. Dedicated to helping students connect with the Quran through proper understanding and application of tajwid rules.',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Languages:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('Arabic, English, Indonesian'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F7A54),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _showBookSessionDialog(context, teacher);
                },
                child: const Text('Book Session'),
              ),
            ],
          ),
    );
  }

  void _showBookSessionDialog(BuildContext context, TilawahTeacher teacher) {
    String selectedSurah = _surahList[0];
    String selectedDate = 'Today';
    String selectedTime = '14:00';

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Book Tilawah Session'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Teacher: ${teacher.name}'),
                      const SizedBox(height: 16),
                      const Text(
                        'Select Surah:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: selectedSurah,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedSurah = newValue;
                            });
                          }
                        },
                        items:
                            _surahList.map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Select Date:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: selectedDate,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedDate = newValue;
                            });
                          }
                        },
                        items:
                            <String>[
                              'Today',
                              'Tomorrow',
                              'In 2 days',
                              'In 3 days',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Select Time:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: selectedTime,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedTime = newValue;
                            });
                          }
                        },
                        items:
                            <String>[
                              '09:00',
                              '10:00',
                              '11:00',
                              '14:00',
                              '15:00',
                              '16:00',
                              '19:00',
                              '20:00',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                    onPressed: () async {
                      Navigator.pop(context);

                      // Show confirmation and then start call
                      final startCall =
                          await showDialog<bool>(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Session Booked'),
                                  content: Text(
                                    'Your Tilawah session with ${teacher.name} has been booked for $selectedDate at $selectedTime.\n\nWould you like to start the session now?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.pop(context, false),
                                      child: const Text('Later'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF1F7A54,
                                        ),
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed:
                                          () => Navigator.pop(context, true),
                                      child: const Text('Start Now'),
                                    ),
                                  ],
                                ),
                          ) ??
                          false;

                      if (startCall && context.mounted) {
                        try {
                          var call = StreamVideo.instance.makeCall(
                            callType: StreamCallType.defaultType(),
                            id: AppConfig.generateCallId(),
                          );
                          await call.getOrCreate();

                          if (!context.mounted) return;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallScreen(call: call),
                            ),
                          );
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      }
                    },
                    child: const Text('Book'),
                  ),
                ],
              );
            },
          ),
    );
  }
}

class TilawahTeacher {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  // final String imageUrl;
  final String availability;

  TilawahTeacher({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    // required this.imageUrl,
    required this.availability,
  });
}
