# Proyecto GDV

## Requisitos para el correcto funcionamiento

Para asegurar el correcto funcionamiento del proyecto, se debe tener en cuenta lo siguiente:

### Configuración del Servidor

Es necesario configurar un servidor **Tomcat 10.1**. Los ajustes requeridos para dicho servidor son los siguientes:

#### Ajustes en el archivo `server.xml`

1. **Server port**: `8005`
2. **Connection port**: `8008`

### Ejemplo de configuración

A continuación se muestra un ejemplo de cómo debería verse la configuración en el archivo `server.xml`:

```xml
<Server port="8005" shutdown="SHUTDOWN">
  <Service name="Catalina">
    <Connector port="8008" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
    <!-- Otros ajustes del servidor -->
  </Service>
</Server>
