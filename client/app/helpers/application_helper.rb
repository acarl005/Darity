module ApplicationHelper

  def tweet_button(args)
    begin
      target = args[:dare].daree.username
    rescue
      target = args[:dare].twitter_handle
    end
    link_to args[:message], "https://twitter.com/intent/tweet?text=%20#{args[:dare].title}%20-%20dared%20to%20%40#{target}%20by%20%40#{args[:dare].proposer.username}%20%23Darity%20%23Dare%20For%20%23Charity%20%40Darity%20localhost:3000/users/#{args[:user].id}/dares/#{args[:dare].id}&url=localhost:3000/users/#{args[:user].id}/dares/#{args[:dare].id}", class: 'btn btn-primary'
  end
end

