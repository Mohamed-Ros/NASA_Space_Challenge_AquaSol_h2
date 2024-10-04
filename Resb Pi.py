import RPi.GPIO as GPIO
import time
from w1thermsensor import W1ThermSensor
import pygame

pygame.init()
screen = pygame.display.set_mode((800, 480))  
pygame.display.set_caption("Hydrogen System Monitor")


WHITE = (255, 255, 255)
GREEN = (0, 255, 0)
RED = (255, 0, 0)
YELLOW = (255, 255, 0)


ELECTROLYZER_PIN = 6 # amount of  hour will run the ELECTROLYZER system
WATER_LEVEL_PIN = 17  # water level When you get there you have to fill the tank.
PRESSURE_SENSOR_PIN = 27 # Number of perssure we need to allow hydrogen


GREEN_LED_PIN = 22
RED_LED_PIN = 23
YELLOW_LED_PIN = 24


GPIO.setmode(GPIO.BCM)
GPIO.setup(ELECTROLYZER_PIN, GPIO.OUT)
GPIO.setup(WATER_LEVEL_PIN, GPIO.IN)
GPIO.setup(GREEN_LED_PIN, GPIO.OUT)
GPIO.setup(RED_LED_PIN, GPIO.OUT)
GPIO.setup(YELLOW_LED_PIN, GPIO.OUT)


temperature_sensor = W1ThermSensor()


def read_pressure():
    return GPIO.input(PRESSURE_SENSOR_PIN)


def check_water_level():
    return GPIO.input(WATER_LEVEL_PIN)


try:
    while True:
       
        temperature = temperature_sensor.get_temperature()
        water_level = check_water_level()
        pressure = read_pressure()

       
        screen.fill(WHITE)

     
        temp_text = f"Temperature: {temperature:.1f} °C" # The Temperature of system 
        water_text = "Water Level: " + ("Sufficient" if water_level == GPIO.HIGH else "Low") # Water Level of tank
        pressure_text = f"Pressure: {'High' if pressure else 'Low'}" # number of perssure will producess
        
 
        font = pygame.font.Font(None, 48)
        text_surface = font.render(temp_text, True, (0, 0, 0))
        screen.blit(text_surface, (50, 50))
        
        water_surface = font.render(water_text, True, (0, 0, 0))
        screen.blit(water_surface, (50, 100))
        
        pressure_surface = font.render(pressure_text, True, (0, 0, 0))
        screen.blit(pressure_surface, (50, 150))

        if water_level == GPIO.HIGH:
            GPIO.output(ELECTROLYZER_PIN, GPIO.HIGH)
            GPIO.output(GREEN_LED_PIN, GPIO.HIGH)
            GPIO.output(RED_LED_PIN, GPIO.LOW)
            status_text = "Electrolyzer: ON"
        else:
            GPIO.output(ELECTROLYZER_PIN, GPIO.LOW)
            GPIO.output(GREEN_LED_PIN, GPIO.LOW)
            GPIO.output(RED_LED_PIN, GPIO.HIGH)
            status_text = "Electrolyzer: OFF"

        status_surface = font.render(status_text, True, (0, 0, 0))
        screen.blit(status_surface, (50, 200))

        if temperature > 70:
            GPIO.output(YELLOW_LED_PIN, GPIO.HIGH)
            warning_text = "Warning: High Temperature!"
            warning_surface = font.render(warning_text, True, YELLOW)
            screen.blit(warning_surface, (50, 250))
        else:
            GPIO.output(YELLOW_LED_PIN, GPIO.LOW)

        pygame.display.flip()

        time.sleep(2)

except KeyboardInterrupt:
    print("Stopping system...")
finally:
    GPIO.cleanup()
    pygame.quit()