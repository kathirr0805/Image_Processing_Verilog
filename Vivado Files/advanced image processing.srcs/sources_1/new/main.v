module image_processor;

    parameter ROWS = 256;    // Number of rows in the image
    parameter COLS = 256;    // Number of columns in the image
    parameter TOLERANCE = 5; // Tolerance threshold for small differences

    reg [7:0] grayscale_data [0:ROWS-1][0:COLS-1];
    reg [23:0] defectless_image_data [0:ROWS-1][0:COLS-1]; 
    reg [23:0] defect_image_data [0:ROWS-1][0:COLS-1]; 
    integer i, j;
    reg [7:0] r, g, b, gray;
    reg [23:0] defectless_pixel, defect_pixel;
    integer defect_file;
    integer grayscale_file;
    integer invert_file;  // File for inverted image

    initial begin
        // Initialize grayscale_data array to 0
        for (i = 0; i < ROWS; i = i + 1) begin
            for (j = 0; j < COLS; j = j + 1) begin
                grayscale_data[i][j] = 8'b0; // Initialize grayscale data
            end
        end

        // Open the files for writing grayscale data, defects, and inverted image
        grayscale_file = $fopen("grayscale_image.txt", "w");
        defect_file = $fopen("defect.txt", "w");
        invert_file = $fopen("invert.txt", "w");  // Open invert.txt for writing

        // Read the hex data into image_data arrays from the specified location
        $display("Reading hex files...");
        $readmemh("C:/Users/itzka/OneDrive/Documents/Vivado/Intern/LEARNELECTRONICS/Image Processing/images/01.hex", defectless_image_data); // Read the defectless image hex file
        $readmemh("C:/Users/itzka/OneDrive/Documents/Vivado/Intern/LEARNELECTRONICS/Image Processing/images/01_open_circuit.hex", defect_image_data); // Read the defect image hex file
        $display("Hex files read successfully.");

        // Process each pixel
        for (i = 0; i < ROWS; i = i + 1) begin
            for (j = 0; j < COLS; j = j + 1) begin
                defectless_pixel = defectless_image_data[i][j];
                defect_pixel = defect_image_data[i][j];

                // Extract RGB values for defectless image
                r = defectless_pixel[23:16];
                g = defectless_pixel[15:8];
                b = defectless_pixel[7:0];

                // Convert to grayscale (more accurate formula)
                gray = (r * 30 + g * 59 + b * 11) / 100;

                // Store the processed data in array
                grayscale_data[i][j] = gray;

                // Extract RGB values for defect image
                r = defect_pixel[23:16];
                g = defect_pixel[15:8];
                b = defect_pixel[7:0];

                // Convert to grayscale (more accurate formula)
                gray = (r * 30 + g * 59 + b * 11) / 100;

                // Comparison: If defect pixel is different from defectless pixel
                // Apply tolerance for small differences
                if (abs(grayscale_data[i][j] - gray) > TOLERANCE) begin
                    // Write the grayscale value of defect pixel in hex format to defect file
                    $fwrite(defect_file, "%h\n", gray);
                end else begin
                    // If no defect (within tolerance), mark it as white (255 or 0xFF) and write to defect file
                    $fwrite(defect_file, "ff\n");
                end

                // Write the grayscale value for all pixels to the grayscale file
                $fwrite(grayscale_file, "%h\n", grayscale_data[i][j]);

                // Invert the grayscale value (255 - gray) for the inverted image
                $fwrite(invert_file, "%h\n", (255 - grayscale_data[i][j]));
            end
        end

        // Close the files after writing
        $fclose(grayscale_file);
        $fclose(defect_file);
        $fclose(invert_file);  // Close invert.txt

        // Display completion message
        $display("Grayscale data, defect locations, and inverted image saved.");
    end

    // Function to calculate absolute difference
    function [7:0] abs;
        input [7:0] value;
        begin
            if (value[7]) begin // If negative
                abs = -value;
            end else begin
                abs = value;
            end
        end
    endfunction

endmodule
