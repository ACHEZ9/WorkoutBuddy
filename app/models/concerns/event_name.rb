module EventName
  #Load
     def load
         amounts.each do |amount|
             proxy_association.target << amount
         end
     end

     #Private
     private

     #Amounts
     def amounts
         return_array = []
         through_collection.each_with_index do |through,i|
             associate = through.send(reflection_name)
             associate.assign_attributes({amount: items[i]}) if items[i].present?
             return_array.concat Array.new(1).fill( associate )
         end
         return_array
     end

     #######################
     #      Variables      #
     #######################

     #Association
     def reflection_name
         proxy_association.source_reflection.name
     end

     #Foreign Key
     def through_source_key
         proxy_association.reflection.source_reflection.foreign_key
     end

     #Primary Key
     def through_primary_key
         proxy_association.reflection.through_reflection.active_record_primary_key
     end

     #Through Name
     def through_name
         proxy_association.reflection.through_reflection.name
     end

     #Through
     def through_collection
         proxy_association.owner.send through_name
     end

     #Captions
     def items
         through_collection.map(&:amount)
     end

     #Target
     def target_collection
         #load_target
         proxy_association.target
     end
