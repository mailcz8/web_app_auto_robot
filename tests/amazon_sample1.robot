*** Settings ***
Documentation  This is basic info about the Byton test cases
Library  SeleniumLibrary
Test Teardown   Run Keyword If Test Failed   Close Browser

*** Variables ***
${TextCheck}  Ferrari 458
${TestURL_Google}     https://www.google.com/
${TestURL_Yahoo}      https://www.yahoo.com/
${TestURL_herokuapp}     http://the-internet.herokuapp.com/
${SampleItem}         a-m-us a-aui_157141-c a-aui_158613-t1 a-aui_72554-c a-aui_dropdown_187959-c a-aui_pci_risk_banner_210084-c a-aui_perf_130093-c a-aui_tnr_v2_180836-c a-aui_ux_145937-c a-meter-animate

*** Test Cases ***
User opens a web-site
    [Documentation]  This is some basic info about the test
    [Tags]  Smoke  Acceptance  Regression   P0
#    Open Browser  ${TestURL_Google}  firefox
    Open browser  ${TestURL_Google}  chrome
    Go To   ${TestURL_Yahoo}
    Go Back
    Sleep  1
    Go To  http://www.amazon.com
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




