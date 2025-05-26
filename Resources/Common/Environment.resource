*** Settings ***
Resource        ../../Data/Secrets/LoadSecrets.resource
Variables       EnvironmentVariables.json


*** Variables ***
&{ADMIN_CREDENTIALS}        username=${SECRET_USERNAME}    password=${SECRET_PASSWORD}
${BOOKING_ENVIRONMENT}      TEST
${BOOKING_DOMAIN}           ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
${BOOKING_URL}              ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]
&{BANNER_COOKIE}            name=banner    value=true    domain=${BOOKING_DOMAIN}
