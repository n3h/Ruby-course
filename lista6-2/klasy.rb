class Ksiazka
  attr_reader :tytul, :autor
  attr_accessor :ilosc
  def initialize(tytul, autor, ilosc_ksiazek)
    @tytul = tytul
    @autor = autor
    @ilosc = ilosc_ksiazek
  end
  def testowa

  end
end

class TestowaKlasa
  def initialize
    @te = 66
  end
  def testowa
  end

  def wypisz
    puts "To ja! TestowaKlasa"
  end
end