from bottle import Bottle, request
from .base_controller import BaseController
from services.user_service import UserService



#Authenticator para login e registro
class AuthenticatorController(BaseController):
    def __init__(self, app):
        super().__init__(app)

        self.user_service = UserService() 
        self.setup_routes() 

        #Rotas user
    def setup_routes(self):
        self.app.route('/login', method=['GET', 'POST'], callback=self.login)
        self.app.route('/register', method=['GET', 'POST'], callback=self.register)


    #Login
    def login(self):
        if request.method == 'GET':
            return self.render('account/login')

        email = request.forms.get('email')
        password = request.forms.get('password')

        user = self.user_service.authenticate(email, password) 

        if not user:
            return ("Email ou senha inválidos")        
        
        self.redirect('/users')

    #Registro
    def register(self):
        if request.method == 'GET':
            return self.render('account/register')

        name = request.forms.get('name')
        email = request.forms.get('email')
        password = request.forms.get('password')

        self.user_service.register(name, email, password)

        self.redirect('/login')


    def render(self, template, **ctx):
            from bottle import template
            return template(template, **ctx)

    def redirect(self, path):
            from bottle import redirect
            return redirect(path)