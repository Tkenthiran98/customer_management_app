import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../services/customer_service.dart';
import '../models/customer.dart';

class EditCustomerScreen extends StatefulWidget {
  final Customer customer;

  EditCustomerScreen({Key? key, required this.customer}) : super(key: key);

  @override
  _EditCustomerScreenState createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _contact;
  DateTime? _dob;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _name = widget.customer.name;
    _email = widget.customer.email;
    _contact = widget.customer.contact;
    _dob = widget.customer.dob;
  }

  @override
  Widget build(BuildContext context) {
    CustomerService customerService = Provider.of<CustomerService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Customer'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value ?? '',
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value ?? '',
              ),
              TextFormField(
                initialValue: _contact,
                decoration: InputDecoration(labelText: 'Contact'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  return null;
                },
                onSaved: (value) => _contact = value ?? '',
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
                Image.file(_profileImage!, height: 100),
              SizedBox(height: 20),
              ElevatedButton(
  child: Text('Update Customer'),
  onPressed: () async {
    if (_formKey.currentState!.validate() && _dob != null) {
      _formKey.currentState!.save();
      Customer updatedCustomer = Customer(
        id: widget.customer.id,
        name: _name,
        email: _email,
        contact: _contact,
        dob: _dob!,
        profilePictureUrl: widget.customer.profilePictureUrl,
      );
      if (_profileImage != null) {
        String fileName = '${widget.customer.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        try {
          await customerService.updateCustomerWithImage(updatedCustomer, _profileImage!, fileName);
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Customer updated successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
        } catch (e) {
          // Handle error, e.g., show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update customer: $e'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        try {
          await customerService.updateCustomer(updatedCustomer);
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Customer updated successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
        } catch (e) {
          // Handle error, e.g., show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update customer: $e'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
      Navigator.pop(context);
    }
  },
),

            ],
          ),
        ),
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
