import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../services/customer_service.dart';
import '../models/customer.dart';

class AddCustomerScreen extends StatefulWidget {
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _contact;
  DateTime? _dob;
  File? _profileImage;

  @override
  Widget build(BuildContext context) {
    CustomerService customerService = Provider.of<CustomerService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Customer'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField(
                label: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              _buildTextFormField(
                label: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              _buildTextFormField(
                label: 'Contact',
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10 || !value.startsWith(RegExp(r'[0-9]'))) {
                    return 'Please enter a valid 10-digit contact number';
                  }
                  return null;
                },
                onSaved: (value) => _contact = value!,
                keyboardType: TextInputType.phone,
              ),
              ListTile(
                title: Text('Date of Birth: ${_dob != null ? _dob!.toLocal().toString().split(' ')[0] : 'Select date'}'),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text('Profile Picture'),
                trailing: Icon(Icons.photo),
                onTap: _pickImage,
              ),
              if (_profileImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Image.file(_profileImage!, height: 100),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text('Add Customer', style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate() &&
                      _dob != null &&
                      _profileImage != null) {
                    _formKey.currentState!.save();
                    try {
                      // Generate file name
                      String fileName = '${_name}_${DateTime.now().millisecondsSinceEpoch}.jpg';

                      // Upload image first
                      String imageUrl = await customerService.uploadImage(_profileImage!, fileName);

                      // Create new customer
                      Customer newCustomer = Customer(
                        id: '', // ID will be set by Firestore
                        name: _name,
                        email: _email,
                        contact: _contact,
                        dob: _dob!,
                        profilePictureUrl: imageUrl,
                      );

                      // Add customer to Firestore
                      await customerService.addCustomer(newCustomer, _profileImage!, fileName);

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Customer added successfully!')),
                      );

                      // Navigate back after successful addition
                      Navigator.pop(context);
                    } catch (e) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error adding customer: $e')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all fields and select an image')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _dob = date;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }
}
