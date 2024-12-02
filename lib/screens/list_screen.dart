import 'package:flutter/material.dart';
import '../services/university_service.dart';
import '../models/university.dart';
import '../colors/colors.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final UniversityService _universityService = UniversityService();
  late Future<List<University>> _universities;
  String _selectedCountry = 'Poland'; // Default country
  final List<String> _countries = [
    'Poland',
    'Germany',
    'France',
    'United States',
    'Canada',
    'Australia',
    'Japan',
    'China',
    'India',
    'Brazil',
    'Mexico',
    'South Africa',
    'Spain',
    'Netherlands',
    'Belgium',
    'Italy',
    'Turkey',
    'Portugal',
    'Austria',
    'Sweden',
    'Norway',
    'Denmark',
    'Finland',
    'Switzerland',
    'Ireland',
    'Greece',
    'Israel',
    'Romania',
    'Hungary',
    'Czech Republic',
    'Slovakia',
    'Croatia',
    'Slovenia',
    'Serbia',
    'Bulgaria',
    'Ukraine',
    'Latvia',
    'Estonia',
    'Lithuania',
  ];

  @override
  void initState() {
    super.initState();
    _loadUniversities();
  }

  void _loadUniversities() {
    setState(() {
      _universities = _universityService.fetchUniversities(_selectedCountry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universities', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryRed,
      ),
      body: Column(
        children: [
          // Dropdown for selecting country
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: _selectedCountry,
              items: _countries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  _selectedCountry = value;
                  _loadUniversities();
                }
              },
              decoration: InputDecoration(
                labelText: 'Select Country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<University>>(
              future: _universities,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No universities found'));
                }

                final universities = snapshot.data!;
                return ListView.builder(
                  itemCount: universities.length,
                  itemBuilder: (context, index) {
                    final university = universities[index];
                    return ListTile(
                      title: Text(university.name),
                      subtitle: Text(university.country),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
