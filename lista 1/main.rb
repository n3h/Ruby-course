def pascal(n)
  linia_poprzednia = [1] #linia pierwsza, zawsze "1"
  puts linia_poprzednia

  #obliczam kolejną linię, wiedząc, że element z lewej i prawej strony to "1", a środek mogę obliczyć na podstawie poprzedniej linii;
  (n - 1).times do
    linia_nastepna = [1]

    for i in 1..(linia_poprzednia.length - 1)
      linia_nastepna << (linia_poprzednia[i - 1] + linia_poprzednia[i])
    end
    linia_nastepna << 1

    puts linia_nastepna.join(" ")

    linia_poprzednia = linia_nastepna
  end
end

puts "Zadanie 2:"
argument_pascal = gets.chomp
pascal(argument_pascal.to_i)

def podzielniki(n)
  dzielniki = [] #tablica dzielników, zwracana na koniec działania funkcji

  #sprawdzam liczby <2, n> czy są dzielnikami danej liczby
  for i in 2..n # lub (n-1) jeśli podzielniki mają być mniejsze od danej liczby
    if n % i == 0
      if czy_pierwsza(i) # jeśli znalazłem liczbę, która jest dzielnikiem, sprawdzam czy jest to liczba pierwsza
        dzielniki << i
      end
    end
  end
  return dzielniki
end

def czy_pierwsza(n)
  for i in 2..(Math.sqrt(n))
    return false if n % i == 0
  end
  return true
end


puts "Zadanie 4:"; argument_podzielniki = gets.chomp; print podzielniki(argument_podzielniki.to_i)



#wszystko w jednej funkcji
def podzielniki2(n)
  dzielniki = [] #tablica dzielników, zwracana na koniec działania funkcji

  #sprawdzam liczby <2, n> czy są dzielnikami danej liczby
  for i in 2..(n) # lub (n-1 jeśli bez danej pierwszej liczby)
    if n % i == 0
      # jeśli znalazłem liczbę, która jest dzielnikiem, sprawdzam czy jest to liczba pierwsza
      pierwsza = true
      for j in 2..(Math.sqrt(i))
        pierwsza = false if i % j == 0
      end
      if pierwsza
        dzielniki << i
      end
    end
  end
  return dzielniki
end

#puts "Zadanie 4b:" ; argument_podzielniki2 = gets.chomp; print podzielniki2(argument_podzielniki2.to_i)
