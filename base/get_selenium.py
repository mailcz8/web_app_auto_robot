import time
from selenium import webdriver
import selenium.webdriver.chrome.service as service
import os
import sys

dir_path = os.path.dirname(os.path.realpath(__file__))
print('dir_path is at = {}'.format(dir_path))
sys_path = os.path.dirname(dir_path)
print("1 =",sys_path)
driver_path = os.path.join(sys_path,"drivers")
print('new driver path = {}'.format(driver_path))

print("Sys path is; {}".format(sys_path))
ota_config_path = os.path.join(dir_path,"ota_config.txt")
print("Ota config path is: {}".format(ota_config_path))

# driver_path = '/path/to/chromedriver'
service = service.Service(driver_path)
# service.start()
capabilities = {'chrome.binary': '/path/to/custom/chrome'}
driver = webdriver.Remote(service.service_url, capabilities)
driver.get('http://www.google.com/xhtml');
time.sleep(5) # Let the user actually see something!
driver.quit()
driver = webdriver.Chrome('/path/to/chromedriver')  # Optional argument, if not specified will search path.
driver.get('http://www.google.com/xhtml');
time.sleep(5) # Let the user actually see something!
search_box = driver.find_element_by_name('q')
search_box.send_keys('ChromeDriver')
search_box.submit()
time.sleep(5) # Let the user actually see something!
driver.quit()