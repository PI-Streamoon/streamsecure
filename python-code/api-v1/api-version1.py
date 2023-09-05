import mysql.connector
import datetime
from datetime import date
import time
import psutil
import platform
import os

import pandas as pd
import numpy as np
import matplotlib as mpl



consoleColors = {
    "black": "\u001b[30m",
    "red": "\u001b[31m",
    "green": "\u001b[32m",
    "yellow": "\u001b[33m",
    "blue": "\u001b[34m",
    "magenta": "\u001b[35m",
    "cyan": "\u001b[36m",
    "white": "\u001b[37m",
    "brightBlack": "\u001b[30;1m",
    "brightRed": "\u001b[31;1m",
    "brightGreen": "\u001b[32;1m",
    "brightYellow": "\u001b[33;1m",
    "brightBlue": "\u001b[34;1m",
    "brightMagenta": "\u001b[35;1m",
    "brightCyan": "\u001b[36;1m",
    "brightWhite": "\u001b[37;1m",
    "reset": "\u001b[0m",
}


def showText():
    print(f"""{consoleColors['magenta']}
[]====================================================================================[]
|                                                                                      |      
|   ███████╗████████╗██████╗ ███████╗ █████╗ ███╗   ███╗ ██████╗  ██████╗ ███╗   ██╗   |
|   ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗████╗ ████║██╔═══██╗██╔═══██╗████╗  ██║   |
|   ███████╗   ██║   ██████╔╝█████╗  ███████║██╔████╔██║██║   ██║██║   ██║██╔██╗ ██║   |
|   ╚════██║   ██║   ██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║██║   ██║██║   ██║██║╚██╗██║   |
|   ███████║   ██║   ██║  ██║███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██║ ╚████║   |
|   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   |
|                                                                                      |
|                               Developed by Streamoon                                 |
[]====================================================================================[]{consoleColors['reset']}""")

    print(f"""{consoleColors['magenta']}
            Network Name: {platform.node()}
            Processor: {platform.processor()}
            Operating System: {platform.system()}\n
[]====================================================================================[]{consoleColors['reset']}""")


indexHour = []
consoleData = {
    "MemoryPercent" : [],
    "MemoryUsed" : [],
    "MemoryTotal" : [],
    "Disk" : []
}
cpuQuantity = psutil.cpu_count(logical=True)
for i in range(cpuQuantity):
    cpuName = (f"CPU{i+1}")
    consoleData[cpuName] = []


colunas = []
for chave in consoleData.keys():
    colunas.append(f"{chave.upper()}")

# Capturar os dados de CPU/RAM/DISK a cada 2segs
while True:

    cpusPercent = psutil.cpu_percent(interval=1, percpu=True)

    memory = (psutil.virtual_memory())
    memPercent = memory.percent
    memoryUsed = round((memory.used / 1024 / 1024 / 1000), 1)   
    memoryTotal = round((memory.total / 1024 / 1024 / 1000), 1)

    diskPartitions = psutil.disk_partitions()
    diskPercent = psutil.disk_usage(diskPartitions[0].mountpoint)                      


    somaCpus = 0
    mediaCpus = 0
    for i in range(psutil.cpu_count()):
        somaCpus += cpusPercent[i]
        cpuName1 = (f"CPU{i+1}") 
        consoleData[cpuName1].append(cpusPercent[i])
    mediaCpus = somaCpus / len(cpusPercent)


    dateNow = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    indexHour.append(dateNow)

    systemClear = ('clear' if platform.system() == 'Linux' else 'cls')
    os.system(systemClear)

    showText()
    consoleData["MemoryPercent"].append(memPercent)
    consoleData["MemoryUsed"].append(memoryUsed)
    consoleData["MemoryTotal"].append(memoryTotal)
    consoleData["Disk"].append(diskPercent.percent)

    df = pd.DataFrame(data=consoleData, index=indexHour)
    print(f"\n{df}")




    # try:
    #                  connection = mysql.connector.connect(host='localhost',
    #                                                      database='streamoon',
    #                                                      user='aluno',
    #                                                      password='sptech')

    #                  mySql_insert_query_cpu_percent = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(mediaCpus) + ", '" + str(agora) + "', 1);"
    #                  mySql_insert_query_memory = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(percentualMemoria) + ", '" + str(agora) + "', 2);"
    #                  mySql_insert_query_memory_used = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(memoryUsed) + ", '" + str(agora) + "', 3);"
    #                  mySql_insert_query_memory_total = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(memoryTotal) + ", '" + str(agora) + "', 4);"
    #                  mySql_insert_query_disc_percent = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(diskPercent.percent) + ", '" + str(agora) + "', 5);"
    #     # mySql_insert_query = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(aleatorio) + ", '" + str(agora) + "', 1);"
    #     # mySql_insert_query = "INSERT INTO registro (idRegistro, registro, dtHora, fkComponenteServidor) VALUES (null, " + str(aleatorio) + ", '" + str(agora) + "', 1);"
    #                  time.sleep(2)
    #                  cursor = connection.cursor()
    #                  cursor.execute(mySql_insert_query_cpu_percent)
    #                  cursor.execute(mySql_insert_query_memory)
    #                  cursor.execute(mySql_insert_query_memory_used)
    #                  cursor.execute(mySql_insert_query_memory_total)
    #                  cursor.execute(mySql_insert_query_disc_percent)
                      

    #                  connection.commit()
    #                 # print(cursor.rowcount, "Record inserted successfully into Laptop table")
    #                  cursor.close()


    # except mysql.connector.Error as error:
    #                  print("Failed to insert record into Laptop table {}".format(error))

    # finally:
    #                  if connection.is_connected():
    #                      connection.close()
    #                      # print("MySQL connection is closed")

    time.sleep(2)

