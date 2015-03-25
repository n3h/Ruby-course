require_relative 'Ksiazka'
require_relative 'Biblioteka'

biblio = Biblioteka.new

biblio.dodaj_ksiazke(Ksiazka.new("Symfonia C++", "Grebosz", 2))
biblio.dodaj_ksiazke(Ksiazka.new("Ruby. Tao programowania", "Fulton", 2))
biblio.wszystkie_ksiazki

biblio.wypozycz_ksiazke("Symfonia C++", "Grebosz")
biblio.wypozycz_ksiazke("Symfonia C++", "Grebosz")
biblio.oddaj_ksiazke("Symfonia C++", "Grebosz")
biblio.oddaj_ksiazke("Symfonia C++", "Grebosz")
biblio.oddaj_ksiazke("Symfonia C++", "Grebosz")

biblio.wypozycz_ksiazke("Symfonia C++", "Grebosz")
biblio.usun_ksiazke("Symfonia C++", "Grebosz")

biblio.wypozycz_ksiazke("Symfonia C++", "Grebosz")
biblio.oddaj_ksiazke("Symfonia C++", "Grebosz")