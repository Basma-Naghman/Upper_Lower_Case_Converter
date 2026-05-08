# UPPER LOWER Case Converter (String Version)
📝 Overview
This assembly program takes a complete string of text from the user (up to 50 characters) and converts its case in real-time. It uses a "Smart Conversion" logic where:

Uppercase letters become lowercase.

Lowercase letters become uppercase.

Numbers and Symbols remain unchanged.

The program is written in x86 Assembly for the NASM assembler, specifically targeting the DOS .COM executable format.

## 🛠️ Technical Logic
### 1. The DOS Input Buffer
To handle a full string, the program uses INT 21h, AH=0Ah. This function requires a structured memory space:

Byte 0: Max buffer size (50).

Byte 1: Actual count of characters typed by the user (filled by DOS).

Byte 2 onwards: The actual string characters.

### 2. The Conversion Loop
The program uses the SI (Source Index) register as a pointer to "walk" through the memory.

Range Checking: It ensures only characters between 'A' and 'z' are modified.

Bitwise Flip: It uses XOR AL, 32. In ASCII, the only difference between 'A' (65) and 'a' (97) is the 5th bit (32 in decimal). Flipping this bit toggles the case instantly.

### 3. Dynamic String Termination
Since DOS Print String (AH=09h) requires a $ to stop, the program manually calculates the end of the user's input and inserts a $ at buffer + 2 + length.

## 🚀 How to Run
Prerequisites
DOSBox (or a 16-bit DOS environment).

NASM Assembler.

Assembly Commands
Open your terminal/DOSBox.

Navigate to your project folder.

Run the following command:

### Bash
nasm -f bin yourfilename.asm -o case.com
Execution
Type the following to run the program:

### Bash
case.com
📊 Example Output
Plaintext
Enter text: Hello COAL 123
Output: hELLO coal 123
## 📂 Code Structure
.data: Defines the prompt, result message, and the 50-byte input buffer.

start: Handles the initial display and captures user input.

convert_loop: Iterates through each character, applies the XOR logic, and saves it back to memory.

print_it: Finalizes the string with a dollar sign and displays the converted result.
