from django.db import models

class Cliente(models.Model):
    nombre_cliente = models.CharField(max_length=225)
    apellido_cliente = models.CharField(max_length=225)
    cedula = models.CharField(max_length=25) 
    telefono = models.CharField(max_length=255)
    correo = models.CharField(max_length=255)
    direccion = models.CharField(max_length=255)
    estado_cliente = models.CharField(max_length=255)
    class Meta:
        db_table = 'cliente'

class Ropa(models.Model):
    nombre_prenda = models.CharField(max_length=225)
    tipo_prenda = models.CharField(max_length=225)
    talla = models.CharField(max_length=10) 
    color = models.CharField(max_length=255)
    descripcion = models.CharField(max_length=255)
    foto = models.CharField(max_length=255)
    precio = models.BigIntegerField()
    material = models.CharField(max_length=255)
    marca = models.CharField(max_length=255)
    recomendaciones = models.CharField(max_length=255)
    unidades = models.CharField(max_length=255)
    fecha_ingreso = models.DateField()
    proveedor = models.CharField(max_length=255)
    pais_origen = models.CharField(max_length=255)
    instrucciones = models.CharField(max_length=255)
    empaque = models.CharField(max_length=255)
    sku = models.CharField(max_length=255)
    descuento = models.CharField(max_length=255)
    class Meta:
        db_table = 'ropa'

class Factura(models.Model):
    fecha = models.CharField(max_length=225)
    total = models.CharField(max_length=225)
    estado = models.CharField(max_length=255) 
    metodo_pago = models.CharField(max_length=255)
    descripcion = models.CharField(max_length=255)
    cliente = models.ForeignKey(Cliente, on_delete=models.CASCADE)
    class Meta:
        db_table = 'factura'

class Facturahasropa(models.Model):
    factura = models.ForeignKey(Factura, on_delete=models.CASCADE)
    ropa = models.ForeignKey(Ropa, on_delete=models.CASCADE)
    cantidad = models.IntegerField()
    class Meta:
        db_table = 'facturahasropa'