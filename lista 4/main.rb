module Wypozyczenia
  def dodaj_element(obiekt)
    @lista_elementow << obiekt
    @wypozyczenia[obiekt] = 0
  end

  def usun_element(nazwa, autor)
    @lista_elementow.delete(znajdz_obiekt(nazwa, autor))
  end

  def wypozycz_element(nazwa, autor)
    obiekt = znajdz_obiekt(nazwa, autor)
    if obiekt == nil
      return 0
    elsif (obiekt.ilosc - @wypozyczenia[obiekt]) > 0
      @wypozyczenia[obiekt] += 1
      return 1
    else
      return 2
    end
  end

  def oddaj_element(nazwa, autor)
    obiekt = znajdz_obiekt(nazwa, autor)
    if obiekt == nil
      return 0
    elsif (@wypozyczenia[obiekt] - obiekt.ilosc) <= 0 && (obiekt.ilosc - @wypozyczenia[obiekt]) < obiekt.ilosc
      @wypozyczenia[obiekt] -= 1
      return 1
    else
      return 2
    end
  end

  def znajdz_obiekt(nazwa, autor)
    obiekt = @lista_elementow.select {|x| x.tytul == nazwa && x.autor == autor}
    # zal: mamy jeden obiekt o danym tytule i autorze
    return obiekt.first
  end

  def wypisz_wszystkie_elementy
    @lista_elementow.each{|x| puts x.tytul + ", " + x.autor}
  end
end

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

class Ksiazka
  attr_reader :tytul, :autor
  attr_accessor :ilosc
  def initialize(tytul, autor, ilosc_ksiazek)
    @tytul = tytul
    @autor = autor
    @ilosc = ilosc_ksiazek
  end
end

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