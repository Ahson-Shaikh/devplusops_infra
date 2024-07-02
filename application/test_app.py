import pytest
import requests
import mysql.connector
from datetime import datetime
from dotenv import load_dotenv
import os

load_dotenv()

test_db_config = {
    'host': f"{os.getenv('db_host')}",
    'user': f"{os.getenv('db_user')}",
    'password': f"{os.getenv('db_password')}",
    'database': f"{os.getenv('db_database')}"
}

@pytest.fixture(scope='module')
def db_connection():
   
    connection = mysql.connector.connect(**test_db_config)
    yield connection  
    connection.close() 

def test_add_visitor(db_connection):
    visitor_data = {
        'name': 'Shahrukh Shaikh'
    }

    url = 'http://3.149.249.63:5000/add_visitor'

    
    response = requests.post(url, json=visitor_data)

   
    assert response.status_code == 200
    assert response.json()['message'] == 'Visitor added successfully'

    cursor = db_connection.cursor()
    query = "SELECT * FROM visitors WHERE name = %s"
    cursor.execute(query, (visitor_data['name'],))
    result = cursor.fetchone()
    cursor.close()

    assert result is not None


def test_get_visitors(db_connection):
    
    url = 'http://3.149.249.63:5000/visitors'

    response = requests.get(url)

    assert response.status_code == 200

    visitors = response.json()
    assert isinstance(visitors, list)
    assert all(isinstance(visitor, dict) for visitor in visitors)
    assert all(key in visitors[0] for key in ['id', 'name', 'visit_time'])

