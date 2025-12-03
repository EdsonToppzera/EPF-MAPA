from bottle import redirect, request
from .base_controller import BaseController
from services.point_service import PointService
from services.user_service import UserService


class PointController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.point_service = PointService()
        self.user_service = UserService()
        self.setup_routes()

    def setup_routes(self):
        #ver o mapa
        self.app.route('/map', method='GET', callback=self.show_map)
        #salvar novo ponto
        self.app.route('/map/add', method='POST', callback=self.add_point)
        # rota da pesquisa
        self.app.route('/map/search', method='GET', callback=self.search_points)

    def show_map(self):
        #DEBUG
        print("show_map chamado")
        # Pega o usuário logado
        user_id = request.get_cookie("user_id", secret='sua_chave_secreta')
        print(f"=== DEBUG MAPA: Cookie lido foi: {user_id}")
        current_user = self.user_service.get_by_id(int(user_id)) if user_id else None

        # if not current_user:
        #      return redirect('/login')

        points = self.point_service.get_all()
        
        # Passa current_user para o template
        return self.render('map', points=points, current_user=current_user)
    

    def add_point(self):
        color = request.forms.get('color', 'blue')
        self.point_service.create(color=color)
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