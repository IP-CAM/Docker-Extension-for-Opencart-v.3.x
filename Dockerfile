# Use an official PHP image as the base image
FROM php:7.4-apache as php7.4

# Set environment variables for MySQL
RUN apt-get update
# Install required PHP extensions


# Enable Apache modules
RUN a2enmod rewrite

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Download and extract OpenCart
ADD https://github.com/opencart/opencart/archive/3.0.3.8.zip /var/www/html/

RUN apt-get update && \
    apt-get install -y unzip && \
    unzip 3.0.3.8.zip && \
    rm 3.0.3.8.zip && \
    mv opencart-3.0.3.8/upload/* . && \
    rm -rf opencart-3.0.3.8

# change config-dist.php to config and set permissions for config files
RUN mv config-dist.php config.php && \
    mv admin/config-dist.php admin/config.php && \
    chmod 755 config.php && \
    chmod 755 admin/config.php


# Expose port 80 for Apache
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]