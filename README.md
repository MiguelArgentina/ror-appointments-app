# README

This is an appointments booking system with payment integration just to practice my skills.
Payments are made with [MercadoPago](https://www.mercadopago.com.ar/developers/es) (already 
functional with a test key) and with [Stripe](https://stripe.com/docs/payments/checkout)

* Live demo: 
  * [https://tucu-appointments-booking.herokuapp.com/](https://tucu-appointments-booking.herokuapp.com/)
* Ruby version: 3.0.3
* Rails version: 7.0.3.1
* Database: postgresql@12 or higher

* Database creation
  * Run:
    ```
    rails db:create
    rails db:migrate
    rails db:seed
    ```

* Running the app
    * Run:
        ```
        rails s
        ```
    * Open your browser and go to `localhost:3000`
