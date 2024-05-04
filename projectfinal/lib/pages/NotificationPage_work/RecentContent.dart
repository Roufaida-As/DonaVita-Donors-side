import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/NotificationPage_work/NotificationItem.dart';

class RecentContent extends StatelessWidget {
  const RecentContent({super.key, Key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Organisations').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        final documents = snapshot.data!.docs;
        return ListView.separated(
          itemCount: documents.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(color: AppColors.highicons),
          itemBuilder: (context, index) {
            final orgName = documents[index]['name'];
            final orgLogoUrl = documents[index]['logoURL'];
            final orgId = documents[index].id;
            final isFirst = index == 0;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    orgName, // Display organization name
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                NotificationItem(
                  orgname: orgName,
                  orgLogoUrl: orgLogoUrl,
                  orgId: orgId,
                  isFirst: isFirst,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
