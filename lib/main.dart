import 'package:flutter/material.dart';
import 'package:video_crop_track/video_track_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter视频裁剪编辑的轨道UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> list = [
    '图1',
    '图2',
    '图3',
    '图4',
    '图5',
    '图6',
    '图7',
    '图8',
    '图9',
  ];
  final Duration duration = Duration(minutes: 1);
  List<String> list2 = [
    '图1',
    '图2',
    '图3',
    '图4',
    '图5',
    '图6',
    '图7',
    '图8',
    '图9',
    '图10',
    '图11',
    '图12',
    '图13',
    '图14',
    '图15',
    '图16',
  ];
  final Duration duration2 = Duration(minutes: 4);
  GlobalKey<VideoTrackWidgetState> key1 = GlobalKey();
  GlobalKey<VideoTrackWidgetState> key2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter视频裁剪编辑的轨道UI'),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Text('小于等于3分钟的视频展示'),
          SizedBox(height: 8),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: VideoTrackWidget(
              key: key1,
              imgList: list,
              totalDuration: duration,
              onSelectDuration: (start, end) {},
              trackWidgetBuilder:
                  (BuildContext context, String data, Size size) {
                return Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      data,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          _timelineControl(key1),
          SizedBox(height: 50),
          Text('大于3分钟的视频展示'),
          SizedBox(height: 8),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: VideoTrackWidget(
              key: key2,
              imgList: list2,
              totalDuration: duration2,
              onSelectDuration: (start, end) {},
              trackWidgetBuilder:
                  (BuildContext context, String data, Size size) {
                return Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      data,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          _timelineControl(key2),
        ],
      ),
    );
  }

  _timelineControl(GlobalKey<VideoTrackWidgetState> key) {
    return Column(
      children: [
        SizedBox(height: 10),
        Text('时间线控制'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              minWidth: 0,
              child: Text('开始'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                key.currentState!.startTimelineAnimation();
              },
            ),
            SizedBox(width: 16),
            MaterialButton(
              minWidth: 0,
              child: Text('暂停'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                key.currentState!.stopTimelineAnimation();
              },
            ),
            SizedBox(width: 16),
            MaterialButton(
              minWidth: 0,
              child: Text('继续'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                key.currentState!.continueTimelineAnimation();
              },
            ),
            SizedBox(width: 16),
            MaterialButton(
              minWidth: 0,
              child: Text('重新开始'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                key.currentState!.startTimelineAnimation(reset: true);
              },
            )
          ],
        ),
      ],
    );
  }
}
