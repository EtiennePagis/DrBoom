#GAUTIER Antoine

# encoding: UTF-8


load 'Grille.rb'

class Editeur

	@maGrille
	
	#Get & Set
	attr_accessor :maGrille
	
	
	# == Createur
	# === Attributs
	# +x+ : correspond a la taille (largeur & hauteur de la grille)
	private_class_method :new
	def Editeur.creer(x)
		new(x)
	end
	
	# ==Initialize
	# === Attributs
	# +x+ : on utilisateur le createur de grille.
	# l'utilisateur sera placé sur une grille blanche (comme une nouvelle partie)
	def initialize(x)
		@maGrille =  Grille.creer(x)
	end
	
	 
	
	# === Methode Validation
	# * +Principe+ :
	# On fait correspondre la solution de la grille avec l'etat actuel
	# * +return+ : self (la grille apres application de la solution
	def valider()	
		for i in (0..self.maGrille.nbLigne-1) do
			for j in (0..self.maGrille.nbCol-1) do
				self.maGrille.matrice[i][j].etatFinal = self.maGrille.matrice[j][i].etat 
			end
		end
		
		return self.maGrille
		
	end
	
end
