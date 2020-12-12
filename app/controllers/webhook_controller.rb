class WebhookController < ApplicationController
  require 'line/bot'

  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new{ |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Join
        group_id = event['source']['groupId']
        Group.find_or_create_by(group_id: group_id)
        message = {
          type: 'text',
          text: "今日からこのチームを担当するライフコーチの山田です！\nよろしくお願いします！\nしっかりみなさんの時間を管理していきます！"
        },
        {
          type: 'sticker',
          packageId: '11538',
          stickerId: '51626496'
        }
        client.reply_message(event['replyToken'],message)
      end
    end
    "OK"
  end
end
