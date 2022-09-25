import mysql.connector
cnx = mysql.connector.connect(user='root',
                             password='',
                             host='localhost',
                             database='oto_db')
cursor = cnx.cursor()

def executeScriptsFromFile(filename):
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

executeScriptsFromFile('sql_scripts/summarize.sql')
cnx.commit()