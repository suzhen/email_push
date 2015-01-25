module ApplicationHelper
  #arg is array
  def controller?(controller) 
    controller.include?(controller_name)
  end 
  
  #arg is array
  def action?(action)
    action.include?(action_name)
  end

  # def time_format(time)
  #   time.to_s(:time) rescue "" 
  # end 
end
