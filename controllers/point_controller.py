from bottle import redirect
from .base_controller import BaseController
from services.point_service import PointService

class PointController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.point_service = PointService()
        self.setup_routes()

    def setup_routes(self):
        #ver o mapa
        self.app.route('/map', method='GET', callback=self.show_map)
        #salvar novo ponto
        self.app.route('/map/add', method='POST', callback=self.add_point)

    def show_map(self):
        points = self.point_service.get_all()
        return self.render('map', points=points)

    def add_point(self):
        self.point_service.create()
        redirect('/map')