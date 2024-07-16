"""
URL configuration for jose_sepulveda project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from jose_sepulveda.views import home,insertarcliente,listadocliente,listadoclientei,actualizarcliente,activarcliente,inactivarcliente,insertarropa,prendasactivas,prendasinactivas,activarprenda,inactivarprenda,actualizarprenda, insertarfactura, detallefactura,listadofactura,consultarclienteapi,insertarusuario,ingresarusuario,cerrarusuario

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',home),

    path('cliente/insertarc',insertarcliente),
    path('cliente/listadoc',listadocliente),
    path('cliente/listadoi',listadoclientei),
    path('cliente/activar/<int:idcliente>',activarcliente),
    path('cliente/inactivar/<int:idcliente>',inactivarcliente),
    path('cliente/actualizarc/<int:id>',actualizarcliente),
    path('cliente/Api/<int:cedulaconsultar>',consultarclienteapi),

    path('ropa/insertar',insertarropa),
    path('ropa/listadoa',prendasactivas),
    path('ropa/listadoi',prendasinactivas),
    path('ropa/activar/<int:idropa>',activarprenda),
    path('ropa/inactivar/<int:idropa>',inactivarprenda),
    path('ropa/actualizar/<int:idropa>',actualizarprenda),

    path('factura/insertarf',insertarfactura),
    path('factura/listadof',listadofactura),
    path('factura/detallef/<int:idfactura>',detallefactura),

    path('usuarios/insertaru',insertarusuario),
    path('usuarios/login',ingresarusuario),
    path('usuarios/logout',cerrarusuario),

]
