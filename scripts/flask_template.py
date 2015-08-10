from flask import Flask
from jinja2 import Template
app = Flask(__name__)

animals = 'dog', 'cat', 'fox'

big_data = [
    dict(name=animals[i % 3], num=i)
    for i in xrange(4048)
]

template = Template("""
<ul>
    {% for data in big_data %}
        <li><b>{{data.num}}</b> {{data.name}} </li>
    {% endfor %}
</ul>
""") 

@app.route('/')
def hello_world():
    return template.render(big_data=big_data)


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=False)
