import csv
import sys
mergefile  = open('mergefile.csv', "wt",encoding="utf8")
writer = csv.writer(mergefile,quotechar='"', quoting=csv.QUOTE_ALL)
for x in range(1,6):
    q = 'dtm'+str(x)+'.csv'
    with open(q, 'rt',encoding="utf8") as f:
        reader = csv.reader(f)
        for row in reader:
            if(row[1]=="freq" ):
                continue
            if(int(row[1])>50):
                for c in range(int(row[1])):
                    writer.writerow([row[0]])
mergefile.close()
