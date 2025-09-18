from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
import time
import sys

APP_URL = "http://localhost:8082"  # Replace with EC2 public IP if remote

service = Service("/usr/bin/chromedriver")  # adjust path if needed
options = webdriver.ChromeOptions()
options.add_argument("--headless")   # run without UI (good for servers/CI)
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")

driver = webdriver.Chrome(service=service, options=options)

try:
    driver.get(APP_URL)
    time.sleep(2)

    body_text = driver.find_element(By.TAG_NAME, "body").text
    print("Page Text:", body_text)

    # assert "Hello from AWS DevOps Demo with Jenkins + Prometheus!" in body_text
    assert "Hello from Azure" in body_text
    print("✅ Test Passed: Application response is correct.")
    sys.exit(0)

except AssertionError:
    print("❌ Test Failed: Unexpected application response.")
    sys.exit(1)

except Exception as e:
    print(f"❌ Test Error: {e}")
    sys.exit(1)

finally:
    driver.quit()
