from app.app import app

def test_hello_world():
    tester = app.test_client()
    response = tester.get('/')
    assert response.status_code == 200
    assert response.data == b'Hello, World!'
