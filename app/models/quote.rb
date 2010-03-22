class Quote < ActiveRecord::Base

  acts_as_voteable

  validates_presence_of :quote, :time, :episodio, :user, :message => "não pode ficar em branco."
  
  validates_numericality_of :timeh, :less_than_or_equal_to => 2, :allow_nil => true, :message => "O campo Hora não deve ser maior que 2"
  validates_numericality_of :timem, :less_than_or_equal_to => 59, :allow_nil => true, :message => "O campo Minutos não deve ser maior que 59"
  validates_numericality_of :times, :less_than_or_equal_to => 59, :allow_nil => true, :message => "O campo Segundos não deve ser maior que 59"
  
  belongs_to :episodio
  belongs_to :user

  before_validation :format_time

  def format_time
    self[:time] = "%02d:%02d:%02d" % [ self[:timeh], self[:timem], self[:times] ]
  end
  
  # Time Pieces
  def timeh=(time)
        self[:timeh] = time.to_i
  end
  def timem=(time)
        self[:timem] = time.to_i
  end
  def times=(time)
        self[:times] = time.to_i
  end
  def timeh
    unless self[:time].nil?
      self[:time].split(/:/).first.rjust(2, "0")
    end 
  end
  def timem
    unless self[:time].nil?
      self[:time].split(/:/)[1].rjust(2, "0")
    end
  end
  def times
    unless self[:time].nil?
      self[:time].split(/:/).last.rjust(2, "0")
    end
  end
end
