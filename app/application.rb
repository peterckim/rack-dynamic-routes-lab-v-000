class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    
    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      Item.all.each do |item|
        if item.name = item_name
          return item.price
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