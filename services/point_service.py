from bottle import request
from models.point import PointModel, Point

class PointService:
    def __init__(self):
        self.point_model = PointModel()

    def get_all(self):
        return self.point_model.get_all()

    def create(self):
        # Gera ID simples
        existing_ids = [p.id for p in self.point_model.get_all()]
        new_id = max(existing_ids) + 1 if existing_ids else 1
        
        # Pega dados do form
        lat = float(request.forms.get('lat'))
        lng = float(request.forms.get('lng'))
        name = request.forms.get('name')
        description = request.forms.get('description')

        new_point = Point(new_id, lat, lng, name, description)
        self.point_model.add(new_point)