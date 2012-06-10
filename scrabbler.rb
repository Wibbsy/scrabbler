#!/usr/bin/ruby

#Poorly Scripted by hax0rMagee
#A script that generates a possible password list based on what the user already knows about password

   ####    ####   #####     ##    #####   #####   #       ######  #####
  #       #    #  #    #   #  #   #    #  #    #  #       #       #    #
   ####   #       #    #  #    #  #####   #####   #       #####   #    #
       #  #       #####   ######  #    #  #    #  #       #       #####
  #    #  #    #  #   #   #    #  #    #  #    #  #       #       #   #
   ####    ####   #    #  #    #  #####   #####   ######  ######  #    #

$dictionary = "dictionary.txt"
$wlength = 1000000;


def chunk
	#checks to see if password contains chunk of word-- (-c)
	puts "\nSearching Dictionary for words containing #{$characters}...";
	File.open($dictionary).each { |line| 		
		
		if $exactLength == true
			puts line if line.chomp.length == $wlength && line.include?($characters);
		
		else 
			puts line if line.length <= $wlength && line.include?($characters);
		end	
	}
end

def containsLetters
	#search for words containing $characters in any order (-r)
	puts "Searching for words that contain #{$characters}\n\n";
	File.open($dictionary).each { |line| 
		if $exactLength == true		
			if line.chomp.length == $wlength
				puts line unless $characters.each_char.map { |c| line.include?(c) }.include? false
			end
			
		elsif line.chomp.length <= $wlength
			puts line unless $characters.each_char.map { |c| line.include?(c) }.include? false	
		end
	}
end

def chunkAndLetters
	# checks to see if it contains random letters and a chunck (-b)
	temp = File.open("temp.txt", "w");
	File.open($dictionary).each { |line| 
				
		unless $followedBy.each_char.map { |c| line.include?(c) }.include? false	
			temp.syswrite(line);
		end
	}
	#temp.close;
	File.open("temp.txt").each { |line| 
		if $exactLength == true
			puts line if line.include?($characters) && line.chomp.length == $wlength
	
		elsif line.include?($characters) && line.chomp.length <= $wlength
			puts line
		end
	}
	File.delete("temp.txt")	
	
end

def lengthOption
	pos = 1;
	ARGV.each do |x|
		if x == "-l"
			$lengthbool = true
			$wlength = Integer(ARGV[pos]);
		elsif x == "-x"
			$exactLength = true
			$wlength = Integer(ARGV[pos]);

		end
		pos += 1;
	end
	
end

def customDictionary
	customDictionary = true
	position = 1
	ARGV.each do |x|
		if x == "-d"
			puts "custom dictionary found"
			$dictionary = ARGV[position];
		end
	position += 1
	end	
end

####################################################################################################
if ARGV.length < 1
	puts "\n\nUsage: scrabbler <options>";
	puts "  -c --> if you know a chunk of the password";
	puts "  -r --> if you know any characters of the password but not the order";
	puts "  -b --> takes two arguments. chunk of password and random characters\n";
	puts "  -l --> specify a maximum word length";
	puts "  -x --> specify an exact length";
	puts "  -d --> specify your own dictionary file\n\n";
	#puts "-o --> specify an output file\n\n";
end

customDictionary
lengthOption


if ARGV[0] == "-c";
	$characters = ARGV[1];
	chunk;
end

if ARGV[0] == "-r";
	$characters = ARGV[1];
	containsLetters;
end

if ARGV[0] == "-b" 
	$characters = ARGV[1];
	$followedBy = ARGV[2];
	puts "\n\nSearching for words containing the chunk #{$characters}";
	puts "That also contain the letters #{$followedBy}\n\n";
	chunkAndLetters;
end
