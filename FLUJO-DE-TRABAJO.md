# Flujo de Trabajo del Repositorio

## 1. Descripción

Este documento describe de manera general el flujo de trabajo utilizado para organizar, desarrollar y versionar los ejercicios realizados durante el **Skill de MySQL II (Bases de Datos)**.

El repositorio está orientado al desarrollo de ejercicios relacionados con una base de datos de un gimnasio y los diferentes temas trabajados durante clase.

La organización busca mantener separados los scripts, ejercicios, evidencias y documentación, permitiendo que cualquier persona que consulte el repositorio pueda comprender cómo está estructurado el proyecto y cómo se llevó a cabo su desarrollo.

Además, el proyecto utiliza **Git** como sistema de control de versiones, aplicando un flujo de trabajo basado en ramas para evitar realizar directamente los cambios sobre la versión principal del proyecto.

Los comandos específicos utilizados durante este proceso se documentan de manera independiente.

---

# 2. Objetivo del flujo de trabajo

El flujo de trabajo tiene como objetivo mantener el repositorio organizado durante todo el proceso de desarrollo.

Se busca que cada cambio realizado pueda ser identificado, revisado y relacionado con una parte específica del proyecto.

Para esto se establecen principalmente las siguientes prácticas:

- Mantener una estructura de carpetas organizada.
- Separar los diferentes temas trabajados en clase.
- Mantener la documentación junto con el proyecto.
- Utilizar ramas independientes para el desarrollo.
- Evitar trabajar directamente sobre la rama principal.
- Integrar los cambios de manera controlada.
- Mantener una versión estable del proyecto.
- Facilitar la revisión del trabajo realizado.

---

# 3. Estructura general del repositorio

La estructura actual del repositorio es:

```text
REVIEW-EJERCICIOS-DE-CLASE/
│
├── ejercicio-de-review-en-clase/
│   └── gimnasio/
│       └── base-de-datos/
│           └── resoluciones/
│               └── lester-garcia/
│                   │
│                   ├── ddl/
│                   ├── dml/
│                   ├── dql/
│                   ├── eventos/
│                   ├── evidencia/
│                   ├── funciones/
│                   ├── normalizacion-4FN/
│                   ├── procedimientos-almacenados/
│                   ├── seguridad y permisos/
│                   ├── transacciones/
│                   ├── triggers/
│                   └── README.md
│
├── README.md
└── FLUJO-DE-TRABAJO.md