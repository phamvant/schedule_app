import 'package:flutter/material.dart';
import 'package:memo/components/form.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Tạo ghi chú'),
        ),
        floatingActionButton: Align(
          alignment: const Alignment(0.95, 0.95),
          child: FloatingActionButton.large(
            onPressed: () {
              setState(() {});
            },
            child: const Icon(Icons.save),
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Positioned(
            //     bottom: 20,
            //     right: 20,
            //     height: 100,
            //     width: 100,
            //     child: ElevatedButton(
            //       style: ButtonStyle(
            //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(40))),
            //         backgroundColor: WidgetStateProperty.all(
            //           const Color.fromARGB(255, 125, 188, 239),
            //         ),
            //       ),
            //       onPressed: () {},
            //       child: const Text(
            //         "Thêm",
            //         style: TextStyle(color: Colors.white, fontSize: 20),
            //       ),
            //     )),
            Padding(
              padding: const EdgeInsets.only(left: 200, right: 200, top: 100),
              child: Column(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: ListView.separated(
                          itemBuilder: (context, item) => const AddForm(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 100),
                          itemCount: 20),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
