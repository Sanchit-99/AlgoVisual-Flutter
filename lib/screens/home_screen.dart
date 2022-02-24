import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<int> data = [];
  var p, q;
  int delayTime = 50;
  int _value = 80;
  bool isRunning = false;

  List<String> _sortingAlgos = [
    "Insertion Sort",
    "Bubble Sort",
    "Selection Sort",
    "Merge Sort",
    "Quick Sort"
  ];
  
  var _currentAlgoSelected = "Insertion Sort";

  void addData(int n) {
    // var random = new Random();
    // data.clear();
    // for (int i = 1; i <= n; i++) {
    //   data.add(random.nextInt(101)); //add a random no bw 0 - 100
    // }
    data.clear();
    for(int i=1;i<=n;i++){
      data.add(i);
    }
    shuffle();
  }

  @override
  void initState() {
    addData(80);
    super.initState();
  }

  void shuffle() {
    var random = new Random();
    for (var i = data.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = data[i];
      data[i] = data[n];
      data[n] = temp;
    }
  }

  Future<void> _mergeSort(int start, int end) async {
    if (start < end) {
      int mid = (start + end) ~/ 2;
      await _mergeSort(start, mid);
      await _mergeSort(mid + 1, end);
      await _merge(start, mid, end);
    }

    setState(() {
      p = -1;
      q = -1;
    });
  }

  Future<void> callMergeSort() async {
    await _mergeSort(0, data.length - 1);
    setState(() {
      p = -1;
      q = -1;
      isRunning = false;
    });
  }

  Future<void> _merge(int start, int mid, int end) async {
    List _backupArray = List.from(data);
    int m = (mid - start) + 1;
    int n = (end - mid);
    List<int> arr1 = List(m);
    List<int> arr2 = List(n);
    int i, j, k = start;

    for (i = 0; i < m; ++i) {
      arr1[i] = data[k++];
    }
    for (j = 0; j < n; ++j) {
      arr2[j] = data[k++];
    }

    i = j = 0;
    k = start;

    while (i != m && j != n) {
      int _index;
      await Future.delayed(Duration(milliseconds: delayTime));
      setState(() {});
      if (arr1[i] < arr2[j]) {
         _index = _backupArray.indexOf(arr1[i]);
         p = _index;
        q = k;
        data[k++] = arr1[i++];
      } else {
         _index = _backupArray.indexOf(arr2[j]);
         q = _index;
        p = k;
        data[k++] = arr2[j++];
      }
    }

    while (i != m) {
      await Future.delayed(Duration(milliseconds: delayTime));
      setState(() {});
      int _index = _backupArray.indexOf(arr1[i]);
      p = _index;
      q = k;
      data[k++] = arr1[i++];
    }

    while (j != n) {
      await Future.delayed(Duration(milliseconds: delayTime));
      setState(() {});
      int _index = _backupArray.indexOf(arr2[j]);
      q = _index;
      p = k;
      data[k++] = arr2[j++];
    }
  }

  void selectionSort() async {
    int n = data.length;
    int i, j, min_idx;

    for (i = 0; i < n - 1; i++) {
      min_idx = i;

      for (j = i + 1; j < n; j++) {
        if (data[j] < data[min_idx]) {
          min_idx = j;
          await Future.delayed(Duration(milliseconds: delayTime));
          setState(() {});
          p = min_idx;
          q = i;
        }
      }
      await Future.delayed(Duration(milliseconds: delayTime));
      setState(() {});
      p = min_idx;
      q = i;
      int temp = data[min_idx];
      data[min_idx] = data[i];
      data[i] = temp;
    }
    setState(() {
      p = -1;
      q = -1;
      isRunning = false;
    });
  }

  Future<void> _quickSort(int start, int end) async {
    if (start < end) {
      int pIndex = await partition(start, end);

      await _quickSort(start, pIndex - 1);
      await _quickSort(pIndex + 1, end);
    }
  }

  Future<void> callQuickSort() async {
    await _quickSort(0, data.length - 1);
    setState(() {
      p = -1;
      q = -1;
      isRunning = false;
    });
  }

  Future<int> partition(int low, int high) async {
    int pivot = data[high]; // pivot
    int i = (low -
        1); // Index of smaller element and indicates the right position of pivot found so far

    for (int j = low; j <= high - 1; j++) {
      // If current element is smaller than the pivot
      if (data[j] < pivot) {
        i++; // increment index of smaller element
        await Future.delayed(Duration(milliseconds: delayTime));
        setState(() {});
        p = i;
        q = j;
        int temp = data[i];
        data[i] = data[j];
        data[j] = temp;
      }
    }
    await Future.delayed(Duration(milliseconds: delayTime));
    setState(() {});
    p = i + 1;
    q = high;
    int temp = data[i + 1];
    data[i + 1] = data[high];
    data[high] = temp;
    return i + 1;
  }

  void bubbleSort() async {
    var n = data.length;
    for (var i = 0; i < n; i++) {
      for (var j = 0; j < n - i - 1; j++) {
        if (data[j] > data[j + 1]) {
          await Future.delayed(Duration(milliseconds: delayTime));
          setState(() {
            p = j;
            q = j + 1;
          });
          var temp = data[j];
          data[j] = data[j + 1];
          data[j + 1] = temp;
        }
      }
    }
    setState(() {
      p = -1;
      q = -1;
      isRunning = false;
    });
  }

  void insertionSort() async {
    for (var i = 0; i < data.length; i++) {
      var x = data[i], j = i;
      while (j > 0 && data[j - 1] > x) {
        data[j] = data[j - 1];
        data[j - 1] = x;
        j--;
        await Future.delayed(Duration(milliseconds: delayTime));
        setState(() {
          p = i;
          q = j - 1;
        });
      }
      data[j] = x;
    }
    setState(() {
      p = -1;
      q = -1;
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: mq.height * 0.1,
              padding: EdgeInsets.only(top: 32),
              child: Text(
                '$_currentAlgoSelected',
                style: TextStyle(
                  fontSize: 25,
                ),
              )),
          Container(
            height: mq.height * 0.8,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 500,
                width: mq.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < data.length; i++)
                      FractionallySizedBox(
                        alignment: Alignment.bottomCenter,
                        heightFactor: data[i] / data.length,
                        child: Container(
                          //margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 0.2),
                            color:
                                (i == p || i == q) ? Colors.red : Colors.green,
                          ),

                          width: (mq.width * 0.9) / (data.length),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: mq.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor:
                      isRunning ? Colors.grey : Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      if (!isRunning) {
                        isRunning = true;
                        switch (_currentAlgoSelected) {
                          case "Insertion Sort":
                            insertionSort();
                            break;
                          case "Bubble Sort":
                            bubbleSort();
                            break;
                          case "Selection Sort":
                            selectionSort();
                            break;
                          case "Merge Sort":
                            callMergeSort();
                            break;
                          case "Quick Sort":
                            callQuickSort();
                            break;
                        }
                      }
                    });
                  },
                  child: isRunning
                      ? Icon(Icons.hourglass_empty)
                      : Icon(Icons.play_arrow),
                ),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor:
                      isRunning ? Colors.grey : Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      if (!isRunning) shuffle();
                    });
                  },
                  child: Icon(Icons.replay),
                ),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor:
                      isRunning ? Colors.grey : Theme.of(context).primaryColor,
                  onPressed: () {
                    if (!isRunning)
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0))),
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: mq.height * 0.5,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Change Sorting Algorithm',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                StatefulBuilder(
                                    builder: (context, rebuildSheetUI) {
                                  return DropdownButton<String>(
                                    elevation: 16,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    // underline: Container(
                                    //   height: 2,
                                    //   color: Colors.deepPurpleAccent,
                                    // ),
                                    value: _currentAlgoSelected,
                                    items: _sortingAlgos
                                        .map(
                                          (String e) => DropdownMenuItem(
                                            child: Text(e),
                                            value: e,
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (String e) {
                                      rebuildSheetUI(() {
                                        this._currentAlgoSelected = e;
                                      });
                                      setState(() {});
                                    },
                                  );
                                }),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Change Array Size',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                StatefulBuilder(
                                  builder: (context, rebuildSheetUI) {
                                    return SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        valueIndicatorShape:
                                            PaddleSliderValueIndicatorShape(),
                                        valueIndicatorTextStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Slider(
                                        min: 10,
                                        max: 300,
                                        value: _value.toDouble(),
                                        label: "$_value",
                                        divisions: 15,
                                        onChanged: (value) {
                                          rebuildSheetUI(() {
                                            _value = value.toInt();
                                            addData(_value);
                                          });
                                          setState(() {});
                                        },
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Change Delay Time',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                StatefulBuilder(
                                  builder: (context, rebuildSheetUI) {
                                    return SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        valueIndicatorShape:
                                            PaddleSliderValueIndicatorShape(),
                                        valueIndicatorTextStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Slider(
                                        min: 1,
                                        max: 500,
                                        value: delayTime.toDouble(),
                                        label: "$delayTime",
                                        divisions: 15,
                                        onChanged: (value) {
                                          rebuildSheetUI(() {
                                            delayTime = value.toInt();
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                  },
                  child: Icon(Icons.settings),
                ),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor:
                      isRunning ? Colors.grey : Theme.of(context).primaryColor,
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationVersion: "1.0",
                      children: [
                        Text('• Developed by Sanchit Gupta'),
                        Text('• Graphics by logomakr.com'),
                      ]
                    );
                  },
                  child: Icon(Icons.info),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
