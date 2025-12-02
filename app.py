from bottle import Bottle, static_file
from config import Config

class App:
    def __init__(self):
        self.bottle = Bottle()
        self.config = Config()

    def setup_routes(self):
        @self.bottle.route('/static/<filename:path>')
        def serve_static(filename):
            return static_file(filename, root=self.config.STATIC_PATH)
        
        from controllers import init_controllers

        print('🚀 Inicializa rotas!')
        init_controllers(self.bottle)


    def run(self):
        self.setup_routes()
        self.bottle.run(
            host=self.config.HOST,
            port=self.config.PORT,
            debug=self.config.DEBUG,
            reloader=self.config.RELOADER
        )


def create_app():
    return App()
