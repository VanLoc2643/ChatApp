import 'package:flutter/material.dart';

class AppColors {
  // Màu chủ đạo chính (ví dụ màu xanh đặc trưng của Messenger)
  static const Color kPrimary = Color(0xFFFF8383);

  // Màu chủ đạo tối hơn, dùng cho trạng thái nhấn giữ, viền
  static const Color kPrimaryDark = Color(0xFF006FDD);

  // Màu chủ đạo sáng hơn, dùng cho background nhẹ hoặc hiệu ứng hover
  static const Color primaryLight = Color(0xFFADD8FF);

  // Màu phụ, dùng làm điểm nhấn thứ hai (nút phụ, cảnh báo nhẹ, icon phụ)
  static const Color kSecondary = Color(0xFFFF6600);

  // Màu nền tổng thể khi giao diện ở chế độ sáng (Light Mode)
  static const Color kBackgroundLight = Color(0xFFffffff);

  // Màu nền tổng thể khi giao diện ở chế độ tối (Dark Mode)
  static const Color kBackgroundDark = Color(0xFF121212);

  // Màu nền cho các bề mặt UI như card, dialog, app bar trong Light Mode
  static const Color kSurfaceLight = Color(0xFFF5F5F5);

  // Màu nền cho các bề mặt UI trong Dark Mode
  static const Color kSurfaceDark = Color(0xFF121212);

  // Màu chữ chính trên nền sáng
  static const Color kTextPrimaryLight = Color(0xFF222222);

  // Màu chữ chính trên nền tối
  static const Color kTextPrimaryDark = Colors.white;

  // Màu chữ phụ, mô tả, chú thích trên nền sáng
  static const Color kTextSecondaryLight = Color(0xFF757575);

  // Màu chữ phụ trên nền tối
  static const Color kTextSecondaryDark = Color(0xFFB3B3B3);

  // Màu báo lỗi, cảnh báo quan trọng
  static const Color kError = Color(0xFFFF3333);

  static const Color statusOnline = Color(0xFF4BCB1F);
  static const Color kLabelTextPrimary = Color(0xFF14304A);
  //Trắng
  static const Color kWhite = Colors.white;
}
