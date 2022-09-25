import mysql.connector
cnx = mysql.connector.connect(user='root',
                             password='',
                             host='localhost',
                             database='oto_db')
cursor = cnx.cursor()

def f_new_client(filename):
    fd = open(filename, 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')

    for command in sqlCommands:
        try:
            if command.strip() != '':
                cursor.execute(command)
        except IOError as msg:
            print(msg)

f_new_client('sql_functions/f_new_client.sql')
cnx.commit()

def f_inativate_client(filename):
    fd = open(filename, 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')

    for command in sqlCommands:
        try:
            if command.strip() != '':
                cursor.execute(command)
        except IOError as msg:
            print(msg)

f_inativate_client('sql_functions/f_inativate_client.sql')
cnx.commit()

def f_lost_client(filename):
    fd = open(filename, 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')

    for command in sqlCommands:
        try:
            if command.strip() != '':
                cursor.execute(command)
        except IOError as msg:
            print(msg)

f_lost_client('sql_functions/f_lost_client.sql')
cnx.commit()