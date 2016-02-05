# encoding: UTF-8

##
# Auteur JORIS TOULMONDE
# Version 0.1 : Date : Thu Jan 28 09:04:45 CET 2016
#

require 'gtk2'

class VueCase < Gtk::EventBox

	@couleur
	@taille
	@grille
	@image
	@i
	@j


	attr_reader :grille, :taille, :i, :j
	attr_accessor :couleur
	private_class_method :new

	def VueCase.Creer(uneCouleur, uneTaille, uneGrille, i, j)
		new(uneCouleur, uneTaille, uneGrille, i, j)
	end

	def initialize(uneCouleur, uneTaille, uneGrille, i, j)
		super()

		@couleur = uneCouleur
		@taille = uneTaille
		@grille = uneGrille
		@i = i
		@j = j
		
		changerCouleurImage(uneCouleur)

	end

	def changerCouleurImage(uneCouleur)
		remove(@image) if not @image.nil?
		configurerImage(uneCouleur)
		add(@image)
		show_all
	end
		

	def configurerImage(uneCouleur)
		if uneCouleur == "caseblanche"
			@image = Gtk::Image.new("./caseblanche.jpg")
		elsif uneCouleur == "casenoire"
			@image = Gtk::Image.new("./casenoire.jpg")
		elsif uneCouleur == "croix"
			@image = Gtk::Image.new("./croix.png")
		end
	end
	
end 
