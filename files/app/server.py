from flask import Flask, jsonify
from flask import request
import random
import string

app = Flask(__name__)

#curl -i -H "Content-Type: application/json" -X POST -d '{"lenght": 10}' http://127.0.0.1:5000/

@app.route('/', methods=['GET','PUT','DELETE'])
def notimp():
    abort(501)

@app.route('/', methods=['POST'])

def post():
    if not request.json:
        abort(400)

    if not 'lenght' in request.json:
        abort(400)

    s = "abcdefghijklmnopqrstuvwxyz01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()?"
    p =  "".join(random.sample(s,request.json['lenght']))

    return jsonify({'password': p}), 201
      
if __name__ == '__main__':
    app.run(debug=True)
