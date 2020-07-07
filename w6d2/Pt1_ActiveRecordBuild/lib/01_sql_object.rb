require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name} 
    SQL

    columns.first.map { |column| column.to_sym }
  end

  def self.finalize!
    columns = self.columns
    columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end

      define_method("#{column}=") do |arg|
        self.attributes[column] = arg
      end
  
    end
  end

  def self.table_name=(new_name)
    @table_name = new_name
  end

  def self.table_name
    self.to_s.downcase + 's'
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |key, val|
      raise 'not in table' unless self.class.columns.include?(key)
      key = key.to_sym 

    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
