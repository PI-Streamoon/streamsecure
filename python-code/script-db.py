import mysql.connector
import monitoring_server as ms
import time


loginAttempts = 5
def connectionDatabase():
  userDatabase = str(input("-> Informe o seu usuário do banco: "))
  passDatabase = str(input("-> Informe a sua senha do banco: "))

  try:
    connection = mysql.connector.connect(
        host = 'localhost',
        user = userDatabase,
        password = passDatabase,
        database = 'streamoon',
    )
    print("Connected database")
    return connection

  except Exception as e:
    global loginAttempts
    if loginAttempts > 1: 
      loginAttempts -= 1
      print(f"Usuário ou senha digitado incorretamente!")
      print(f"Tentavivas: {loginAttempts}")
      print(f"This is error: {e}\n")
      connectionDatabase()
    else:
      print('Seu chefe foi alertado')


connection = connectionDatabase()
ms.captureServerData(connection)
connection.close()