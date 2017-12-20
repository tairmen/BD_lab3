import json
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render, render_to_response
from django.core.urlresolvers import reverse
from django.core.exceptions import ObjectDoesNotExist
from .db import DB
import MySQLdb

db = DB()

def index(request):
    return render(request, 'index.html')

def main_list(request):
    context = db.select_travels()
    context['title'] = 'travels'
    context['cities'] = db.select('cities')['rows']
    return render(request, 'table_main.html', context)

def secondary_list(request, secondary_name):
    context = db.select(secondary_name)
    context['title'] = secondary_name
    return render(request, 'table.html', context)

def secondary_upload(request, secondary_name):
    file_data = json.loads(request.FILES['file'].read().decode('utf-8'))['data']
    if file_data:
        fields = [field for field in file_data[0].keys()]

        rows = []
        for raw_row in file_data:
            row = [raw_row[field] for field in fields]
            rows.append(row)

        db.insert(secondary_name, {
            'fields': fields,
            'rows': rows,
        })

    return HttpResponseRedirect('/{0}/'.format(secondary_name))

def add_travels(request):
    db.insert_travels(request.POST['city'],
        request.POST['date1'],
        request.POST['date2']
    )

    return HttpResponseRedirect('/travels/')

def delete_travels(request):
    db.delete_travels(int(request.POST['id']))

    return HttpResponseRedirect('/travels/')
	
def trigger(request):
	con = MySQLdb.connect('localhost', 'root', '1111', 'travels')
	con.commit()
	cur = con.cursor()
	if request.POST:
		print(request.POST['trigger'])
		if request.POST['trigger'] == "OnTrigger":
			query = ''' CREATE TRIGGER travels.insert_test BEFORE INSERT ON travels.travels FOR EACH ROW BEGIN
			UPDATE travels.cities SET population=population+1;
			END;'''
			cur.execute(query)
 
		elif request.POST['trigger'] == "OffTrigger":
			query = '''DROP TRIGGER IF EXISTS travels.insert_test;'''
			cur.execute(query)
	con.close()
	return HttpResponseRedirect('/travels/')
