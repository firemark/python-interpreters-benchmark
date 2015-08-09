#from http://flask.pocoo.org/docs/0.10/quickstart/ 
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'


if __name__ == '__main__':
    app.run(debug=False, processes=4)