# frozen_string_literal: true

tab =
  if Adn.config.admin_payouts
    'add_payouts_tab_to_user_edit'
  else
    'add_sponsorship_tab_to_user_edit'
  end

Deface::Override.new(
  virtual_path: 'spree/admin/users/_tabs',
  name: 'add_avalara_information_tab_to_user_edit',
  insert_bottom: 'ul.tabs',
  sequence: { after: tab },
  text: <<-ERB
    <% if can?(:display, @user) %>
      <li<%== ' class="active"' if current == :avalara_information %>>
        <%= link_to t("spree.avalara_information"), spree.avalara_information_admin_user_path(@user) %>
      </li>
    <% end %>
  ERB
)
