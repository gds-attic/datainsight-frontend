require "songkick/transport"

Transport = Songkick::Transport::HttParty

module Insight
  module API

    module StubApiMethod
      def api(config)
        @api ||= ClientStub.new
      end
    end

    module ApiMethod
      def api(config)
        @api ||= ClientAPI.new(config)
      end
    end

    class ClientAPI
      def initialize(config)
        @config = config
      end

      def get_json(&block)
        begin
          block.yield.data
        rescue Songkick::Transport::UpstreamError => e
          logger.error(e)
          :error
        end
      end

      def narrative
        result = get_json { transport(@config['todays_activity_base_url']).get("/narrative") }
        result == :error ? result : result["content"]
      end

      def weekly_visits
        get_json { transport(@config['weekly_reach_base_url']).get("/weekly-visits") }
      end

      def weekly_visitors
        get_json { transport(@config['weekly_reach_base_url']).get("/weekly-visitors") }
      end

      def todays_activity
        get_json { transport(@config['todays_activity_base_url']).get("/todays-activity") }
      end

      def format_success
        get_json { transport(@config['format_success_base_url']).get("/format-success") }
      end

      private
      def transport(host, args={})
        Transport.new(host, :user_agent => "Data Insight Web", :timeout => args[:timeout] || 5)
      end
    end

    class ClientStub
      def narrative
        fixture :narrative
      end

      def weekly_visits
        fixture :weekly_visits
      end

      def weekly_visitors
        fixture :weekly_visitors
      end

      def todays_activity
        fixture :todays_activity
      end

      def format_success
        fixture :format_success
      end

      private
      def fixture(name)
        fixture_file = File.join(File.dirname(__FILE__), "../spec/fixtures/#{name}.json")

        json = JSON.parse(load_fixture(fixture_file))
        if name == :narrative
          json["content"]
        else
          json
        end
      end

      def load_fixture(fixture_file)
        if File.exist?(fixture_file)
          File.read(fixture_file)
        else
          ERB.new(File.read(fixture_file + ".erb")).result(binding)
        end
      end
    end
  end
end
