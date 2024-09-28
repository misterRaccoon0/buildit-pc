#### To run after cloning this project you must follow these steps, make sure to `cd buildit-pc-backend` before proceeding:
```
    composer install
    copy .env.example .env
    php artisan key:generate
    php artisan migrate
    php artisan db:seed
```

#### After the setup is done you can now serve the content:
```
    php artisan serve
```
