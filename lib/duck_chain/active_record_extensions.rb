module DuckChain

  # Methods that extend ActiveRecord and allows duck_chain to work
  module ActiveRecordExtensions   

    # The generic call which will generate all methods for the model
    def duck_chain(*model_attributes)
      Toolset.create_eq_methods(model_attributes)
      Toolset.create_like_methods(model_attributes)
      Toolset.create_range_methods(model_attributes)
    end

    # Takes the list of model attributes calls the create method from DuckChain::Toolset
    # to generate the 'eq' methods 
    def duck_chain_eq(*model_attributes)
      Toolset.create_eq_methods(model_attributes)
    end

    # Takes the list of model attributes calls the create method from DuckChain::Toolset
    # to generate the 'list' methods 
    def duck_chain_like(*model_attributes)
      Toolset.create_like_methods(model_attributes)
    end

    # Takes the list of model attributes calls the create method from DuckChain::Toolset
    # to generate the 'range' methods 
    def duck_chain_range(*model_attributes)
      Toolset.create_range_methods(model_attributes)
    end
    
  end
end
