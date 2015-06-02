atom_feed do |feed|
	feed.details "Who ordered?"
  feed.title "#{@room.title}"
  feed.roomtype "#{@room.roomtype}"

  feed.updated @latest_order.try(:updated_at) 

  @room.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Order #{order.id}"
      entry.summary type: 'xhtml' do |xhtml|
        xhtml.p "Mailed to #{order.email}"
        xhtml.table do
          xhtml.tr do
            xhtml.th 'Room'
            xhtml.th 'Roomtype'
            xhtml.th 'Quantity'
            xhtml.th 'Total Price(per day)'
          end
          order.line_items.each do |item|
            xhtml.tr do
              xhtml.td item.room.title
              xhtml.td item.room.roomtype
              xhtml.td item.quantity_item
              xhtml.td number_to_currency item.total_price
            end
          end
          xhtml.tr do
            xhtml.th 'total', colspan: 2
            xhtml.th number_to_currency \
              order.line_items.map(&:total_price).sum
          end
        end
      end
      entry.author do |author|
        author.name order.name
        author.email order.email
        author.mobile order.mobile
      end
    end
  end
end
