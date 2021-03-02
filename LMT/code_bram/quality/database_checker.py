import ntpath
import sqlite3

from lmtanalysis.FileUtil import getFilesToProcess


def validate_database_columns(table):
    table_names = ['ANIMAL','DETECTION','EVENT','FRAME','LOG','RFIDEVENT','sqlite_sequence']
    table_column_names = {'ANIMAL':['ID', 'RFID', 'GENOTYPE', 'NAME'],
                   'DETECTION':['ID', 'FRAMENUMBER', 'ANIMALID', 'MASS_X', 'MASS_Y', 'MASS_Z', 'FRONT_X', 'FRONT_Y', 'FRONT_Z', 'BACK_X', 'BACK_Y', 'BACK_Z', 'REARING', 'LOOK_UP', 'LOOK_DOWN', 'DATA'],
                   'EVENT':['ID', 'NAME', 'DESCRIPTION', 'STARTFRAME', 'ENDFRAME', 'IDANIMALA', 'IDANIMALB', 'IDANIMALC', 'IDANIMALD', 'METADATA'],
                   'FRAME':['FRAMENUMBER', 'TIMESTAMP', 'NUMPARTICLE', 'PAUSED', 'TEMPERATURE', 'HUMIDITY', 'SOUND', 'LIGHTVISIBLE', 'LIGHTVISIBLEANDIR'],
                   'LOG':['id', 'process', 'version', 'date', 'tmin', 'tmax'],
                   'RFIDEVENT':['ID', 'RFID', 'TIME', 'X', 'Y'],
                   'sqlite_sequence':['name', 'seq']}

    error = False
    for table_name in table_names:
        try:
            conn = sqlite3.connect(table)  # <- Connect to the database using the variable declared in main

            cursor = conn.cursor()

            query = "select * from %s limit 0" %table_name

            cursor.execute(query)


            field_names = [i[0] for i in cursor.description]

            missing_columns = list(set(table_column_names[table_name]) - set(field_names))
            extra_columns = list(set(field_names) - set(table_column_names[table_name]))

            #missing = list((set(field_names) ^ set(table_column_names[table_name])))
            if missing_columns != []:
                error = True
                print(ntpath.basename(table) + ' is missing the following columns: ' + str(missing_columns) + ' in the table: ' + table_name)

            if extra_columns != []:
                error = True
                print(ntpath.basename(table) + ' has following columns extra: ' + str(extra_columns) + ' in the table ' + table_name)

        except sqlite3.OperationalError:
            print(ntpath.basename(table) + ' is missing the table: ' + table_name)
            error = True
            continue
    return error
if __name__ == '__main__':
    files = getFilesToProcess()
    for table in files:
        error = validate_database_columns(table)
