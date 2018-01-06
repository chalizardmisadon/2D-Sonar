# 2D-Sonar
Simple project to familiarize with Arduino, servos, and ultrasonic sensors to prepare for Sumobot.

The sonar consists of:
- Arduino Uno R3  
- Futaba S3151 Servo  
- HC-SR04 Ultrasonic Sensor

# Overview
The Arduino set the angle for the servo, then reads the distance value from the ultrasonic sensor. It transmits the information using serial communication to a computer through USB connection. Processing program reads the information from the serial port and animates a radar screen.
