# 🔑 API for Apache JMeter Tutorial

This project provides a simple, three-endpoint Flask API designed specifically to demonstrate **token correlation** and different HTTP response handling during performance testing, particularly using Apache JMeter.

## 🎯 Purpose

This API simulates a standard login flow that requires extracting a dynamic access token from a successful login response and passing it in the `Authorization` header for all subsequent protected requests.

It includes endpoints to demonstrate:
1.  Successful token generation (200 OK).
2.  Successful token validation leading to a successful resource response (200 OK).
3.  Successful token validation leading to an *Internal Server Error* response (500), which is critical for demonstrating failure assertion handling in JMeter.

---

## 🛠️ Project Setup

Download the Prerequisites
1. Clone the Repository.
2. run .\prerequisite.ps1
3. run python app.py

## 🚀 API Endpoints Documentation

1. **Login (Token Generation)** - POST - /api/login - Status200 OK on success, 401 Unauthorized on failure.
   JSON Body
   
   {
    "username": "testuser",
    "password": "testpass"
}

2. **Check Token** - GET - /api/check_token - Status	200 OK on successful token validation.

3. **Generate 500 Error** - GET - /api/error_check - Status 500 Internal Server Error (even with a valid token).

### This Code is compatible for local "Windows Only" machine.
