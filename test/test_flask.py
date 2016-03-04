from flask import Flask, request
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/save", methods=['POST'])
def save():
    print request.data
    return "Hello World!"


if __name__ == "__main__":
    app.run()
