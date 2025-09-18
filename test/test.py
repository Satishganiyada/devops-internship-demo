from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
import time

APP_URL = "http://localhost:8082"  # Replace with EC2 public IP if testing remotely

# Use Service to point to chromedriver (if it's in current directory or PATH)
service = Service("/usr/bin/chromedriver")   # or "./chromedriver" if local

options = webdriver.ChromeOptions()
options.add_argument("--headless")   # Run without opening browser (useful on servers)
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")

driver = webdriver.Chrome(service=service, options=options)

try:
    driver.get(APP_URL)
    time.sleep(2)

    body_text = driver.find_element(By.TAG_NAME, "body").text
    print("Page Text:", body_text)

    # assert "Hello from AWS DevOps Demo with Jenkins + Prometheus!" in body_text
    assert "Azure testing" in body_text

    print("✅ Test Passed: Application response is correct.")

except AssertionError:
    print("❌ Test Failed: Unexpected application response.")

finally:
    driver.quit()
