module Youtube
  PARAMS = { max_results: 20, key: ENV['GOOGLE_API_KEY'] }.freeze
  BASE_URL = 'https://www.googleapis.com/youtube/v3/search'.freeze
  PARAM_STR = "?part=snippet&maxResults=#{PARAMS[:max_results]}&type=video&key=#{PARAMS[:key]}".freeze

  def self.search(query)
    raw_response = Faraday.get(BASE_URL + PARAM_STR + "&q=#{query}")
    parsed_response = JSON.parse(raw_response.body)

    videos = []

    parsed_response['items'].each do |video|
      video_item = {}
      video_item[:id] = video['id']['videoId']
      video_item[:title] = video['snippet']['title']
      video_item[:description] = video['snippet']['description']
      video_item[:thumbnail] = video['snippet']['thumbnails']['high']['url']
      video_item[:watch_url] = "https://www.youtube.com/watch?v=#{video_item[:id]}"
      video_item[:embed_url] = "https://www.youtube.com/embed/#{video_item[:id]}"
      videos << video_item
    end

    videos
  end
end
