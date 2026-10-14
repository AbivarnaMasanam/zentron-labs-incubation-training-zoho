# Elixir CLI Image Processor

A command-line image processing application built using **Elixir** and **Vix/libvips**. The application allows users to process a single image, multiple images, or all supported images inside a folder.

## Features

- Process a single image
- Process multiple images
- Process images from a folder
- Detect and validate image files
- Rotate images
- Invert images
- Compress images
- Convert images between supported formats
- Validate user input
- Handle invalid files and folders
- Handle processing and file-writing errors
- Continue processing multiple images
- Exit the application safely

---

## Technologies Used

- **Elixir**
- **Mix**
- **Vix**
- **libvips**
- **Git**
- **GitHub**

### Vix

[Vix](https://hex.pm/packages/vix) is an Elixir library that provides bindings to the **libvips** image-processing library.

The project uses Vix for reading, manipulating, and writing images.

---

## Project Architecture

The application is divided into multiple modules based on responsibility.

```text
                    Image CLI
                       |
          +------------+-------------+
          |            |             |
          v            v             v
      UserInput    FileHandler   ImageProcessor
          |            |             |
          |            |       +-----+-----+
          |            |       |     |     |
          |            |       v     v     v
          |            |    Rotate Invert Compress
          |            |                   |
          |            |                   v
          |            |                Convert
          |            |                   |
          +------------+-------------------+
                       |
                       v
                    Vix
                       |
                       v
                    libvips
```

---

## Project Structure

```text
image_cli/
│
├── lib/
│   ├── image_cli.ex
│   ├── image_processor.ex
│   ├── file_handler.ex
│   └── user_input.ex
│
├── test/
│
├── mix.exs
├── mix.lock
├── README.md
└── .formatter.exs
```

### Module Responsibilities

#### `ImageCli`

Handles:

- Application startup
- Welcome message
- User interaction
- Main menu
- Operation selection
- Continue/exit flow

#### `UserInput`

Handles:

- Reading input from the user
- Input validation
- Integer parsing
- Validating numeric ranges

#### `FileHandler`

Handles:

- File validation
- Folder validation
- Detecting files and folders
- Finding images inside folders
- Filtering supported image files
- Handling multiple image paths

#### `ImageProcessor`

Handles:

- Image loading
- Image rotation
- Image inversion
- Image compression
- Image conversion
- Writing processed images

---

# Requirements

Before running the project, install the following:

- Elixir
- Erlang/OTP
- libvips
- Git

Check Elixir:

```bash
elixir --version
```

Check Mix:

```bash
mix --version
```

Check libvips:

```bash
vips --version
```

---

# Installation

## 1. Clone the Repository

```bash
git clone <https://github.com/AbivarnaMasanam/zentron-labs-incubation-training-zoho/>
```

Move into the project directory:

```bash
cd image_cli
```

## 2. Install Dependencies

```bash
mix deps.get
```

## 3. Compile the Project

```bash
mix compile
```

---

# Verify Vix Installation

The project uses Vix to communicate with libvips.

Run:

```bash
mix run -e "IO.puts(Vix.Vips.version())"
```

Example output:

```text
8.18.7
```

The exact version may differ depending on the installed libvips version.

---

# Running the Application

Run the application using:

```bash
mix run
```

The CLI will display the welcome message and ask for an image, multiple images, or a folder path.

Example:

```text
+-------------------------------------------------------------------+
|                                                                   |
|               ------ Image Manipulation CLI ------                |
|                              WELCOME!                             |
|                                                                   |
+-------------------------------------------------------------------+

Enter the "Image/File or Folder Path" (OR) Enter "0" to Exit:
```

---

# Input Types

The application supports three main input types.

## 1. Single Image

Example:

```text
/home/user/images/photo.jpg
```

The application validates the path and processes the image.

## 2. Folder

A folder path can be provided.

Example:

```text
/home/user/images
```

The application:

```text
Folder
   ↓
List files
   ↓
Check file extensions
   ↓
Find supported images
   ↓
Create image list
   ↓
Process images
```

For example:

```text
images/
├── photo1.jpg
├── photo2.png
├── photo3.jpeg
└── notes.txt
```

The application processes:

```text
photo1.jpg
photo2.png
photo3.jpeg
```

and ignores:

```text
notes.txt
```

---

# Image Operations

## 1. Rotate

Select:

```text
1. Rotate
```

The application asks for the rotation degree.

Example:

```text
Enter rotation degree:
90
```

The image is rotated and saved as a new file.

Example:

```text
photo.jpg
    ↓
photo_rotated.jpg
```

---

## 2. Invert

Select:

```text
2. Invert
```

The image colors are inverted using Vix/libvips.

Example:

```text
photo.jpg
    ↓
photo_inverted.jpg
```

---

## 3. Compress

Select:

```text
3. Compress
```

The application asks for compression quality.

Example:

```text
Enter the Compress Quality (0 to 100) or Enter 0 to Skip:
```

### Quality values

```text
0       → Skip compression
1-100   → Compress image
Other   → Invalid input
```

The application uses safe input parsing to prevent crashes caused by invalid user input.

Example:

```text
photo.jpg
    ↓
photo_compressed.jpg
```

---

## 4. Exit

Select:

```text
4. Exit
```

The application terminates safely.

Example:

```text
+-------------------------------------------------------------------+
|                                                                   |
|                      Exited Successfully...!                      |
|                      ********Thankyou********                     |
|                                                                   |
+-------------------------------------------------------------------+
```

---

# Application Flow

```text
Start
  |
  v
Welcome Message
  |
  v
Get File / Folder Input
  |
  v
Validate Input
  |
  +-------------------+
  |                   |
 File               Folder
  |                   |
  |               Find Images
  |                   |
  +---------+---------+
            |
            v
       Image List
            |
            v
     Select Operation
            |
    +-------+-------------+
    |       |             |       
  Rotate  Invert Compress&Convert
    |       |             |       
    +-------+-------------+
            |
            v
       Process Image
            |
            v
       Save Output
            |
            v
    Display Result
            |
            v
     Continue / Exit
```

---

# Input Validation

The application validates user input before processing.

Examples of validation include:

- File existence
- Folder existence
- Supported image extension
- Rotation value
- Compression quality
- Conversion format
- Numeric input

Instead of directly using:

```elixir
String.to_integer(input)
```

the application uses safe parsing:

```elixir
Integer.parse(input)
```

This prevents the application from crashing when the user enters invalid numeric input.

---

# Error Handling

The application handles common errors such as:

### Invalid Path

```text
File or folder does not exist.
```

### Unsupported File

```text
Unsupported image format.
```

### Invalid User Input

```text
Invalid input. Please try again.
```

### Invalid Rotation

```text
Invalid rotation degree.
```

### Invalid Compression Quality

```text
Quality must be between 0 and 100.
```

### Image Processing Error

```text
Unable to process image.
```

### File Writing Error

```text
Unable to write processed image.
```

The goal is to handle errors gracefully instead of terminating the application unexpectedly.

---

# Output Files

Processed images are saved as new files so that the original image remains unchanged.

Examples:

```text
Original:
photo.jpg

After rotation:
photo_rotated.jpg

After inversion:
photo_inverted.jpg

After compression:
photo_compressed.jpg
```

# Test Cases

The following scenarios should be tested before finalizing the project.

## File Handling

- [ ] Valid single image
- [ ] Invalid file path
- [ ] Valid folder
- [ ] Empty folder
- [ ] Folder containing images and non-image files
- [ ] Multiple images
- [ ] Unsupported file
- [ ] Non-existing path

## Rotation

- [ ] Valid rotation
- [ ] Invalid rotation
- [ ] Single image
- [ ] Multiple images
- [ ] Folder

## Compression

- [ ] Quality 1
- [ ] Quality 50
- [ ] Quality 100
- [ ] Quality 0
- [ ] Quality above 100
- [ ] Negative value
- [ ] Non-numeric value

## Exit

- [ ] Exit from main menu
- [ ] Exit after processing
- [ ] Continue processing after an operation

---

# Development Process

The project was developed in the following stages:

### Phase 1 — Requirement Analysis

Understand the requirement to build a CLI application capable of manipulating images.

### Phase 2 — Elixir Learning

Learn the required Elixir concepts:

- Pattern matching
- Functions
- Lists
- Tuples
- Maps
- Guards
- `case`
- `cond`
- File handling
- Error handling

### Phase 3 — Project Setup

Create the Mix project and configure dependencies.

### Phase 4 — Vix Integration

Install and configure Vix/libvips for image manipulation.

### Phase 5 — File Handling

Implement:

- Single file detection
- Folder detection
- Multiple file handling
- Image filtering

### Phase 6 — CLI Development

Implement:

- Welcome screen
- User input
- Main menu
- Operation selection

### Phase 7 — Image Operations

Implement:

- Rotation
- Inversion
- Compression & Conversion

### Phase 8 — Batch Processing

Extend the application to process:

- Multiple images
- Folder images

### Phase 9 — Error Handling

Handle:

- Invalid input
- Invalid paths
- Unsupported files
- Image processing errors
- Output errors

### Phase 10 — Refactoring and Testing

Clean the code, remove duplicate logic, test edge cases, format the project, and prepare documentation.

---

# Future Improvements

Possible improvements include:

- Add recursive folder processing
- Add progress indicators
- Add parallel image processing
- Add custom output directory
- Add custom output filename
- Add image resizing
- Add image cropping
- Add brightness adjustment
- Add contrast adjustment
- Add metadata removal
- Add command-line arguments
- Add automated test coverage
- Add configuration options

---

# Learning Outcomes

Through this project, the following concepts were practiced:

### Elixir

- Functional programming
- Pattern matching
- Recursion
- Guards
- Lists
- Tuples
- Modules
- Mix projects
- Error handling
- File handling

### Software Development

- Requirement analysis
- Modular design
- Input validation
- Error handling
- Refactoring
- Testing
- Git version control
- Documentation

### Image Processing

- Reading image files
- Writing image files
- Image transformation
- Image compression
- Image format conversion
- Batch image processing

---

# Conclusion

The **Elixir CLI Image Processor** demonstrates how Elixir can be used to build a practical command-line application for image manipulation.

The application combines **Elixir**, **Vix**, and **libvips** to provide image processing capabilities while maintaining modular code, input validation, error handling, and support for batch processing.

The project also provides practical experience with functional programming, file handling, third-party libraries, CLI application design, and software development practices.
