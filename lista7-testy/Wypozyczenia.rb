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