import 'package:flutter/material.dart';

class ParentDetailsPage extends StatefulWidget {
  const ParentDetailsPage({Key? key}) : super(key: key);

  @override
  State<ParentDetailsPage> createState() => _ParentDetailsPageState();
}

class _ParentDetailsPageState extends State<ParentDetailsPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Widget buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[600]!,
                width: 1,
              ),
            ),
            child: TextField(
              controller: controller,
              keyboardType: inputType,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                border: InputBorder.none,
                hintText: 'Enter $label',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[400]),
                        onPressed: () {
                          setState(() {
                            controller.clear();
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
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
            const Text(
              'Parent Details',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Step 4 of 5',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildInputField(
                        label: 'First Name', controller: _firstNameController),
                    buildInputField(
                        label: 'Last Name', controller: _lastNameController),
                    buildInputField(
                        label: 'Date of Birth', controller: _dobController),
                    buildInputField(
                        label: 'Email',
                        controller: _emailController,
                        inputType: TextInputType.emailAddress),
                    buildInputField(
                        label: 'Telephone',
                        controller: _telephoneController,
                        inputType: TextInputType.phone),
                    buildInputField(
                        label: 'Postal Code',
                        controller: _postalCodeController),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 56,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  final data = {
                    'First Name': _firstNameController.text,
                    'Last Name': _lastNameController.text,
                    'Date of Birth': _dobController.text,
                    'Email': _emailController.text,
                    'Telephone': _telephoneController.text,
                    'Postal Code': _postalCodeController.text,
                  };
                  print('Parent Details: $data');
                  // Handle continue logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
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
