require File.dirname(__FILE__) + '/test_helper.rb'
require "activesupport"

class Person
  attr_accessor :name, :age, :eye_color
  def initialize(_name, _age, _eye_color)
    @name = _name
    @age = _age
    @eye_color = _eye_color
  end
end

class TestArrayExtensions < Test::Unit::TestCase

  context "An array with objects" do
    
    setup do 
      @people = []
      # Setup an array of users with names and ages
      [["Jason", 31, "brown"],
      ["Ross", 28, 'blue'],
      ["Josh", 29, 'green'],
      ["Patrick", 24, 'blue'],
      ["Danny", 28, 'brown']].each do |name, age, eye_color|
        person = eval("@#{name.downcase} = Person.new('#{name}', #{age}, '#{eye_color}')")
        @people << person
      end
    end
    
    should "be sortable by a names" do 
      sort_list = %w(Ross Patrick Josh Jason Danny) #different from current array
      sorted_people = @people.sort_by_list(sort_list) do |person|
        person.name
      end
      
      assert sorted_people.first == @ross
      assert sorted_people[1] == @patrick
      assert sorted_people[-1] == @danny
      
      
    end
    
    should 'be sortable by eye color' do 
      sort_list = %w(blue green brown) #different from current array
      sorted_people = @people.sort_by_list(sort_list) do |person|
        person.eye_color
      end
      
      assert sorted_people[0..1].include?(@patrick)
      assert sorted_people[0..1].include?(@ross)
      assert sorted_people[2] == @josh
      assert sorted_people[3..4].include?(@jason)
      assert sorted_people[3..4].include?(@danny)
       
    end
    
    should "have distinct items based upon an attribute" do 
      by_name = @people.uniquify{|person| person.name}
      by_age = @people.uniquify{|person| person.age}
      by_eye_color = @people.uniquify{|person| person.eye_color}
      
      assert by_name.length == 5
      assert by_age.length == 4
      assert by_eye_color.length == 3
      
    end
  end

end
