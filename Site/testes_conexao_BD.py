import mysql.connector
import random
import datetime
from datetime import date
import time


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

import psutil
import platform

print("[+]" + "=" * 170 + "[+]")
print(
    """\u001b[35m
#    ______     __                                                   ______                                                    
#   /      \   |  \                                                 /      \                                                   
#  |  $$$$$$\ _| $$_     ______    ______    ______   ______ ____  |  $$$$$$\  ______    _______  __    __   ______    ______  
#  | $$___\$$|   $$ \   /      \  /      \  |      \ |      \    \ | $$___\$$ /      \  /       \|  \  |  \ /      \  /      \ 
#   \$$    \  \$$$$$$  |  $$$$$$\|  $$$$$$\  \$$$$$$\| $$$$$$\$$$$\ \$$    \ |  $$$$$$\|  $$$$$$$| $$  | $$|  $$$$$$\|  $$$$$$\\
#   _\$$$$$$\  | $$ __ | $$   \$$| $$    $$ /      $$| $$ | $$ | $$ _\$$$$$$\| $$    $$| $$      | $$  | $$| $$   \$$| $$    $$
#  |  \__| $$  | $$|  \| $$      | $$$$$$$$|  $$$$$$$| $$ | $$ | $$|  \__| $$| $$$$$$$$| $$_____ | $$__/ $$| $$      | $$$$$$$$
#   \$$    $$   \$$  $$| $$       \$$     \ \$$    $$| $$ | $$ | $$ \$$    $$ \$$     \ \$$     \ \$$    $$| $$       \$$     \\
#    \$$$$$$     \$$$$  \$$        \$$$$$$$  \$$$$$$$ \$$  \$$  \$$  \$$$$$$   \$$$$$$$  \$$$$$$$  \$$$$$$  \$$        \$$$$$$$
#  
#                                                   Developed by Streamoon\u001b[0m
"""
)
print("[+]" + "=" * 170 + "[+]\n")


# Mostrando alguns dados do Sistema Operacional
print(f"Network Name: {platform.node()}")
print(f"Processor: {platform.processor()}")
print(f"Operating System: {platform.system()}")


# Construindo o cabeçalho que indica o tipo de dado que cada coluna exibe
headerConsole = "   Date      |      Hour      |"
cpuQuantity = psutil.cpu_count(logical=True)
for i in range(cpuQuantity):
    headerConsole += "      "
    headerConsole += f"\u001b[34;1mCPU{i+1}\u001b[0m" + "      |"
headerConsole += "    \u001b[35;1mMemory (%)\u001b[0m   |  Memory Used(GB)  |  Memory Total(GB)  |      Diks"
print("\n[+]" + "=" * 170 + "[+]\n")
print(headerConsole + "\n")



# Capturar os dados de CPU/RAM/DISK a cada 2segs
while True:

    # Captura dos dados através das libs
    cpusPercent = psutil.cpu_percent(
        interval=1, percpu=True
    )  # Vetor que recebe os dados (em porcentagem) das CPUs que o computador possui
    memory = (
        psutil.virtual_memory()
    )  # Variável que guarda uma lista de atributos da Memória.
    percentualMemoria = memory.percent

    memoryUsed = (
        (memory.used / 1024) / 1024
    ) / 1000  # Variável que recebe a quantidade de memória que esta sendo usada, já convertida em GB
    memoryTotal = (
        (memory.total / 1024) / 1024
    ) / 1000  # Variável que recebe a quantidade total da memória, já convertida em GB
    diskPercent = psutil.disk_usage(
        "/"
    )  # Variável que recebe uma lista de atributos do Disco

    # cpu1 = cpusPercent[0]
    # cpu2 = cpusPercent[1]
    # cpu3 = cpusPercent[2]
    # cpu4 = cpusPercent[3]

    # mediaCpus = (cpu1 + cpu2 + cpu3 + cpu4) / 4



    # Usando a lib TIME, a função me retorna o horário da máquina
    # no formato que eu escolhi dentro do parâmetro -> time.strftime(formato, outra função que retorna o horário)
    # %d = dia | %m = mês | %Y = ano <> %H = hora | %M = minutos
    mensagem = time.strftime(f"   %d/%m/%Y   |   %H:%M   |", time.localtime())

    # Um FOR que vai fragmentar o vetor de CPUS listado lá em cima
    # Colocando os dados separados na mensagem do CONSOLE
    somaCpus = 0
    mediaCpus = 0
    for i in range(len(cpusPercent)):
        somaCpus += cpusPercent[i]
        mensagem += (
            "      " + f"\u001b[34;1m{cpusPercent[i]}%\u001b[0m" + "      |"
        )  # Percentuais das CPUs

    mediaCpus = somaCpus / len(cpusPercent)

    # Construindo a mensagem que vai ser exibida no console
    mensagem += (
        "       " + f"\u001b[35;1m{memory.percent}%\u001b[0m" + "       |"
    )  # Percentual da Memoria
    mensagem += (
        "       " + f"{round(memoryUsed, 1)}" + "       |"
    )  # Qtde de memória usada
    mensagem += (
        "       " + f"{round(memoryTotal, 1)}" + "       |"
    )  # Qtde total da memória
    mensagem += "       " + f"{diskPercent.percent}%"  # Percentual do Disco

    print(mensagem)
    time.sleep(2)


    aleatorio = random.randint(1, 100)
    agora = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    try:
                     connection = mysql.connector.connect(host='localhost',
                                                         database='streamoon',
                                                         user='root',
                                                         password='1234')
                                                         
                     mySql_insert_query_cpu_percent = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(mediaCpus) + ", '" + str(agora) + "', 1);"
                     mySql_insert_query_memory = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(percentualMemoria) + ", '" + str(agora) + "', 2);"
                     mySql_insert_query_memory_used = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(memoryUsed) + ", '" + str(agora) + "', 3);"
                     mySql_insert_query_memory_total = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(memoryTotal) + ", '" + str(agora) + "', 4);"
                     mySql_insert_query_disc_percent = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(diskPercent.percent) + ", '" + str(agora) + "', 5);"
        # mySql_insert_query = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(aleatorio) + ", '" + str(agora) + "', 1);"
        # mySql_insert_query = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(aleatorio) + ", '" + str(agora) + "', 1);"
                     time.sleep(2)
                     cursor = connection.cursor()
                     cursor.execute(mySql_insert_query_cpu_percent)
                     cursor.execute(mySql_insert_query_memory)
                     cursor.execute(mySql_insert_query_memory_used)
                     cursor.execute(mySql_insert_query_memory_total)
                     cursor.execute(mySql_insert_query_disc_percent)
                      

                     connection.commit()
                     print(cursor.rowcount, "Record inserted successfully into Laptop table")
                     cursor.close()


    except mysql.connector.Error as error:
        print("Failed to insert record into Laptop table {}".format(error))

    # finally:
    #     if connection.is_connected():
    #         connection.close()
    #         print("MySQL connection is closed")
