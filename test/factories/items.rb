  # This will guess the Item class
  Factory.define :item do |u|
    u.user_id 1
    u.currency_id 1
    u.description 'milk'
    u.value 1.3
  end
