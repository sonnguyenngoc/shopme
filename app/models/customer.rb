class Customer < ActiveRecord::Base
  belongs_to :order
  
  def name
    first_name + " " + last_name
  end
  
  def checkout_total_price
    price = 0
    self.order.order_details.each do |item|
      price += item.price
    end
    return price
  end
  
  def display_address
    str = []
    str << address if address.present?
    str << city if city.present?
    str << province if province.present?
    str << country if country.present?
    str << zip_code if zip_code.present?
    #address.to_s + ", " + city.to_s + ", " + province.to_s + ", " + country.to_s + ", " + zip_code.to_s
    
    return str.join(", ")
  end
  
  #
  def self.sort_by
    [
      ["Last Bought","customers.created_at"]
    ]
  end
  
  def self.sort_order
    [
      ["ASC","asc"],
      ["DESC","desc"],
    ]
  end
  
  def self.search(params)
    records = self.all
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(CONCAT(customers.first_name,' ',customers.last_name,' ',customers.email,' ',customers.phone,' ',customers.company,' ',customers.address,' ',customers.city,' ',customers.zip_code,' ',customers.country,' ',customers.province)) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "customers.created_at"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records   
  end


end
