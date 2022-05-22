import 'package:educational_app/bloc/subject_addition_model_bloc.dart';
import 'package:educational_app/models/subject_additional_model.dart';
import 'package:educational_app/models/user_model.dart';
import 'package:educational_app/services/api_request_service/group_service.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../models/group_model.dart';
import 'course_screen.dart';

class SubjectScreen extends StatefulWidget {
  final UserModel user;
  const SubjectScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late Future<GroupModel> futureCurrentGroup;
  GroupModel? currentGroup;

  @override
  void initState() {
    futureCurrentGroup = GroupService().getCurrentGroup();
    futureCurrentGroup.then((value) {
      setState(() {
        currentGroup = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
      return [
        SliverAppBar(
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 100, 99, 99),
              ),
              height: 2,
              width: size.width * 100,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: RichText(
              text: TextSpan(
                text: currentGroup?.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            centerTitle: false,
          ),
        ),
      ];
    }, body: BlocBuilder<SubjectAdditionModelBloc, SubjectAdditionModelState>(
      builder: (context, state) {
        if (state is SubjectAdditionModelInitialState) {
          context
              .read<SubjectAdditionModelBloc>()
              .add(LoadSubjectAdditionModelEvent());
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SubjectAdditionModelLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SubjectAdditionModelLoadedState) {
          return customWidget(state.apiSubjectResult);
        }
        if (state is SubjectAdditionModelErrorState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Вы не состоите ни в какой группе.'),
              Text('Обратитесь к учителю, чтобы он добавил вас')
            ],
          );
        }
        return const Text('Ошибка');
      },
    ));
  }

  Widget customWidget(List<MySubjectOverall> apiSubjectResult) {
    var size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CategoryCard(
                subject: apiSubjectResult[index],
                user: widget.user,
                subjectOverall: apiSubjectResult,
              );
            },
            childCount: apiSubjectResult.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, childAspectRatio: 2.3),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final List<MySubjectOverall> subjectOverall;
  final MySubjectOverall subject;
  final UserModel user;

  const CategoryCard({
    Key? key,
    required this.subject,
    required this.user,
    required this.subjectOverall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return subjectOverall.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseScreen(
                      subject: subject,
                      subjectOverall: subjectOverall,
                      user: user,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image(
                        height: size.height,
                        width: size.width,
                        fit: BoxFit.cover,
                        image: const NetworkImage(
                            'https://besthqwallpapers.com/Uploads/24-8-2019/102582/thumb-education-is-very-important-gray-background-creative-art-education-motivation.jpg'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subject.subject.name.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.002,
                              ),
                              Text(
                                subject.subject.description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Id: " + subject.subject.id,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Center(
            child: (Text('Вы не состоите ни в одной группе')),
          );
  }
}
