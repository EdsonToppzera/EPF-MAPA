from bottle import Bottle, run, redirect
from controllers import init_controllers
from services.session_state import session

app = Bottle()

init_controllers(app)


run(app, host='localhost', port=8080, debug=True, reloader=True)
