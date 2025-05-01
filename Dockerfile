# Use an official PHP runtime as a parent image
FROM php:8.1-apache

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    libonig-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip ctype
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd


# Enable Apache rewrite module
RUN a2enmod rewrite

# Download Mautic
RUN curl -O https://github.com/mautic/mautic/releases/download/4.4.9/mautic-4.4.9.zip

# Unzip Mautic
RUN unzip mautic-4.4.9.zip -d /var/www/html

# Set directory permissions
RUN chown -R www-data:www-data /var/www/html/var
RUN chmod -R 755 /var/www/html/var

# Expose port 80
EXPOSE 80

# Set the default command to start Apache
CMD ["apache2-foreground"]
