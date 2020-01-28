*** Settings ***
Documentation  demo for common lib
Library  SeleniumLibrary

*** Keywords ***
Begin Web Test
    Open Browser  about:blank  firefox
#    Open Browser  about:blank  create headless chrome

End Web Test
    Close Browser