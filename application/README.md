# Python Application Steps For DevPlusOps Team

## Overview

This application is using Flask framework for exposing endpoints. This application recieves POST request with the visitor's name and updates that to the RDS instance previously created with the help of Terraform. It also retrieves the visitors names with the timestamp when they visited.

## Prerequisites

You need the tools and packages required to be installed to run the application.

- You have installed Python and its required packages mentioned in the requirements.txt

## Installation

1. **Install Packages:**

   ```sh
   pip install --no-cache-dir -r requirements.txt
   ```

## Usage

1. **Update the .env file**

   - Add the RDS credentials in the .env file in the application directory.
   - Update the Remote Machine IP in .env file.

2. **Run the Application:**

   - Run the application by running this command in terminal.

   ```sh
   python main.py
   ```

3. **Run the Test with Pytest:**

   - Run the command in the terminal. Pytest will automatically pickup the testcase starting with test\_\*.py
     ```sh
     pytest
     ```
