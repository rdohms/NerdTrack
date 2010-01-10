class Counter
  def self.get_counts

    counts = { 
      :users => Counter.retrieve_count(User),
      :episodios => Counter.retrieve_count(Episodio),
      :tracks => Counter.retrieve_count(Track),
      :quotes => Counter.retrieve_count(Quote), 
    }
    
    counts
  end
  
  def self.retrieve_count(obj)
    obj.count(:all)
  end
  
  # def self.retrieve_from_cache
  #   
  # end
  # 
  # def self.increment_count
  #   
  # end
end
