from bottle import redirect, request
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
        # rota da pesquisa
        self.app.route('/map/search', method='GET', callback=self.search_points)

    def show_map(self):
        points = self.point_service.get_all()
        return self.render('map', points=points)

    def add_point(self):
        self.point_service.create()
        redirect('/map')

    #LOGICA DA PESQUISA
    def search_points(self):
        query = request.query.get('q', '').lower()
        
        all_points = self.point_service.get_all()
        
        if not query:
            #Se vazio, mostra todos
            filtered_points = all_points
        else:
            #filtra pelo nome
            filtered_points = [
                p for p in all_points 
                if query in p.name.lower()
            ]
            
        return self.render('search_points', points=filtered_points, query=query)