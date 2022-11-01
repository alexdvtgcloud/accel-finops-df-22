from datetime import datetime


class Budget(object):
    def __init__(self, ref, date, label, amount):
        self.b_id = str(ref.path).split("/")[1]
        self.date = date
        self.label = label
        self.amount = amount

    def get_date_string(self):
        date_obj = datetime.strptime(self.date, "%Y-%m")
        return date_obj.strftime("%B %Y")

    def to_dict(self):
        return {
            "id": self.b_id,
            "date": self.date,
            "date_string": self.get_date_string(),
            "label": self.label,
            "amount": self.amount,
        }
