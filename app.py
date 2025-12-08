from flask import Flask, request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity, JWTManager

app = Flask(__name__)

# --- JWT Configuration ---
# WARNING: ALWAYS use a strong, complex key in a real application
app.config["JWT_SECRET_KEY"] = "super-secret-key-for-tutorial" 
jwt = JWTManager(app)

# --- Dummy User Database (for demonstration) ---
USERS = {
    "testuser": "testpass",
    "admin": "adminpass"
}

# --- 1. Login Endpoint (Generates Token) ---
@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username', None)
    password = data.get('password', None)
    
    # Simple validation check
    if username in USERS and USERS[username] == password:
        # Generate the Login Token (JWT)
        access_token = create_access_token(identity=username) 
        
        return jsonify(
            message="Login successful",
            login_token=access_token
        ), 200
    else:
        return jsonify({"message": "Bad username or password"}), 401

# --- 2. Protected Endpoint (Checks Token) ---
@app.route('/api/check_token', methods=['GET'])
@jwt_required() # This decorator enforces token requirement and validation
def check_token():
    # If the request reaches here, the token is VALID.
    current_user = get_jwt_identity() 
    
    # Returns 200 OK upon successful validation.
    return jsonify(
        message=f"Token is valid. Welcome, {current_user}!",
        status="Token successfully validated."
    ), 200

# --- 3. Generate 500 Error (Checks Token) ---
@app.route('/api/error_check', methods=['GET'])
@jwt_required() # This decorator enforces token requirement and validation
def error_check():
    # If the request reaches here, the token is VALID.
    current_user = get_jwt_identity() 
    
    # Returns 500 OK upon successful validation.
    return jsonify(
        message=f"Authentication successful for {current_user}, but an **Internal Server Error** occurred during processing.",
        status="Token validated successfully, but API returned 500."
    ), 500

if __name__ == '__main__':
    # Flask runs on http://127.0.0.1:5000 by default
    app.run(debug=True, port=5000)