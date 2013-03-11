module Spree
  module Amazon

    class Price < Spree::Amazon::Base



      @@price

        def class_name
          'Spree::Variant'
        end

        def name
          "Price"
        end

      def display_amount

        price.to_s
      end
      alias :display_price :display_amount

      def price
        @@price
      end

      def price=(price)
        @@price = price
      end


    end
  end
end

