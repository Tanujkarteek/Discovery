import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:together/constants/colors.dart';
import 'package:together/widgets/calls.dart';
import 'package:tuple/tuple.dart';

import '../models/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<WebData> data = <WebData>[];
  int pageNum = 1;
  bool isLoading = false; // Track loading state
  bool isReturnEmpty = false;

  @override
  void initState() {
    super.initState();
    fetchData(); // Initial data fetch
    _scrollController.addListener(loadMoreData);
  }

  void fetchData() async {
    setState(() => isLoading = true); // Show loading indicator
    final Tuple2<List<WebData>, bool> result = await getData(pageNum, isReturnEmpty);
    if(result.item2){
      setState(() {
        isLoading = false;// Hide loading indicator
        isReturnEmpty = true;
      });
    }
    setState(() {
      data.addAll(result.item1);
      isLoading = false;// Hide loading indicator
      isReturnEmpty = result.item2;
    });
  }

  void loadMoreData() {
    if (!isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      pageNum++;
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text(
            'Discovery App',
            style: TextStyle(
              color: textColor,
              fontFamily: 'Galorine',
              fontSize: 30,
            ),
        ),
      ),
      body:Column(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: false,
                controller: _scrollController,
                itemCount: data.length + (isReturnEmpty ? 1 : 0),
                itemBuilder: (context, index) {
                  if(index == data.length && isReturnEmpty){
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        const Text(
                          'No more data',
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'InterTight',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ],
                    );
                  }
                  else{
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: canvasColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: data[index].imageUrl!,
                              width: MediaQuery.of(context).size.width * 0.3,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].title!,
                                style: const TextStyle(
                                  color: textColor,
                                  fontFamily: 'WatchQuinn',
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  data[index].description!,
                                  softWrap: true,
                                  style: const TextStyle(
                                    color: textColor,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            )
          ),
          isLoading ? const CircularProgressIndicator() : const SizedBox(),
        ],
      ),
    );
  }
}