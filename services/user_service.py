from bottle import request
from models.user import UserModel, User
import hashlib 


#função para cryptografar a senha
def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()


class UserService:
    def __init__(self):
        self.user_model = UserModel()


    def get_all(self):
        return self.user_model.get_all()

    #salva novos usuarios. 
    def save(self):
        #gerar id para novo usuario
        last_id = max([u.id for u in self.user_model.get_all()], default=0)
        new_id = last_id + 1

        name = request.forms.get('name')
        email = request.forms.get('email')
        wpassword = request.forms.get('password')
        
        #hash
        password = hash_password(wpassword)

        user = User(
            id=new_id,
            name=name,
            email=email,
            password=password,
            tipo="user"
        )

        self.user_model.add_user(user)

    #busca por id
    def get_by_id(self, user_id):
        return self.user_model.get_by_id(user_id)

    #atualiza usuario
    def edit_user(self, user):
        name = request.forms.get('name')
        email = request.forms.get('email')

        passwordw = request.forms.get('password')
        
        user.name = name
        user.email = email
        
        #caso o usuario solicite uma nova senha
        if passwordw:
            user.password = hash_password(passwordw)
            
        self.user_model.update_user(user)

    #remover usuario
    def delete_user(self, user_id):
        self.user_model.delete_user(user_id)




#autenticação de usuario
    def authenticate(self, email, password):
        password_hashed = hash_password(password)
        #verifica se existe usuario com email e senha fornecidos  
        for u in self.user_model.get_all():
            if u.email == email and u.password == password_hashed:
                return u
        return None