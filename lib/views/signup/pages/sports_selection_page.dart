import 'package:flutter/material.dart';

class SportSelectionScreen extends StatefulWidget {
  const SportSelectionScreen({Key? key}) : super(key: key);

  @override
  State<SportSelectionScreen> createState() => _SportSelectionScreenState();
}

class _SportSelectionScreenState extends State<SportSelectionScreen> {
  final List<String> sports = [
    'Football',
    'Boxing',
    'MMA',
    'Cricket',
    'Football',
    'Boxing',
    'MMA',
  ];

  final Set<String> selectedSports = {};

  void _toggleSport(String sport) {
    setState(() {
      if (selectedSports.contains(sport)) {
        selectedSports.remove(sport);
      } else {
        selectedSports.add(sport);
      }
    });
  }

  IconData _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer;
      case 'boxing':
        return Icons.sports_martial_arts;
      case 'mma':
        return Icons.sports_mma;
      case 'cricket':
        return Icons.sports_cricket;
      default:
        return Icons.sports;
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF121212);
    const cardColor = Color(0xFF1E1E1E);
    const borderColor = Color(0xFF3C3C3C);
    const textColor = Colors.white70;
    const selectedColor = Colors.red;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Select your Current Sport',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Step 3 of 5',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 24),

            // Progress Bar
            Container(
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.pink, Colors.purple],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Sports List
            Expanded(
              child: ListView.builder(
                itemCount: sports.length,
                itemBuilder: (context, index) {
                  final sport = sports[index];
                  final isSelected = selectedSports.contains(sport);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () => _toggleSport(sport),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected ? selectedColor : borderColor,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? selectedColor.withOpacity(0.1)
                                    : const Color(0xFF2C2C2C),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getSportIcon(sport),
                                color: isSelected ? selectedColor : textColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              sport,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color:
                                    isSelected ? selectedColor : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Continue Button
            Container(
              width: double.infinity,
              height: 56,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: selectedSports.isNotEmpty
                    ? () {
                        print('Selected sports: $selectedSports');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedSports.isNotEmpty ? selectedColor : borderColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
