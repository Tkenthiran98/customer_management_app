import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/customer.dart';

class CustomerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<int> _getNextCustomerId() async {
    return await _db.runTransaction((transaction) async {
      DocumentReference counterRef = _db.collection('counters').doc('customers');
      DocumentSnapshot counterSnap = await transaction.get(counterRef);

      if (!counterSnap.exists) {
        await transaction.set(counterRef, {'currentId': 1});
        return 1;
      }

      int currentId = counterSnap.get('currentId');
      int nextId = currentId + 1;

      transaction.update(counterRef, {'currentId': nextId});
      return nextId;
    });
  }

  Future<void> addCustomer(Customer customer, File profileImage, String fileName) async {
    try {
      // Get the next customer ID
      int customerId = await _getNextCustomerId();
      customer.id = customerId.toString();  // Convert int to string

      // Upload profile image and get URL
      String imageUrl = await uploadImage(profileImage, fileName);
      customer.profilePictureUrl = imageUrl;

      // Add customer to Firestore
      await _db.collection('customers').doc(customer.id).set(customer.toJson());
    } catch (e) {
      print('Error adding customer: $e');
      throw e; // Rethrow the exception for UI to handle
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    try {
      await _db.collection('customers').doc(customer.id).update(customer.toJson());
    } catch (e) {
      print('Error updating customer: $e');
      throw e; // Rethrow the exception for UI to handle
    }
  }

  Future<void> updateCustomerWithImage(Customer customer, File profileImage, String fileName) async {
    try {
      // Upload new profile image and get URL
      String imageUrl = await uploadImage(profileImage, fileName);
      customer.profilePictureUrl = imageUrl;

      // Update customer in Firestore
      await _db.collection('customers').doc(customer.id).update(customer.toJson());
    } catch (e) {
      print('Error updating customer with image: $e');
      throw e; // Rethrow the exception for UI to handle
    }
  }

  Future<void> deleteCustomer(String customerId, String profilePictureUrl) async {
    try {
      // Delete customer from Firestore
      await _db.collection('customers').doc(customerId).delete();

      // Delete profile image from Firebase Storage
      await _storage.refFromURL(profilePictureUrl).delete();
    } catch (e) {
      print('Error deleting customer: $e');
      throw e; // Rethrow the exception for UI to handle
    }
  }

  Future<String> uploadImage(File image, String fileName) async {
    try {
      Reference ref = _storage.ref().child('profile_pictures/$fileName');

      // Determine file extension
      String fileType = fileName.split('.').last.toLowerCase();

      // Upload the file with metadata
      UploadTask uploadTask = ref.putFile(
        image,
        SettableMetadata(contentType: 'image/$fileType'),
      );

      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print('FirebaseException: $e');
      throw e; // Rethrow the exception for UI to handle
    } catch (e) {
      print('Error uploading image: $e');
      throw e; // Rethrow the exception for UI to handle
    }
  }

  Stream<List<Customer>> searchCustomers(String query) {
    return _db
        .collection('customers')
        .where('name', isGreaterThanOrEqualTo: query)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Customer.fromJson(doc.data())).toList());
  }
}
