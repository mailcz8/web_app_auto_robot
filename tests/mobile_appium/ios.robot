*** Settings ***
Documentation  This is basic info about the Byton test cases
Library     AppiumLibrary

*** Variables ***


*** Test Cases ***
Open Application On Android
      Open Application     http://localhost:4725     udid=< deviceid > platformName=Android
      ...  deviceName=AndroidDevice     app=com.google.android.calendar
      ...  appActivity= com.android.providers.calendar
     [Teardown]     Close Application

Test case 2
    Do Another Thing
    Do Something Else

*** Keywords ***
Do Something
    log  I am doing something...

Do Something Else
    log  I am doing something else...

Do Another Thing
    log  I am doing another thing...

