module QueriesHelper
    
    def options_for_tags
      ActsAsTaggableOn::Tag.all
    end
  
  
end
