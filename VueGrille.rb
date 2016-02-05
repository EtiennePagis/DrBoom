# encoding: UTF-8

##
# Auteur JORIS TOULMONDE
# Version 0.1 : Date : Fri Feb 05 09:23:56 CET 2016
#
load 'Vue.rb'

class VueGrille < Vue

	@grille
	@table
	@matriceGrille

	@annulerCoup
	@hypothese
	@indice
	@quitter

	attr_reader :annulerCoup, :quitter, :hypothese, :indice

	attr :table, :grille

	def VueGrille.Creer(uneGrille)
		new(uneGrille)
	end

	def initialize(uneGrille)
	
		super()
		@grille = uneGrille
		@grille.indice

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


	def indiceHorizontal(indice)
		verticalBox = Gtk::VBox.new()
		unless indice.empty?
			indice.each do |chiffre|
				labelChiffre = Gtk::Label.new
				labelChiffre.set_markup(chiffre.to_s)
				verticalBox.add(labelChiffre)
			end
		end
		return verticalBox
	end

	def indiceVertical(indice)
		horizontalBox = Gtk::HBox.new()
		unless indice.empty?
			indice.each do |chiffre|
				labelChiffre = Gtk::Label.new
				labelChiffre.set_markup(chiffre.to_s+" ")
				horizontalBox.add(labelChiffre)
			end
		end
		return horizontalBox
	end

	def grilleCreer

		taille = @grille.nbCol

		@table = Gtk::Table.new(taille+3,taille+3, false)
		@matriceGrille = Array.new(taille){Array.new(taille)}

		0.upto(taille-1) do |i|
			@table.attach(indiceHorizontal(@grille.pile_indice_ver[i]), i+2, i+3, 1, 2)
		end

		0.upto(taille-1) do |j|
			@table.attach(indiceVertical(@grille.pile_indice_hor[j]), 1, 2, j+2, j+3)
		end

		0.upto(taille-1){ |x|
			0.upto(taille-1){ |y|
				uneCase = VueCase.Creer("caseblanche", taille, @grille,x,y)
				@table.attach(uneCase,y+2,y+3,x+2,x+3)
				@matriceGrille[x][y] = uneCase
			}
		}
		
		@table.set_row_spacings(1)
		@table.set_column_spacings(1)

		6.step(taille, 5) do |i|
			@table.set_row_spacing(i, 3)
			@table.set_column_spacing(i, 3)
		end
	
		return @table
		
	end

	def actualiserGrille
		taille = @grille.nbCol
		0.upto(taille-1) do |i|
			0.upto(taille-1) do |j|
				print
			end		
		end
	end

	def actualiserCase(i,j)
		if @matriceGrille[i][j].couleur == "caseblanche" && @grille.matrice[i][j].etat == 0 then
			@matriceGrille[i][j].changerCouleurImage("casenoire")
			@matriceGrille[i][j].couleur = "casenoire"
			@grille.matrice[i][j].noircir
			
		elsif @matriceGrille[i][j].couleur == "casenoire" && @grille.matrice[i][j].etat == 1 then
			@matriceGrille[i][j].changerCouleurImage("croix")
			@matriceGrille[i][j].couleur = "croix"
			@grille.matrice[i][j].griser

		elsif @matriceGrille[i][j].couleur == "croix" && @grille.matrice[i][j].etat == 2 then
			@matriceGrille[i][j].changerCouleurImage("caseblanche")
			@matriceGrille[i][j].couleur = "caseblanche"
			@grille.matrice[i][j].blanchir
		end
	end
end

