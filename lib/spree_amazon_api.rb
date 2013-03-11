require 'spree_core'
require 'spree_amazon_api/engine'
require "amazon/ecs"
require 'yaml'
module SpreeAmazonApi
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      amazon_options = YAML.load(File.open(File.join(Rails.root,'config', 'amazon.yml')))[Rails.env]

      Spree::Config.searcher_class = Spree::Search::Amazon

      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      require File.join(File.dirname(__FILE__), "../lib/spree_ecs.rb")
      Spree::Ability.register_ability(AmazonAbility)



      Spree::AppConfiguration.class_eval do
        preference :redirect_to_amazon, :boolean,  :default => false
        preference :amazon_options, :hash
      end

      Spree::Config.amazon_options = amazon_options


      Amazon::Ecs.configure do |options|
        options[:AWS_access_key_id]        = amazon_options[:configure][:AWS_access_key_id]
        options[:AWS_secret_key]           = amazon_options[:configure][:AWS_secret_key]
        options[:response_group]           = amazon_options[:configure][:response_group] || 'Large'
        options[:country]                  = amazon_options[:configure][:country] || 'us'
      end

    end

    config.to_prepare &method(:activate).to_proc
  end
end
