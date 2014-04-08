#!/usr/bin/env python
# -*- coding: utf-8 -*-

#Imports from
#Framework.
#Forms.
#Data Base.
#Mako to call templates.
import web
from web import form
from web.contrib.template import render_mako
import pymongo

urls = (
	'/index', 'index',
	'/givememoney', 'givememoney',
	'/logout', 'logout',
	'/(.*)', 'error' 
)

#To use sesions with web.py
web.config.debug = False

#App will indicate wich urls will be used in the connection
app = web.application(urls, globals())

#To create cookies (Save te users information).
session = web.session.Session(app, web.session.DiskStore('session'), initializer={'usuario':''})

#Connection to Mongo's Database.
#Connection try
try:
	conn=pymongo.Connection()
	print "Conexión realizada con éxito"
#Catch possible exceptions
except pymongo.errors.ConnectionFailure, e:
	print "Fallo en la conexión a MongoDB: %s" %e
conn #Make the new connection

#Create the database for instance our collection
db = conn.usuarios
db #To use the database variable later.

#Instance the Mongo's collection where i'll introduce the data
coll = db.datos
coll #To use the collection variable later

#Templates structure
#Mako templates
render = render_mako(
	directories = ['templates'], #Directory where we save the html files
	input_encoding = 'utf-8', #Codification we will use. Input
	output_encoding = 'utf-8') #Codification we will use. Output

###### FORMS ######
#Login for user register.
login_form = form.Form(
	form.Textbox ('usuario', form.notnull, description='Usuario: '), #Textbox object to write the user nickname
	form.Password ('contrasenia', form.notnull, description='Contrasenia: '), #Password object to occult the user pass
	form.Button ('Ingresar'), #Button object to click and send the data
)

#Intro gastos form
gastos_form = form.Form(
	#form.Dropdown("gastos",['Alimentación', 'Gastos del hogar', 'Escolares', 'Transportes', 'Ocio', 'Otros'], description="Tipos de gasto"),
	#tipo_gasto = ['Alimentación', 'Gastos del hogar', 'Escolares', 'Transportes', 'Ocio', 'Otros'],
	form.Textbox ('Alimentacion', form.notnull, description = 'Gastos en alimentación'),
	form.Textbox ('Gastos_del_hogar', form.notnull, description = 'Gastos del hogar'),
	form.Textbox ('Escolares', form.notnull, description = 'Gastos en material escolar'),
	form.Textbox ('Transportes', form.notnull, description = 'Gastos en transportes'),
	form.Textbox ('Ocio', form.notnull, description = 'Gastos ocio y tiempo libre'),
	form.Textbox ('Otros', form.notnull, description = 'Otros gastos'),
	#form.Textbox ('cantidad', form.notnull, form.regexp('^([0-9]{2})$', 'La cantidad introducida no es válida', description='Cantidad')
	form.Button ('Enviar'),
	#for i in tipo_gasto:
		#validators = [form.Validator(i, lambda j: (int (j.cantidad) > 0))],
	validators = [form.Validator("Valor introducido incorrecto", lambda i: ((int (i.Alimentacion) > 0)) and (int (i.Gastos_del_hogar) > 0) and (int (i.Escolares) > 0) and (int (i.Transportes) > 0) and (int (i.Ocio) > 0) and (int (i.Otros) > 0))]
)

##### FUNCTIONS ######
def check_identification ():
	usuario = session.usuario #Check in cookies if user is already login
	return usuario 

def correct_password (usuario):
	return usuario + '3' #Assig value 3 to user name to create a password

##### CLASSES ######
#All clases have two methods
##GET method who normally show forms and user's information
##POST method who we collect data from forms to do actions with them 

## Class index ##	
class index:
	def GET(self): 
		usuario = check_identification () #Check the user is register or, in other case, show the form and request his identification
		if usuario:
			return web.seeother('/givememoney') #If is register then go to Give Me Money main page
		else:
			form = login_form() #If is not register then go to login_form 
			return render.login(form = form, usuario = usuario, mensaje = '') #and call te HTML file with params form and usuario

	def POST(self):
		form = login_form() #Catch the form
		if not form.validates(): #Check the validation options are correct
			return render.login(form = form, usuario = '', mensaje = '') #Return the form again and erase the user data

		i = web.input()
		usuario = i.usuario #There is the content of user name
		password = i.contrasenia

		if password == correct_password (usuario):
			session.usuario = usuario
			return web.seeother('/givememoney')
		else:
			form = login_form()
			return render.login(form = form, usuario = '', mensaje = u'La contraseña introducida es incorrecta, la clave correcta es tu nombre de usuario seguido de un 3')

## Class gastos ##
class gastos:
	def GET(self):
		usuario = check_identification ()
		
		form = gastos_form()
		return render.Gasto (usuario = usuario, form = form)

	def POST(self):
		usuario = check_identification ()

		form = gasto_form()
		if not form.validates():
			return render.Gasto (usuario = usuario, form = form)
		else:
			tipo_gast = {"Alimentacion": form.d.Alimentacion,
							"Gastos_del_hogar": form.d.Gastos_del_hogar,
							"Escolares": form.d.Escolares,
							"Transportes": form.d.Transportes,
							"Ocio": form.d.Ocio,
							"Otros": form.d.Otros
			}
			coll = insert(tipo_gast)
			return render.givememoney(usuario = usuario, form = form, mensaje = "Gastos insertados correctamente")

## Class givememoney ##
class givememoney:
	def GET(self):
		usuario = check_identification ()
		
		if usuario:
			return render.givememoney(usuario = usuario)
		else:
			return web.seeother('/index')

## Class logout ##
class logout:
	def GET(self):
		usuario = session.usuario
		session.kill()
		return 'Adios ' + usuario

## Class error ##
class error:
	def GET(self, name):
		return '<!doctype html><html lang="es"><head><meta charset="utf-8"><title>ERROR</title></head><body><header>404 Not Found</header></body></html>'

if __name__ == "__main__":
	app.run()
