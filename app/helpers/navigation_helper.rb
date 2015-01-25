module NavigationHelper
      
  # To easily render menu items
  # Usage: render_menu_items 'drivers', 'passengers', 'schedules'
  def render_menu_items(*items)
    content_tag :ul, class: "nav navbar-nav" do
      items.collect{ |item| nav_link item }.join("").html_safe
    end
  end
      
  def nav_link(controllers)
    content_tag :li, class: controller?(controllers) ? 'active' : nil do
      content = I18n.t(controller_name, :scope => :navigation) + (controller?(controllers) ? "<span class='sr-only'>(current)</span>" : '')
      link_to content.html_safe, send("#{controller_name}_path")
    end
  end

  def nav_dropdown(controllers,*items)
    content_tag :li, class: (controller?(controllers) ? 'dropdown active' : 'dropdown') do
      nav_title = link_to ("#{I18n.t controllers[0], :scope => :navigation}<span class='caret'></span>"+(controller?(controllers) ? "<span class='sr-only'>(current)</span>" : '')).html_safe,"",role:"button",'data-toggle'=>"dropdown",'aria-expanded'=>"false"
      nav_dropdown = content_tag :ul, class: 'dropdown-menu', role: 'menu' do
        items.inject(:concat)
      end
      nav_title.concat nav_dropdown
    end
  end

  def nav_dropdown_item(controller,action,path)
    content_tag :li do
      link_to I18n.t(action, :scope => "navigation.#{controller.singularize}_actions").html_safe,path
    end
  end

  def nav_dropdown_divider
    content_tag :li, class: 'divider' do end
  end



  # def submenu_link(name, path)
  #   #content_tag :li, class: is_submenu_active?(path) do
  #     link_to name, path,:class=>is_submenu_active?(path)
  #   #end
  # end
    
  # # For filters in admin pages
  # def filter_links(*filters)
  #   content_tag :ul, class: "nav nav-pills" do
  #     filters.collect{ |item| filter_link item }.join("").html_safe
  #   end
  # end
    
  # def filter_link(name)
  #   path = url_for(params.merge({filter: name}))
  #   content_tag :li, class: is_active?(path) do 
  #     link_to name.humanize, path     
  #   end
  # end
  

  # # Returns active for specific current page
  # def is_submenu_active?(path)
  #   current_page?(path) ? 'list-group-item active' : 'list-group-item'
  # end
end