#GAUTIER Antoine

# encoding: UTF-8

class Case
	@etat
	@etatFinal
	
	# Get & Set
	attr_accessor :etat, :etatFinal
	
	# 
	# Affichage de la case, on affiche son etat actuel
	#
	def to_s()
		return "#{@etat}"
	end

	# === Principe
	# initialisation de :
	# +etat+ à 0
	# +etatFinal à 0
	def initialize()
		@etat = 0
		@etatFinal = 0
		
	end
		
	# === Principe
	# +etat+ vaut desormais 1 (case noire), sans se soucier de l'etat precedent.
	def noircir()
		@etat = 1
	end
	
	# === Principe
	# +etat+ vaut desormais 0 (case blanche), sans se soucier de l'etat precedent.
	def blanchir()
		@etat = 0
	end
		
	# === Principe
	# +etat+ vaut desormais 2 (case croix), sans se soucier de l'etat precedent.
	def griser() 
		@etat = 2
	end	
	
	# === Principe
	# retourne l'egalité entre l'etat de la case et son etat final
	def estCorrecte?()
		return @etat == @etatFinal
	end
	
	
end
