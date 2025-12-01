from bottle import Bottle, run
from controllers import init_controllers

app = Bottle()

#carregar todas as rotas do projeto
init_controllers(app)

#rodar o servidor
run(app, host='localhost', port=8080, debug=True, reloader=True)
