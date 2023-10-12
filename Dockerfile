# Use an official PHP image as the base image
FROM php:7.4-apache as php7.4

# Set environment variables for MySQL
RUN apt-get update
# Install required PHP extensions
# Database	On	On	
# GD	Off	On	
# cURL	On	On	
# OpenSSL	On	On	
# ZLIB	On	On	
# ZIP
RUN apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libzip-dev libcurl4-openssl-dev libssl-dev
RUN docker-php-ext-install mysqli pdo pdo_mysql gd curl zip

RUN apt-get update && \
    apt-get install -y zlib1g-dev libpng-dev libjpeg-dev

RUN docker-php-ext-configure gd --with-jpeg && \
    docker-php-ext-install gd

# Enable Apache modules
RUN a2enmod rewrite


# Set the working directory to /var/www/html
WORKDIR /var/www/html
# add user
RUN usermod -aG www-data www-data

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html


# Download and extract OpenCart



# Expose port 80 for Apache
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]