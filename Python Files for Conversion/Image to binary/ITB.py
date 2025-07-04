import os
from PIL import Image

def convert_image_to_hex(image_path, hex_file_path):
    # Open the image
    img = Image.open(image_path)

    # Resize the image to 256x256 if it's not already
    img = img.resize((256, 256))

    # Convert the image to RGB (in case it's in another format like RGBA, grayscale, etc.)
    img = img.convert("RGB")

    # Open the hex file for writing
    with open(hex_file_path, 'w') as hex_file:
        # Loop through every pixel in the image and write the RGB values as hex
        for y in range(256):
            for x in range(256):
                # Get RGB values of the current pixel
                r, g, b = img.getpixel((x, y))

                # Convert RGB values to hex (6 characters)
                hex_color = f"{r:02X}{g:02X}{b:02X}"

                # Write the hex color to the file
                hex_file.write(hex_color + "\n")

    print(f"Image successfully converted to hex and saved at {hex_file_path}")

# Get a list of all .jpg files in the current directory
jpg_files = [f for f in os.listdir() if f.endswith('.jpg')]

# Process each .jpg file
for jpg_file in jpg_files:
    # Define the hex file path (same name as the jpg file but with .hex extension)
    hex_filename = os.path.splitext(jpg_file)[0] + ".hex"
    
    # Convert the image to hex and save it
    convert_image_to_hex(jpg_file, hex_filename)
