# encoding: UTF-8

require 'gtk2'

	@tempsAccumule
    @tempsPasse
    @debut
	@boutonDebut
	@timer
	@timerArrete
	@labelMessage

class Timer

  def debut
    @tempsAccumule ||= 0 #permet d'assigner à la variable @tempsAccumule la valeur de 0 si @tempsAccumule n'est pas vrai
    					 #De cette façon, @tempsAccumule sera toujours définie.
    @tempsPasse = 0

    @debut = Time.now

    @timerArrete = false

    @timer = Thread.new() do
      until @timerArrete do
        sleep(1)
        self.afficheToi() unless @timerArrete
      end #end until
    end #end thread
  end #end methode debut
#-----------------------
  def remiseAZero
  	self.pause()
    @tempsAccumule = 0
    @tempsPasse = 0
    @labelMessage.set_text("00:00:00")
  end#end remiseAZero
#-----------------------
  def pause
    @timerArrete = true
    @tempsAccumule += @tempsPasse
  end#end pause
 #-----------------------
  def afficheToi
	@tempsPasse = Time.now - @debut
    time = @tempsAccumule + @tempsPasse
    h = time.to_i / 3600
    m = (time.to_i % 3600) / 60
    s = time.to_i % 60

    heures = h < 10 ? "0" + h.to_s : h.to_s
	minutes = m < 10 ? "0" + m.to_s : m.to_s
	secondes = s < 10 ? "0" + s.to_s : s.to_s

    @labelMessage.set_text("#{heures}:#{minutes}:#{secondes}")
  end#end afficheToi
#-----------------------
  def initialize
    Gtk.init

    maFenetre = Gtk::Window.new()
	
	maFenetre.set_title("Timer")
	maFenetre.set_default_size(300, 200)
	maFenetre.set_window_position(Gtk::Window::Position::CENTER)
	maFenetre.signal_connect('destroy') do
		puts "Fin de l'application"
		Gtk.main_quit()
	end

	vBox = Gtk::VBox.new(true, 5)

    maFenetre.add(vBox)

    @labelMessage = Gtk::Label.new("00:00:00")
    vBox.pack_start(@labelMessage)

    #Permet de lancer ou de relancer le timer
    @boutonDebut = Gtk::Button.new('Lancer')
    @boutonDebut.signal_connect('clicked') do
    	self.debut()
    end
    vBox.pack_start(@boutonDebut)

    #Permet de mettre en pause le timer
    @boutonPause = Gtk::Button.new('Pause')
    @boutonPause.signal_connect('clicked') do
    	self.pause()
    end
    vBox.pack_start(@boutonPause)

    #Permet de remettre à zéro le timer
    @boutonRAZ = Gtk::Button.new('Remise a zero')
    @boutonRAZ.signal_connect('clicked') do
    	self.remiseAZero()
    end
    vBox.pack_start(@boutonRAZ)

    #Permet de quitter l'application
    @boutonQuitter = Gtk::Button.new('Quitter')
    @boutonQuitter.signal_connect('clicked') do
    	puts "Fin de l'application"
		Gtk.main_quit()
    end
    vBox.pack_start(@boutonQuitter)

    maFenetre.signal_connect('destroy') do
    	Gtk.main_quit
    end
    maFenetre.show_all

    Gtk.main()
  end
end#end initialize
#-----------------------
Timer.new
