import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:dictionary_api/provider/bloc/bloc_provider_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocProviderBloc(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<BlocProviderBloc>(context).add(FetchDictionaryValues(''));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary API'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: width * 0.9,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.clear,
                  size: 25,
                ),
              ),
              onChanged: (text) {
                BlocProvider.of<BlocProviderBloc>(context)
                    .add(FetchDictionaryValues(text));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<BlocProviderBloc, BlocProviderState>(
              builder: (context, state) {
                if (state is DictionaryLoaded) {
                  return ListView.separated(
                    itemCount: state.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<ListElement> ld = state.list;
                      return Container(
                        color: index.isEven ? Colors.black12 : Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Text(
                                ld[index].word,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.70,
                              child: Text(
                                ld[index].definition,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  );
                } else if (state is DictionaryLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
