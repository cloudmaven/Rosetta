import csv
import glob
import os

os.chdir(os.getcwd()) #If you place this script in the directory where your CSVs are, then this will work or else modify path
iterations = 10 #Change the number of iterations of benchmark you have done
number_of_threads = 36
for file in glob.glob("*.csv"):
    print(file,"\n")
    average_array = [0] * (number_of_threads + 1) #creating 0 array with number of threads as size
    f = open(file , 'rt', newline = '')
    reader = csv.reader(f, delimiter=',')
    for row in reader:
        if(row[2] == "Number of threads in parallel"):
            continue
        array_index = int(row[2])
        average_array[array_index] += int(row[4])
    f.close()
    for index, number in enumerate(average_array):
        if(index == 0 or average_array[index] == 0):
            continue
        print(index, "|", round((average_array[index] /(iterations * (index))), 2))

exit()
