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
import 'package:video_crop_track/track_style.dart';

class VideoTrackPainter extends CustomPainter {
  late Paint earPaint;
  late Paint rectPaint;
  late Paint maskPaint;
  late Paint timelinePaint;
  late Size earSize;

  ///耳朵的位置
  final Offset leftEarOffset;
  final Offset rightEarOffset;

  ///时间线偏移
  final Offset timelineOffset;
  final TrackStyle style;

  VideoTrackPainter({
    required this.leftEarOffset,
    required this.rightEarOffset,
    required this.timelineOffset,
    required this.style,
  }) {
    _init();
  }

  void _init() {
    earSize = style.earSize;
    earPaint = Paint();
    rectPaint = Paint()
      ..color = style.trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    maskPaint = Paint()
      ..color = style.maskColor
      ..style = PaintingStyle.fill;
    timelinePaint = Paint()
      ..color = style.trackColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
  }

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
    earPaint.color = style.trackColor;
    canvas.drawRRect(rRect, earPaint);

    ///白色矩形
    Rect whiteRect = Rect.fromCenter(
        center: Offset(offset.dx + rect.width / 2, offset.dy + rect.height / 2),
        width: style.earRectSize.width,
        height: style.earRectSize.height);
    earPaint.color = style.earRectColor;
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
