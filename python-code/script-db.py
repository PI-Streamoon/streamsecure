import mysql.connector
import monitoring_server as ms


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
    # ms.captureServerData(connection)
    ms.checkServerExists(connection)
    connection.close()
    print("Connected database")
  
  except Exception as e:
    global loginAttempts
    if loginAttempts > 1: 
      loginAttempts -= 1
      print(f"Usuário ou senha digitado incorretamente!")
      print(f"Tentavivas: {loginAttempts}")
      print(f"This is error: {e}\n")
      connectionDatabase()
    else:
      connection.close()
      print('Seu chefe foi alertado')

connectionDatabase()
