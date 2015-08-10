from django.http import HttpResponse
from django.template import Template, Context

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

def hello_world(request):
    return HttpResponse(template.render(Context(dict(big_data=big_data))))

