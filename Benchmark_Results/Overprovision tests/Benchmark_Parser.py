import csv
import glob
import os

os.chdir("/Users/sriharivignesh/Documents/Rosetta-Protein-Folding-Project/Benchmark_Results/Overprovision tests/")
for file in glob.glob("*.csv"):
    var = 0
    sum = 0
    counter = 0
    print(file,"\n")
    average_array = [0] * 100
    f = open(file , 'rt', newline = '')
    reader = csv.reader(f, delimiter=',')
    for row in reader:
        if(counter >= 1):
            if(var == 0 and int(row[2]) == 1):
                continue
            if(var == 0):
                var = int(row[2])
                sum = int(row[4])
            elif(var != int(row[2])):
                average_array[var] += (sum/var)
                var = int(row[2])
                sum = int(row[4])
            else:
                sum += int(row[4])
        counter += 1
    f.close()
    average_array[var] += (sum/var)
    for count, i in enumerate(average_array):
        if(count == 1 and i > 0):
            print(count, "|", round((i/9), 2))
        else:
            if(i > 0):
                print(count, "|", round((i/10), 2))
    print("*********************************************\n\n\n")
exit()
