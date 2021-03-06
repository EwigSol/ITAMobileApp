// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:italms/utils/CustomAppBarWidget.dart';
import 'package:italms/utils/Utils.dart';
import 'package:italms/utils/apis/Apis.dart';
import 'package:italms/utils/model/UploadedContent.dart';
import 'package:italms/utils/widget/StudyMaterial_row.dart';

// ignore: must_be_immutable
class StudentSyllabus extends StatefulWidget {
  String id;

  StudentSyllabus({this.id});

  @override
  _StudentSyllabusState createState() => _StudentSyllabusState();
}

class _StudentSyllabusState extends State<StudentSyllabus> {
  Future<UploadedContentList> syllabuses;

  String _token;

  @override
  void initState() {
    Utils.getStringValue('token').then((value) {
      _token = value;
    });
    Utils.getStringValue('id').then((value) {
      setState(() {
        syllabuses = fetchSyllabus(
            widget.id != null ? int.parse(widget.id) : int.parse(value));
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Syllabus'),
      backgroundColor: Colors.white,
      body: FutureBuilder<UploadedContentList>(
        future: syllabuses,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot != null) {
            if (snapshot.data.uploadedContents.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.uploadedContents.length,
                itemBuilder: (context, index) {
                  return StudyMaterialListRow(
                      snapshot.data.uploadedContents[index]);
                },
              );
            } else {
              return Utils.noDataWidget();
            }
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }

  Future<UploadedContentList> fetchSyllabus(dynamic id) async {
    final response = await http.get(Uri.parse(InfixApi.getStudentSyllabus(id)),
        headers: Utils.setHeader(_token.toString()));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      return UploadedContentList.fromJson(jsonData['data']['uploadContents']);
    } else {
      throw Exception('failed to load');
    }
  }
}
