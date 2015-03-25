class Ksiazka
  attr_reader :tytul, :autor, :ilosc
  #attr_accessor :
  def initialize(tytul, autor, ilosc_ksiazek)
    @tytul = tytul
    @autor = autor
    @ilosc = ilosc_ksiazek
  end
  def ilosc=(arg)
    if !arg.instance_of? Fixnum
      raise "ZlyArgument"
    end

    if arg < 0
      raise "UjemnyArgument"
    end
    @ilosc = arg
  end
end