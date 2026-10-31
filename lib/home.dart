

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/joke.dart';

class MyHomeView extends StatelessWidget {
  const MyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Random joke generator app"),),
      body: SizedBox.expand(
        child: Consumer(
          builder: (context, ref, _){
            final randomJoke = ref.watch(randomJokeProvider);

            return Stack(
              alignment: Alignment.center,
              children: [
                switch (randomJoke) {
                  AsyncValue(:final value?) => SelectableText(
                    '${value.setup}\n\n${value.punchline}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),

                  AsyncValue(error: != null) => const Text("Error fetching Joke"),

                  AsyncValue() => const CircularProgressIndicator(),
                },
                Positioned(
                  bottom: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.invalidate(randomJokeProvider);
                    },
                    child: const Text("Get another Joke"),
                  ),
                ),
                if (randomJoke.isRefreshing)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(),
                  )
              ],
            );
          },
        )
      ),
    );
  }
}