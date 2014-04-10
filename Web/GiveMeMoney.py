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
	'/registro', 'registro',
	'/logout', 'logout',
	'/contacto', 'contacto',
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
	form.Textbox ('alimentacion', form.notnull, description = 'Gastos en alimentación'),
	form.Textbox ('hogar', form.notnull, description = 'Gastos del hogar'),
	form.Textbox ('escolares', form.notnull, description = 'Gastos en material escolar'),
	form.Textbox ('transportes', form.notnull, description = 'Gastos en transportes'),
	form.Textbox ('ocio', form.notnull, description = 'Gastos ocio y tiempo libre'),
	form.Textbox ('otros', form.notnull, description = 'Otros gastos'),
	#form.Textbox ('cantidad', form.notnull, form.regexp('^([0-9]{2})$', 'La cantidad introducida no es válida', description='Cantidad')
	form.Button ('Enviar'),
	#for i in tipo_gasto:
		#validators = [form.Validator(i, lambda j: (int (j.cantidad) > 0))],
	validators = [form.Validator("Valor introducido incorrecto", lambda i: ((int (i.Alimentacion) > 0)) and (int (i.Gastos_del_hogar) > 0) and (int (i.Escolares) > 0) and (int (i.Transportes) > 0) and (int (i.Ocio) > 0) and (int (i.Otros) > 0))]
)
#Register form #
registro_form = form.Form(
	form.Textbox ('nombre', form.notnull, description = 'Nombre'), 
	form.Textbox ('apellidos', form.notnull, description = 'Apellidos'),
	form.Textbox ('email', form.notnull, description = 'E-mail'),
	form.Dropdown("dia", [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31], description="Dia de nacimiento"),
	form.Dropdown("mes", ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre'], description="Mes de nacimiento"),
	form.Dropdown("anio", [1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014], description="Anio de nacimiento"),
	form.Password ('password', form.notnull, description = 'Password', post = u'La contraseña debe tener al menos 6 caracteres.'),
	form.Password ('passv', form.notnull, description = u'Repita su contraseña'),
	form.Checkbox ('permission', form.Validator('Debes aceptar las cláusulas de protección de datos.', lambda i: 'permission' not in i), description = 'Aceptación de claúsulas de protección de datos'),
	form.Button('Enviar'),
	validators = [form.Validator("La contrasenia no coincide", lambda i: i.password == i.passv), form.Validator("Tamanio de contrasenia incorrecto", lambda i: len(i.password) >= 7), form.Validator("Fecha de nacimiento incorrecta", lambda i: (((str(i.mes) == 'febrero') and ((int(i.dia) <= 28) and ((int(i.anio) % 4) != 0) or (int(i.dia) <= 29) and ((int(i.anio) % 4) == 0))) or ((int(i.dia) <= 31) and ((str(i.mes) == 'enero') or (str(i.mes) == 'marzo') or (str(i.mes) == 'julio') or (str(i.mes) == 'agosto') or (str(i.mes) == 'octubre') or (str(i.mes) == 'diciembre'))) or ((int(i.dia) <= 30) and ((str(i.mes) == 'abril') or (str(i.mes) == 'junio') or (str(i.mes) == 'septiembre') or (str(i.mes) == 'noviembre')))))]
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

## Class register ##
class registro:
	def GET(self):
		usario = check_identification ()

		form = registro_form()
		return render.Registro (usuario = usuario, form = form)

	def POST(self):
		usuario = check_identification ()

		form = registro_form()
		
		if not form.validates():
			return render.Registro (usuario = usuario, form = form)
		else:
			packet_registro = {"nombre": form.d.nombre,
									"apellidos": form.d.apellidos,
									"email": form.d.email,
									"birth": form.d.birth,
									"password": form.d.password,
									"passv": form.d.passv
									}
			coll = insert(packet_registro)
		return render.givememoney(usuario = usuario, form = form, mensaje = "Usuario registrado correctamente") 

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
			tipo_gast = {"alimentacion": form.d.alimentacion,
							"hogar": form.d.hogar,
							"escolares": form.d.escolares,
							"transportes": form.d.transportes,
							"ocio": form.d.ocio,
							"otros": form.d.otros
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

## Class contacto ##
class contacto:
	def GET(self):
		usuario = check_identification ()

		return render.contacto(usuario = usuario)

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
