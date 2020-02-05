*** Settings ***
Documentation  Test scalar vaeriable

*** Variables ***
${MY_VAR1}=  This is my first variable
@{my_var2}=  This is item 1  The item 2 i the list  I am item 3
*** Test Cases ***
Test case 1
    log  print my ${MY_VAR1}

Test case 2
    log  @{my_var2}[0]
    log  @{my_var2}[1]
    log  @{my_var2}[2]

Test case 3
    @{my_list_var} =  set variable  item 1  item 2  item 3
    log  @{my_list_var}[0]
    log  @{my_list_var}[1]
    log  @{my_list_var}[2]

Test case 4
    @{my_list_var2} =  create list  create lisVar 1  create lisVar 2  create lisVar 3
    log  @{my_list_var2}[0]
    log  @{my_list_var2}[1]
    log  @{my_list_var2}[2]

Test case 5
    ${MY_G_VAR} =  set variable  Home sweet home
    log  ${MY_G_VAR}

Test case 6
    log  ${MY_G_VAR}

*** Keywords ***
Do Something
    log  I am doing something...

Do Something Else
    log  I am doing something else...

Do Another Thing
    log  I am doing another thing...

