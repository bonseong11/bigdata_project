import 'package:flutter/material.dart';

import 'package:kkn/home/home_controller.dart';
import 'package:kkn/home/dto/home_dto.dart';
import 'package:kkn/home/dto/home_response_dto.dart';
import 'package:kkn/mypage/mypage_controller.dart';
import 'package:kkn/home/home_view.dart';
import 'package:kkn/drawer/drawer.dart';
import 'package:kkn/mypage/dto/mypage_dto.dart';

class MypageView extends StatefulWidget {
  const MypageView({Key? key, required this.homeDto, required this.myPageDto})
      : super(key: key);

  final HomeDto homeDto;
  final MypageDto myPageDto;

  @override
  State<MypageView> createState() => _MypageViewState();
}

class _MypageViewState extends State<MypageView> {
  MypageDto mypageDto = MypageDto("", "", "", "0", "", "");

  bool obscurePassword = true;
  String errorMessage = '';

  void updateProcess() async {
    errorMessage =
        await MypageController().memberupdate(mypageDto, widget.myPageDto);

    if (errorMessage.isEmpty) {
      homePrepareProcess(widget.homeDto.userid);
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

  @override
  void initState() {
    super.initState();

    mypageDto.nickname = widget.myPageDto.nickname;
    mypageDto.email = widget.myPageDto.email;
    mypageDto.gender = widget.myPageDto.gender;
    mypageDto.age = widget.myPageDto.age;
    mypageDto.height = widget.myPageDto.height;
    mypageDto.weight = widget.myPageDto.weight;
    mypageDto.userid = widget.homeDto.userid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text('내 정보'),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.07,
              child: TextFormField(
                enabled: false,
                controller: TextEditingController(text: mypageDto.userid),
                onChanged: (value) {
                  mypageDto.password = value;
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'ID',
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
                controller: TextEditingController(text: mypageDto.password),
                onChanged: (value) {
                  mypageDto.password = value;
                },
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "암호",
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon:
                      const Icon(Icons.password_outlined, color: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: obscurePassword
                        ? const Icon(Icons.visibility_outlined,
                            color: Colors.white)
                        : const Icon(Icons.visibility_off_outlined,
                            color: Colors.white),
                  ),
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
                controller: TextEditingController(text: mypageDto.nickname),
                onChanged: (value) {
                  mypageDto.nickname = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: '닉네임',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.person_pin, color: Colors.white),
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
                controller: TextEditingController(text: mypageDto.email),
                onChanged: (value) {
                  mypageDto.email = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: '이메일',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: Colors.white),
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
                value: mypageDto.gender,
                decoration: InputDecoration(
                  labelText: '성별',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.contact_emergency_outlined,
                      color: Colors.white),
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
                    child: Text('남성'),
                  ),
                  DropdownMenuItem<String>(
                    value: '1',
                    child: Text('여성'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    mypageDto.gender = value!;
                  });
                },
                dropdownColor: Colors.black, // 드롭다운 메뉴의 배경색을 검정색으로 설정
                style: const TextStyle(color: Colors.white),
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.07,
              child: TextFormField(
                controller: TextEditingController(text: mypageDto.height),
                onChanged: (value) {
                  mypageDto.height = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: '키',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.height, color: Colors.white),
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
                controller: TextEditingController(text: mypageDto.weight),
                onChanged: (value) {
                  mypageDto.weight = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: '몸무게',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.fitness_center_outlined,
                      color: Colors.white),
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
                controller: TextEditingController(text: mypageDto.age),
                onChanged: (value) {
                  mypageDto.age = value;
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: '나이',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon:
                      const Icon(Icons.cake_outlined, color: Colors.white),
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
                  child: const Text('수정'),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomeView(homeDto: widget.homeDto)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF181818),
                  ),
                  child: const Text('취소'),
                ),
              ],
            ),
            const SizedBox(height: 70.0),
          ],
        ),
      ),
    );
  }
}
