module Spree
  module Amazon
    class Taxon < Spree::Amazon::Base
      include ActiveModel::AttributeMethods
      extend ActiveModel::Callbacks
      attr_accessor :id, :parent_id, :is_parent, :name, :status, :is_root, :search_index, :children
      attr_accessor :children, :ancestors
      alias :is_parent? :is_parent


      ROOT_TAXONS = YAML.load( File.open(File.join( Rails.root, 'db', 'amazon_categories.yml' )  ) )


      class << self
        attr_accessor :root_category

        def root_category
          @root_category ||=  new(:name => "Categories", :id => "0000", :is_root => true)
          @root_category
        end

        # Таксоны верхнего уровня
        #
        def roots
          @@roots ||= ROOT_TAXONS.map{ |x| new(:id => x[:id], :name => x[:name], :children => [])  }
          @@roots
        end

        def find(cid)
          roots.find{ |x| x.id.to_s == cid.to_s} ||  new(SpreeEcs::Taxon.find(cid))
        end


      end # end class << self

      # Products
      #
      def products
        @taxon_products ||= Spree::Amazon::Product.multi_find(SpreeEcs::Taxon.top_sellers(self.id).join(', '))
        @taxon_products
      end

      def root
        is_root ? self.class.root_category : self
      end

      def permalink
        @id.to_s
      end

      def children
        if self.id.to_s == '0000'
          self.class.roots
        else
          @_children ||= (@children||[ ]).map{ |v| self.class.new(v)}
          @_children
        end
      end

      def parent
        ancestors.first
      end

      def ancestors
        @_ancestors ||=(@ancestors||[]).map{ |v| self.class.new(v)} || []
        @_ancestors
      end

      def self_and_descendants
        [ self, ancestors ].flatten.compact
      end
      def applicable_filters
        [ ]
      end
      def is_root
        Spree::Amazon::Taxon.roots.find{|v| v.id.to_s == self.id.to_s }
      end
    end
  end
end
