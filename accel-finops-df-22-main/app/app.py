import os

from flask import Flask, render_template, request, redirect, url_for
from firebase_admin import credentials, firestore, initialize_app

from budget import Budget

# Initialize Flask app
app = Flask(__name__)

# Initialized FirestoreDB
default_app = initialize_app()
db = firestore.client()
budgets = db.collection('budgets')


@app.route('/')
def index():
    all_budgets = budgets.stream()
    return render_template("index.html", budgets=[budget.to_dict() for budget in all_budgets])


@app.route('/create', methods=['POST'])
def create():
    ref = budgets.document()
    budget = Budget(ref, request.form['date'], {request.form['label_key']: request.form['label_value']},
                    request.form['amount'])
    ref.set(budget.to_dict())

    return redirect(url_for("index"))


@app.route('/update/<budget_id>', methods=['POST'])
def update(budget_id):
    ref = budgets.document(budget_id)
    budget = Budget(ref, request.form['date'], {request.form['label_key']: request.form['label_value']},
                    request.form['amount'])
    ref.update(budget.to_dict())

    return redirect(url_for("index"))


@app.route('/delete/<budget_id>', methods=['POST'])
def delete(budget_id):
    ref = budgets.document(budget_id)
    ref.delete()

    return redirect(url_for("index"))


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
