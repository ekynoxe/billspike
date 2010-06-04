  # This will guess the User class
  Factory.define :user do |u|
    u.username          'matt'
    u.email             'matt@ekynoxe.com'
    u.crypted_password  'f5658035209e794072c67e5d2c3d94c2f360b573c6f29a5927f8e91bd125eab5622919bb1c16bb6bd2667737371948ede726bb37e27a8f100f15e1d3ef4bb6c4'
    u.password_salt     'bS8oDRDrAeTy69MnNPmY'
  end
  
  Factory.define :owner, :class => User do |u|
    u.owner             true
  end
  
  Factory.define :admin, :class => User do |u|
    u.admin             true
  end