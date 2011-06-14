module DuckChain
  module Toolset
    # Generic helper method that ensures whatever is passed into it is an array.
    # If it's not, make it one.
    def self.set_as_array(value)
      value.is_a?(Array) ? value : [value]
    end

    # Creates 'eq' class methods for the model
    # Ex:: Post.title_eq("Why do my feet smell?")
    # Methods created include...
    # * eq
    # * equals
    # * is
    # * in
    # * neq
    # * not_equal
    # * is_not
    # * does_not_equal
    # * not_in
    # A string, array, or a range may be passed into these created methods.
    # Passing an array or range will result in a IN clause in the resulting SQL.
    def self.create_eq_methods(model_attributes)
      Toolset.set_as_array(model_attributes).each do |m|
        ['eq','equals','is','in'].each do |suffix|
          self.class.send(:define_method, "#{m}_#{suffix}", Proc.new{ |search_term| 
              if search_term.is_a?(Array) || search_term.is_a?(Range)
                where(["#{m} IN (?)", search_term])               
              else
                where(["#{m} = ?", search_term])
              end
            } 
          )
        end

        ['neq','not_equal','is_not','does_not_equal','not_in'].each do |suffix|
          self.class.send(:define_method, "#{m}_#{suffix}", Proc.new{ |search_term| 
              if search_term.is_a?(Array) || search_term.is_a?(Range)
                where(["? NOT IN (?)", m, search_term])               
              else
                where(["? != ?", m, search_term])
              end
            } 
          )
        end
      end
    end
    
    # Creates 'like' class methods for the model
    # Ex:: Post.title_like("Foo")
    # Methods created include...
    # * like
    # * begins_with
    # * ends_with
    # * not_like
    # * not_begin_with
    # * not_end_with
    def self.create_like_methods(model_attributes)
      Toolset.set_as_array(model_attributes).each do |m|
        self.class.send(:define_method, "#{m}_like", Proc.new{ |search_term| where(["? LIKE (?)", m, "%#{search_term}%"])} )
        self.class.send(:define_method, "#{m}_begins_with", Proc.new{ |search_term| where(["? LIKE (?)", m, "#{search_term}%"])} )
        self.class.send(:define_method, "#{m}_ends_with", Proc.new{ |search_term| where(["? LIKE (?)", m, "%#{search_term}"])} )

        self.class.send(:define_method, "#{m}_not_like", Proc.new{ |search_term| where(["? NOT LIKE (?)", m, "%#{search_term}%"])} )
        self.class.send(:define_method, "#{m}_not_begin_with", Proc.new{ |search_term| where(["? NOT LIKE (?)", m, "#{search_term}%"])} )
        self.class.send(:define_method, "#{m}_not_end_with", Proc.new{ |search_term| where(["? NOT LIKE (?)", m, "%#{search_term}"])} )
      end
    end

    # Creates 'range' class methods for the model
    # Ex:: Post.comment_counter_gt(5)
    # Methods created include...
    # * gt
    # * greater_than
    # * gte
    # * greater_than_or_equal_to
    # * lt
    # * less_then
    # * lte
    # * less_than_or_equal_to
    def self.create_range_methods(model_attributes)
      Toolset.set_as_array(model_attributes).each do |m|
        ['gt','greater_than'].each do |suffix|
          self.class.send(:define_method, "#{m}_#{suffix}", Proc.new{ |search_term| where(['? > ?', m, search_term])} )
        end
        ['gte','greater_than_or_equal_to'].each do |suffix|
          self.class.send(:define_method, "#{m}_#{suffix}", Proc.new{ |search_term| where(['? >= ?', m, search_term])} )
        end
        ['lt','less_than'].each do |suffix|
          self.class.send(:define_method, "#{m}_#{suffix}", Proc.new{ |search_term| where(['? < ?', m, search_term])} )
        end
        ['lte','less_than_or_equal_to'].each do |suffix|
          self.class.send(:define_method, "#{m}_#{suffix}", Proc.new{ |search_term| where(['? <= ?', m, search_term])} )
        end
      end
    end

  end
end
