

ATTRIBUTES = {
   base: [
      'male1',
      'male2',
      'male3',
      'male4',
      'female1',
      'female2',
      'female3',
      'female4',
      'zombie',
      'ape',
      'alien',
      'alien_green',
      'alien_gold',
      'alien_purple_female',
      'orc',
      'orc_female',
      'demon',
      'bot',
      'skeleton',
      'skeleton_female',
      'pink_female',
      'pepe',
      'gold',
      'orange',
      'blue',
      'blue_female',
      'green',
      'green_female',
   ],
   hair: [
      'blonde_bob',
      'crazy_hair_(f)',
      'crazy_hair_(m)',
      'mohawk_dark',
      'peak_spike',
      'purple_hair',
      'straight_hair_blonde',
      'wild_blonde',
      'wild_hair_(m)',
      'wild_hair_(f)',
      'wild_white_hair',
      'half_shaved',
      'mohawk_thin',
      'mohawk',
      'red_mohawk',
      'messy_hair_(m)',
      'messy_hair_(f)',
      'dark_hair',
      'straight_hair',
      'straight_hair_dark',
      'shaved_head',
      'blonde_short',
      'stringy_hair',
      'frumpy_hair_(f)',
      'frumpy_hair_(m)',
      'orange_side',
      'pink_with_hat',
      'clown_hair_green_(f)',
      'clown_hair_green_(m)',
      'clown_hair_blue_(m)',
      'vampire_hair',
      'pigtails', 
   ],
   head: [
      'bandana',
      'cap',
      'cap_forward',
      'cowboy_hat',
      'headband',
      'knitted_cap',
      'top_hat',
      'beanie',
      'do-rag',
      'police_cap',
      'pilot_helmet',
      'tassle_hat',
      'fedora',
      'tiara',
   ],
   eyes: [
      '3d_glasses',
      'big_shades',
      'classic_shades',
      'clown_eyes_green',
      'clown_eyes_blue',
      'nerd_glasses',
      'regular_shades',
      'vr',
      'small_shades',
      'laser_eyes',
      'laser_eyes_gold',
      'eye_mask',
      'horned_rim_glasses',
      'eye_patch',
      'green_eye_shadow',
      'purple_eye_shadow',
      'blue_eye_shadow',
   ],
   beard: [
      'chinstrap',
      'big_beard',
      'luxurious_beard',
      'goat',
      'front_beard_dark',
      'front_beard',
      'normal_beard',
      'normal_beard_black',
      'muttonchops',
      'handlebars',
      'shadow_beard',
      'mustache',
   ],
   more: [
      'clown_nose',
      'earring',
      'hoodie',
      'choker',
      'pipe',
      'cigarette',
      'vape',
      'gold_chain',
      'silver_chain',
      'spots',
      'mole',
      'rosy_cheeks',
      'black_lipstick',
      'purple_lipstick',
      'hot_lipstick',  
      'medical_mask',
      'buck_teeth',
],
}.reduce( {} ) do |h,(category, names)| 
     names.each do |name|
        key = File.basename( name ).downcase.gsub( /[^a-z0-9]/, '' )

        ## fix-up file path by category
        path =  category == :base ? name : "#{category}/#{name}"

        puts "  #{key} / #{category}"
        if h.has_key?( key )
          puts "!! ERROR - duplicate key >#{key}<; already in use; sorry"
          exit 1
        end

        h[ key ] = Image.read( "./attributes/#{path}.png" )
     end
     h
end




def generate( *attributes )
   base = Image.new( 12,12 )
   
   ## normalize attribute names 
   keys = attributes.map { |attribute| attribute.downcase.gsub( /[^a-z0-9]/, '' ) }

   ## check for male/female gender
   gender = keys[0].index( 'female' ) ? 'f' : 'm'

   keys.each_with_index do |key,i|
        img = nil
        img = ATTRIBUTES[ "#{key}#{gender}" ]   if i > 0    ## try gender-specific first for accessores (not base e.g. i==0)
        img = ATTRIBUTES[ key ]    unless img       
        if img.nil?
           puts "!! attribute with key #{key} not found; sorry"
           exit 1
        end
        base.compose!( img )
   end
   base
end



