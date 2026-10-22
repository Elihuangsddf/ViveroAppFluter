# 🌱 ViveroA

¡Bienvenido a **ViveroA**! Este es un proyecto desarrollado con **Flutter** que crecerá, cambiará y mejorará durante los próximos **4 meses**.

La idea es comenzar con una base sencilla e ir incorporando nuevas pantallas, funcionalidades y aprendizajes conforme avance el desarrollo. Este repositorio será la bitácora de todo ese proceso: desde los primeros widgets hasta una aplicación más completa y pulida. 🚀

## 📆 Un proyecto en evolución

Durante cuatro meses, ViveroA avanzará por distintas etapas:

- 🌱 **Mes 1 — Sembrar:** estructura inicial, diseño y fundamentos de Flutter.
- 🌿 **Mes 2 — Crecer:** nuevas pantallas, navegación y manejo de datos.
- 🌼 **Mes 3 — Florecer:** funcionalidades principales, validaciones y mejoras visuales.
- 🌳 **Mes 4 — Consolidar:** pruebas, optimización, detalles finales y publicación.

> El proyecto está en desarrollo activo, por lo que encontrarás cambios frecuentes y nuevas ideas en cada versión.

## 🛠️ Tecnologías

- [Flutter](https://flutter.dev/) para construir la aplicación.
- [Dart](https://dart.dev/) como lenguaje de programación.
- Git y GitHub para registrar y compartir cada avance.

## ▶️ Ejecutar el proyecto

Necesitas tener Flutter instalado y un emulador o dispositivo disponible.

```bash
flutter pub get
flutter run
```

También puedes comprobar que tu entorno esté listo con:

```bash
flutter doctor
```

## Configuración local de Firebase

Los archivos `lib/firebase_options.dart`, `android/app/google-services.json` y
`firebase.json` se generan para cada proyecto de Firebase y no se incluyen en
Git. Antes de ejecutar la app web o Android en un clon nuevo:

1. Instala la [Firebase CLI](https://firebase.google.com/docs/cli) y ejecuta
   `firebase login` con una cuenta que tenga acceso a tu proyecto.
2. Instala FlutterFire CLI con `dart pub global activate flutterfire_cli`.
3. En la raíz de este proyecto ejecuta `flutterfire configure` y selecciona el
   proyecto y las plataformas **Android** y **Web**.
4. Ejecuta `flutter pub get` y `flutter run -d chrome` (o selecciona Android).

Las claves de configuración de Firebase para aplicaciones cliente identifican
el proyecto; no conceden acceso por sí solas. Protege los datos con Firebase
Security Rules, App Check y restricciones de API. Nunca incluyas claves de
cuentas de servicio, contraseñas ni tokens privados en el código Flutter.

## 🧭 Objetivo

Más que llegar rápidamente al resultado final, este proyecto busca mostrar una evolución real: experimentar, aprender, equivocarse, mejorar y documentar el camino.

Cada commit será una pequeña hoja nueva. 🍃
