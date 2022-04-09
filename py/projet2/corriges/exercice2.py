import csv

folder_path = "inst/rawdata/projet2/"

adresses_dict = csv.DictReader(open(folder_path + "adresses_intermediaire.csv"))
adresses_dict = list(adresses_dict)
  
for adresse in adresses_dict:
    adresse["Tel"] = adresse["Tel"].replace(' ', '') # nécessaire pour le fichier *facile*
    adresse["Tel"] = adresse["Tel"].replace('/', '') # nécessaire pour le fichier *facile*
    adresse["Tel"] = adresse["Tel"].replace('-', '') # nécessaire pour le fichier *intermediaire*
    adresse["Tel"] = adresse["Tel"].replace('(', '') # nécessaire pour le fichier *intermediaire*
    adresse["Tel"] = adresse["Tel"].replace(')', '') # nécessaire pour le fichier *intermediaire*
    adresse["Tel"] = adresse["Tel"].replace('.', '') # nécessaire pour le fichier *intermediaire*
    adresse["Tel"] = "+41 " + adresse["Tel"][1:3] + " " + adresse["Tel"][3:6] + " " + adresse["Tel"][6:8] + " " + adresse["Tel"][8:10]

for adresse in adresses_dict:
  print(adresse["Tel"])

