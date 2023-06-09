import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'khawi.dart';
import 'tourist.dart';

class Offer {
  String title;
  String description;
  double? price;
  DateTime startDateTime;
  DateTime endDateTime;
  final DateTime creationDateTime;
  final Khawi khawi;
  String city;
  Tourist? tourist;

  Offer(
      {required this.title,
      required this.description,
      this.price,
      required this.khawi,
      required this.city,
      required this.startDateTime,
      required this.endDateTime,
      required this.creationDateTime});

  factory Offer.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    var offer = Offer(
      title: data?['title'],
      description: data?['description'],
      price: data?['price'],
      khawi: Khawi.fromMap(data?['khawi']),
      city: data?['city'],
      startDateTime: (data?['startDateTime'] as Timestamp).toDate(),
      endDateTime: (data?['endDateTime'] as Timestamp).toDate(),
      creationDateTime: (data?['creationDateTime'] as Timestamp).toDate(),
    );
    offer.tourist =
        data?['tourist'] == null ? null : Tourist.fromMap(data?['tourist']);

    return offer;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "description": description,
      if (price != null) "price": price,
      "khawi": khawi.toFirestore(),
      "city": city,
      if (tourist != null) "tourist": tourist!.toFirestore(),
      "startDateTime": startDateTime,
      "endDateTime": endDateTime,
      "creationDateTime": creationDateTime,
    };
  }
}
