import csv, re

folder_path = "inst/rawdata/projet2/"

adresses_dict = csv.DictReader(open(folder_path + "adresses_expert.csv"))
adresses_dict = list(adresses_dict)

for adresse in adresses_dict:
  adresse["Tel"] = re.sub(r"^(?:\+41\W?)?(?:\(0\)\W?)?(?:\(0|0)?(\d{2})[^0-9]*(\d{3})[^0-9]?(\d{2})[^0-9]?(\d{2})", r"+41 \1 \2 \3 \4", adresse["Tel"])
  
keys = adresses_dict[0].keys()
with open(folder_path + 'adresses_clean.csv', 'w', newline='')  as output_file:
    dict_writer = csv.DictWriter(output_file, keys)
    dict_writer.writeheader()
    dict_writer.writerows(adresses_dict)
