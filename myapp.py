from flask import Flask, render_template

app = Flask(__name__)


@app.route("/", methods=['GET'])
def root():
    return render_template('unsplash.html')


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
