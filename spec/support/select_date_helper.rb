module SelectDateHelper
  def select_date(date, options = {})
    field = options[:from]
    base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for].chomp('_1i')
    select date.year.to_s,   :from => "#{base_id}_1i"
    select date.strftime('%B').to_s,  :from => "#{base_id}_2i"
    select date.day.to_s,    :from => "#{base_id}_3i"  
  end
end