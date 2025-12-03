from models.user import UserModel, User
import hashlib 


def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()


class UserService:
    def __init__(self):
        self.user_model = UserModel()

    def get_all(self):
        return self.user_model.get_all()

    #CRIAÇÃO: Recebe os dados
    def register_user(self, name, email, password_raw):
        last_id = max([u.id for u in self.user_model.get_all()], default=0)
        new_id = last_id + 1
        
        user = User(
            id=new_id,
            name=name,
            email=email,
            password=hash_password(password_raw),
            tipo="user"
        )
        self.user_model.add_user(user)

    #ATUALIZAÇÃO: Recebe o objeto User completo (limpo)
    def update(self, user: User):
        self.user_model.update_user(user)

    def get_by_id(self, user_id):
        return self.user_model.get_by_id(user_id)

    def delete_user(self, user_id):
        self.user_model.delete_user(user_id)

    #AUTENTICAÇÃO: Recebe email e senha 
    def authenticate(self, email, password):
        password_hashed = hash_password(password)
        for u in self.user_model.get_all():
            if u.email == email and u.password == password_hashed:
                return u
        return None