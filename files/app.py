from flask import Flask, render_template, request, jsonify
import pymysql

app = Flask(__name__)

# -----------------------------------------------------
# AJUSTA ESTOS DATOS CON LOS DE TU BASE DE DATOS LOCAL
# -----------------------------------------------------
DB_CONFIG = {
    'host': 'localhost',
    'user': 'user-name',
    'password': 'user-password',
    'database': 'CodigosPostales',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}


def get_connection():
    return pymysql.connect(**DB_CONFIG)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/buscar')
def buscar():
    """
    Recibe parte de un asentamiento (colonia/fraccionamiento) y regresa
    las coincidencias con su Municipio, Estado y CP.
    Ejemplo de uso desde el navegador: /buscar?q=centro
    """
    termino = request.args.get('q', '').strip()

    # Evita consultar la base con 1 sola letra (resultados demasiado amplios)
    if len(termino) < 2:
        return jsonify([])

    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = """
                SELECT CP, Asentamiento, Tipo_Asentamiento, Municipio, Estado
                FROM codigos_postales
                WHERE Asentamiento LIKE %s
                ORDER BY Asentamiento
                LIMIT 10
            """
            cursor.execute(sql, (f'%{termino}%',))
            resultados = cursor.fetchall()
    finally:
        conn.close()

    return jsonify(resultados)


if __name__ == '__main__':
    app.run(debug=True)
