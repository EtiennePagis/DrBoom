# encoding: UTF-8

##
# Auteur JORIS TOULMONDE
# Version 0.1 : Date : Thu Jan 28 09:54:43 CET 2016
#

load 'Controleur.rb'
load 'Grille.rb'
load 'VueGrille.rb'
require 'gtk2'

class ControleurPartie < Controleur

	@@pile = Array.new()
	@@hypo = false
	@@compteur = 0
	@image = Gtk::Image.new("./modeon.png")
	@uneVue

	attr_reader :uneVue
	
	def ControleurPartie.Creer(uneGrille)
		new(uneGrille)
	end

	def initialize(uneGrille)

		@uneVue = VueGrille.Creer(uneGrille)
		@uneVue.table.each do |uneCase|
			uneCase.signal_connect("button_press_event") do
				Gdk::Display.default.pointer_ungrab(Gdk::Event::CURRENT_TIME)
				if(@uneVue.grille.verifJeu) then
					Gtk.main_quit
				end
			end
			
			uneCase.signal_connect("button_release_event") do
				Gdk::Display.default.pointer_ungrab(Gdk::Event::CURRENT_TIME)
				if @@hypo==true then
					@@compteur += 1
				end
				print(@uneVue.grille.matrice[uneCase.i][uneCase.j].etat)
				@@pile.push(uneCase)
				@uneVue.actualiserCase(uneCase.i, uneCase.j)
				@uneVue.grille.verifJeu
			end	
		
		end

		@uneVue.quitter.signal_connect('clicked'){
			quitter
		}

		@uneVue.annulerCoup.signal_connect('clicked'){
			annuler
		}

		@uneVue.hypothese.signal_connect('clicked'){
			hypothese
			@uneVue.hypothese.image=(@image)
		}
		
	end

	def annuler
		if !@@pile.empty? then
			laCaseAvant = @@pile.pop
			@uneVue.actualiserCase(laCaseAvant.i, laCaseAvant.j)
		end
	end

	def hypothese
		if @@hypo == true then
			0.upto(@@compteur-1) do
				annuler
			end
			@@hypo = false	
			
		elsif @@hypo == false
			@@hypo = true
			@@compteur = 0
		end
	end
		

Gtk.init
jeu = ControleurPartie.Creer(Grille.Creer(5))
jeu.uneVue.grille.afficherGrilleSolu()
Gtk.main

end 


