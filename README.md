# 🔑 Flask JWT Correlation Tutorial API

This project provides a simple, three-endpoint Flask API designed specifically to demonstrate **token correlation** and different HTTP response handling during performance testing, particularly using Apache JMeter.

## 🎯 Purpose

This API simulates a standard login flow that requires extracting a dynamic access token from a successful login response and passing it in the `Authorization` header for all subsequent protected requests.

It includes endpoints to demonstrate:
1.  Successful token generation (200 OK).
2.  Successful token validation leading to a successful resource response (200 OK).
3.  Successful token validation leading to an *Internal Server Error* response (500), which is critical for demonstrating failure assertion handling in JMeter.

---

## 🛠️ Project Setup (Windows/Linux/macOS)

### Prerequisites

* Python 3.8+
* `pip` (Python package installer)

### 1. Clone the Repository

```bash
git clone [YOUR_REPOSITORY_URL]
cd api_tutorial
