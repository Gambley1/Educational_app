import 'package:educational_app/widgets/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/addition_subject_bloc/subject_addition_model_bloc.dart';
import '../../blocs/current_group_bloc/current_group_bloc_dart_bloc.dart';
import '../../models/models.dart';
import '../screens.dart';

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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<SubjectAdditionModelBloc>(context).add(
                    LoadSubjectAdditionModelEvent(),
                  );
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.zero,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                ),
                height: 1,
                width: size.width * 100,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: BlocBuilder<CurrentGroupBloc, CurrentGroupState>(
                builder: (context, state) {
                  if (state is CurrentGroupLoadingState) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  if (state is CurrentGroupLoadedState) {
                    return _buildAppBar(state.group);
                  }
                  if (state is SubjectAdditionModelErrorState) {
                    return const KText(
                      text: 'Ooops! Nothing found.',
                    );
                  }
                  return Container();
                },
              ),
              centerTitle: false,
            ),
          ),
        ];
      },
      body: BlocBuilder<SubjectAdditionModelBloc, SubjectAdditionModelState>(
        builder: (context, state) {
          if (state is SubjectAdditionModelLoadedState) {
            var subjectsOverall = state.subjectOverall;
            return _customWidget(subjectsOverall);
          } else if (state is SubjectAdditionModelLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is SubjectAdditionModelNoInternetState) {
            return const Center(
              child: KText(
                text: 'No Internet',
              ),
            );
          } else if (state is SubjectAdditionModelErrorState) {
            return const Center(
              child: KText(
                text: 'Ooops! Nothing found.',
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(GroupModel group) {
    return KText(
      text: group.name,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _customWidget(List<MySubjectOverall> subjectsOverall) {
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return SubjectCard(
                subject: subjectsOverall[index],
                user: widget.user,
                subjectOverall: subjectsOverall,
              );
            },
            childCount: subjectsOverall.length,
          ),
        ),
      ],
    );
  }
}

class SubjectCard extends StatelessWidget {
  final List<MySubjectOverall> subjectOverall;
  final MySubjectOverall subject;
  final UserModel user;

  const SubjectCard({
    Key? key,
    required this.subjectOverall,
    required this.subject,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
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
                  height: 120,
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
                        KText(
                          text: subject.subject.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        KText(
                          text: subject.subject.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
