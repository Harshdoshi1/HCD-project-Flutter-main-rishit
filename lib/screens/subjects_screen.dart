import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  int _selectedSemester = 1;
  
  static const semesters = [
    {
      'name': 'Semester 1',
      'subjects': [
        {'name': 'Engineering Mathematics I', 'code': 'MA101'},
        {'name': 'Engineering Physics', 'code': 'PH101'},
        {'name': 'Engineering Chemistry', 'code': 'CH101'},
      ]
    },
    {
      'name': 'Semester 2',
      'subjects': [
        {'name': 'Engineering Mathematics II', 'code': 'MA201'},
        {'name': 'Basic Electronics', 'code': 'EC201'},
        {'name': 'Programming Fundamentals', 'code': 'CS201'},
      ]
    },
    {
      'name': 'Semester 3',
      'subjects': [
        {'name': 'Data Structures', 'code': 'CS301'},
        {'name': 'Digital Logic', 'code': 'CS302'},
        {'name': 'Computer Networks', 'code': 'CS303'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppTheme.primaryColor,
              child: Column(
                children: [
                  const Text(
                    'My Subjects',
                    style: TextStyle(
                      color: AppTheme.onPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(8, (index) {
                        final semester = index + 1;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ChoiceChip(
                            label: Text(
                              'Sem $semester',
                              style: TextStyle(
                                color: _selectedSemester == semester 
                                  ? AppTheme.onPrimaryColor 
                                  : AppTheme.onBackgroundColor,
                              ),
                            ),
                            selected: _selectedSemester == semester,
                            selectedColor: AppTheme.secondaryColor,
                            backgroundColor: AppTheme.surfaceColor,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedSemester = semester;
                                });
                              }
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: (_selectedSemester <= semesters.length) 
                  ? (semesters[_selectedSemester - 1]['subjects'] as List).length 
                  : 0,
                itemBuilder: (context, index) {
                  final subjects = _selectedSemester <= semesters.length
                    ? (semesters[_selectedSemester - 1]['subjects'] as List)
                    : [];
                  final subject = subjects[index];
                  return Card(
                    color: AppTheme.surfaceColor,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        subject['name'] as String,
                        style: const TextStyle(
                          color: AppTheme.onBackgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Code: ${subject['code']}',
                        style: TextStyle(color: AppTheme.onBackgroundColor),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: AppTheme.onBackgroundColor),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubjectDetailsScreen(subject: subject),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> subject;

  const SubjectDetailsScreen({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final components = [
      {'name': 'ESE (End Semester Exam)', 'marks': 100},
      {'name': 'VIVA', 'marks': 100},
      {'name': 'TERM WORK', 'marks': 100},
      {'name': 'CSE (Class Semester Exam)', 'marks': 100},
      {'name': 'IA (Internal Assessment)', 'marks': 100},
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(subject['name'] as String),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppTheme.surfaceColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Code: ${subject['code']}',
                    style: const TextStyle(
                      color: AppTheme.onBackgroundColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Assessment Components',
                    style: TextStyle(
                      color: AppTheme.onBackgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: components.length,
                itemBuilder: (context, index) {
                  final component = components[index];
                  return Card(
                    color: AppTheme.surfaceColor,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        component['name'] as String,
                        style: const TextStyle(
                          color: AppTheme.onBackgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Marks: ${component['marks']}',
                        style: TextStyle(color: AppTheme.onBackgroundColor),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: AppTheme.onBackgroundColor),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
