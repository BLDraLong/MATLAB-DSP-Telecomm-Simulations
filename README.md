# MATLAB Simulations for Telecommunications & Control Systems

## 📌 Project Overview
This repository contains a comprehensive collection of MATLAB scripts and Simulink models developed for Digital Signal Processing (DSP), Control Systems, and Telecommunications engineering. It serves as a practical portfolio demonstrating hands-on experience in discrete-time system analysis, PID controller tuning, statistical distributions, and wireless fading channel modeling.

## 🗂️ Repository Structure

### `01_Basic_Signal_Operations`
Core functions for discrete-time signal manipulation and analysis:
* Signal generation (step functions, impulses).
* Signal transformations (shifting, folding, addition, multiplication).
* Linear convolution (`conv_m.m`) and frequency response analysis (`freqz_m.m`).

### `02_Probability_and_Channel_Models`
Scripts dedicated to statistical modeling and wireless communications (Highlight of the repository):
* Generation of random variables: Binomial, Chi, Chi-squared, Poisson, and Uniform distributions.
* **Fading Channel Simulation**: Implementation of wireless communication environments including Rayleigh, Rician, and Nakagami-m fading channels.
* **Performance Testing**: Comprehensive test scripts (`testNoise_AWNG_NAKA_REI_RICI.m`, `test_rayleigh.m`, `test_nakagami_m.m`) to evaluate and compare signal reliability and noise across different wireless environments.
* **Path Loss**: Simplified path loss modeling (`SimplifiedPathLoss.m`).

### `03_Control_Systems`
Algorithms and practical exercises for automated control systems:
* **PID Tuning**: Calculations and transfer functions for Proportional-Integral-Derivative (PID) controllers (`PID_Gs_buoi3.m`, `PID_K_Ti_Td.m`, `KT_pidtune.m`).
* **Practical Labs**: Step-by-step control system lab scripts (`TH_DKTD_Buoi1...`).
* **Simulink Models**: Block diagram implementations (`Buoi_2.slx`).

### `04_DSP_Course_Examples`
A systematic archive of DSP algorithms, categorized by course chapters and assignments:
* **Chapter 2 & 3 & 4:** Scripts covering discrete-time signals, Z-Transform applications, and frequency domain analysis (Fourier Transforms).
* **Final Exams & Assignments:** Various practical problem-solving scripts testing algorithm implementation.

### `05_Filter_Design`
Functions dedicated to digital filter design:
* Implementation of ideal low-pass filters (`ideal_lp.m`).
* Computation of desired impulse responses for FIR filter design (`hd.m`).

## 🛠️ Technologies & Tools
* **Software:** MATLAB, Simulink.
* **Key Domains:** Digital Signal Processing (DSP), LTI Systems, Wireless Fading Channels (AWGN, Rayleigh, Nakagami), Statistical Modeling, Control Systems (PID).

## 👨‍💻 Author
**Nguyen Hai Long**
* Senior Student majoring in Electronics and Telecommunications Engineering at Industrial University of Ho Chi Minh City.
* **Contact:** [Insert Your LinkedIn Profile Link Here]