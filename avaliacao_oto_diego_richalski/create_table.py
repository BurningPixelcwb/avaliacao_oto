import mysql.connector
import pandas as pd
from sqlalchemy import create_engine

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="oto_db"
)

mycursor = mydb.cursor()

mycursor.execute("CREATE TABLE if not exists compras (cliente INT, data_compra DATE, valor DECIMAL(6,2))")
mycursor.execute("truncate compras")


d = {'cliente': [1, 2, 3, 4, 2, 5, 3, 5], 'data_compra': ['2021-08-02', '2022-08-01','2022-08-01','2022-08-03','2022-08-03','2022-08-04','2022-08-05','2022-08-05'], 'valor':[199.90, 245.20, 89.90, 545.80, 199.90, 239.90, 89.90, 119.80]}
df = pd.DataFrame(data=d)

db_connection_str = 'mysql+pymysql://root:@localhost:3306/oto_db'
db_connection = create_engine(db_connection_str)

df.to_sql('compras', db_connection, if_exists='append', index = False)