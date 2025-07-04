# Image Processing using Verilog

## Overview
This project implements an image processing module in Verilog that performs grayscale conversion, defect detection, and image inversion on 256x256 RGB images. The module compares a defectless image with a potentially defective image, identifies defects based on a tolerance threshold, and generates grayscale and inverted image outputs.

## Features
- **Grayscale Conversion**: Converts RGB images to grayscale using the luminosity method (weighted formula: 30% Red, 59% Green, 11% Blue).
- **Defect Detection**: Compares a defectless image with a defective image, marking differences exceeding a tolerance threshold.
- **Image Inversion**: Generates an inverted grayscale image (255 - grayscale value).
- **File Output**: Saves grayscale data, defect locations, and inverted image data to text files in hexadecimal format.

## Prerequisites
- Verilog simulation environment (e.g., Vivado, ModelSim).
- Input image data in hexadecimal format (256x256 RGB, 24-bit per pixel).
- File paths for input hex files must be updated in the code to match your system.

## File Structure
- `image_processor.v`: Main Verilog module for image processing.
- `images/01.hex`: Sample defectless image data in hex format.
- `images/01_open_circuit.hex`: Sample defective image data in hex format.
- `grayscale_image.txt`: Output file for grayscale pixel values.
- `defect.txt`: Output file for defect locations (grayscale value or 0xFF for no defect).
- `invert.txt`: Output file for inverted grayscale image.

## Usage
1. **Prepare Input Files**:
   - Ensure `01.hex` and `01_open_circuit.hex` are in the specified directory (`C:/Users/itzka/OneDrive/Documents/Vivado/Intern/LEARNELECTRONICS/Image Processing/images/`).
   - Update file paths in the Verilog code if necessary.

2. **Run the Simulation**:
   - Load `image_processor.v` into your Verilog simulator.
   - Simulate the module to process the images and generate output files.

3. **Output Files**:
   - `grayscale_image.txt`: Contains grayscale values for the defectless image.
   - `defect.txt`: Contains grayscale values for defective pixels or `ff` for non-defective pixels.
   - `invert.txt`: Contains inverted grayscale values for the defectless image.

## Parameters
- `ROWS`: Number of rows in the image (default: 256).
- `COLS`: Number of columns in the image (default: 256).
- `TOLERANCE`: Threshold for defect detection (default: 5).

## How It Works
1. **Initialization**: The module initializes a grayscale data array and opens output files.
2. **Image Reading**: Reads defectless and defective image data from hex files into 24-bit RGB arrays.
3. **Grayscale Conversion**: Converts RGB pixels to grayscale using the formula:  
   `gray = (R * 30 + G * 59 + B * 11) / 100`.
4. **Defect Detection**: Compares grayscale values of defectless and defective images. If the absolute difference exceeds `TOLERANCE`, the pixel is marked as defective.
5. **Inversion**: Computes the inverted grayscale value (`255 - gray`) for each pixel.
6. **File Output**: Writes results to `grayscale_image.txt`, `defect.txt`, and `invert.txt` in hexadecimal format.

## Example
For a 256x256 image:
- Input: `01.hex` (defectless) and `01_open_circuit.hex` (defective).
- Output:
  - `grayscale_image.txt`: Grayscale values for all pixels.
  - `defect.txt`: Grayscale values for defective pixels or `ff` for non-defective.
  - `invert.txt`: Inverted grayscale values.

## Notes
- Ensure the file paths in the `$readmemh` and `$fopen` statements are valid for your system.
- The tolerance value (`TOLERANCE`) can be adjusted to fine-tune defect detection sensitivity.
- The module assumes 24-bit RGB input data (8 bits each for R, G, B).

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
