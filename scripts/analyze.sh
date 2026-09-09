#!/bin/bash
from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route("/logs", methods=["GET"])
def read_logs():
    log_file = os.path.join(
        os.path.dirname(__file__),
        "..",
        "logs",
        "app.log"
    )

    with open(log_file, "r") as file:
        logs = file.read()

    return jsonify({
        "logs": logs
    })
@app.route("/stats", methods=["GET"])
def get_stats():
    log_file = os.path.join(
        os.path.dirname(__file__),
        "..",
        "logs",
        "app.log"
    )

    count_404 = 0
    count_500 = 0

    with open(log_file, "r") as file:
        for line in file:
            if "404" in line:
                count_404 += 1
            if "500" in line:
                count_500 += 1

    return jsonify({
        "number of 404": count_404,
        "number of 500": count_500
    })

if __name__ == "__main__":
    app.run(debug=True)
