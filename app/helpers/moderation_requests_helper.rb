module ModerationRequestsHelper
  def reportTarget(type, id)
    
    tclass = Object.const_get(type)
    
    target = tclass.find(id)
    
    if type == 'Quote'
      link_to "##{target.episodio.full_id}: #{target.episodio.titulo} <br/>[#{target.time}] #{target.quote} (#{target.autor})", target.episodio
    elsif type == 'Track'
      link_to "##{target.episodio.full_id}: #{target.episodio.titulo} <br/>[#{target.time}] #{target.song}", target.episodio
    end
  end
end
