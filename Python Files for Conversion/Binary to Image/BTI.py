import os
from PIL import Image
import numpy as np

# Define image dimensions
ROWS = 256  # Image rows
COLS = 256  # Image columns
EXPECTED_SIZE = ROWS * COLS

# Get a list of all .txt files in the current directory
txt_files = [f for f in os.listdir() if f.endswith('.txt')]

# Process each .txt file
for txt_file in txt_files:
    # Initialize the list for grayscale values
    grayscale_values = []

    # Read the grayscale data from the current txt file
    with open(txt_file, "r") as file:
        for line in file:
            grayscale_values.append(int(line.strip(), 16))

    # Check if the number of grayscale values matches the expected image size
    num_values = len(grayscale_values)

    if num_values < EXPECTED_SIZE:
        print(f"Warning: Found {num_values} grayscale values in {txt_file}, padding with black (0x00).")
        # Pad with 0x00 (black) if not enough values
        grayscale_values.extend([0] * (EXPECTED_SIZE - num_values))
    elif num_values > EXPECTED_SIZE:
        print(f"Warning: Found {num_values} grayscale values in {txt_file}, truncating the extra values.")
        # Truncate if there are too many values
        grayscale_values = grayscale_values[:EXPECTED_SIZE]

    # Create a numpy array to hold the pixel values
    image_array = np.array(grayscale_values, dtype=np.uint8).reshape((ROWS, COLS))

    # Create an image from the numpy array
    image = Image.fromarray(image_array)

    # Save the image with the same name as the txt file but with a .jpg extension
    jpg_filename = os.path.splitext(txt_file)[0] + ".jpg"
    image.save(jpg_filename)

    print(f"Image saved as {jpg_filename}.")
