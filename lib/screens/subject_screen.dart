import 'dart:math';

import 'package:educational_app/constants/colors.dart';
import 'package:educational_app/models/data_model.dart';
import 'package:educational_app/models/subjects_model.dart';
import 'package:educational_app/models/user_model.dart';
import 'package:educational_app/services/group_service.dart';
import 'package:flutter/material.dart';

import 'course_screen.dart';

class SubjectScreen extends StatefulWidget {
  final List<Datum>? data;
  const SubjectScreen({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late UserModel user;

  late Future<List<Datum>?> futureListGroup;

  @override
  void initState() {
    futureListGroup = GroupService().getListOfGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Datum>?>(
      future: futureListGroup,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: kPrimaryColor,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        // TextSpan(
                        //   text: '',
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: 18),
                        // ),
                        TextSpan(
                          text: 'Класс',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  centerTitle: false,
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CategoryCard(
                      data: snapshot.data,
                      dataModel: snapshot.data![index],
                      subject: subjectList[index],
                    );
                  },
                  childCount: subjectList.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.1,
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Subject subject;
  final List<Datum>? data;
  final Datum? dataModel;
  const CategoryCard({
    Key? key,
    this.data,
    this.dataModel,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CourseScreen(
            subject: subject,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 4.0,
                spreadRadius: .05,
              ), //BoxShadow
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 13,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  subject.thumbnail,
                  height: 75,
                  width: 75,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(subject.name, style: Theme.of(context).textTheme.bodyLarge),
              Text(
                data!.length.toString() + ' курсов',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'id: ' + dataModel!.id.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
