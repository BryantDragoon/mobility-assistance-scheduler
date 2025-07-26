
# Digital Scheduling App for Accessible Transportation Services [Development discontinued]

Prototype of an app for scheduling mobility assistance for people with physical impairments.

## 🎯 Problem Description

Users with physical limitations may not always have the daily support of family members or acquaintances. Therefore, they can request the assistance of trained personnel to help them during transportation to their scheduled activities, as well as provide support while those activities are being carried out.

## 🛠️ Proposed solution

A double support posture analysis system was proposed based on insoles, using force-sensitive resistive sensors and other easily accessible electronic components.

## ✨ Main results

The system allows the evaluation of reaction forces present during the user's support posture, providing accurate information about the loads borne under key anatomical points on the sole of the foot.
- Individual load quantification up to 15 kg at each analysis point.
- Force estimations with satisfactory accuracy, exhibiting a maximum error of approximately 20%.
- In general, the system is estimated to capture approximately 40% of the total forces exerted by the user during double support stance.

## 📸 Visual Overview

### Data Acquisition System

The System was built with affordable electronic components like force-sensitive resistors, resistors, multiplexers 16:1, an ESP32 board, etc.

<img src="/images/Estacion_sistema.jpg" alt="Station for testing insoles" width="30%">

### Graphical user interface for visualizing forces

A user-friendly graphical interface was developed to facilitate intuitive and efficient system control. The interface allows for the selection of different sensor configurations, initiation and termination of the remote connection with the development board (ESP32), as well as the start and stop of data sampling. Throughout the process, real-time measurements are continuously displayed on screen, ensuring immediate feedback and system monitoring. Optionally, the sampled data can be saved as a CSV file for future analysis and comparison.

<img src="/images/Menu_plantillas.png" alt="Selection of the insole configuration" width="30%">
<img src="/images/interfaz_8.png" alt="Insoles with 8 sensors" width="30%">
<img src="/images/interfaz_11.png" alt="Insoles with 11 sensors" width="30%">
<img src="/images/interfaz_16.png" alt="Insoles with 16 sensors" width="30%">
<img src="/images/parado_natural.png" alt="Double support stance" width="50%">

### Visualization of Analysis Results

If the user’s scan data was stored, a script was developed to generate 3D and 2D visualizations based on the average of the recorded forces. Once the path to the user’s CSV file is specified, the script processes the data and produces these visualizations, enabling more in-depth analyses over time or comparisons with other users. Additionally, the script includes a variety of useful functions for comparing multiple results from the same user, as well as comparisons between different users.

<img src="/images/representacion_3d.jpg" alt="3D visualization" width="40%">
<img src="/images/distribucion.jpg" alt="Force distribution" width="40%">

## 📁 Project Structure

```
main/
├── images/ # Images used in README.md
├── source/ # Source codes of the project
│ ├── Analisis_Resultados.py # Script for statistical and visual analysis
│ ├── FSRs_Mux_Bluetooth.ino # ESP32 program logic
│ └── Sistema_Fuerzas_Plantares.py # Main program logic
└── README.md # Project overview
```

## 🧰 Technologies Used

- Python
  - Tkinter
  - Serial
  - Numpy
  - Pandas
  - Matplotlib 
- Arduino
  - BluetoothSerial.h
  - string.h 

## 📖 Official Project Repository

To access the complete development of the project—including technical documentation, user testing, validation processes, and statistical analysis—please visit the official institutional repository at the following link:
🔗 [Repositorio Institucional Buelna](http://repositorio.uas.edu.mx/handle/DGB_UAS/785)

