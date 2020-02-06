*** Settings ***
Library  RequestsLibrary
Library  SeleniumLibrary


*** Variables ***
${github_api_url} =  https://api.github.com


*** Keywords ***
Check Github Username
    # Create the session
    create session  my_github_session  ${github_api_url}

    # Make the call
    ${response} =  get request  my_github_session  users/robotframework

    # check the response status
    should be equal as strings  ${response.status_code}  200

    # Check the response body
    ${json} =  set variable  ${response.json()}
    should be equal as strings  ${json['login']}  robotframework
    log  ${json}

Display emoji from Github
    [Tags]  API
    # Create the session
    create session  my_github_session  ${github_api_url}
    log to console  my_github_session

    # Make the call
    ${response} =  get request  my_github_session  emojis

    # check the response status
    should be equal as strings  ${response.status_code}  200

    # Check the response body
    ${json} =  set variable  ${response.json()}
    ${emoji_url} =  set variable  ${json.['aerial_tramway']}
    log to console  ${emoji_url}
    open browser  ${emoji_url}  firefox

Display emoji from Github 2
    [Tags]  API
    # Create the session
    create session  my_github_session  ${github_api_url}
    log to console  my_github_session

    # Make the call
    ${response} =  get request  my_github_session  emojis

    # check the response status
    should be equal as strings  ${response.status_code}  200

    # Check the response body
    ${json} =  set variable  ${response.json()}
    ${emoji_url} =  set variable  ${json.['aerial_tramway']}
    log  ${emoji_url}
    open browser  ${emoji_url}  firefox