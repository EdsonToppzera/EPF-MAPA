from bottle import Bottle, run, static_file
from controllers import init_controllers

app = Bottle()

#carregar todas as rotas do projeto
init_controllers(app)

#rota do css e js
@app.route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='static')

#rodar o servidor
run(app, host='localhost', port=8080, debug=True, reloader=True)
