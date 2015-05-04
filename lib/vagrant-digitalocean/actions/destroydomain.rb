require 'vagrant-digitalocean/helpers/client'

module VagrantPlugins
  module DigitalOcean
    module Actions
      class DestroyDomain
        include Helpers::Client

        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @client = client
          @logger = Log4r::Logger.new('vagrant::digitalocean::destroy')
        end

        def call(env)
          domain_name = @client
            .request('/v2/domains')
            .find_name(:domains, {:name => @machine.provider_config.domain})

          # submit destroy domain 
          if domain_name
            @client.delete("/v2/domains/#{domain_name}")
          end

          env[:ui].info "Deleting domain entry for #{domain_name}"

          @app.call(env)
        end
      end
    end
  end
end
