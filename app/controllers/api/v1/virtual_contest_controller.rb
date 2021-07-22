module Api
  module V1
    class VirtualContestController < ApplicationController
      def index
        require 'discordrb'
        require 'mechanize'
        require 'open-uri'
        require 'nokogiri'
        require "pry"

        agent = Mechanize.new
        agent.max_history = 2
        agent.user_agent = 'Mac Safari'

        # login
        page = agent.get("https://github.com/login/oauth/authorize?")
        form = page.form_with()
        form.action = "https://github.com/session"
        form.login = ""
        form.password = ""
        form.method = "POST"

        url = agent.submit(form)

        logger.error url
        binding.pry

        # create
        sleep(1)
        url = "https://kenkoooo.com/atcoder/#/contest/create"
        html = agent.get("#{url}").content.toutf8
        contents = Nokogiri::HTML(html, nil, 'utf-8')
        logger.error(contents.inspect)

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