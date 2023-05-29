
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;


// class Branch{
//   Future<void> fetchBranches() async {
//     final response = await http.get(Uri.parse('https://api.github.com/repos/${widget.ownerName}/${widget.repoName}/branches'));
//     if (response.statusCode == 200) {
//       final List<dynamic> branchesData = json.decode(response.body);
//       setState(() {
//         branches = branchesData;
//       });
//       // Fetch commits for each branch
//       for (var branch in branchesData) {
//         final branchName = branch['name'];
//         await fetchCommitsForBranch(branchName);
//       }
//     } else {
//       throw Exception('Failed to fetch branches');
//     }
//   }

//   Future<void> fetchCommitsForBranch(String branchName) async {
//     final response = await http.get(Uri.parse('https://api.github.com/repos/${widget.ownerName}/${widget.repoName}/commits?sha=$branchName'));
//     if (response.statusCode == 200) {
//       final List<dynamic> commitsData = json.decode(response.body);
//       setState(() {
//         commitsByBranch[branchName] = commitsData;
//       });
//     } else {
//       throw Exception('Failed to fetch commits for branch $branchName');
//     }
//   }
// }