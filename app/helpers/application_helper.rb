module ApplicationHelper
  def full_title page_title = ""
    base_title = t "admin.base_title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def load_menu
    @menu = Menu.display
  end

  def load_menu_template menus
    html = ""
    menus.each do |menu|
      html << "<div class=\"mm1-com mm1-cour-com mm1-s3\">"
        html << "<h4>#{menu.name}</h4>"
        html << "<ul>"
          menu.dishes.limit(Settings.settings.limit_dish).offset(Settings.settings.offset_dish).each do |dishes|
            html << "<li>"
             html << link_to(dishes.name, dish_path(dishes))
            html << "</li>"
          end
          if menu.dishes.limit(Settings.settings.limit_dish).offset(Settings.settings.offset_dish).length >= Settings.settings.limit_dish
            html << "<li>"
              html << link_to(t("menu.load_more"), menu_path(menu), class: "menu_header")
            html << "</li>"
          end
        html << "</ul>"
      html << "</div>"
    end
    html
  end

  def number_format price
    number_to_currency price, precision: Settings.settings.precision, delimiter: "."
  end

  def load_user_images review
    if review.image.nil?
      image_tag Settings.settings.default_image_user, class: "img-responsive"
    else
      image_tag review.image, class: "img-responsive"
    end
  end

  def gravatar_for_table dish
    if dish.images.first.nil?
      image_tag Settings.settings.default_image_product, class: "img-responsive"
    else
      image_tag dish.images.first.url, class: "img-responsive"
    end
  end

  def check_type_table? table
    table.type_table == Settings.table.type_vip_table
  end

  def count_point_review point
    html = ""
    case point
    when Settings.settings.case_one
      html << "<li><i class=\"glyphicon glyphicon-star\"></i></li>"
    when Settings.settings.case_two
       Settings.settings.case_two.times do
        html << "<li><i class=\"glyphicon glyphicon-star\"></i></li>";
      end
    when Settings.settings.case_three
      Settings.settings.case_three.times do
        html << "<li><i class=\"glyphicon glyphicon-star\"></i></li>";
      end
    when Settings.settings.case_four
      Settings.settings.case_four.times do
        html << "<li><i class=\"glyphicon glyphicon-star\"></i></li>";
      end
    when Settings.settings.case_five
      Settings.settings.case_five.times do
        html << "<li><i class=\"glyphicon glyphicon-star\"></i></li>";
      end
    end
    html.html_safe
  end

  def current_cart
    session[:reservation]
  end

  def bookingdetails_exist?
    session[:reservation] && session[:cart]
  end

  def total_cart dishes
    total = 0
    dishes.each do |dish,quantity|
      total += dish.price * quantity
    end
    total
  end

  def price_total_cart dish, quantity
    number = dish.price.to_i * quantity.to_i
    number_to_currency(number, separator: ",")
  end
end
