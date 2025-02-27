*** Settings ***
Resource     ../../Data/Secrets/LoadSecrets.resource
Variables    EnvironmentVariables.json


*** Variables ***
&{ADMIN_CREDENTIALS}        username=${SECRET_USERNAME}    password=${SECRET_PASSWORD}
${BOOKING_ENVIRONMENT}      PROD
&{BANNER_COOKIE}            name=banner    value=true    domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
