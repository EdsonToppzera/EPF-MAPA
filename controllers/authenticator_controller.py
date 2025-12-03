from bottle import request, redirect
from .base_controller import BaseController
from services.user_service import UserService
from services.session_state import session


class AuthenticatorController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.user_service = UserService()
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/login', method=['GET', 'POST'], callback=self.login)
        self.app.route('/registro', method=['GET', 'POST'], callback=self.registro)
        self.app.route('/home', method='GET', callback=self.home) 
        self.app.route('/logout', callback=self.logout)

    # LOGIN
    def login(self):
        if request.method == 'GET':
            return self.render('account/login')

        email = request.forms.get('email')
        password = request.forms.get('password')

        user = self.user_service.authenticate(email, password)

        if not user:
            return self.render('account/login', error="Email ou senha inválidos!")

        session.user = user     # salva na sessão
        return redirect('/home')

    # REGISTRO
    def registro(self):
        if request.method == 'GET':
            return self.render('account/registro')

        name = request.forms.get('name')
        email = request.forms.get('email')
        password = request.forms.get('password') 

        self.user_service.register_user(name, email, password) 

        return redirect('/login')


    # HOME

    def home(self):
        if session.user is None:
            return redirect('/login')

        return self.render('home', user=session.user)
    

    # LOGOUT
    def logout(self):
        session.user = None
        
        return redirect('/login')