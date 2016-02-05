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

class VueGrille < Vue

	@taille
	@table
	@matriceGrille

	@annulerCoup
	@hypothese
	@indice
	@quitter

	attr_reader :annulerCoup, :quitter, :hypothese, :indice

	attr :table

	def VueGrille.Creer(uneTaille)
		new(uneTaille)
	end

	def initialize(uneTaille)
	
		super()
		@taille = uneTaille

		hbox = Gtk::HBox.new(true, 5)
		
		@fenetre.add(hbox)
		
		hbox.pack_start(grilleCreer)
		hbox.pack_start(barreAide)

		@fenetre.show_all
		
	end	

	def barreAide
	
		menu = Gtk::VBox.new(true, 5)
		@annulerCoup = Gtk::Button.new("Annuler Coup", true)
		@hypothese = Gtk::Button.new("Hypothèse", true)
		@indice = Gtk::Button.new("Indice", true)
		@quitter = Gtk::Button.new("Quitter", true)
		menu.add(@indice)
		menu.add(@hypothese)
		menu.add(@annulerCoup)
		menu.add(@quitter)
		return menu
		
	end
		

	def grilleCreer

		@table = Gtk::Table.new(@taille,@taille, true)
		@matriceGrille = Array.new(@taille){Array.new(@taille)}

		0.upto(@taille-1){ |x|
			0.upto(@taille-1){ |y|
				uneCase = VueCase.Creer("caseblanche", @taille, @matriceGrille,x,y)
				@table.attach(uneCase,y,y+1,x,x+1)
				@matriceGrille[x][y] = uneCase
			}
		}
		
		@table.set_row_spacings(1)
		@table.set_column_spacings(1)

		4.step(@taille, 5) do |i|
			@table.set_row_spacing(i, 3)
			@table.set_column_spacing(i, 3)
		end
	
		return @table
		
	end

	def actualiserGrille
		0.upto(@taille-1) do |i|
			0.upto(@taille-1) do |j|
				print
			end		
		end
	end

	def actualiserCase(i,j)
		if @matriceGrille[i][j].couleur == "caseblanche" then
			@matriceGrille[i][j].changerCouleurImage("casenoire")
			@matriceGrille[i][j].couleur = "casenoire"
			
		elsif @matriceGrille[i][j].couleur == "casenoire" then
			@matriceGrille[i][j].changerCouleurImage("caseblanche")
			@matriceGrille[i][j].couleur = "caseblanche"
		end
	end
end