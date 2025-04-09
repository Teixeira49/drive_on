# DRIVE ON 

Evaluación tecnica para optar al puesto de desarrollador **MOBILE** en **Flembee Technologies C. A**.

Enunciado:

[Pruebas_Técnicas.pdf](https://github.com/user-attachments/files/19675511/Pruebas_Tecnicas.pdf)

---

## Primeros pasos

Este proyecto es el punto de partida para una aplicación **Flutter**.

Si nunca antes a utilizado **Flutter**, aqui tiene algunos recursos para empezar:

- [Lab: Escribe tu primera aplicación Flutter](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Ejemplos útiles de Flutter](https://docs.flutter.dev/cookbook)

Para obtener ayuda para comenzar a desarrollar Flutter, consulta la
[Documentación oficial](https://docs.flutter.dev/), que ofrece tutoriales, ejemplos, orientación sobre desarrollo móvil y una referencia completa de la API.

Si aun no ha instalado Flutter, puede utilizar los siguientes tutoriales:

- [YOUTUBE: Como Instalar Flutter en Windows (Paso a Paso 2025)](https://www.youtube.com/watch?v=BTubOBvfEUE)
- [YOUTUBE: 🚀 Prepara el Ambiente de Flutter en MINUTOS: Instalación Completa + Hola Mundo 🌟](https://www.youtube.com/watch?v=9DsKJyEygos)
- [YOUTUBE: Instalando y configurando Dart, Flutter y Android Studio para desarrollo de aplicaciones móviles](https://www.youtube.com/watch?v=-2wcHqLAbsY)
- [YOUTUBE: How to Setup Flutter on Windows 2025 | Fastest Way to Install Flutter and Start Coding in 2025!](https://www.youtube.com/watch?v=ASzu_JzcA34)

---

# 💾 Features del programa

## 🔐 1. Autenticación

1. El sistema permite hacer Login con correo electronico
2. Solo permite acceso a usuarios registrados en el programa

## 👤 2. Perfil

1.  Vista de perfil de usuario que varia segun el rol del usuario
2.  Roles Disponible: Personal y Corporativo
3.  El Rol Corporativo incluye a que dept. pertenece el usuario, y permite acceso a la cartera de seguros

## 📞 3. Contactos de emergencia

1. Vista con la lista de contactos de emergencia
2. Cada contacto incluye Nombre, Telefono y Relacion con el usuario
3. Es posible Agregar, ver, editar y eliminar un contacto de la lista

## 💵 4. Cartera (Solo usuarios corporativos)

1. Vista con el presupuesto del departamento
2. Historial de uso del presupuesto con fechas, montos usados y saldo disponible.

---

# 🧪 Como ejecutar el proyecto

Instale los recursos de **Flutter** y **Node.js**

Descargue y ejecute el siguiente backend:
```
https://github.com/Teixeira49/drive_on_backend
``` 

El Backend correra en su red local, en el puerto 4000

Ejecute su terminal de CMD, e ingrese el siguiente comando
```
ipconfig
```

Copie su direccion **IPv4** y reemplacela en la variable **apiUrl** del archivo **network_url.dart** usando el siguiente formato:
```
http://[your_ip_here]:4000
```

Esto permitira que pueda correr el entorno y la aplicacion conectados

Por ultimo, ejecute el codigo de la app en **Flutter**.
