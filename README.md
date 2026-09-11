# BaseDeDatos-U1-Ej06-GestionProyectos

Base de Datos - Unidad 1 - Ejercicio 6

Consigna

Modelar el sistema interno de una consultora de software: proyectos descompuestos en fases y tareas, empleados con perfil técnico que ejecutan esas tareas registrando horas reales trabajadas, y recursos materiales (hardware y software) asignados temporalmente a los proyectos.

Lógica

Jerarquía PROYECTO → FASE → TAREA (composición 1:N encadenada). La fase no existe sin su proyecto y la tarea no existe sin su fase: son dependencias de existencia. La tarea se cuelga de la fase y no directamente del proyecto porque la consigna dice que cada fase contiene su conjunto de tareas; el proyecto llega a sus tareas por transitividad, sin necesidad de una FK redundante Id_Proyecto en TAREA (eso permitiría inconsistencias donde la tarea apunta a un proyecto distinto al de su fase).

PERFIL-TECNICO como entidad, no como atributo de EMPLEADO. El enunciado da ejemplos cerrados (Backend, UX, Tester QA, DevOps), o sea un catálogo finito y reutilizable. Como entidad se evita repetir el texto en cada empleado y se puede filtrar por perfil al asignar recursos humanos. Cardinalidad PERFIL 1:N EMPLEADO porque el enunciado habla de un perfil principal: cada empleado tiene uno solo.

Empleado ↔ Tarea: N:M resuelta con empleado-tarea. Un empleado trabaja en varias tareas y una tarea puede tener varios empleados según su complejidad. horas_trabajadas va en la intermedia porque no es un dato del empleado (trabaja distinta cantidad en cada tarea) ni de la tarea (cada empleado aporta distinto): es un atributo del hecho de la asignación. Con fecha_registro además se puede auditar la carga de horas.

Proyecto ↔ Recurso: N:M con proyecto-recurso. La clave está en la palabra "temporalmente": un mismo equipo o licencia se presta a un proyecto, se libera y después va a otro. Si fuera N:1 (recurso con una sola FK de proyecto) se perdería el histórico de asignaciones al reasignarlo. Por eso la intermedia guarda fecha_asignacion y fecha_devolucion, que delimitan el período de uso.

Integridad referencial. Cada entidad tiene PK propia subrayada (codigo_proyecto, codigo_fase, codigo_tarea, legajo, codigo_perfil, numero_inventario). Las intermedias llevan ID propio más las dos FK, sobre las que conviene declarar un UNIQUE compuesto para evitar duplicados (un empleado cargado dos veces en la misma tarea). Los borrados en cascada aplican hacia abajo en la jerarquía (borrar un proyecto arrastra fases y tareas), mientras que la baja de un empleado o un recurso debería restringirse mientras tenga registros en las intermedias, para no perder las horas ya imputadas.

Resultado
<img width="3300" height="2880" alt="BaseDeDatos-U1-Ej06-GestionProyectos" src="https://github.com/user-attachments/assets/1dcf67b4-fb71-404b-8273-cbf76625546f" />
