# encoding: UTF-8

##
# Auteur JORIS TOULMONDE
# Version 0.1 : Date : Thu Jan 28 09:54:55 CET 2016
#

require 'gtk2'

class Controleur

	@uneVue

	attr :vue
	private_class_method :new

	def initialize
	end

	def quitter
		Gtk.main_quit
	end

end 
