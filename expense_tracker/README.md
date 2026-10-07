# CSIT284 Expense Tracker

A Flutter application designed to track personal expenses, categorize spending, and monitor budget limits. Built as the final submission for the Lesson 5 milestone at Cebu Institute of Technology - University.

## Core Features

- <b>Custom UI Theme:</b> Electric Blue and Obsidian Black color palette with full dark mode and light mode toggle support.
- <b>Typography:</b> Integrated Google Fonts utilizing the Poppins typeface across all application text.
- <b>Budget Tracking:</b> Dynamic visual progress bar calculating total expenses against a monthly budget limit.
- <b>Expense Management:</b> Input forms with date pickers, category dropdowns, and input validation logic.
- <b>Interactive Gestures:</b> Swipe-to-delete functionality with an undo action via Scaffold SnackBar.

## Environment Setup

Ensure your development environment is properly configured before compiling the application. 

1. Clone the repository to your local machine.
2. Run <code>flutter clean</code> in your terminal to clear any cached build files.
3. Run <code>flutter pub get</code> to install all required dependencies including Google Fonts and UUID.
4. Launch an Android emulator (a Pixel 8 running API 33 or 34 is recommended to avoid experimental 16k page size bugs).
5. Execute <code>flutter run</code> to compile and boot the application.
