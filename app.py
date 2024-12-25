import os
import random
from PIL import Image
# If you have a specific Inky Impression library, adjust import accordingly:
from inky.auto import auto
import time

def main():
    # Initialize Inky Impression (auto-detects the correct display type).
    inky_display = auto()
    
    # Define the path to your photo folder.
    photos_dir = "photos"
    
    # Get a random image from the folder.
    images = os.listdir(photos_dir)
    if not images:
        print("No images found in 'photos' directory.")
        return
    
    chosen_photo = random.choice(images)
    chosen_path = os.path.join(photos_dir, chosen_photo)
    
    # Open the image with Pillow and display it.
    try:
        img = Image.open(chosen_path)
        # Optionally resize or convert the image to match display specs.
        # For a 400x300 Inky Impression, for example:
        img = img.resize((800, 480))
        # img = img.convert("P")  # If needed, depending on color/format.
        
        inky_display.set_image(img)
        inky_display.show()
        print(f"Displayed: {chosen_photo}")
    except Exception as e:
        print(f"Error displaying {chosen_photo}: {str(e)}")

def run_looped():
    eight_hours = 8 * 60 * 60  # 8 hours in seconds

    while True:
        start_time = time.time()
        main()
        run_duration = time.time() - start_time

        # Subtract the run time of main() from the 8-hour interval
        sleep_time = eight_hours - run_duration
        if sleep_time < 0:
            sleep_time = 0  # If main() took longer than 8 hours, skip sleeping

        time.sleep(sleep_time)

if __name__ == "__main__":
    run_looped()
