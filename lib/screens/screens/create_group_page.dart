import 'package:flutter/material.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  String? errorMessage;

  // final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final nameEditingController = TextEditingController();
  final chapterEditingController = TextEditingController();
  final audienceEditingController = TextEditingController();
  final subjectEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final name = TextFormField(
        autofocus: false,
        controller: nameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Название не может быть пустым");
          }
          return null;
        },
        onSaved: (value) {
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Название(Обязательно)",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final chapter = TextFormField(
        autofocus: false,
        controller: chapterEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          chapterEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Раздел",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final audience = TextFormField(
        autofocus: false,
        controller: audienceEditingController,
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          audienceEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Аудитория",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final subject = TextFormField(
        autofocus: false,
        controller: subjectEditingController,
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          subjectEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Предмет",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Создать курс',
          style: TextStyle(color: Colors.grey, fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  // createGroup();
                },
                child: const Text(
                  'Подтвердить',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                name,
                const SizedBox(height: 20),
                chapter,
                const SizedBox(height: 20),
                audience,
                const SizedBox(height: 20),
                subject,
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void createGroup() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       postDetailsToFirestore().catchError((e) {
  //         Fluttertoast.showToast(msg: e!.message);
  //       });
  //     } on FirebaseAuthException catch (error) {
  //       switch (error.code) {
  //         case "invalid-email":
  //           errorMessage = "Ваш адрес электронной почты имеет неверный формат.";
  //           break;
  //         case "wrong-password":
  //           errorMessage = "Ваш пароль неверный.";
  //           break;
  //         case "user-not-found":
  //           errorMessage =
  //               "Пользователь с таким адресом электронной почты не существует.";
  //           break;
  //         case "user-disabled":
  //           errorMessage =
  //               "Пользователь с этим адресом электронной почты отключен.";
  //           break;
  //         case "too-many-requests":
  //           errorMessage = "Слишком много запросов.";
  //           break;
  //         case "operation-not-allowed":
  //           errorMessage =
  //               "Вход с помощью электронной почты и пароля не доступен.";
  //           break;
  //         default:
  //           errorMessage = "Произошла неопределенная ошибка.";
  //       }
  //       Fluttertoast.showToast(msg: errorMessage!);
  //       if (kDebugMode) {
  //         print(error.code);
  //       }
  //     }
  //   }
  // }

  // postDetailsToFirestore() async {
  //   // calling our firestore
  //   // calling our user model
  //   // sending these values
  //
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = _auth.currentUser;
  //
  //   Group group = Group();
  //
  //   // writing all the values
  //   group.name = nameEditingController.text;
  //   group.chapter = chapterEditingController.text;
  //   group.audience = audienceEditingController.text;
  //   group.subject = subjectEditingController.text;
  //   group.role = 'teacher';
  //
  //   await firebaseFirestore
  //       .collection("group")
  //       .doc(group.name)
  //       .set(group.toMap());
  //   Fluttertoast.showToast(msg: "Курс был успешно создан!");
  //
  //   Navigator.pushAndRemoveUntil(
  //       (context),
  //       MaterialPageRoute(builder: (context) => const HomeScreen()),
  //       (route) => false);
  // }
}
