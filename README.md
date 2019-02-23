# php + apache for drupal in production environment

## Images include :

* php Uploadprogress
* PhpRedis
* Composer
* Drush
* hirak/prestissimo

## Supported tags and respective Dockerfile links

* php-7.0 [(php-7.0/Dockerfile)](https://github.com/wallon-ines/drupal-php-apache/blob/master/php-7.0/Dockerfile)
* php-7.1 [(php-7.1/Dockerfile)](https://github.com/wallon-ines/drupal-php-apache/blob/master/php-7.1/Dockerfile)
* php-7.2 [(php-7.2/Dockerfile)](https://github.com/wallon-ines/drupal-php-apache/blob/master/php-7.2/Dockerfile)
* php-7.3 [(php-7.3/Dockerfile)](https://github.com/wallon-ines/drupal-php-apache/blob/master/php-7.3/Dockerfile)

## Specific SSMTP configuration for send mail

|   Environment variables   | Descrription|
| :-------------: |-------------|
|SSMTP_POSTMASTER|The person who gets all mail for userids _eg: mail@mydomain.com_|
|SSMTP_MAILHUB|The place where the mail goes. The actual machine name is required no MX records are consulted. Commonly mailhosts are named mail.domain.com|
|SSMTP_HOSTNAME|The full hostname _eg: mywebsrv.mydomain.com_|
