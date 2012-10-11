module Casting

  def cast_to_integer_unless_blank_from_om(dsid,field_name)
    v=self.datastreams[dsid].send(field_name).first
    unless v.blank?
      return v.to_i
    end
  end

  def cast_to_boolean_unless_blank_from_om(dsid,field_name)
    v=self.datastreams[dsid].send(field_name).first
    unless v.blank?
      return v=="true"
    end
  end

  def cast_to_date_from_om(dsid,field_name)
    v=self.datastreams[dsid].send(field_name).first
    val = v.blank? ? Date.today : Date.parse(v)
    #puts "val is #{val.inspect}"
    return val
  end

  def serialize_to_om(dsid, field_name, val)
    self.datastreams[dsid].send((field_name.to_s + '=').to_sym, val.to_s)
  end

  ## This allows you to use date_select helpers in rails views 
  def attributes=(params)
    dates = {}
    params.each do |key, value| 
      if data = key.to_s.match(/^(.+)\((\d)i\)$/)
        dates[data[1]] ||= {}
        dates[data[1]][data[2]] = value
        params.delete(key)
      end
    end
    dates.each do |key, value|
      self.send((key+'=').to_sym, [value['1'], value['2'], value['3']].join('-'))
    end
    
    super
  end
end
