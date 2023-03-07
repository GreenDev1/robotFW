*** Settings ***
Library  SeleniumLibrary
Library  RPA.Excel.Files
Library  RPA.HTTP

*** Variables ***


*** Test Cases ***
RPA challenge
    Zaciatok
    Vypln formu

*** Keywords ***
Zaciatok
    Open Browser  http://rpachallenge.com/  chrome
    Download  http://rpachallenge.com/assets/downloadFiles/challenge.xlsx  overwrite=True
    Click Button    Start

Vypln formu
    ${people}=    Zober jeden zaznam
    FOR    ${person}    IN    @{people}
        Vypln a odovzdaj formu    ${person}
    END

Zober jeden zaznam
    Open Workbook    challenge.xlsx
    ${table}=    Read Worksheet As Table    header=True
    Close Workbook
    RETURN    ${table}

Vypln a odovzdaj formu
    [Arguments]    ${person}
    Input Text  //input[@ng-reflect-name="labelFirstName"]   ${person}[First Name]
    Input Text  //input[@ng-reflect-name="labelLastName"]  ${person}[Last Name]
    Input Text  //input[@ng-reflect-name="labelCompanyName"]  ${person}[Company Name]
    Input Text  //input[@ng-reflect-name="labelRole"]  ${person}[Role in Company]
    Input Text  //input[@ng-reflect-name="labelAddress"]  ${person}[Address]
    Input Text  //input[@ng-reflect-name="labelEmail"]  ${person}[Email]
    Input Text  //input[@ng-reflect-name="labelPhone"]  ${person}[Phone Number]

    Click Button    Submit
