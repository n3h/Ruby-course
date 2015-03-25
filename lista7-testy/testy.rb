require 'test/unit'
require_relative 'Ksiazka'
require_relative 'Biblioteka'

class TestKsiazka < Test::Unit::TestCase
  def test_inicjalizacja
    obj = Ksiazka.new("Symfonia C++", "Grebosz", 2)
    assert_equal("Symfonia C++", obj.tytul)
    assert_equal("Grebosz", obj.autor)
    assert_equal(2, obj.ilosc)
  end

  def test_wyjatki
    obj = Ksiazka.new("Tytul", "Autor", 5)
    assert_raise(RuntimeError) { obj.ilosc = "ff" }
    assert_raise(RuntimeError) { obj.ilosc = -4 }
  end

  def test_brak_wyjatkow
    obj = Ksiazka.new("Tytul", "Autor", 5)
    assert_nothing_raised { obj.ilosc = 0 }
    assert_nothing_raised { obj.ilosc = 999999 }
  end
end

class TestBiblioteka < Test::Unit::TestCase
  def test_metody
    obj = Biblioteka.new
    assert_respond_to(obj, :dodaj_ksiazke)
    assert_respond_to(obj, :usun_ksiazke)
    assert_respond_to(obj, :wypozycz_ksiazke)
    assert_respond_to(obj, :oddaj_ksiazke)
    assert_respond_to(obj, :wszystkie_ksiazki)
  end
end

