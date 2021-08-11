/*
 * 项目名:    video_crop_track
 * 包名       
 * 文件名:    style_config
 * 创建时间:  2021/8/11 on 10:30
 * 描述:     TODO
 *
 * @author   阿钟
 */

import 'package:flutter/material.dart';

class TrackStyle {
  ///轨道高度
  final double trackHeight;

  ///帧图片宽度
  final double imgWidth;

  ///轨道颜色
  final Color trackColor;

  ///遮罩颜色
  final Color maskColor;

  ///拖拽耳朵内矩形的颜色
  final Color earRectColor;

  ///拖拽耳朵的大小
  final Size earSize;

  ///拖拽耳朵内矩形的大小
  final Size earRectSize;

  const TrackStyle({
    this.trackHeight = 48,
    this.imgWidth = 48,
    this.earSize = const Size(20, 48),
    this.earRectSize = const Size(4, 12),
    this.trackColor = const Color(0xFFFF443D),
    this.maskColor = const Color.fromRGBO(0, 0, 0, 0.6),
    this.earRectColor = Colors.white,
  });
}
