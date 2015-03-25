require 'open-uri'
require 'monitor'

class PrzegladarkaSerwisow
  def initialize
    @przegladniete_podstrony = []
    @threads = [] #!
    @lock2 = Monitor.new
    @lock3 = Monitor.new
  end

  def przeglad(start_page, depth, block)
    przeglad_rek(start_page, '/', depth, block)
    @threads.each { |t| t.join() } #!
  end
  def przeglad_rek(start_page, arg, depth, block)
    #puts @threads.count
    return if depth < 0

    #!
    #@lock3.synchronize do
    #  return if @przegladniete_podstrony.include?(arg)
    #  @przegladniete_podstrony << arg
    #end

    #reg_http = /<a href=["'](#{start_page})(.*)["']/
    reg_http = /<a href=["']([\w,-.\/]*)["']/ # inicjalizowac tylko raz!
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
          @lock2.synchronize do
          if (!@przegladniete_podstrony.include?(x[0])) #&& (not x[2] =~ /"/)
            @threads << Thread.new(x[0]) do
              przeglad_rek(start_page, x[0], depth - 1, block)
            end
          end
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
@lock = Monitor.new
p = PrzegladarkaSerwisow.new
#p.page_weight('http://wp.pl')
#p.page_summary('http://wp.pl')
#p.przeglad('http://wiadomosci.wp.pl', 0, lambda{|x| @i += x.scan(/\.png/).count})
#p.przeglad('http://wmi.uni.wroc.pl', 1, lambda{|x| @lock.synchronize { @i += x.scan(/\.png/).count } })
t1 = Time.now
p.przeglad('http://wmi.uni.wroc.pl', 1,
           #@lock.synchronize {
             lambda{|x|  @i += x.scan(/\.png/).count
           #  }
           })
t2 = Time.now
puts @i
puts (t2-t1)