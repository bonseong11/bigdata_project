import 'package:flutter/material.dart';

import 'package:kkn/home/home_controller.dart';
import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/home/dto/home_response_dto.dart';
import 'package:kkn/mypage/mypage_controller.dart';
import 'package:kkn/home/home_view.dart';
import 'package:kkn/drawer/drawer.dart';
import 'package:kkn/mypage/mypage_dto.dart';

class MypageView extends StatefulWidget {
  const MypageView({Key? key, required this.homeDto}) : super(key: key);

  final HomeDto homeDto;

  @override
  State<MypageView> createState() => _MypageViewState();
}

class _MypageViewState extends State<MypageView> {
  MypageDto mypage = MypageDto("", "", "", "0");

  String errorMessage = '';

  void updateProcess() async {
    MypageController mypageController = MypageController();

    errorMessage = await mypageController.memberupdate(mypage);

    if (errorMessage.isEmpty) {
      homePrepareProcess(mypage.userid);
    } else {
      setState(() {});
    }
  }

  void homePrepareProcess(String userid) async {
    HomeController homeController = HomeController();

    HomeResponseDto homeResponseDto =
        await homeController.homeInformationLoad(userid);

    if (homeResponseDto.errorMessage.isEmpty) {
      toHome(homeResponseDto.homeDto!);
    } else {
      setState(() {
        errorMessage = homeResponseDto.errorMessage;
      });
    }
  }

  void toHome(HomeDto homeDto) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomeView(homeDto: homeDto)));
  }

  bool updateFormValidate() {
    if (mypage.height == "") {
      setState(() {
        errorMessage = "빈칸을 입력해주세요.";
      });

      return false;
    }
    if (mypage.weight == "") {
      setState(() {
        errorMessage = "빈칸을 입력해주세요.";
      });

      return false;
    }
    return true;
  }

  void navigateToHome(HomeDto homeDto) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomeView(homeDto: homeDto)));
  }

  @override
  Widget build(BuildContext context) {
    mypage.userid = widget.homeDto.userid;

    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text('My Page'),
        backgroundColor: const Color(0xFF181818),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeView(homeDto: widget.homeDto)),
              );
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      drawer: AppDrawer(homeDto: widget.homeDto),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07,
            child: TextFormField(
              controller: TextEditingController(text: mypage.height),
              onChanged: (value) {
                mypage.height = value;
              },
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Height',
                labelStyle: const TextStyle(color: Colors.white),
                prefixIcon:
                    const Icon(Icons.person_outline, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07,
            child: TextFormField(
              controller: TextEditingController(text: mypage.weight),
              onChanged: (value) {
                mypage.weight = value;
              },
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Weight',
                labelStyle: const TextStyle(color: Colors.white),
                prefixIcon:
                    const Icon(Icons.person_outline, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07,
            child: DropdownButtonFormField<String>(
              value: mypage.gender,
              decoration: InputDecoration(
                labelText: 'Gender',
                labelStyle: const TextStyle(color: Colors.white),
                prefixIcon:
                    const Icon(Icons.person_outline, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              items: const [
                DropdownMenuItem<String>(
                  value: '0',
                  child: Text('Male'),
                ),
                DropdownMenuItem<String>(
                  value: '1',
                  child: Text('Female'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  mypage.gender = value!;
                });
              },
              dropdownColor: Colors.black, // 드롭다운 메뉴의 배경색을 검정색으로 설정
              style: const TextStyle(color: Colors.white),
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          if (errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.yellow),
            ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: updateProcess,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF181818),
                ),
                child: const Text('Update'),
              ),
            ],
          ),
          const SizedBox(height: 70.0),
        ],
      ),
    );
  }
}
