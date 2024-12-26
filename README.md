# Torsion Bar Design

**ME 314 Spring 2024 Student Design Project**  
Department of Mechanical Engineering  
Author: Sean A. Hedgecock  
Professor: Ricardo Ayala  

## Table of Contents

- [Overview](#overview)
- [Project Objective](#project-objective)
- [Key Design Features](#key-design-features)
- [Analysis and Calculations](#analysis-and-calculations)
- [Key Takeaways & Skills Demonstrated](#key-takeaways--skills-demonstrated)
- [Conclusion](#conclusion)
- [References](#references)

---

## Overview

This repository contains the final design and analysis for a conceptual torsion bar, part of a vehicle suspension system, developed as a project for the ME 314 course at SDSU. The design incorporates principles of mechanical engineering, material science, and structural analysis to meet specified safety and performance requirements.

<p align="center">
  <img src="https://github.com/user-attachments/assets/2ed66846-645d-4155-bef5-c558a7a257a4" alt="Torsion Bar Detail" width="700">
</p>

---

## Project Objective

The project focuses on designing a steel torsion bar integrated into a vehicle's suspension to enhance wheel and tire dynamics. The bar connects an axle to a lever arm, ensuring the system adapts to road conditions while maintaining stability and resilience.

Key goals include:
- **Material Efficiency:** Using hollow torsion bar shafts to reduce weight without sacrificing strength.
- **Fatigue Resistance:** Calculating safety factors for critical components.
- **Compliance:** Ensuring the design adheres to engineering standards and specified performance metrics.

---

## Key Design Features

1. **Torsion Bar Shaft:**
   - Material: AISI 4140 Q&T steel
   - Dimensions: Outer diameter of 1.375 inches, inner diameter of 0.6 inches
   - Safety Factor: > 1.15 for torsional stress

2. **Bearing Support Lug:**
   - Material: 333-T5 aluminum
   - Safety Factor: > 3.75 for lug stress

3. **Spline Connections:**
   - Involute splines for torque transmission
   - Analysis includes shear and compressive stresses

4. **Fatigue Analysis:**
   - Conducted using the DE Soderberg method
   - Safety factor > 1.10 for fatigue resistance

---

## Analysis and Calculations

The project includes:
- **Shear force and bending moment diagrams:**

<p align="center">
  <img src="https://github.com/user-attachments/assets/ad53bfaf-4690-4bc6-a6a4-4a0d4d2d6b05" alt="Axle Shear" width="400">
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/affff1d4-9b3a-4a0c-81c1-ce10e908626d" alt="Axle Moment" width="400">
</p>

- **Fatigue and safety factor assessments:**

<p align="center">
  <img src="https://github.com/user-attachments/assets/312b7a6e-bc62-4f62-90e0-d248a957f406" alt="Additional Image 1" width="400">
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/ca75932a-d71f-46be-917e-8b8dca9c4f95" alt="S-N Curve" width="400">
</p>

- **Material selection and optimization:**

<p align="center">
  <img src="https://github.com/user-attachments/assets/06116932-2055-4b1c-9064-05ea644a7ef4" alt="Additional Image 2" width="400">
</p>

- **MATLAB programming for iterative calculations**  
  The provided scripts automate calculations for stress, factor of safety, and fatigue life estimation.

Comprehensive tables and figures are included in the project report to document loading conditions, stresses, and safety factors.

---

## Key Takeaways & Skills Demonstrated

- **Mechanical Design**: Torsion bar engineering for vehicle suspension systems.  
- **Finite Element & Analytical Analysis**: Fatigue assessment using standard engineering methods (e.g., DE Soderberg).  
- **MATLAB Scripting**: Data-driven calculations and plotting to verify design feasibility.  
- **Technical Documentation**: Clear reporting of methods, calculations, and results.  
- **Project Management**: Demonstrating the ability to take a concept from initial specifications through final design validation.

---

## Conclusion

The torsion bar design successfully meets all safety, material, and performance criteria outlined in the project requirements. The design offers a cost-efficient and reliable solution for vehicle suspension systems.

---

## References

1. Ayala, Ricardo. ME 314 Lecture Slides. 
2. Shigley’s Mechanical Engineering Design, 11th Edition.
3. Beam Calculator for Statically Indeterminate Beams, Optimal Beam.
