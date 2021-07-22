module Api
  module V1
    class VirtualContestController < ApplicationController
      def index
        require 'discordrb'

        channel_id = "867608553426124850"
        bot = Discordrb::Commands::CommandBot.new(
        token: ENV['BOT_TOKEN'],
        client_id: ENV['BOT_CLIENT_ID'],
        prefix:'/'
        )
        bot.send_message(channel_id, "@")
        render json: { status: 'SUCCESS' }
      end
    end
  end
end