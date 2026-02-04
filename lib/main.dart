import 'package:flutter/material.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Grade Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        fontFamily: 'Roboto',
      ),
      home: const GradeHomePage(),
    );
  }
}

class GradeHomePage extends StatefulWidget {
  const GradeHomePage({super.key});

  @override
  State<GradeHomePage> createState() => _GradeHomePageState();
}

class _GradeHomePageState extends State<GradeHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mathController = TextEditingController();
  final TextEditingController _scienceController = TextEditingController();
  final TextEditingController _englishController = TextEditingController();

  double _average = 0.0;
  String _grade = '';
  String _status = '';

  void _calculateGrade() {
    double math = double.tryParse(_mathController.text) ?? 0;
    double science = double.tryParse(_scienceController.text) ?? 0;
    double english = double.tryParse(_englishController.text) ?? 0;

    double avg = (math + science + english) / 3;

    String grade;
    String status;

    if (avg >= 90) {
      grade = 'A';
      status = 'Excellent';
    } else if (avg >= 80) {
      grade = 'B';
      status = 'Very Good';
    } else if (avg >= 70) {
      grade = 'C';
      status = 'Good';
    } else if (avg >= 60) {
      grade = 'D';
      status = 'Needs Improvement';
    } else {
      grade = 'F';
      status = 'Failed';
    }

    setState(() {
      _average = avg;
      _grade = grade;
      _status = status;
    });
  }

  void _clearFields() {
    _nameController.clear();
    _mathController.clear();
    _scienceController.clear();
    _englishController.clear();

    setState(() {
      _average = 0.0;
      _grade = '';
      _status = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Grade Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.primaryContainer,
              ],
            ),
          ),
        ),
      ),

      // LayoutBuilder for Responsive Layout
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1000;
          bool isDesktop = constraints.maxWidth >= 1000;

          double maxWidth = isDesktop
              ? 900
              : isTablet
              ? 700
              : double.infinity;

          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 30,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      _buildHeader(colorScheme, isMobile, isTablet),
                      const SizedBox(height: 25),

                      // Responsive Layout (Row on wide screens)
                      isMobile
                          ? Column(
                        children: [
                          _buildInputCard(),
                          const SizedBox(height: 20),
                          _buildButtons(isMobile),
                        ],
                      )
                          : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildInputCard()),
                          const SizedBox(width: 20),
                          Expanded(child: _buildButtons(isMobile)),
                        ],
                      ),

                      const SizedBox(height: 25),

                      _buildResultCard(isMobile),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(
      ColorScheme scheme, bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 25 : 35,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.primaryContainer],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Icon(
            Icons.school,
            color: Colors.white,
            size: isMobile ? 45 : 65,
          ),
          const SizedBox(height: 8),
          Text(
            'Grade Calculator',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 20 : 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

