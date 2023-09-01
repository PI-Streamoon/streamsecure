import mysql.connector
import datetime
from datetime import date
import time
import psutil
import platform
import os
import pandas as pd


def showText():
    print("[+]" + "=" * 150 + "[+]")
    print(
        """\u001b[35m
    #    ______     __                                                   ______                                                    
    #   /      \   |  \                                                 /      \                                                   
    #  |  $$$$$$\ _| $$_     ______    ______    ______   ______ ____  |  $$$$$$\  ______    _______  __    __   ______    ______  
    #  | $$___\$$|   $$ \   /      \  /      \  |      \ |      \    \ | $$___\$$ /      \  /       \|  \  |  \ /      \  /      \ 
    #   \$$    \  \$$$$$$  |  $$$$$$\|  $$$$$$\  \$$$$$$\| $$$$$$\$$$$\ \$$    \ |  $$$$$$\|  $$$$$$$| $$  | $$|  $$$$$$\|  $$$$$$
    #   _\$$$$$$\  | $$ __ | $$   \$$| $$    $$ /      $$| $$ | $$ | $$ _\$$$$$$\| $$    $$| $$      | $$  | $$| $$   \$$| $$    $$
    #  |  \__| $$  | $$|  \| $$      | $$$$$$$$|  $$$$$$$| $$ | $$ | $$|  \__| $$| $$$$$$$$| $$_____ | $$__/ $$| $$      | $$$$$$$$
    #   \$$    $$   \$$  $$| $$       \$$     \ \$$    $$| $$ | $$ | $$ \$$    $$ \$$     \ \$$     \ \$$    $$| $$       \$$     
    #    \$$$$$$     \$$$$  \$$        \$$$$$$$  \$$$$$$$ \$$  \$$  \$$  \$$$$$$   \$$$$$$$  \$$$$$$$  \$$$$$$  \$$        \$$$$$$$
    #  
    #                                                   Developed by Streamoon\u001b[0m
    """
    )
    print("[+]" + "=" * 150 + "[+]\n")

    print(f"Network Name: {platform.node()}")
    print(f"Processor: {platform.processor()}")
    print(f"Operating System: {platform.system()}")
    print("\n[+]" + "=" * 150 + "[+]\n")


consoleData = {
    "memoryPercent" : [],
    "memoryUsed" : [],
    "memoryTotal" : [],
    "disk" : []
}
cpuQuantity = psutil.cpu_count(logical=True)
for i in range(cpuQuantity):
    cpuName = (f"cpu{i+1}")
    consoleData[cpuName] = []


# Capturar os dados de CPU/RAM/DISK a cada 2segs
while True:

    cpusPercent = psutil.cpu_percent(interval=1, percpu=True)

    memory = (psutil.virtual_memory())
    memPercent = memory.percent
    memoryUsed = (memory.used / 1024 / 1024 / 1000)     
    memoryTotal = (memory.total / 1024 / 1024 / 1000)

    diskPartitions = psutil.disk_partitions()
    diskPercent = psutil.disk_usage(diskPartitions[0].mountpoint)                      


    somaCpus = 0
    mediaCpus = 0
    for i in range():
        somaCpus += cpusPercent[i]
        cpuName1 = (f"cpu{i+1}") 
        consoleData[cpuName1].append(cpusPercent[i])
    mediaCpus = somaCpus / len(cpusPercent)


    agora = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")


    # os.system('clear') # limpa o console antes de exibir
    showText()
    consoleData["memoryPercent"].append(memPercent)
    consoleData["memoryUsed"].append(memoryUsed)
    consoleData["memoryTotal"].append(memoryTotal)
    consoleData["disk"].append(diskPercent.percent)

    teste = consoleData.keys()
    print(f"\033[K{pd.DataFrame(data=consoleData, columns=teste)}", end="\r")

    


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

