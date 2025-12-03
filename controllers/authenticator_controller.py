from bottle import request, redirect, response
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
            #response.delete_cookie("user_id", path='/')
            return self.render('account/login')

        email = request.forms.get('email')
        password = request.forms.get('password')

        if not email or not password:
             return self.render('account/login', error="Preencha todos os campos")
        
        user = self.user_service.authenticate(email, password)
        print("DEBUG LOGIN: user autenticado =", user)

        if not user:
            return self.render('account/login', error="Email ou senha inválidos!")

        #modifiquei aqui
        
        # session.user = user
        response.set_cookie("user_id", str(user.id), secret='sua_chave_secreta', path='/')     # salva na sessão
        return redirect('/home')

    # REGISTRO
    def registro(self):
        if request.method == 'GET':
            return self.render('account/registro')

        name = request.forms.get('name')
        email = request.forms.get('email')
        password = request.forms.get('password') 

        #parte q modiquei

        # Qual botão foi clicado (user ou user_premium)
        tipo_conta = request.forms.get('tipo_conta', 'user') 

        if not name or not email or not password:
            return self.render('account/registro', error="Preencha todos os campos")
        ###
        
        # Passa o tipo para o service
        self.user_service.register_user(name, email, password, tipo_conta)#

        return redirect('/login')


    # HOME

    def home(self):
        # #Lê do cookie e busca o user no banco
        # user_id = request.get_cookie("user_id", secret='sua_chave_secreta')
        
        # if not user_id:
        #     return redirect('/login')
            
        # # Busca o objeto user real para passar pro template
        # current_user = self.user_service.get_by_id(int(user_id))
        
        # if not current_user: # Cookie antigo de usuário deletado
        #      return redirect('/login')

        # return self.render('home', user=current_user)

        #DEBUGGGGG
        # Tenta ler o cookie
        user_id = request.get_cookie("user_id", secret='sua_chave_secreta')
        
        # DEBUG: Imprime no terminal do VS Code o que ele achou
        print(f"DEBUG HOME: user_id do cookie é: {user_id}")

        if not user_id:
            print("DEBUG HOME: Redirecionando para login porque não achei cookie.")
            return redirect('/login')
            
        current_user = self.user_service.get_by_id(int(user_id))
        
        if not current_user:
             print(f"DEBUG HOME: Achei o ID {user_id} no cookie, mas esse usuário não existe no banco.")
             return redirect('/login')

        print(f"DEBUG HOME: Sucesso! Usuário é {current_user.name}")
        return self.render('home', user=current_user)
    

    # LOGOUT
    def logout(self):
        # session.user = None
        response.delete_cookie("user_id", path='/')
        return redirect('/login')