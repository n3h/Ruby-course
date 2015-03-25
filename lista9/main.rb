require 'tk'

class Ksiazka
  attr_reader :tytul, :autor
  attr_accessor :ilosc
  def initialize(tytul, autor, ilosc_ksiazek)
    @tytul = tytul
    @autor = autor
    @ilosc = ilosc_ksiazek
  end
end

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
    elsif (obiekt.ilosc.to_i - @wypozyczenia[obiekt]) > 0
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
    elsif (@wypozyczenia[obiekt] - obiekt.ilosc.to_i) <= 0 && (obiekt.ilosc.to_i - @wypozyczenia[obiekt]) < obiekt.ilosc.to_i
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
    @lista_elementow
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
    return "Dodano książkę #{ksiazka.tytul} autorstwa #{ksiazka.autor}"
  end

  def usun_ksiazke(tytul, autor)
    usun_element(tytul, autor)
    return "Usunięto książkę #{tytul}"
  end

  def wypozycz_ksiazke(tytul, autor) #dodac brak ksiazki
    x = wypozycz_element(tytul, autor)
    if x == 1
      return "Wypożyczono książkę #{tytul} autorstwa #{autor}"
    elsif x == 2
      return "Książka #{tytul} autorstwa #{autor} jest juz wypożyczona"
    else
      return "Brak książki"
    end
  end

  def oddaj_ksiazke(tytul, autor)
    x = oddaj_element(tytul, autor)
    if x == 1
      return "Oddano książkę #{tytul} autorstwa #{autor}"
    elsif x == 2
      return "Wszystkie książki #{tytul} autorstwa #{autor} zostały juz oddane"
    else
      return "Brak książki"
    end
  end

  def wszystkie_ksiazki
    return wypisz_wszystkie_elementy
  end

  def uruchom
    @win = TkRoot.new { title 'Biblioteka'; geometry "300x300"}

    menu = TkMenu.new(@win)
    glowne = TkMenu.new(menu)
    menu.add('cascade', :menu => glowne, :label => 'Menu')
    glowne.add('command', :label => 'Dodaj książkę', :command => proc { @menuFrame.unpack; self.dodajOkno })
    glowne.add('command', :label => 'Usuń książkę', :command => proc { @menuFrame.unpack;  self.usunOkno })
    glowne.add('command', :label => 'Wypożycz książkę', :command => proc { @menuFrame.unpack; self.wypozyczOkno })
    glowne.add('command', :label => 'Oddaj książkę', :command => proc { @menuFrame.unpack; self.oddajOkno })
    glowne.add('command', :label => 'Wszystkie książki', :command => proc { @menuFrame.unpack; self.wszystkieOkno })
    glowne.add('command', :label => 'KONIEC', :command => proc { @win.destroy })
    @win.menu(menu)

    @menuFrame = TkFrame.new { pack }
    dodajButton = TkButton.new(@menuFrame) { text 'Dodaj książkę'; pack }
    dodajButton.command { @menuFrame.unpack; self.dodajOkno }
    usunButton = TkButton.new(@menuFrame) { text 'Usuń książkę'; pack }
    usunButton.command { @menuFrame.unpack; self.usunOkno }
    wypozyczButton = TkButton.new(@menuFrame) { text 'Wypożycz książkę'; pack }
    wypozyczButton.command { @menuFrame.unpack; self.wypozyczOkno }
    oddajButton = TkButton.new(@menuFrame) { text 'Oddaj książkę'; pack }
    oddajButton.command { @menuFrame.unpack; self.oddajOkno }
    wszystkieButton = TkButton.new(@menuFrame) { text 'Wszystkie książki'; pack }
    wszystkieButton.command { @menuFrame.unpack; self.wszystkieOkno }
    koniecButton = TkButton.new(@menuFrame) { text 'KONIEC'; pack }
    koniecButton.command { @win.destroy }

    obrazek = TkPhotoImage.new
    obrazek.file = "ksiazka.gif"

    label = TkLabel.new(@win)
    label.image = obrazek
    label.place('height' => obrazek.height - 10, 'width' => obrazek.width, 'x' => 54, 'y' => 160)
    Tk.mainloop
  end

  def dodajOkno
    frame = TkFrame.new(@win) { pack }
    tytulLabel = TkLabel.new(frame) { text 'Tytuł'; grid(:row => 0, :column => 0)  }
    tytulEntry = TkEntry.new(frame) { grid(:row => 0, :column => 1)  }
    autorLabel = TkLabel.new(frame) { text 'Autor'; grid(:row => 1, :column => 0)  }
    autorEntry = TkEntry.new(frame) { grid(:row => 1, :column => 1)  }
    iloscLabel = TkLabel.new(frame) { text 'Ilość książek'; grid(:row => 2, :column => 0) }
    iloscEntry = TkEntry.new(frame) { grid(:row => 2, :column => 1) }
    dodajButton = TkButton.new(frame) { text 'Dodaj'; grid(:row => 4, :column => 0) }
    dodajButton.command { Tk::messageBox :message => "#{self.dodaj_ksiazke(Ksiazka.new(tytulEntry.value, autorEntry.value, iloscEntry.value))}" }
    wrocButton = TkButton.new(frame) { text 'Wróć';grid(:row => 4, :column => 1) }
    wrocButton.command { frame.unpack; @menuFrame.pack }
  end

  def usunOkno
    frame = TkFrame.new(@win) { pack }
    tytulLabel = TkLabel.new(frame) { text 'Tytuł'; grid(:row => 0, :column => 0)  }
    tytulEntry = TkEntry.new(frame) { grid(:row => 0, :column => 1)  }
    autorLabel = TkLabel.new(frame) { text 'Autor'; grid(:row => 1, :column => 0)  }
    autorEntry = TkEntry.new(frame) { grid(:row => 1, :column => 1)  }
    dodajButton = TkButton.new(frame) { text 'Usuń'; grid(:row => 4, :column => 0) }
    dodajButton.command { Tk::messageBox :message => "#{self.usun_ksiazke(tytulEntry.value, autorEntry.value)}" }
    wrocButton = TkButton.new(frame) { text 'Wróć';grid(:row => 4, :column => 1) }
    wrocButton.command { frame.unpack; @menuFrame.pack }
  end

  def wypozyczOkno
    frame = TkFrame.new(@win) { pack }

    tytulLabel = TkLabel.new(frame) { text 'Tytuł'; grid(:row => 0, :column => 0)  }
    tytulEntry = TkEntry.new(frame) { grid(:row => 0, :column => 1)  }
    autorLabel = TkLabel.new(frame) { text 'Autor'; grid(:row => 1, :column => 0)  }
    autorEntry = TkEntry.new(frame) { grid(:row => 1, :column => 1)  }
    dodajButton = TkButton.new(frame) { text 'Wypożycz'; grid(:row => 4, :column => 0) }
    dodajButton.command { Tk::messageBox :message => "#{self.wypozycz_ksiazke(tytulEntry.value, autorEntry.value)}" }
    wrocButton = TkButton.new(frame) { text 'Wróć';grid(:row => 4, :column => 1) }
    wrocButton.command { frame.unpack; @menuFrame.pack }
  end

  def oddajOkno
    frame = TkFrame.new(@win) { pack }

    tytulLabel = TkLabel.new(frame) { text 'Tytuł'; grid(:row => 0, :column => 0)  }
    tytulEntry = TkEntry.new(frame) { grid(:row => 0, :column => 1)  }
    autorLabel = TkLabel.new(frame) { text 'Autor'; grid(:row => 1, :column => 0)  }
    autorEntry = TkEntry.new(frame) { grid(:row => 1, :column => 1)  }
    dodajButton = TkButton.new(frame) { text 'Oddaj'; grid(:row => 4, :column => 0) }
    dodajButton.command { Tk::messageBox :message => "#{self.oddaj_ksiazke(tytulEntry.value, autorEntry.value)}" }
    wrocButton = TkButton.new(frame) { text 'Wróć';grid(:row => 4, :column => 1) }
    wrocButton.command { frame.unpack; @menuFrame.pack }
  end

  def wszystkieOkno
    @frameWszystkie = TkFrame.new(@win) { pack }

    @tytulLabel = TkLabel.new(@frameWszystkie) { text 'Autor, Tytuł, Ilość egzemplarzy, Ilość wypożyczeń'; grid(:row => 0, :column => 0)  }
    self.odswiez_liste

    usunButton = TkButton.new(@frameWszystkie) { text 'Usuń książkę'; grid(:row => 3, :column => 0) }
    usunButton.command { Tk::messageBox :message => "#{self.usun_ksiazke(@lista_elementow[$l.curselection.first].tytul, @lista_elementow[$l.curselection.first].autor)}"
    self.odswiez_liste }

    wypozyczButton = TkButton.new(@frameWszystkie) { text 'Wypożycz książkę'; grid(:row => 4, :column => 0) }
    wypozyczButton.command {
      if $l.curselection.empty?
        Tk::messageBox :message => "Nie zaznaczono żadnej książki!"
      else
        Tk::messageBox :message => "#{self.wypozycz_ksiazke(@lista_elementow[$l.curselection.first].tytul, @lista_elementow[$l.curselection.first].autor)}"
        self.odswiez_liste
      end }

    oddajButton = TkButton.new(@frameWszystkie) { text 'Oddaj książkę'; grid(:row => 5, :column => 0) }
    oddajButton.command {
      if $l.curselection.empty?
        Tk::messageBox :message => "Nie zaznaczono żadnej książki!"
      else
        Tk::messageBox :message => "#{self.oddaj_ksiazke(@lista_elementow[$l.curselection.first].tytul, @lista_elementow[$l.curselection.first].autor)}"
        self.odswiez_liste
       end }

    @wrocButton = TkButton.new(@frameWszystkie) { text 'Wróć';grid(:row => 6, :column => 0) }
    @wrocButton.command { @frameWszystkie.unpack; @menuFrame.pack }
  end

  def odswiez_liste
    $l = TkListbox.new(@frameWszystkie) {height 10; width 50; yscrollcommand proc{|*args| $s.set(*args)} }.grid :column => 0, :row => 1, :sticky => 'nwes'
    $s = Tk::Tile::Scrollbar.new(@frameWszystkie) {orient 'vertical'; command proc{|*args| $l.yview(*args)}}.grid :column => 1, :row => 1, :sticky => 'ns'

    self.wszystkie_ksiazki.each{|x| $l.insert 'end', "#{x.autor}, #{x.tytul}, #{x.ilosc}, #{@wypozyczenia[x]}"}
  end
end

biblio = Biblioteka.new
biblio.uruchom
