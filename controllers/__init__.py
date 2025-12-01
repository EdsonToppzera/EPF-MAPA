from bottle import Bottle
from controllers.user_controller import UserController
from controllers.authenticator_controller import AuthenticatorController
from controllers.point_controller import PointController

def init_controllers(app: Bottle):
    
    UserController(app)
    AuthenticatorController(app)
    PointController(app)
