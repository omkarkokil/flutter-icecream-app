import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_app/modal/icecream.dart';

class IceCreamView extends StatelessWidget {
  const IceCreamView({super.key});

  Future<List<Icecream>> loadIceCreams() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      // Get data from json file
      final rawIceCreams = await rootBundle.loadString("assets/icecream.json");

      // Decode the JSON data
      final Map<String, dynamic> decodedData = jsonDecode(rawIceCreams);

      // Extract the list of ice creams from the decoded data
      final List<dynamic> icecreamList = decodedData['icecreams'];

      // Map the list to Icecream objects
      final iceCreams =
          icecreamList.map((item) => Icecream.fromJson(item)).toList();

      return iceCreams;
    } catch (e) {
      print("Error occurred: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Icecream? selectedIcecream;
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Icecream",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Text(
              "We have the best ice cream in town.",
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: Column(children: [
              FutureBuilder(
                  future: loadIceCreams(),
                  builder: (context, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.done) {
                    final icecreams = snapshot.data;
                    selectedIcecream = icecreams![0];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height / 3,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final icecream = icecreams[index];

                              return CardWidget(icecream: icecream);
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: icecreams.length,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Toppings for you",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final topping = selectedIcecream!.toppings![index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(selectedIcecream!.image!),
                              ),
                              title: Text(topping),
                            );
                          },
                          scrollDirection: Axis.vertical,
                          itemCount: selectedIcecream!.toppings!.length,
                        ),
                      ],
                    );
                    // } else {
                    //   return const CircularProgressIndicator.adaptive();
                    // }
                  })
            ]))
          ],
        ));
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, this.icecream});

  final Icecream? icecream;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 215,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              icecream!.image!,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(icecream!.flavor,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                      Text(
                        icecream!.price.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
