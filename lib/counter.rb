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
  
  def self.get_top_contribs

    top_t = Track.count(:group => 'user_id', :order => 'count_all ASC').sort {|a,b| b[1]<=>a[1]}.shift
    top_q = Quote.count(:group => 'user_id', :order => 'count_all ASC').sort {|a,b| b[1]<=>a[1]}.shift
    
    puts top_t.inspect
    puts top_q.inspect
    
    tops = {
      :quotes => {:user => User.find(top_q[0]), :count => top_q[1] },
      :tracks => {:user => User.find(top_t[0]), :count => top_t[1] }
    }
    
    tops
  end
  
  # def self.retrieve_from_cache
  #   
  # end
  # 
  # def self.increment_count
  #   
  # end
end
