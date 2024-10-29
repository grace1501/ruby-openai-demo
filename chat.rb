require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))


message_list = [
  # {
  #   "role" => "system",
  #   "content" => "You are a helpful assistant who talks like Shakespeare."
  # },
  {
    "role" => "user",
    "content" => "Hello! What are the best spots for pizza in Chicago?"
  }
]


loop {
  puts "Hello! How can I help you today? Type 'bye' or 'end' if you want to end the program."
  50.times{print "-"}
  puts ""

  user_input = gets.chomp

  if user_input == "bye" || user_input == "end"
    puts "Thank you. Goodbye!"
    break;
  end

  message_list.push({
    "role": "user",
    "content": user_input
  })

  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list    
    }
  )
  
  api_response_message = api_response.fetch("choices")[0].fetch("message")
  
  puts api_response_message.fetch("content")
  50.times{print "-"}
  puts ""

  message_list.push({
    "role": api_response_message.fetch("role"),
    "content": api_response_message.fetch("content")
  })


}
