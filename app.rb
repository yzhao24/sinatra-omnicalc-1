require "sinatra"
require "sinatra/reloader"

get("/howdy") do
  erb(:hello)

end

get("/goodbye") do
  erb(:bye)
end  

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end

get("/square/new") do
  erb(:new_square_calc)
end

get("/square/results") do

  @the_num = params.fetch("users_number").to_f
  @the_result = @the_num ** 2
  
  erb(:square_results)
end  

get("/square_root/new") do
  erb(:new_square_root_calc)
end

get("/square_root/results") do

  @the_num = params.fetch("users_number").to_f
  @the_result = @the_num ** 0.5
  
  erb(:square_root_results)
end  

get("/random/new") do
  erb(:new_random_calc)
end

get("/random/results") do

  @the_num_min = params.fetch("users_number_min").to_f
  @the_num_max = params.fetch("users_number_max").to_f
  @the_result = rand(@the_num_min..@the_num_max)
  
  erb(:random_results)
end  




get("/payment/new") do
  erb(:new_payment_calc)
end

get("/payment/results") do

  @the_num_apr_raw = params.fetch("user_apr").to_f
  @the_num_apr = @the_num_apr_raw / 100 / 12
  @the_num_period_raw = params.fetch("user_years").to_i
  @the_num_period = (@the_num_period_raw * 12).to_i
  @principal = params.fetch("user_pv").to_f

  @numerator = @the_num_apr * @principal * (1 + @the_num_apr) ** @the_num_period
  @denominator = (1 + @the_num_apr) ** @the_num_period - 1

  if @denominator != 0
    @the_result = (@numerator / @denominator).to_fs(:currency)
  else
    @the_result = (@principal / @the_num_period).to_fs(:currency)
  end
  
  @formatted_apr = @the_num_apr_raw.to_fs(:percentage, precision: 4)
  @formatted_principal = @principal.to_fs(:currency)

  erb(:payment_results)
end  
