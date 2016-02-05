# encoding: UTF-8

##
# Auteur JORIS TOULMONDE
# Version 0.1 : Date : Wed Jan 27 09:00:27 CET 2016
#

load 'VueCase.rb'
require 'gtk2'

class Vue

	@fenetre

	private_class_method :new

	def initialize
		@fenetre = Gtk::Window.new("Picross")
		@fenetre.set_window_position(Gtk::Window::POS_CENTER)
		@fenetre.set_resizable(false)
	end

end 

