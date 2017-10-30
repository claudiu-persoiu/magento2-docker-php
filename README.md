# Magento 2 PHP FPM

Magento2 docker container

## Environment variables:
`WWW_DATA_UID 1000`
`WWW_DATA_GID 1000`

`PHP_MEMORY_LIMIT 2G`
`APP_MAGE_MODE developer`
`PHP_PORT 9000`
`PHP_PM dynamic`
`PHP_PM_MAX_CHILDREN 10`
`PHP_PM_START_SERVERS 4`
`PHP_PM_MIN_SPARE_SERVERS 2`
`PHP_PM_MAX_SPARE_SERVERS 6`

For xdebug there are the following config settings:
`XDEBUG_CONFIG`
`PHP_IDE_CONFIG`
