# Source des données bruts:
# https://opendata.swiss/fr/dataset/isplus
data <- readr::read_csv2("inst/extdata/ISPlus_ISIL.csv")

# Fonction qui modifie un numéro de téléphone et rend son format aléatoire
# Le paramètre de difficulté permet de gérer la "complexité" des formats
mixitup <- function(phone, difficulty) {
  chance <- runif(1) * difficulty

  tel <- stringr::str_match_all(phone, r"[\+41 (\d{2})\W(\d{3})\W(\d{2})\W(\d{2})]")[[1]][1,2:5]

  if (chance < 1) {
    glue::glue("0{tel[[1]]} {tel[[2]]} {tel[[3]]} {tel[[4]]}")
  } else if (chance < 2) {
    glue::glue("0{tel[[1]]}/{tel[[2]]}{tel[[3]]}{tel[[4]]}")
  } else if (chance < 3) {
    glue::glue("0{tel[[1]]} {tel[[2]]}{tel[[3]]}{tel[[4]]}")
  } else if (chance < 4) {
    glue::glue("(0{tel[[1]]}) {tel[[2]]}-{tel[[3]]}-{tel[[4]]}")
  } else if (chance < 5) {
    glue::glue("0{tel[[1]]}-{tel[[2]]}-{tel[[3]]}-{tel[[4]]}")
  } else if (chance < 6) {
    glue::glue("0{tel[[1]]}/{tel[[2]]}.{tel[[3]]}.{tel[[4]]}")
  } else if (chance < 7) {
    glue::glue("+41{tel[[1]]} {tel[[2]]} {tel[[3]]}{tel[[4]]}")
  } else if (chance < 8) {
    glue::glue("+41 (0) {tel[[1]]} {tel[[2]]} {tel[[3]]} {tel[[4]]}")
  } else if (chance < 9) {
    glue::glue("+41 {tel[[1]]}/{tel[[2]]}.{tel[[3]]}.{tel[[4]]}")
  } else {
    glue::glue("+41 {tel[[1]]}/{tel[[2]]}/{tel[[3]]}/{tel[[4]]}")
  }
}

# Fonction qui modifie les données et les enregistre
save_data <- function(data, save_path, difficulty) {
  data |>
    dplyr::select(Institution,
                  Rue = Strasse,
                  Lieu = Ort,
                  Tel = Telefon_Nr,
                  ZIP = PLZ,
                  Email = E_Mail) |>
    tidyr::drop_na() |>
    dplyr::filter(stringr::str_detect(Tel, r"[\+41 (\d{2})\W(\d{3})\W(\d{2})\W(\d{2})]")) |>
    dplyr::mutate(phone_mess = purrr::map_chr(Tel, mixitup, difficulty)) |>
    dplyr::select(-Tel, Tel = phone_mess) |>
    readr::write_csv(save_path)
}

save_data(data, "inst/rawdata/projet2/adresses_facile.csv", 3)
save_data(data, "inst/rawdata/projet2/adresses_intermediaire.csv", 6)
save_data(data, "inst/rawdata/projet2/adresses_expert.csv", 10)

