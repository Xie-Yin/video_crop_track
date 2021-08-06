/*
 * 项目名:    video_crop_track
 * 包名       
 * 文件名:    video_track_painter
 * 创建时间:  2021/8/5 on 18:36
 * 描述:     TODO
 *
 * @author   阿钟
 */
import 'package:flutter/material.dart';

class VideoTrackPainter extends CustomPainter {
  Size earWhiteSize = Size(4, 12);
  Paint earPaint = Paint();
  Paint rectPaint = Paint()
    ..color = Color(0xFFFF443D)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  Paint maskPaint = Paint()
    ..color = Colors.black.withOpacity(0.6)
    ..style = PaintingStyle.fill;
  Paint timelinePaint = Paint()
    ..color = Color(0xFFFF443D)
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  ///耳朵的位置
  Size earSize;
  Offset leftEarOffset;
  Offset rightEarOffset;

  ///时间线偏移
  Offset timelineOffset;

  VideoTrackPainter({
    required this.leftEarOffset,
    required this.earSize,
    required this.rightEarOffset,
    required this.timelineOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _createMaskLayer(canvas, size);
    _createRect(canvas, size, leftEarOffset, rightEarOffset);
    _createEar(canvas, leftEarOffset, true);
    _createEar(canvas, rightEarOffset, false);
    _createTimeLine(canvas, size);
  }

  ///创建中间的矩形
  void _createRect(
      Canvas canvas, Size size, Offset leftEarOffset, Offset rightEarOffset) {
    double left = leftEarOffset.dx + earSize.width;
    double right = rightEarOffset.dx;

    ///线的宽度
    double top = leftEarOffset.dy + 1;
    double bottom = size.height - 1;
    Rect rect = Rect.fromLTRB(left, top, right, bottom);
    canvas.drawRect(rect, rectPaint);
  }

  ///创建两边的耳朵
  void _createEar(Canvas canvas, Offset offset, bool leftCorner) {
    Rect rect = offset & earSize;
    Radius radius = Radius.circular(6);
    RRect rRect = RRect.fromRectAndCorners(
      rect,
      topLeft: leftCorner ? radius : Radius.zero,
      bottomLeft: leftCorner ? radius : Radius.zero,
      topRight: leftCorner ? Radius.zero : radius,
      bottomRight: leftCorner ? Radius.zero : radius,
    );
    earPaint.color = Color(0xFFFF443D);
    canvas.drawRRect(rRect, earPaint);

    ///白色矩形
    Rect whiteRect = Rect.fromCenter(
        center: Offset(offset.dx + rect.width / 2, offset.dy + rect.height / 2),
        width: earWhiteSize.width,
        height: earWhiteSize.height);
    earPaint.color = Colors.white;
    RRect whiteRRect = RRect.fromRectAndRadius(whiteRect, Radius.circular(4));
    canvas.drawRRect(whiteRRect, earPaint);
  }

  ///绘制灰色蒙层
  void _createMaskLayer(Canvas canvas, Size size) {
    Rect leftRect =
        Rect.fromLTWH(earSize.width, 0, leftEarOffset.dx, size.height);
    canvas.drawRect(leftRect, maskPaint);
    Rect rightRect = Rect.fromLTWH(rightEarOffset.dx, 0,
        size.width - rightEarOffset.dx - earSize.width, size.height);
    canvas.drawRect(rightRect, maskPaint);
  }

  ///绘制时间线
  void _createTimeLine(Canvas canvas, Size size) {
    if (timelineOffset.dx == -1) return;
    Offset start = Offset(timelineOffset.dx, 0);
    Offset end = Offset(timelineOffset.dx, size.height);
    canvas.drawLine(start, end, timelinePaint);
  }

  ///是否需要拦截触摸事件
  bool interceptTouchEvent(Offset offset) {
    Rect leftRect = leftEarOffset & earSize;
    Rect rightRect = rightEarOffset & earSize;
    return leftRect.contains(offset) || rightRect.contains(offset);
  }

  @override
  bool shouldRepaint(VideoTrackPainter oldDelegate) {
    return true;
  }
}
