#from http://docs.pylonsproject.org/projects/pyramid//en/latest/narr/firstapp.html
from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.response import Response


def hello_world(request):
    return Response('Hello world!')

config = Configurator()
config.add_route('hello', '/')
config.add_view(hello_world, route_name='hello')
app = config.make_wsgi_app()

if __name__ == '__main__':
    server = make_server('0.0.0.0', 5000, app)
    server.serve_forever()
                       
