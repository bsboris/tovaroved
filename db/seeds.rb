%w(Apple Google Microsoft Tesla Nokia Samsung LG Lenovo Acer ASUS Toshiba Sony).each do |name|
  Brand.create!(name: name)
end

%w(Компьютеры Ноутбуки Телефоны Планшеты Телевизоры Разное).each do |name|
  Category.create!(name: name)
end

%w(Магазин\ на\ Невском Магазин\ на\ Петроградке Магазин\ в\ Озерках).each do |name|
  Store.create!(name: name)
end

50.times do
  name = ''
  name << ' ' << ('A'..'Z').to_a.sample(rand(6) + 1).join
  name << '-' << (rand(1000) + 1).to_s
  Product.create! category: Category.all.sample,
                  brand: Brand.all.sample,
                  name: name,
                  price: rand(10000),
                  stores: Store.all.sample(rand(4))
end
