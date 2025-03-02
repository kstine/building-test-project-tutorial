*** Variables ***
&{PRODUCTION_URL_DATA}
...                         DOMAIN=automationintesting.online
...                         URL=https://automationintesting.online
&{TEST_URL_DATA}
...                         DOMAIN=tomtebook-pro.local
...                         URL=http://tomtebook-pro.local:8080
&{BOOKING_URL_DATA}         PROD=${PRODUCTION_URL_DATA}    TEST=${TEST_URL_DATA}
${BOOKING_ENVIRONMENT}      TEST
&{BANNER_COOKIE}            name=banner    value=true    domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
&{ADMIN_CREDENTIALS}        username=admin    password=password
