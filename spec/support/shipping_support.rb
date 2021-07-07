module ShippingSupport
  def shipping(item_built, tag_built)
    visit new_item_path
        image_path = Rails.root.join('public/images/test_image.png')
        attach_file('item_tag[images][]', image_path, make_visible: true)
        fill_in 'item-name', with: item_built.name
        fill_in 'item-info', with: item_built.description
        fill_in 'tag-name', with: tag_built.tag_name
        find("#item-category").find("option[value='#{item_built.category_id}']").select_option
        find("#item-sales-status").find("option[value='#{item_built.status_id}']").select_option
        find("#item-shipping-fee-status").find("option[value='#{item_built.shipping_charge_id}']").select_option
        find("#item-prefecture").find("option[value='#{item_built.prefecture_id}']").select_option
        find("#item-scheduled-delivery").find("option[value='#{item_built.days_to_ship_id}']").select_option
        fill_in 'item-price', with: item_built.price
        expect{click_on('出品する')}.to change{Item.count}.by(1).and change {Tag.count}.by(1)

        expect(body).to have_content(item_built.name)
  end
end