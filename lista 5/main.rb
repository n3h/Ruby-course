require 'open-uri'

class PrzegladarkaSerwisow
  def initialize
    @przegladniete_podstrony = []
  end

  def przeglad(start_page, depth, block)
    przeglad_rek(start_page, '/', depth, block)
  end
  def przeglad_rek(start_page, arg, depth, block)
    return if depth < 0

    @przegladniete_podstrony << arg
    #reg_http = /<a href=["'](#{start_page})(.*)["']/
    reg_http = /<a href=["']([\w,-.\/]*)["']/
    open(start_page + arg) {|x|
      x.each_line {|line|
        block.call(line)
        adresy = line.scan(reg_http)
        #puts adresy
        adresy.each { |x|
          #p x
          if x[0][0] != "/"
            x[0] = "/"+x[0]
          end
          #puts x
          if (!@przegladniete_podstrony.include?(x[0])) #&& (not x[2] =~ /"/)
            przeglad_rek(start_page, x[0], depth - 1, block)
          end
        }
      }
    }


  end

  def page_weight(page)
    ilosc = 0;
    reg_elementy = /(\.png|\.jpg|\.JPG|\.jpeg|\.JPEG|\.class|\.CLASS)/
    open(page) {|x|
      x.each_line {|line|
        ilosc += line.scan(reg_elementy).count
      }
    }
    puts ilosc
  end

  def page_summary(page)
    reg_tytul = /<title>(.*)<\/title>/
    reg_meta = /(META|meta)\s(NAME|name|http-equiv|HTTP-EQUIV)=["'](.*)["']\s(CONTENT|content)=["'](.*)["']/
    open(page) {|x|
      x.each_line {|line|
        puts "Tytul: #{$1}" if line =~ reg_tytul
        puts "#{$3}: #{$5}" if line =~ reg_meta
      }
    }
  end
end
@i = 0
p = PrzegladarkaSerwisow.new
t1 = Time.now
#p.page_weight('http://wp.pl')
#p.page_summary('http://wp.pl')
#p.przeglad('http://wiadomosci.wp.pl', 0, lambda{|x| @i += x.scan(/\.png/).count})
p.przeglad('http://wmi.uni.wroc.pl', 1, lambda{|x| @i += x.scan(/\.png/).count })
t2 = Time.now
puts @i
puts (t2-t1)