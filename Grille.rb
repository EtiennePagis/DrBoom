# encoding: UTF-8


class Grille


	load 'Case.rb'

	#
	#Variable de classe contenant
	#une matrice carrée correspondant a notre grille de jeu
	#pile_indice_ver qui est une pile stockant pour le nombre de case a remplir verticalement
	#pile_indice_hor qui est une pile stockant pour le nombre de case a remplir horizontalement
	#nbLigne est le nombre de ligne que contient la matrice
	#nbCol est le nombre de colonne que contient la matrice
	#
	#Les deux dernieres variables servent surtout dans le cas ou nous n'avons pas de grille carré
	#Dans un soucis de comprehension de code nous garderons ces variables
	#
	
	@matrice 
	@pile_indice_ver
	@pile_indice_hor
	@nbLigne
	@nbCol
	
	
	private_class_method :new
	attr_accessor :matrice
	attr_accessor :pile_indice_ver
	attr_accessor :pile_indice_hor
	attr_accessor :nbLigne
	attr_accessor :nbCol
	
	def Grille.Creer(x)
		new(x)
	end

def initialize(x)
	#Initialisation des variables de la grille
		@matrice = Array.new(x){Array.new(x)}
		@pile_indice_ver = Array.new()
		@pile_indice_hor = Array.new()
		@nbLigne = x
		@nbCol = x
		self.ini()
	end
	
	def ini()
	#Initialisation de toutes les valeurs de la grille a 0
		self.definirSolutionAlea()
	end
	
	
	def definirSolutionAlea()
	#Initialisation aléatoire de la grille de solution 
		for i in (0..self.nbLigne-1) do
			for j in (0..self.nbCol-1) do
				@matrice[i][j] = Case.new() 
			end
		end
	end
	
	def afficherGrilleSolu()
		#Change l'affichage de la grille contenant la solution
		for i in (0..self.nbLigne-1) do
			for j in (0..self.nbCol-1) do
				if @matrice[i][j].etatFinal == 0
					 print "0"
					
				elsif @matrice[i][j].etatFinal == 1
					 print "1"
				else 
					 print "X"
				end
				
			end
			print("\n")
		end
		 print("\n")
	end
	
	def afficherGrilleJeu()
		#Change l'affichage de la grille de jeu
		for i in (0..self.nbLigne-1) do
			for j in (0..self.nbCol-1) do
				if @matrice[i][j].etat == 0
					 print "0"
					
				elsif @matrice[i][j].etat == 1
					 print "1"
				else 
					 print "X"
				end
				
			end
			print("\n")
		end
		 print("\n")
	end
	
	def indicage_vertical()
		#Methode qui calcule les indices sur les cases verticales, afin d'initialiser notre jeu
		count = 0
		
		tableau = Array.new() #Tableau servant a garder en memoire les cases a remplir d'une colonne
		0.upto(@nbCol-1){ |i| #On fait un parcours horizontal
			0.upto(@nbLigne -1) { |j|#Parcours vertical
				if(@matrice[j][i].etatFinal == 1) then #Si la valeur de la matrice equivaut a 1 on incremente le compteur
					count += 1 
				elsif(@matrice[j][i].etatFinal == 0 && count > 0) then #Permet de mettre dans notre tableau tampon la valeur d'une suite de 1
					tableau.push(count)
					count = 0
				end
			}
			if (count > 0) then
					tableau.push(count)
					count = 0
			end
			pile_indice_ver.push(tableau) #Recuperation du tableau contenant les indices, on l'empile a la fin afin de garder une coherence en fonction de la grille
			
			tableau = Array.[]
		}
	end
		
	def indicage_horizontal()
		#Methode qui calcule les indices sur les cases horizontales, afin d'initialiser notre jeu
		count = 0
		
		tableau = Array.new() #Tableau servant a garder en memoire les cases a remplir d'une ligne
		@matrice.each{ |i| #On recupere dans i les tableau afin de faire un parcours horizontal
		
			i.each { |j| #Parcours de la matrice a partir du tableau i
				if(j.etatFinal == 1) then #Lorsque la case vaut 1 alors on incremente le compteur
					count += 1 
				elsif(j.etatFinal == 0 && count > 0) then #Permet de mettre dans notre tableau tampon la valeur d'une suite de 1
					tableau.push(count)
					count = 0
				end
			}
			if (count > 0) then
					tableau.push(count)
					count = 0
			end
			@pile_indice_hor.push(tableau) #Recuperation du tableau contenant les indices, on l'empile a la fin afin de garder une coherence en fonction de la grille
			
			tableau = Array.[]
		}
		
	end
		
	
	
	def indice()
		#Methode faisant l'initialisation des indices de toutes la matrice de jeu
		self.indicage_horizontal()
		self.indicage_vertical()
		print "\n\nindice horizontal"
		print @pile_indice_hor
		print "\n\nindice vertical"
		print @pile_indice_ver
		print "\n"
	end


	def verifJeu()
		#Methode de verification de jeu final
		#On verifie donc que toutes les cases remplies sont celles qui doivent etre rempli
		0.upto(@nbCol-1){ |i|
			0.upto(@nbLigne -1) { |j|
				if(!@matrice[i][j].estCorrecte?) then
					return false
				end
			}
		}
		return true
	end
					
end