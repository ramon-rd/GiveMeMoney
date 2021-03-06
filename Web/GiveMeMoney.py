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
	'/gastos', 'gastos',
	'/ingresos', 'ingresos',
	'/modificar', 'modificar',
	'/(.*)', 'error' 
)

#MONGODB_URI = 'mongodb://josemlp:660281871@ds029630.mongolab.com:29630/givememoney' 

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
	#conn=pymongo.MongoClient()
	#client = pymongo.MongoClient(MONGODB_URI)
	#db = client.get_default_database()

	print "Conexión realizada con éxito"
#Catch possible exceptions
except pymongo.errors.ConnectionFailure, e:
	print "Fallo en la conexión a MongoDB: %s" %e
conn

#Create the database for instance our collection
#db = client.get_default_database()
db = conn.usuarios
db

#Instance the Mongo's collection where i'll introduce the data
coll = db.datos
coll
#user =       db['usuariosGiveMeMoney']
#gastos =     db['gastos']
#beneficios = db['beneficios']


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
	form.Textbox ('alimentacion', form.notnull, description = 'Gastos en alimentacion'),
	form.Textbox ('hogar', form.notnull, description = 'Gastos del hogar'),
	form.Textbox ('escolares', form.notnull, description = 'Gastos en material escolar'),
	form.Textbox ('transportes', form.notnull, description = 'Gastos en transportes'),
	form.Textbox ('ocio', form.notnull, description = 'Gastos ocio y tiempo libre'),
	form.Textbox ('otros', form.notnull, description = 'Otros gastos'),
	#form.Textbox ('cantidad', form.notnull, form.regexp('^([0-9]{2})$', 'La cantidad introducida no es válida', description='Cantidad')
	form.Button ('Enviar'),
	#for i in tipo_gasto:
		#validators = [form.Validator(i, lambda j: (int (j.cantidad) > 0))],
	validators = [form.Validator("Valor introducido incorrecto", lambda i: ((int (i.alimentacion) >= 0)) and (int (i.hogar) >= 0) and (int (i.escolares) >= 0) and (int (i.transportes) >= 0) and (int (i.ocio) >= 0) and (int (i.otros) >= 0))]
)

#Intro beneficios form
beneficios_form = form.Form(
	#form.Dropdown("gastos",['Alimentación', 'Gastos del hogar', 'Escolares', 'Transportes', 'Ocio', 'Otros'], description="Tipos de gasto"),
	#tipo_gasto = ['Alimentación', 'Gastos del hogar', 'Escolares', 'Transportes', 'Ocio', 'Otros'],
	form.Textbox ('deudas', form.notnull, description = 'Dinero ingresado por pagos de deudas'),
	form.Textbox ('trabajo', form.notnull, description = 'Tu salario'),
	form.Textbox ('premios', form.notnull, description = 'Premios economicos'),
	form.Textbox ('ventas', form.notnull, description = 'Ingresos por ventas'),
	form.Textbox ('otros', form.notnull, description = 'Otros ingresos'),
	#form.Textbox ('cantidad', form.notnull, form.regexp('^([0-9]{2})$', 'La cantidad introducida no es válida', description='Cantidad')
	form.Button ('Enviar'),
	#for i in tipo_gasto:
		#validators = [form.Validator(i, lambda j: (int (j.cantidad) > 0))],
	validators = [form.Validator("Valor introducido incorrecto", lambda i: ((int (i.deudas) >= 0)) and (int (i.trabajo) >= 0) and (int (i.premios) >= 0) and (int (i.ventas) >= 0) and (int (i.otro) >= 0))]
)

#Register form #
registro_form = form.Form(
	form.Textbox ('nombre', form.notnull, description = 'Nombre'), 
	form.Textbox ('apellidos', form.notnull, description = 'Apellidos'),
	form.Textbox ('email', form.notnull, form.regexp('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$', 'Formato de correo electronico incorrecto'), description = 'E-mail'),
	form.Dropdown("dia", [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31], description="Dia de nacimiento"),
	form.Dropdown("mes", ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre'], description="Mes de nacimiento"),
	form.Dropdown("anio", [1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014], description="Anio de nacimiento"),
	form.Password ('password', form.notnull, description = 'Password', post = 'La contrasenia debe tener al menos 6 caracteres.'),
	form.Password ('passv', form.notnull, description = 'Repita su contrasenia'),
	form.Checkbox ('permission', form.Validator('Debes aceptar las clausulas de proteccion de datos.', lambda i: 'permission' not in i), description = 'Aceptacion de clausulas de proteccion de datos'),
	form.Button('Enviar'),
	validators = [form.Validator("La contrasenia no coincide", lambda i: i.password == i.passv), form.Validator("Tamanio de contrasenia incorrecto", lambda i: len(i.password) >= 6), form.Validator("Fecha de nacimiento incorrecta", lambda i: (((str(i.mes) == 'febrero') and ((int(i.dia) <= 28) and ((int(i.anio) % 4) != 0) or (int(i.dia) <= 29) and ((int(i.anio) % 4) == 0))) or ((int(i.dia) <= 31) and ((str(i.mes) == 'enero') or (str(i.mes) == 'marzo') or (str(i.mes) == 'julio') or (str(i.mes) == 'agosto') or (str(i.mes) == 'octubre') or (str(i.mes) == 'diciembre'))) or ((int(i.dia) <= 30) and ((str(i.mes) == 'abril') or (str(i.mes) == 'junio') or (str(i.mes) == 'septiembre') or (str(i.mes) == 'noviembre')))))]
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
		usuario = check_identification ()

		form = registro_form()
		return render.registro (usuario = usuario, form = form)

	def POST(self):
		usuario = check_identification ()

		form = registro_form()
		
		if not form.validates():
			return render.registro (usuario = usuario, form = form)
		else:
			birth = form.d.dia + '/' + form.d.mes + '/' + form.d.anio
			pack_registro = {"nombre": form.d.nombre,
									"apellidos": form.d.apellidos,
									"email": form.d.email,
									"birth": birth,
									"password": form.d.password
									}
			coll.insert(pack_registro)

			#user.insert(pack_registro)

			#cursor = user.find()
			#for doc in cursor:
			#	print (doc['nombre'], doc['apellidos'])

			formi = login_form()
		return render.login(usuario = usuario, form = formi, mensaje = "Usuario registrado correctamente") 

class modificar:
	def GET(self):
		usuario = check_identification ()

		form = registro_form()

		cursor = coll.find({"email":form.d.email})
		nombre = cursor[0]["nombre"]
		apellidos = cursor[0]["apellidos"]
		email = cursor[0]["email"]
		birth = cursor[0]["birth"]
		dia,mes,anio = str(birth).split()
		password = cursor[0]["password"]

		form.nombre.value = nombre
		form.apellidos.value = apellidos
		form.email.value = email
		form.dia.value = int(dia)
		form.mes.value = mes
		form.anio.value = int(anio)	
		form.contrasenia.value = password
		form.verificacion.value = password

		return render.modificarperfil(usuario = usuario, form = form)

	def POST(self):
		usuario = check_identification ()

		form = registro_form()

		if not form.validates():
			return render.modificarperfil(usuario = usuario, form = form)
		else:
			birth = form.d.dia + '/' + form.d.mes + '/' + form.d.anio

			pack_registro = {"nombre": form.d.nombre,
									"apellidos": form.d.apellidos,
									"email": form.d.email,
									"birth": birth,
									"password": form.d.password
									}

			coll.remove({"email":form.d.email})
			coll.insert(pack_registro)

		formi = login_form()
		
		return render.login(usuario = usuario, form = formi, mensaje = "Usuario modificado correctamente") 

## Class gastos ##
class gastos:
	def GET(self):
		usuario = check_identification ()
		
		form = gastos_form()
		return render.gasto (usuario = usuario, form = form)

	def POST(self):
		usuario = check_identification ()

		form = gasto_form()
		if not form.validates():
			return render.gasto (usuario = usuario, form = form)
		else:
			pack_gasto = {"alimentacion": form.d.alimentacion,
							"hogar": form.d.hogar,
							"escolares": form.d.escolares,
							"transportes": form.d.transportes,
							"ocio": form.d.ocio,
							"otros": form.d.otros
							}
			coll.insert(pack_gasto)
			#gastos.insert(pack_gasto)

			#cursor = gastos.find()
			#for doc in cursor:
			#	print (doc['alimentacion'], doc['hogar'], doc['transportes'], doc['ocio'], doc['otros'])

		return render.givememoney(usuario = usuario, form = form, mensaje = "Gastos insertados correctamente")

## Class beneficios ##
class ingresos:
	def GET(self):
		usuario = check_identification ()
		
		form = beneficios_form()
		return render.ingresos (usuario = usuario, form = form)

	def POST(self):
		usuario = check_identification ()

		form = beneficios_form()
		if not form.validates():
			return render.ingresos (usuario = usuario, form = form)
		else:
			pack_benefit = {"deudas": form.d.deudas,
							"trabajo": form.d.trabajo,
							"premios": form.d.premios,
							"ventas": form.d.ventas,
							"otros": form.d.otros
							}
			coll.insert(pack_benefit)
			#beneficios.insert(pack_benefit)

			#cursor = beneficios.find()
			#for doc in cursor:
			#	print (doc['deuda'], doc['trabajo'], doc['premio'], doc['venta'], doc['otros'])

		return render.givememoney(usuario = usuario, form = form, mensaje = "Beneficios insertados correctamente")

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
