# Wallet API

## Overview

**Wallet API** is a Ruby on Rails application designed to manage wallet transactions for different entities such as Users, Teams, Stocks, etc. The API provides endpoints for user authentication, wallet creation, deposits, withdrawals, and transfers between wallets. The project is built with Ruby version 3.3.3, Rails version 7.2.0, and PostgreSQL as the database.

## Features

- **User Authentication**: Custom sign-in functionality without external gems.
- **Wallet Management**: Create and manage wallets for different entities.
- **Transaction Handling**: Secure deposit, withdrawal, and transfer operations.
- **ACID Compliance**: Transactions are handled with database transaction blocks to ensure ACID compliance.

## Installation

To run the project locally, follow these steps:

1. **Install Bundler**:

   ```bash
   gem install bundler
   ```

2. **Install Dependencies**:

   ```bash
   bundle install
   ```

3. **Run the Rails Server**:
   ```bash
   rails s
   ```

## API Endpoints

The API provides the following key endpoints, which can be accessed via Postman:

### User Authentication

- **Create User**:  
  _Method_: `POST`  
  _Endpoint_: `/users`  
  _Description_: Create a new user with a username and password.  
  _Sample Request Body_:

  ```json
  {
    "user": {
      "username": "alpenho1",
      "password": "testingpass"
    }
  }
  ```

- **Login**:  
  _Method_: `POST`  
  _Endpoint_: `/login`  
  _Description_: Login with an existing username and password.  
  _Sample Request Body_:

  ```json
  {
    "username": "alpenho1",
    "password": "testingpass"
  }
  ```

- **Logout**:  
  _Method_: `DELETE`  
  _Endpoint_: `/logout`  
  _Description_: Logout the current user.

### Wallet Management

- **Create User Wallet**:  
  _Method_: `POST`  
  _Endpoint_: `/wallets`  
  _Description_: Create a wallet for a user.  
  _Sample Request Body_:

  ```json
  {
    "wallet": {
      "name": "Testing wallet create for other user"
    }
  }
  ```

- **Get All User Wallets**:  
  _Method_: `GET`  
  _Endpoint_: `/wallets`  
  _Description_: Retrieve all wallets for the current user.

### Transactions

- **Deposit to User Wallet**:  
  _Method_: `POST`  
  _Endpoint_: `/wallets/:wallet_id/deposit`  
  _Description_: Deposit money into a specific wallet.  
  _Sample Request Body_:

  ```json
  {
    "amount": 150000
  }
  ```

- **Withdraw from User Wallet**:  
  _Method_: `POST`  
  _Endpoint_: `/wallets/:wallet_id/withdraw`  
  _Description_: Withdraw money from a specific wallet.  
  _Sample Request Body_:

  ```json
  {
    "amount": 50000
  }
  ```

- **Transfer from User Wallet to Target Wallet**:  
  _Method_: `POST`  
  _Endpoint_: `/wallets/:wallet_id/transfer`  
  _Description_: Transfer money from one wallet to another.  
  _Sample Request Body_:
  ```json
  {
    "amount": 25000,
    "target_account_number": "99931723673827"
  }
  ```

## In Progress

- **LatestStockPrice Implementation**: A library to provide stock price information.
- **Additional Tables**: Integration of other entities such as Team and Stocks.
- **Unit Testing**: Implement unit testing for all of the code.

## Postman Collection

The Postman collection included in this repository contains pre-configured requests to test all the API endpoints described above. Simply import the collection into Postman to get started with testing.
