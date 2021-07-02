crumb :root do
  link "Home", root_path
end

crumb :complex_search_item_items do
  link "限定検索の結果", complex_search_item_items_path
  parent :root
end

crumb :complex_search_tag_items do
  link "タグ検索の結果", complex_search_tag_items_path
  parent :root
end

crumb :new_item do
  link "商品登録ページ", new_item_path
  parent :root
end

crumb :item do
  link "商品詳細ページ", item_path
  parent :root
end

crumb :edit_item do
  link "商品編集ページ", edit_item_path
  parent :item
end