import MySQLdb as mdb

class DB:
    def __init__(self):
        self.connection = None

    def connect(self):
        self.connection = mdb.connect('localhost', 'root', '1111', 'travels')

    def disconnect(self):
        self.connection.close()
        self.connection = None

    def select(self, table_name):
        self.connect()
        cur = self.connection.cursor(mdb.cursors.DictCursor)
        
        cur.execute('DESCRIBE {0}'.format(table_name))
        fields_response = cur.fetchall()
        fields = []

        for field in fields_response:
            fields.append(field['Field'])

        cur.execute('SELECT * FROM {0}'.format(table_name))
        rows_response = cur.fetchall()
        rows = []

        for raw_row in rows_response:
            row = []
            for field in fields:
                row.append(raw_row[field])
            rows.append(row)

        self.disconnect()

        return {
            'fields': fields,
            'rows': rows,
        }

    def select_travels(self):
        self.connect()
        cur = self.connection.cursor(mdb.cursors.DictCursor)

        fields = ['id', 'city', 'date1', 'date2']

        cur.execute('SELECT travels.id, cities.city AS city, travels.date1, travels.date2 FROM travels, cities WHERE travels.city_id=cities.id')

        rows_response = cur.fetchall()
        rows = []

        for raw_row in rows_response:
            row = []
            for field in fields:
                row.append(raw_row[field])
            rows.append(row)

        self.disconnect()

        return {
            'fields': fields,
            'rows': rows,
        }

    def insert(self, table_name, data):
        self.connect()
        cur = self.connection.cursor(mdb.cursors.DictCursor)

        fields_str = ''
        for i, field in enumerate(data['fields']):
            fields_str += field
            if i < len(data['fields']) - 1:
                fields_str += ','

        for row in data['rows']:
            values_str = ''
            for i, value in enumerate(row):
                values_str += '\'' + str(value) + '\''
                if i < len(row) - 1:
                    values_str += ','

            cur.execute('INSERT INTO {0} ({1}) VALUES ({2})'.format(table_name, fields_str, values_str))

        self.connection.commit()
        self.disconnect()

    def insert_travels(self, city, date1, date2):
        self.connect()
        cur = self.connection.cursor(mdb.cursors.DictCursor)

        cur.execute('INSERT INTO travels (city_id, date1, date2)\
            VALUES ({0}, \'{1}\',\'{2}\')'
            .format(city, date1, date2))
        self.connection.commit()
        self.disconnect()

    def delete_travels(self, id):
        self.connect()
        cur = self.connection.cursor(mdb.cursors.DictCursor)
        print('DELETE FROM travels WHERE id={0}'.format(id))
        cur.execute('DELETE FROM travels WHERE id={0}'.format(id))
        self.connection.commit()
        self.disconnect()
