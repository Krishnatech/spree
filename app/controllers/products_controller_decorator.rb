Spree::ProductsController.class_eval do


    def show

      return unless @product

      @variants = Spree::Variant.active.includes([:option_values, :images]).where(:product_id => @product.id)
      @product_properties = Spree::ProductProperty.includes(:property).where(:product_id => @product.id)

      referer = request.env['HTTP_REFERER']
      if referer
        begin
          referer_path = URI.parse(request.env['HTTP_REFERER']).path
            # Fix for #2249
        rescue URI::InvalidURIError
          # Do nothing
        else
          if referer_path && referer_path.match(/\/t\/(.*)/)
            @taxon = Spree::Taxon.find_by_permalink($1)
          end
        end
      end

    end

    private
      def load_product
        @product = Spree::Product.find_by_permalink(params[:id]) || Spree::Amazon::Product.find(params[:id])

      end

end
