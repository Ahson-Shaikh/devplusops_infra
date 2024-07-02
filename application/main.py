from flask import Flask, jsonify, request
import mysql.connector
from datetime import datetime
from dotenv import load_dotenv
import os

app = Flask(__name__)

load_dotenv

# MySQL Configuration
db = mysql.connector.connect(
    host=f"{os.getenv('db_host')}",
    user=f"{os.getenv('db_user')}",
    password=f"{os.getenv('db_password')}",
    database=f"{os.getenv('db_database')}",
)
cursor = db.cursor()

# Endpoint to add a visitor's name
@app.route('/add_visitor', methods=['POST'])
def add_visitor():
    data = request.get_json()
    name = data['name']
    visit_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    query = "INSERT INTO visitors (name, visit_time) VALUES (%s, %s)"
    cursor.execute(query, (name, visit_time))
    db.commit()
    return jsonify({'message': 'Visitor added successfully'})

@app.route('/visitors', methods=['GET'])
def get_visitors():
    query = "SELECT id, name, visit_time FROM visitors"
    cursor.execute(query)
    visitors = cursor.fetchall()
    visitors_list = []
    for visitor in visitors:
        visitor_data = {
            'id': visitor[0],
            'name': visitor[1],
            'visit_time': visitor[2].strftime('%Y-%m-%d %H:%M:%S')
        }
        visitors_list.append(visitor_data)
    return jsonify(visitors_list)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
