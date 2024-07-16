from django.db import connection
from django.http import HttpResponse
from django.shortcuts import render, redirect
from jose_sepulveda.models import Cliente, Factura, Facturahasropa, Ropa
from django.core.files.storage import FileSystemStorage 
from django.core.serializers import serialize
from django.contrib.auth.models import User
from django.contrib.auth import login,authenticate,logout

def home(request):
    return render(request,"home/home.html")

#region clientes

def insertarcliente(request):
    if not request.user.is_authenticated:
        return redirect('/usuarios/login')
    if request.method=="POST":
        if request.POST.get("nombre_cliente") and request.POST.get("apellido_cliente") and request.POST.get("cedula") and request.POST.get("telefono") and request.POST.get("correo") and request.POST.get("direccion"):
            clientes = Cliente()
            clientes.nombre_cliente =request.POST.get("nombre_cliente")
            clientes.apellido_cliente =request.POST.get("apellido_cliente")
            clientes.cedula =request.POST.get("cedula")
            clientes.telefono =request.POST.get("telefono")
            clientes.correo =request.POST.get("correo")
            clientes.direccion =request.POST.get("direccion")
            clientes.estado_cliente=("Activo")
            clientes.save()
            return redirect("/cliente/listadoc")
    else: 
        return render(request,"cliente/insertarc.html")
    
def listadocliente(request):
    clientes = connection.cursor()
    clientes.execute("call listadocliente ()")
    return render(request, "cliente/listadoc.html",{'clientes':clientes})

def listadoclientei(request):
    clientes = connection.cursor()
    clientes.execute("call listadoclientei ()")
    return render(request, "cliente/listadoi.html",{'clientes':clientes})

def activarcliente(request, idcliente):
    clientes = connection.cursor()
    clientes.execute("call activarcliente ('"+str(idcliente)+"')")
    return redirect("/cliente/listadoi")

def inactivarcliente(request, idcliente):
    clientes = connection.cursor()
    clientes.execute("call inactivarcliente ('"+str(idcliente)+"')")
    return redirect("/cliente/listadoc") 

def actualizarcliente(request,id):
    if request.method=="POST":
        if request.POST.get("nombre_cliente") and request.POST.get("apellido_cliente") and request.POST.get("cedula") and request.POST.get("telefono") and request.POST.get("correo") and request.POST.get("direccion"):
            clientes = Cliente.objects.get(id=id)
            clientes.nombre_cliente =request.POST.get("nombre_cliente")
            clientes.apellido_cliente =request.POST.get("apellido_cliente")
            clientes.cedula =request.POST.get("cedula")
            clientes.telefono =request.POST.get("telefono")
            clientes.correo =request.POST.get("correo")
            clientes.direccion =request.POST.get("direccion")
            clientes.save()
            return redirect("/cliente/listadoc")
    else: 
        clientes = Cliente.objects.filter(id=id)
        return render(request,'cliente/actualizarc.html',{'clientes':clientes})
    
def consultarclienteapi(request,cedulaconsultar):
    cliente = Cliente.objects.filter(cedula=cedulaconsultar)
    jsoncliente = serialize('json', cliente)
    return HttpResponse(jsoncliente, content_type="application/json")

#endregion

#region ropa

def insertarropa(request):
    if not request.user.is_authenticated:
        return redirect('/usuarios/login')
    if request.method=="POST":
        if request.POST.get("nombre_prenda") and request.POST.get("tipo_prenda") and request.POST.get("talla") and request.POST.get("color") and request.POST.get("descripcion") and request.FILES["foto"] and request.POST.get("precio") and request.POST.get("material") and request.POST.get("marca") and request.POST.get("recomendaciones") and request.POST.get("unidades") and request.POST.get("proveedor") and request.POST.get("instrucciones") and request.POST.get("pais_origen") and request.POST.get("empaque") and request.POST.get("sku") and request.POST.get("descuento"):
            ropa = Ropa()
            ropa.nombre_prenda =request.POST.get("nombre_prenda")
            ropa.tipo_prenda =request.POST.get("tipo_prenda")
            ropa.talla =request.POST.get("talla")
            ropa.color =request.POST.get("color")
            ropa.descripcion =request.POST.get("descripcion")
            ropa.foto =request.FILES['foto']
            ropa.precio =request.POST.get("precio")
            ropa.material =request.POST.get("material")
            ropa.marca =request.POST.get("marca")
            ropa.recomendaciones =request.POST.get("recomendaciones")
            ropa.unidades =request.POST.get("unidades")
            ropa.proveedor =request.POST.get("proveedor")
            ropa.instrucciones =request.POST.get("instrucciones")
            ropa.pais_origen =request.POST.get("pais_origen")
            ropa.empaque =request.POST.get("empaque")
            ropa.sku =request.POST.get("sku")   
            ropa.descuento =request.POST.get("descuento")
            imagen = FileSystemStorage()
            imagen.save(ropa.foto.name,ropa.foto)
            insertar = connection.cursor()
            insertar.execute("call insertarropa('"+ropa.nombre_prenda+"','"+ropa.tipo_prenda+"','"+ropa.talla+"','"+ropa.color+"','"+ropa.descripcion+"','"+ropa.foto.name+"','"+ropa.precio+"','"+ropa.material+"','"+ropa.marca+"','"+ropa.recomendaciones+"','"+ropa.unidades+"','"+ropa.proveedor+"','"+ropa.instrucciones+"','"+ropa.pais_origen+"','"+ropa.empaque+"','"+ropa.sku+"','"+ropa.descuento+"')")
            return redirect("/ropa/listadoa")
    else: 
        return render(request,"ropa/insertar.html")
    
def prendasactivas(request):
    if not request.user.is_authenticated:
        return redirect('/usuarios/login')
    ropa = connection.cursor()
    ropa.execute("call prendasactivas ()")
    return render(request, "ropa/listadoa.html",{'ropa':ropa})

def prendasinactivas(request):
    if not request.user.is_authenticated:
        return redirect('/usuarios/login')
    ropa = connection.cursor()
    ropa.execute("call prendasinactivas ()")
    return render(request, "ropa/listadoi.html",{'ropa':ropa})

def activarprenda(request, idropa):
    ropa = connection.cursor()
    ropa.execute("call activarprenda ('"+str(idropa)+"')")
    return redirect("/ropa/listadoi")

def inactivarprenda(request, idropa):
    ropa = connection.cursor()
    ropa.execute("call inactivarprenda ('"+str(idropa)+"')")
    return redirect("/ropa/listadoa") 

def actualizarprenda(request,idropa):
    if request.method=="POST":
        if request.POST.get("nombre_prenda") and request.POST.get("tipo_prenda") and request.POST.get("talla") and request.POST.get("color") and request.POST.get("descripcion") and request.POST.get("precio") and request.POST.get("material") and request.POST.get("marca") and request.POST.get("recomendaciones") and request.POST.get("unidades") and request.POST.get("proveedor") and request.POST.get("instrucciones") and request.POST.get("pais_origen") and request.POST.get("empaque") and request.POST.get("sku") and request.POST.get("descuento"):
            ropa = Ropa()
            ropa.nombre_prenda =request.POST.get("nombre_prenda")
            ropa.tipo_prenda =request.POST.get("tipo_prenda")
            ropa.talla =request.POST.get("talla")
            ropa.color =request.POST.get("color")
            ropa.descripcion =request.POST.get("descripcion")
            ropa.precio =request.POST.get("precio")
            ropa.material =request.POST.get("material")
            ropa.marca =request.POST.get("marca")
            ropa.recomendaciones =request.POST.get("recomendaciones")
            ropa.unidades =request.POST.get("unidades")
            ropa.proveedor =request.POST.get("proveedor")
            ropa.instrucciones =request.POST.get("instrucciones")
            ropa.pais_origen =request.POST.get("pais_origen")
            ropa.empaque =request.POST.get("empaque")
            ropa.sku =request.POST.get("sku")
            ropa.descuento =request.POST.get("descuento")
            insertar = connection.cursor()
            try:

             if request.FILES["foto"]:
                 ropa.foto =request.FILES['foto']
                 unaropa = Ropa.objects.get(id=idropa)
                 fs = FileSystemStorage()
                 fs.delete(unaropa.foto)
                 ropa.foto =request.FILES['foto']
                 fs.save(ropa.foto.name,ropa.foto)
                 insertar.execute("call actualizarprenda('"+str(idropa)+"','"+ropa.nombre_prenda+"','"+ropa.tipo_prenda+"','"+ropa.talla+"','"+ropa.color+"','"+ropa.descripcion+"','"+ropa.foto.name+"','"+ropa.precio+"','"+ropa.material+"','"+ropa.marca+"','"+ropa.recomendaciones+"','"+ropa.unidades+"','"+ropa.proveedor+"','"+ropa.instrucciones+"','"+ropa.pais_origen+"','"+ropa.empaque+"','"+ropa.sku+"','"+ropa.descuento+"')")
            except:
                insertar.execute("call actualizarprenda('"+str(idropa)+"','"+ropa.nombre_prenda+"','"+ropa.tipo_prenda+"','"+ropa.talla+"','"+ropa.color+"','"+ropa.descripcion+"','"+request.POST.get("fotovieja")+"','"+ropa.precio+"','"+ropa.material+"','"+ropa.marca+"','"+ropa.recomendaciones+"','"+ropa.unidades+"','"+ropa.proveedor+"','"+ropa.instrucciones+"','"+ropa.pais_origen+"','"+ropa.empaque+"','"+ropa.sku+"','"+ropa.descuento+"')")
            return redirect("/ropa/listadoa")
    else:
        ropa = Ropa.objects.filter(id=idropa)
        return render(request,"ropa/actualizar.html",{'ropa':ropa}) 

#endregion


#region factura

def insertarfactura(request):
    if request.method=="POST":
        if request.POST.get("idcliente") and request.POST.get("fechafactura") and request.POST.get("metodo_pago") and request.POST.get("descripcion") and request.POST.get("totalfacturainput") and request.POST.get("idprendatabla[]") and request.POST.get("cantidadprendatabla[]"):
            factura = Factura()
            factura.fecha = request.POST.get('fechafactura')
            factura.metodo_pago = request.POST.get('metodo_pago')
            factura.descripcion = request.POST.get('descripcion')
            factura.estado = ("Pendiente")
            factura.total = request.POST.get('totalfacturainput')
            factura.cliente = Cliente.objects.get(id=request.POST.get('idcliente'))
            factura.save()
            consulta = connection.cursor()
            consulta.execute('call consultarultimafactura()')
            idfacturaultimo = 0
            for c in consulta:
                idfacturaultimo = c[0]
            arrayidprenda = request.POST.getlist('idprendatabla[]')
            arraycantidad = request.POST.getlist('cantidadprendatabla[]')
            for r in range (0,len(arrayidprenda),1):
                facturahasropa = Facturahasropa()
                facturahasropa.cantidad = arraycantidad[r]
                facturahasropa.factura = Factura.objects.get(id=idfacturaultimo)
                facturahasropa.ropa = Ropa.objects.get(id=arrayidprenda[r])
                facturahasropa.save()
            return redirect("/factura/listadof")
    else:
        ropa = Ropa.objects.all()
        return render(request, "factura/insertarf.html",{'ropa':ropa})

def listadofactura(request):
    factura =Factura.objects.all()
    return render(request,'factura/listadof.html',{'factura':factura})

def detallefactura(request,idfactura):
    detalle = connection.cursor()
    detalle.execute("call detallefactura('"+str(idfactura)+"')")
    factura = Factura.objects.all()
    return render(request,'factura/detallef.html',{'detalle':detalle, 'factura':factura})

#endregion


#region usuarios

def insertarusuario(request):
    if request.method=="POST":
        if request.POST.get("username") and request.POST.get("first_name") and request.POST.get("last_name") and request.POST.get("email") and request.POST.get("password"):
            usuario = User.objects.create_user(request.POST.get('username'),request.POST.get('email'),request.POST.get('password'))
            usuario.first_name = request.POST.get('first_name')
            usuario.last_name = request.POST.get('last_name')
            usuario.save()
            return redirect('/usuarios/login')
    else:
        return render(request,'usuarios/insertaru.html')

def ingresarusuario(request):
    if request.method=="POST":
        if request.POST.get("username") and request.POST.get("password"):
            usuario = authenticate(username=request.POST.get("username"),password=request.POST.get("password"))
            if usuario is not None:
                login(request,usuario)
                return redirect('/')
            else:
                mensaje = "Usuarios o Contraseña Incorrectos, Intenta de nuevo bby"
                return render(request,'usuarios/login.html',{'mensaje':mensaje})
    return render(request,'usuarios/login.html')

def cerrarusuario(request):
    logout(request)
    return redirect('/usuarios/login')


#endregion