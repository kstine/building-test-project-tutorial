*** Comments ***
Name may not be blank
Email may not be blank
Phone may not be blank
Phone must be between 11 and 21 characters.
Subject must be between 5 and 100 characters.
Subject may not be blank
Message must be between 20 and 2000 characters.
Message may not be blank


*** Settings ***
Documentation       Restful Booker Web Tests


*** Variables ***
${DOMAIN}                               automationintesting.online
${RESTFUL_BOOKER_URL}                   https://${DOMAIN}
${RESTFUL_BOOKER_URL_ADMIN}             ${RESTFUL_BOOKER_URL}/#/admin
${RESTFUL_BOOKER_URL_REPORT}            ${RESTFUL_BOOKER_URL_ADMIN}/report
${RESTFUL_BOOKER_URL_BRANDING}          ${RESTFUL_BOOKER_URL_ADMIN}/branding
${RESTFUL_BOOKER_URL_MESSAGES}          ${RESTFUL_BOOKER_URL_ADMIN}/messages
${ADMIN_USERNAME}                       admin
${ADMIN_PASSWORD}                       password
&{BANNER_COOKIE}                        name=banner    value=true
${BOOK_ROOM_BUTTON}                     css:button.openBooking
${BOOK_ROOM_BUTTON_TEXT}                Book this room
${NAME_ICON}                            css:span.input-group-text > span.fa-id-card
${NAME_INPUT}                           css:input[id="name"]
${NAME_PLACEHOLDER}                     Name
${EMAIL_ICON}                           css:div:nth-child(2) > div > span.input-group-text > span.fa-envelope
${EMAIL_INPUT}                          css:input[id="email"]
${EMAIL_PLACEHOLDER}                    Email
${PHONE_ICON}                           css:span.input-group-text > span.fa-phone
${PHONE_INPUT}                          css:input[id="phone"]
${PHONE_PLACEHOLDER}                    Phone
${SUBJECT_ICON}                         css:div:nth-child(4) > div span.input-group-text > span.fa-envelope
${SUBJECT_INPUT}                        css:input[id="subject"]
${SUBJECT_PLACEHOLDER}                  Subject
${MESSAGE_TEXTAREA}                     css:textarea[id="description"]
${MESSAGE_TEXT}                         xpath://span[contains(@class, "input-group-text")][text()="Message"]
${SUBMIT_BUTTON}                        css:button[id="submitContact"]
${SUBMIT_BUTTON_TEXT}                   Submit
${ALERT_BOX}                            css:div.alert-danger
${NAME_BLANK_ALERT}                     Name may not be blank
${EMAIL_BLANK_ALERT}                    Email may not be blank
${EMAIL_FORM_ALERT}                     must be a well-formed email address
${PHONE_BLANK_ALERT}                    Phone may not be blank
${PHONE_LENGTH_ALERT}                   Phone must be between 11 and 21 characters.
${SUBJECT_BLANK_ALERT}                  Subject may not be blank
${SUBJECT_LENGTH_ALERT}                 Subject must be between 5 and 100 characters.
${MESSAGE_BLANK_ALERT}                  Message may not be blank
${MESSAGE_LENGTH_ALERT}                 Message must be between 20 and 2000 characters.
${THANKS_HEADER}                        css:div.contact > div > div > h2
${BACK_TO_YOU_START}                    css:div.row.contact > div:nth-child(2) > div > p:nth-child(2)
${BACK_TO_YOU_SUBJECT}                  css:div.row.contact > div:nth-child(2) > div > p:nth-child(3)
${BACK_TO_YOU_END}                      css:div.row.contact > div:nth-child(2) > div > p:nth-child(4)
${BACK_TO_YOU_START_TEXT}               We'll get back to you about
${BACK_TO_YOU_END_TEXT}                 as soon as possible.
${CONTACT_CSS}                          css:div.contact > div
${CONTACT_HOME}                         ${CONTACT_CSS} > p > span.fa-home
${CONTACT_ADDRESS}                      ${CONTACT_CSS} > p:nth-child(2) > span
${CONTACT_PHONE}                        ${CONTACT_CSS} > p > span.fa-phone
${CONTACT_EMAIL}                        ${CONTACT_CSS} > p > span.fa-envelope
${CONTACT_HOME_TEXT}                    Shady Meadows B&B
${CONTACT_ADDRESS_TEXT}                 The Old Farmhouse, Shady Street, Newfordburyshire, NE1 410S
${CONTACT_PHONE_TEXT}                   012345678901
${CONTACT_EMAIL_TEXT}                   fake@fakeemail.com
${CONTACT_XPATH}                        xpath://div[contains(@class, "contact")]/div
${CONTACT_HOME_XPATH}                   ${CONTACT_XPATH}/p[contains(text(), "${CONTACT_HOME_TEXT}")]
${CONTACT_ADDRESS_XPATH}                ${CONTACT_XPATH}/p[contains(text(), "${CONTACT_ADDRESS_TEXT}")]
${CONTACT_PHONE_XPATH}                  ${CONTACT_XPATH}/p[contains(text(), "${CONTACT_PHONE_TEXT}")]
${CONTACT_EMAIL_XPATH}                  ${CONTACT_XPATH}/p[contains(text(), "${CONTACT_EMAIL_TEXT}")]
${LOGIN_HEADER}                         css:h2[data-testid="login-header"]
${LOGIN_HEADER_TEXT}                    Log into your account
${LOGIN_USERNAME_INPUT}                 id:username
${LOGIN_USERNAME_PLACEHOLDER}           Username
${LOGIN_PASSWORD_INPUT}                 id:password
${LOGIN_PASSWORD_PLACEHOLDER}           Password
${LOGIN_BUTTON}                         id:doLogin
${LOGIN_BUTTON_TEXT}                    Login
${LOGIN_STYLE}                          [style="border: 1px solid grey"]
${LOGIN_STYLE_WARNING}                  [style="border: 1px solid red"]
${ADMIN_NAVBAR_ROOMS_LINK}              xpath://li/a[contains(@href, "admin")][text()="Rooms"]
${ADMIN_NAVBAR_REPORT_LINK}             id:reportLink
${ADMIN_NAVBAR_BRANDING_LINK}           id:brandingLink
${ADMIN_NAVBAR_BRAND_LINK}              a.navbar-brand
${ADMIN_NAVBAR_BRAND_TEXT}              B&B Booking Management
${ADMIN_NAVBAR_NOTIFICATIONS_LINK}      css:a.nav-link[href="#/admin/messages"]
${ADMIN_NAVBAR_FRONT_PAGE_LINK}         id=frontPageLink
${ADMIN_NAVBAR_FRONT_PAGE_TEXT}         Front Page
${ADMIN_NAVBAR_LOGOUT_LINK}             css:a.nav-link[href="#/admin"]
${ADMIN_NAVBAR_LOGOUT_TEXT}             Logout


*** Keywords ***
Thanks Message
    [Arguments]    ${name}
    ${thanks_message}    Catenate    SEPARATOR=${EMPTY}
    ...    Thanks for getting in touch
    ...    ${name}
    ...    !
    RETURN    ${thanks_message}
