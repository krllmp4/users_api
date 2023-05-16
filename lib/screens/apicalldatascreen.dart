import 'package:flutter/material.dart';
import 'package:users/model/usermodel.dart';
import 'package:users/response/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Users>? _user = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _user = (await ApiService().getUsers())!;
    Future.delayed(const Duration(
      seconds: 1,
    )).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 2, 93),
        title: const Text(
          "Rest API example",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(3.0, 3.0),
                blurRadius: 5.0,
                color: Color.fromRGBO(62, 227, 200, 1),
              ),
            ],
          ),
        ),
      ),
      body: _user?.isEmpty ?? true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(62, 227, 200, 1),
              ),
            )
          : ListView.builder(
              itemCount: _user!.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: Column(children: [
                    CustomMultiChildLayout(
                      delegate: OwnMultiChildLayoutDelegate(),
                      children: [
                        LayoutId(
                          id: 1,
                          child: Text(_user![index].id.toString()),
                        ),
                        LayoutId(
                          id: 2,
                          child: Text(_user![index].username),
                        ),
                        LayoutId(
                          id: 3,
                          child: Text(_user![index].phone),
                        ),
                      ],
                    ),
                    ],),
                );
              }),
            ),
    );
  }
}
// child: Column(children: [
                  //   CustomMultiChildLayout(
                  //     delegate: OwnMultiChildLayoutDelegate(),
                  //     children: [
                  //       LayoutId(
                  //         id: 1,
                  //         child: Text(_user![index].id.toString()),
                  //       ),
                  //       LayoutId(
                  //         id: 2,
                  //         child: Text(_user![index].username),
                  //       ),
                  //       LayoutId(
                  //         id: 3,
                  //         child: Text(_user![index].phone),
                  //       ),
                  //       // LayoutId(
                  //       //   id: 4,
                  //       //   child: Text(_user![index].address.city),
                  //       // ),
                  //     ],
                  //   ),
                  // ]),

class OwnMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.biggest.width, 100);
  }

  @override
  void performLayout(Size size) {
    if (hasChild(1) && hasChild(2) && hasChild(3)) {
      const minOtherElWidth = 200;

      final firstElMaxWidth = size.width - 2 * minOtherElWidth;
      final firstElSize = layoutChild(
          1, BoxConstraints.loose(Size(firstElMaxWidth, size.height)));

      final thirdElMaxWidth = size.width - firstElMaxWidth - minOtherElWidth;
      final thirdElSize = layoutChild(
          3, BoxConstraints.loose(Size(thirdElMaxWidth, size.height)));

      final secondElMaxWidth = size.width - firstElMaxWidth - thirdElMaxWidth;
      final secondElSize = layoutChild(
          2, BoxConstraints.loose(Size(secondElMaxWidth, size.height)));

      final firstElY = size.height / 2 - firstElSize.height / 2;
      final secondElY = size.height / 2 - secondElSize.height / 2;
      final thirdElY = size.height / 2 - thirdElSize.height / 2;
      
      final secondElX = size.width/2 - secondElSize.height/2;
      final thirdElX = size.width - thirdElSize.width;
      positionChild(1, Offset(0, firstElY));
      positionChild(2, Offset(secondElX, secondElY));
      positionChild(3, Offset(thirdElX, thirdElY));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
