#Deface::Override.new(:virtual_path  => "spree/admin/configurations/index",
#                     :name          => "add_user_group",
#                     :insert_bottom => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
#                     :text          => "<%= configurations_menu_item(I18n.t(:user_groups), admin_user_groups_path, I18n.t(:manage_user_groups)) %>")

#insert_after :admin_configurations_menu do
#  %Q( <tr>
#          <td><%= link_to t("amazon_settings"), admin_amazon_path %></td>
#          <td><%= t("amazon_description") %></td>
#        </tr>
#       )
#end