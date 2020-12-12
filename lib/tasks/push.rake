namespace :push_line do
  desc "push_line" 
  task push_line_message_prepare: :environment do
    message = {
      type: 'text',
      text: 'おはようございます！朝礼10分前です！準備はできていますか？'
    },
    {
      type: 'sticker',
      packageId: '11537',
      stickerId: '52002738'
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    Group.all.each do |group|
      client.push_message(group.group_id, message)
    end
  end

  task push_line_message_start: :environment do
    message = {
      type: 'text',
      text: "朝礼の時間です！\n今日も1日頑張りましょう！"
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    Group.all.each do |group|
      client.push_message(group.group_id, message)
    end
  end

  task push_line_message_afternoon: :environment do
    message = {
      type: 'text',
      text: "お疲れ様です！\nお昼のアウトプットです！"
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    Group.all.each do |group|
      client.push_message(group.group_id, message)
    end
  end

  task push_line_message_finish: :environment do
    message = {
      type: 'text',
      text: '本日ラストのアウトプットです！'
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    Group.all.each do |group|
      client.push_message(group.group_id, message)
    end
  end

  task push_line_message_dayout: :environment do
    message = {
      type: 'text',
      text: "Eチームのみなさん！\n今日も1日お疲れ様でした！\n1日を振り返ってみていかかがですか？\n明日もしっかり行動できるように、今日の良かった点や反省点を振り返ってみましょう！"
    },
    {
      type: 'sticker',
      packageId: '11537',
      stickerId: '52002735'
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    Group.all.each do |group|
      client.push_message(group.group_id, message)
    end
  end
end