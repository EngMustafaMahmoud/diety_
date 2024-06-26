// ignore_for_file: library_private_types_in_public_api, file_names, avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../Core/Colors.dart';

class CustomSearchFood extends StatefulWidget {
  const CustomSearchFood({super.key});

  @override
  _CustomSearchFoodState createState() => _CustomSearchFoodState();
}

class _CustomSearchFoodState extends State<CustomSearchFood> {
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> _suggestedValues = [];
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: _searchController.text.isEmpty ? 50.0 : 70.0,
              width: double.infinity,
              child: TextFormField(
                onChanged: (value) {
                  _filterValues(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your food ';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                cursorColor: AppColors.button,
                style: TextStyle(color: AppColors.white, fontSize: 18),
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter your food or drink',
                  hintStyle: TextStyle(color: AppColors.white, fontSize: 18),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: AppColors.button,
                      size: 30,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _search();
                      }
                    },
                  ),
                  border: const UnderlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.button),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.button),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                focusNode: FocusNode()..addListener(_onFocusChange),
              ),
            ),
            const Gap(20),
            Text(
              _searchResult,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _suggestedValues.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _suggestedValues[index],
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                    ),
                    onTap: () {
                      _searchController.text = _suggestedValues[index];
                      _search();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _search() async {
    String valueToSearch = _searchController.text;

    try {
      // Call the searchByKey function to search for the value in the Firebase Realtime Database
      String? value = await searchByKey(valueToSearch);

      // Update state with the search result
      setState(() {
        if (value != null) {
          _searchResult = 'Every 100 grams of $valueToSearch is : $value';
        } else {
          _searchResult = 'Value not found.';
        }
      });
    } catch (error) {
      // Handle any errors that occur during data retrieval
      print('Error retrieving data: $error');
      setState(() {
        _searchResult = 'Error retrieving data. Please try again later.';
      });
    }
  }

  Future<String?> searchByKey(String key) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref();

    try {
      // Use a DatabaseEvent instead of a DataSnapshot
      DatabaseEvent event = await ref.once();

      // Access the DataSnapshot from the DatabaseEvent
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        // Cast snapshot value to Map<dynamic, dynamic>
        Map<dynamic, dynamic>? values =
            snapshot.value as Map<dynamic, dynamic>?;

        if (values != null) {
          // Iterate through all child nodes
          for (var entry in values.entries) {
            // Get the key and value
            String entryKey = entry.key.toString();
            String entryValue = entry.value.toString();

            // Check if the key matches the search term (case-insensitive)
            if (entryKey.substring(0, 1).toUpperCase() ==
                    key.substring(0, 1).toUpperCase() &&
                entryKey.substring(1) == key.substring(1)) {
              // Return the value if the key matches
              return entryValue;
            }
          }
        } else {
          print('Snapshot value is not a Map');
        }
      } else {
        // Handle the case when snapshot value is null
        print('Snapshot value is null');
      }
    } catch (error) {
      // Handle errors
      print('Error searching by key: $error');
    }

    return null; // Return null if key is not found or if an error occurs
  }

  void _filterValues(String query) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref();

    try {
      DatabaseEvent event = await ref.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          List<String> suggestions = [];
          for (var entry in values.entries) {
            String entryKey = entry.key.toString();
            if (entryKey.toLowerCase().contains(query.toLowerCase())) {
              suggestions.add(entryKey);
            }
          }
          setState(() {
            _suggestedValues = suggestions;
          });
        } else {
          print('Snapshot value is not a Map');
        }
      } else {
        print('Snapshot value is null');
      }
    } catch (error) {
      print('Error filtering values: $error');
    }
  }

  void _onSearchTextChanged() {
    _filterValues(_searchController.text);
  }

  void _onFocusChange() {
    setState(() {
      _isKeyboardVisible = !_isKeyboardVisible;
      // Clear suggestions when keyboard is visible
      if (_isKeyboardVisible) {
        _suggestedValues.clear();
      }
    });
  }
}
