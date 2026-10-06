# Buscador-de-Direcciones
Aplicación web simple que busca asentamientos (colonias, fraccionamientos, etc.) en la base de datos MariaDB y autocompleta Municipio, Estado y CP.

## 1. Instalar dependencias

```bash
pip install -r requirements.txt
```

## 2. Configurar la conexión a tu base de datos

Abre `app.py` y edita el diccionario `DB_CONFIG` con tus datos reales:

```python
DB_CONFIG = {
    'host': 'localhost',
    'user': 'tu_usuario',
    'password': 'tu_password',
    'database': 'tu_base_de_datos',
    ...
}
```

## 3. Verificar el nombre de tu tabla y columnas

El código asume una tabla llamada `codigos_postales` con las columnas:
`CP, Asentamiento, Tipo_Asentamiento, Municipio, Estado`
(tal como quedaron en tu tabla actual). Si tu tabla o columnas se llaman
distinto, ajusta la consulta SQL dentro de `app.py` en la función `buscar()`.

## 4. Ejecutar la aplicación

```bash
python app.py
```

Abre tu navegador en: http://127.0.0.1:5000

## Cómo funciona

1. Escribes al menos 2 letras en el campo de búsqueda.
2. El JavaScript del frontend espera 300ms (para no saturar con cada tecla)
   y manda la petición a `/buscar?q=...`.
3. Flask recibe el término, hace un `SELECT ... WHERE Asentamiento LIKE '%termino%'`
   contra MariaDB y regresa hasta 10 resultados en JSON.
4. Al hacer clic en un resultado, se autocompletan Municipio, Estado y CP
   en pantalla.
