class AttrAccessorObject

  def self.my_attr_accessor(*names)
    names.each do |name|
      attributes = <<-CODE
        def #{name}
          @#{name}
        end

        def #{name}=(val)
          @#{name} = val
        end
      CODE
      class_eval(attributes)
    end
  end

end
