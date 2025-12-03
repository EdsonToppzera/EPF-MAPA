from bottle import Bottle, run, redirect
from controllers import init_controllers
from services.session_state import session

app = Bottle()

init_controllers(app)

@app.route('/home')
def home():
    if session.user is None:
        return redirect('/login')

    return f"Bem-vindo, {session.user.name}!"


run(app, host='localhost', port=8080, debug=True, reloader=True)
