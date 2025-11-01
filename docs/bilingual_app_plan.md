# Plan de Aplicación Educativa Bilingüe (Español-Inglés)

## 1. Propósito del documento
Definir un plan de ejecución accionable para construir una aplicación educativa bilingüe (español-inglés) destinada a niños de 6 a 8 años, alineando objetivos pedagógicos con hitos técnicos y operativos.

## 2. Resultados de aprendizaje y métricas
| Resultado esperado | Indicadores cuantitativos | Instrumentos |
| --- | --- | --- |
| Conciencia fonémica y decodificación en ambos idiomas | ≥80 % de aciertos en juegos de identificación de sonidos tras 4 semanas | Juegos fonéticos con analítica en tiempo real |
| Fluidez en palabras de alta frecuencia | ≥30 palabras de uso frecuente reconocidas automáticamente por sesión | Evaluaciones semanales de sight words |
| Comprensión lectora básica | ≥70 % de respuestas correctas en quizzes posteriores a historias | Juegos de comprensión con registro de progreso |
| Motivación sostenida | Retención semanal ≥60 %, racha promedio de 3 días | Sistema de logros y misiones |

## 3. Experiencia educativa
### 3.1 Módulos fonéticos
| Iteración | Español | Inglés | Entregables |
| --- | --- | --- | --- |
| Sprint 1 | Vocales y consonantes continuas (m, s, l) | Vocales cortas /ă/, /ĕ/, /ĭ/, /ŏ/, /ŭ/ | Juegos de emparejar sonido-letra, animaciones de boca |
| Sprint 2 | Sílabas abiertas (ma, me, mi…) | Blends iniciales (sh, ch, th) | Minijuegos de arrastrar sílabas, pares mínimos |
| Sprint 3 | Sílabas trabadas (pla, tra) | Vocales largas con patrones CVCe | Módulo de comparación español-inglés con feedback de voz |

### 3.2 Palabras de alta frecuencia
- Listas objetivo: Dolch (Pre-Primer, Primer) y corpus CREA inicial.
- Flujo por palabra: introducción animada → práctica en contexto → reto de escritura rápida → revisión espaciada automática.
- Automatización: scheduler de repetición espaciada configurable por dificultad.

### 3.3 Lectura contextual
- Biblioteca inicial de 10 historias originales con ilustraciones propias.
- Modo karaoke con resaltado palabra a palabra y opción de repetir frases.
- Actividades posteriores: ordenar eventos, identificar emoción del personaje, completar diálogo bilingüe.

## 4. Diseño de producto
### 4.1 Estructura de navegación
1. **Inicio**: mascota guía, botón de continuar lección, acceso a biblioteca y juego libre.
2. **Mapa de mundos**: tres mundos (Granja, Bosque, Ciudad) con 5 lecciones cada uno; desbloqueo condicionado.
3. **Juego libre**: catálogo filtrable por habilidad (fonética, vocabulario, historias, voz).
4. **Panel familiar**: métricas clave, recomendaciones de práctica en casa y control de tiempo de uso.

### 4.2 Componentes reutilizables
- `LessonCarousel`: gestiona secuencia de minijuegos con guardado incremental.
- `RewardOverlay`: capa de animaciones y feedback configurable (estrellas, stickers, avatar).
- `StoryPlayer`: reproductor de historias con subtítulos sincronizados, control de idioma y narración.
- `ProgressTracker`: servicios para registrar eventos pedagógicos y alimentar dashboards.

## 5. Arquitectura técnica
### 5.1 Stack propuesto
- **Frontend**: Flutter 3.x, arquitectura MVVM con Riverpod para estado.
- **Backend ligero**: Firebase (Auth anónimo, Firestore para progreso, Storage para assets). Alternativa self-hosted: Supabase.
- **Contenidos**: Gestión con Google Sheets + scripts de ingesta a JSON, convertidos mediante pipeline CI.
- **Analítica**: Firebase Analytics + exportación a BigQuery para dashboards Looker Studio.
- **CI/CD**: GitHub Actions (build Android/iOS/Web), Fastlane para despliegues.

### 5.2 Módulos principales
| Módulo | Responsabilidades | Dependencias |
| --- | --- | --- |
| `core/audio` | reproducción, TTS, efectos | paquetes `just_audio`, `flutter_tts` |
| `core/speech` | reconocimiento básico de palabras | plugin `speech_to_text`, fallback manual |
| `features/phonics` | juegos de fonética, lógica de niveles | `core/audio`, `core/progress` |
| `features/stories` | biblioteca, quizzes, narración | `core/audio`, `core/ui` |
| `features/rewards` | catálogo de logros, avatar | `core/progress`, `core/storage` |
| `core/progress` | sincronización con backend, análisis offline | Firestore/Supabase |

### 5.3 Integración de contenido
1. Redactar guiones y guías de pronunciación → aprobar por pedagogo.
2. Ilustraciones en lotes de 5 historias → exportar a SVG/PNG.
3. Grabación de audio (español neutro, inglés nativo) → limpieza y normalización.
4. Script `tools/content_builder.dart` compila assets y genera paquetes por idioma.
5. Validación automática mediante tests de contenido (campos obligatorios, duración de audio).

## 6. Backlog inicial (12 semanas)
| Sprint | Objetivos | Historias clave |
| --- | --- | --- |
| 0 – Preparación | Repositorio, CI/CD, definición de estilo UI, guías pedagógicas | `ENG-1` Configurar Flutter + CI, `EDU-1` Definir currículo detallado |
| 1 | MVP fonética español, navegación básica, auth anónimo | `APP-1` Pantalla inicio, `PHO-1` Juego escuchar-letra, `CORE-1` Persistencia local |
| 2 | MVP fonética inglés, RewardOverlay, módulo progreso | `PHO-3` Pares mínimos bilingües, `RWD-1` Recompensas básicas |
| 3 | Palabras frecuentes nivel 1, integración audio TTS | `VOC-1` Tarjetas interactivas, `AUD-1` Reproductor offline |
| 4 | Historias 1-3, StoryPlayer, quizzes | `STO-1` Lector karaoke, `CMP-1` Quiz comprensión |
| 5 | Reconocimiento de voz básico, panel familiar beta | `SPE-1` Evaluación lectura palabra, `PAR-1` Reporte semanal |
| 6 | Beta cerrada: monitoreo y ajustes UX, accesibilidad | `UX-3` Tests con niños, `ACC-1` Modos alto contraste |

## 7. Estrategia de pruebas
- **Unitarias**: lógica de juegos, cómputo de puntajes, scheduler de repetición.
- **Widget/UI**: Golden tests para consistencia visual, interacción con dispositivos táctiles.
- **Integración**: flujo de lección completo, sincronización progreso offline/online.
- **Pruebas con usuarios**: sesiones quincenales con checklist de usabilidad (tiempo de tarea, comprensión de instrucciones, diversión percibida).
- **QA de contenido**: checklist pedagógico (exactitud fonética, nivel de vocabulario, neutralidad cultural).

## 8. Operación y lanzamiento
- **Beta interna** (Semana 10): distribución por TestFlight y Google Play Internal Testing.
- **Beta pública** (Semana 12): lanzamiento regional con campaña de email a escuelas piloto.
- **Monitoreo**: panel en Looker Studio (retención, logros completados, errores de voz).
- **Soporte**: canal Zendesk/HelpScout con SLA de 48 h, base de conocimiento para familias.

## 9. Escalamiento posterior
- Añadir cuarto mundo (Historias largas) y minijuegos colaborativos con modo familiar.
- Localización de contenidos culturales (festividades, nombres propios) según región.
- Programa de suscripción premium con biblioteca ampliada y modo sin conexión total.

## 10. Riesgos y mitigaciones
| Riesgo | Impacto | Mitigación |
| --- | --- | --- |
| Complejidad del reconocimiento de voz en niños | Retroalimentación inexacta | Prototipo temprano, fallback a autocorrección manual, calibración por edad |
| Producción de contenido lenta | Retraso de lanzamientos | Pipeline semanal con proveedores externos y control de versiones |
| Sobrecarga cognitiva por mezcla de idiomas | Desmotivación | Alternar idiomas por lección, incluir tutoriales guiados, monitorear métricas |
| Requisitos de privacidad infantil (COPPA/GDPR-K) | Riesgo legal | Revisar con asesor legal, anonimizar datos, controles parentales estrictos |

## 11. Seguridad informática y protección de datos
- **Gobernanza y cumplimiento**: aplicar políticas alineadas con COPPA, GDPR-K y la Ley de Protección de Datos local. Registro de actividades de tratamiento y evaluación de impacto antes de la beta pública.
- **Arquitectura segura**: cifrado en tránsito (HTTPS/TLS 1.2+) y en reposo (Cloud KMS para claves de Firestore/Storage). Separar cuentas de servicio por entorno (dev, staging, prod) con principio de mínimo privilegio.
- **Protección de identidades**: autenticación anónima rotativa para niños y portal parental con MFA opcional. Tokens expiran cada 24 h y se revocan automáticamente si se detecta uso anómalo.
- **Seguridad de contenidos y telemetría**: sanitizar toda entrada de usuario, validar assets en pipeline CI para evitar código malicioso. Limitar analítica a métricas agregadas y pseudonimizadas.
- **Monitoreo y respuesta**: integrar Firebase App Check / DeviceCheck, alertas de Cloud Logging y plan de respuesta a incidentes con SLA <24 h para contención. Ejercicios semestrales de simulación.
- **Privacidad del menor**: panel parental con controles de consentimiento, exportación/borrado de datos bajo solicitud y modo sin conexión que almacena progreso solo en dispositivo con cifrado nativo.

## 12. Próximos pasos inmediatos
1. Aprobar este plan con stakeholders (producto, pedagogía, ingeniería).
2. Asignar roles clave (Product Manager, Lead Pedagógico, Tech Lead, Diseñador UX, Artista, QA).
3. Configurar repositorio Flutter con plantillas iniciales, branding y herramientas de calidad (lint, formatter, tests base).
4. Producir primer lote de contenidos (5 sonidos, 10 palabras, 1 historia) para pruebas internas.
5. Agendar sesiones quincenales de validación con niños y familias piloto.

