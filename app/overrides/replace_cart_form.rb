#Deface::Override.new(:virtual_path  => "spree/admin/configurations/index",
#                     :name          => "add_user_group",
#                     :insert_bottom => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
#                     :text          => "<%= configurations_menu_item(I18n.t(:user_groups), admin_user_groups_path, I18n.t(:manage_user_groups)) %>")


#replace :cart_form do
#  %Q( <div id="cart-form">
#        <% if !!Spree::Config[:redirect_to_amazon] %>
#          <%= render 'shared/amazon_cart_form' %>
#        <% else %>
#          <%= render 'cart_form' %>
#        <% end %>
#        </div>
#      )
#end