class Array
  
  # # Example
  # 
  # class Person
  #   attr_accessor :type, :name, :source
  #   def initialize(options)
  #     @type=options[:type]
  #     @name=options[:name]
  #     @source=options[:source]
  #   end
  # end
  # 
  # type_sort_list = %w(User Admin Salesman)
  # source_sort_list = %w(web email direct mail television)
  # myarr = []
  # myarr << Person.new(:source=>"direct", :type=>"Admin", :name=>"Jason")
  # myarr << Person.new(:source=>"mail", :type=>"User", :name=>"Xavier")
  # myarr << Person.new(:source=>"email", :type=>"User", :name=>"Josh")
  # myarr << Person.new(:source=>"email", :type=>"Salesman", :name=>"Pablo")
  # myarr << Person.new(:source=>"web", :type=>"User", :name=>"Pat")
  # myarr << Person.new(:source=>"television", :type=>"Salesman", :name=>"Ross")
  # 
  # # Sort by type
  # sorted_by_type_myarr = myarr.sort_by_list(type_sort_list) do |item|
  #   item.type
  # end
  # puts sorted_by_type_myarr.to_yaml
  # 
  # 
  # # Sort by source
  # sorted_by_source_myarr = myarr.sort_by_list(source_sort_list) do |item|
  #   item.source
  # end
  # puts sorted_by_source_myarr.to_yaml

  def sort_by_list(ordered_list, &block)
    new_ol = ordered_list.inject({}){|new_hash, sort_item| new_hash[sort_item] = ordered_list.index(sort_item); new_hash}
    sorted = self.map{|item| [item, new_ol[block.call(item)] || 0]}.sort_by{|item| item[1]}.map{|item| item[0]}
  end
  
  def uniquify(&block)
    items = []
    comparables = self.map{|item| block.call(item)}
    added_list = []
    self.each do |item|
      parsed = block.call(item)
      unless added_list.include?(parsed)
        added_list << parsed
        items << item 
      end
    end
    items
  end
  
end