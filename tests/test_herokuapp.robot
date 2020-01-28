*** Settings ***
Documentation  This is basic info about the Byton test cases
Library  SeleniumLibrary
Test Teardown   Run Keyword If Test Failed   Close Browser

*** Variables ***
${TextCheck}    Ferrari 458
${TestURL_herokuapp}     http://the-internet.herokuapp.com/
${TestURL_Yahoo}      https://www.yahoo.com/
${TestURL_XYZ}        https://www.xyz.com/
${SampleItem}         id=xyz

*** Test Cases ***
User opens a web-site
    [Documentation]  This is some basic info about the test
    [Tags]  Smoke  Acceptance  Regression   P0
#    Open Browser  ${TestURL_herokuapp}  firefox
    Open browser  ${TestURL_herokuapp}  chrome
    Sleep  1
#    wait until page contains  Your Amazon.com
    Input Text  id=twotabsearchtextbox  ${TextCheck}
    click button  class=nav-input
    wait until page contains  results for "${TextCheck}"
    click link  css=#result_C a.s-access-detail-page
    wait until page contains  Back to search results
    click button  id=add-to-cart-button
    wait until page contains  1 item added to Cart
    click link  Proceed to Checkout
    page should contain element  ap_signila_pagelet_title
    element text should be  ap_signila_pagelet_title  Sign In

*** Keywords ***




