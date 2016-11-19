import csv
import sys
mergefile  = open('mergefile.csv', "wt",encoding="utf8")
writer = csv.writer(mergefile,delimiter=',',quotechar='"', quoting=csv.QUOTE_ALL)
for x in range(1,6):
    q = 'dtm'+str(x)+'.csv'
    with open(q, 'rt',encoding="utf8") as f:
        reader = csv.reader(f)
        for row in reader:
            if(row[1]=="freq"):
                continue
            if(int(row[1])>50):
                writer.writerow(row)
mergefile.close()

"""f = open(sys.argv[1], 'rb') # opens the csv file
try:
    reader = csv.reader(f)  # creates the reader object
    for row in reader:   # iterates the rows of the file in orders
        print(row)    # prints each row
finally:
    f.close()
"""
