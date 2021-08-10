### 一个Flutter视频裁剪编辑的轨道UI交互效果

### 效果图展示
<img src="https://github.com/Xie-Yin/video_crop_track/blob/main/gif/screen_1.gif" width="300"/>  <img src="https://github.com/Xie-Yin/video_crop_track/blob/main/gif/screen_2.gif" width="300"/>

### 实现的功能
- 视频轨道最大截取3分钟
- 视频轨道最小截取3秒钟
- 如果小于3分钟则充满整个轨道
- 如果大于3分钟，则轨道上的展示的帧图片可以左右滑动来截取

### 示例代码

```java
VideoTrackWidget(
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
```