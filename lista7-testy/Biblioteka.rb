require_relative 'Wypozyczenia'

class Biblioteka
  include Wypozyczenia

  def initialize
    @lista_elementow = []
    @wypozyczenia = {}
  end

  def dodaj_ksiazke(ksiazka)
    dodaj_element(ksiazka)
    puts "Dodano ksiazke #{ksiazka.tytul} autorstwa #{ksiazka.autor}"
  end

  def usun_ksiazke(tytul, autor)
    usun_element(tytul, autor)
    puts "Usunieto ksiazke #{tytul}"
  end

  def wypozycz_ksiazke(tytul, autor) #dodac brak ksiazki
    x = wypozycz_element(tytul, autor)
    if x == 1
      puts "Wypozyczono ksiazke #{tytul} autorstwa #{autor}"
    elsif x == 2
      puts "Ksiazka #{tytul} autorstwa #{autor} jest juz wypozyczona"
    else
      puts "Brak ksiazki"
    end
  end

  def oddaj_ksiazke(tytul, autor)
    x = oddaj_element(tytul, autor)
    if x == 1
      puts "Oddano #{tytul} autorstwa #{autor}"
    elsif x == 2
      puts "Wszystkie ksiazki #{tytul} autorstwa #{autor} zostaly juz oddane"
    else
      puts "Brak ksiazki"
    end
  end

  def wszystkie_ksiazki
    puts "Lista wszystkich ksiazek: "
    wypisz_wszystkie_elementy
  end
end