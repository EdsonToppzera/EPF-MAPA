from bottle import Bottle
from controllers.user_controller import UserController
from controllers.authenticator_controller import AuthenticatorController

def init_controllers(app: Bottle):
    
    UserController(app)
    AuthenticatorController(app)
