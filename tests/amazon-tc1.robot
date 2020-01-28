*** Settings ***
Documentation  This is basic info about the amazon test cases
Resource  ../resources/common.robot
Resource  ../resources/amazon.robot
Test Setup  common.Begin Web Test
Test Teardown  common.End Web Test

*** Variables ***
${BROWSER} =


*** Test Cases ***
User opens a web-site
    [Documentation]  This is some basic info about the test
    [Tags]  Smoke  Acceptance  Regression
    amazon.Search for Products
    amazon.Select Prodcut from Search Results
    amazon.Add Product to Cart
    amazon.Begin Checkout