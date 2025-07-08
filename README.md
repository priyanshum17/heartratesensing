# Health Data Analysis through Mobile Devices

## Objective
In this assignment, we will utilize the sensors on mobile phones to track health data such as heartbeat and breathing patterns. The goal is to demonstrate that mobile phones are powerful and sufficient for personal health data monitoring.

## Part I – Develop a Mobile Phone App
This part involves developing a mobile application using Flutter (https://flutter.dev/), a cross-platform app development framework compatible with both iOS and Android. The app will record data from the phone's sensors, specifically the Inertial Measurement Unit (IMU) and, as a bonus, the microphone.

## Part II – Collect Data through Mobile Phone
Using the developed mobile app, data will be collected while the user is stationary (sitting or lying down). The phone should be placed on the chest, and three trials, each lasting 5 minutes, will be recorded. Efforts should be made to minimize movement during data acquisition.

## Part III – Data Analysis
The final part focuses on deriving heartbeat and breathing patterns from the collected IMU data. The heart rate and breathing rate will be reported, along with a detailed, professional description of the process used to obtain these results.

---

# Mobile IMU Data Recorder

This Flutter application is designed for high-frequency Inertial Measurement Unit (IMU) data acquisition from mobile devices. It captures accelerometer, gyroscope, and magnetometer data at a sampling rate of approximately 100 Hz.

## Features

- **High-Frequency Data Capture**: Records accelerometer, gyroscope, and magnetometer data at 100 Hz.
- **Real-time Sensor Monitoring**: Displays recent sensor readings on-screen.
- **CSV Export**: Compiles recorded sensor data into a CSV file for easy analysis.
- **Native Sharing Integration**: Facilitates seamless sharing of the generated CSV file via the device's native share sheet (e.g., AirDrop on iOS)
