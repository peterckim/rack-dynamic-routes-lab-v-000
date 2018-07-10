class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    
    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      
      if Item.all.include?(item_name)
        item = Item.all.find do |i|
           i.name == item_name
          resp.write "#{i.price}"
          resp.status = 200
          return
        end
      end
      resp.write "Item not found"
      resp.status = 400
    else
      resp.write "Route not found"
      resp.status = 404
    end
    
    resp.finish
  end
end