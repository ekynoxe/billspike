module SharesHelper
  def format_sidebar_share_member(share,user)
  			user_amount = share.calculate_total_for_user(user)
  			if user_amount<0
  				separator = ' is owed '
  				classname = 'green'
  			else
  				separator = ' owes '
  				classname = 'red'
  			end

  		%Q{<li><div class="name">#{user.username}</div><span class="#{classname}">#{separator}#{number_to_currency(user_amount.abs / Float(100), :precision => 2, :unit => "&pound;")}</span></li>}
  end
end
