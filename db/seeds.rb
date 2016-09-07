User.destroy_all
Quest.destroy_all
Activity.destroy_all
Friendship.destroy_all
UserQuest.destroy_all

names = ["Alaric", "William", "Charlemagne", "Joan", "Halfdan", "Julius", "Napoleon", "George", "Henry", "Saladin", "Hiawatha"]

names.each do |name|
  puts name
  user = User.new(
    email: "#{name}@#{name}.com".downcase,
    char_name: name,
    password: "password",
    experience: 0,
    speed: 1,
    endurance: 1,
    mental: 1,
    level: 1
  )
  user.save
end

alaric = User.all[0]
william = User.all[1]
charlemagne = User.all[2]
joan = User.all[3]
halfdan = User.all[4]
julius = User.all[5]
napoleon = User.all[6]
george = User.all[7]
henry = User.all[8]
saladin = User.all[9]
hiawatha = User.all[10]

alaric.avatar = "http://www.bbc.co.uk/staticarchive/163555f174737053c6fdb2a235751ceeeea0b554.jpg"
alaric.save
william.avatar = "http://mrnussbaum.com/images/william_the_conqueror.jpg"
william.save
charlemagne.avatar = "http://100leaders.org/sites/default/files/Charlemagne-nypl.jpg"
charlemagne.save
joan.avatar = "http://100leaders.org/sites/default/files/joan-wellcomeimages.jpg"
joan.save
halfdan.avatar = "http://t05.deviantart.net/MS0vMm4tSJzCBmwwjdG1uM8g4GE=/fit-in/700x350/filters:fixed_height(100,100):origin()/pre09/cdb6/th/pre/f/2007/171/d/3/viking_by_suzu2.jpg"
halfdan.save
julius.avatar = "https://earlychurchhistory.org/wp-content/uploads/2015/02/Julius-Ceaser.jpg"
julius.save
napoleon.avatar = "http://www.faktoider.nu/img/napoleon2.jpg"
napoleon.save
george.avatar = "http://img1.rnkr-static.com/user_node_img/54/1060845/C350/george-washington-architects-photo-u15.jpg"
george.save
henry.avatar = "http://cdn.immediatecontent.com/history-hot100/HenryVIII.jpg"
henry.save
saladin.avatar = "http://t01.deviantart.net/7AlbaXqgyfKjNJ2qHcqgz0b1wK8=/fit-in/700x350/filters:fixed_height(100,100):origin()/pre06/f82b/th/pre/f/2014/096/1/3/loyal_vizier_by_kaizendesign-d7dasgd.jpg"
saladin.save
hiawatha.avatar = "https://janebaileybain.files.wordpress.com/2012/09/hiawathabrave.jpg"
hiawatha.save
# users.each do |user|
#   rand(1..3).times do
#     quest = Quest.create(
#       name: ["New Quest", "Long Run", "Short Run", "Palace Raid", "Genie"].sample,
#       status_code: rand(0..3),
#       quest_type: ["endurance", "speed", "mental"].sample,
#       deadline: date.days_ago(rand(1..30)),
#       assigner_id: user.id,
#       assignee_id: users.sample.id
#     )

#     user_quest = UserQuest.create(
#       quest_id: quest.id,
#       user_id: user.id
#     )

#     2.times do
#       start_time = time + rand(1..30).days
#       end_time = start_time + rand(15..45).minutes
#       total_time = (end_time - start_time) / 60
#       distance = rand(1..10)
#       avg_pace = total_time / distance
#       activity = Activity.create(
#         quest_id: quest.id,
#         user_id: user.id,
#         distance: distance,
#         start_time: start_time,
#         duration: rand(500..5000),
#         calories: rand(100..1000)
#       )
#     end
#   end
  
  # users.each do |friend|
  #   user_ary = users - [friend]
  #   user_1 = friend.id
  #   user_2 = user_ary.sample.id
  #   if user_1 > user_2
  #     user_1 = user_2
  #     user_2 = friend.id
  #   end
  #   companion = Friendship.new(
  #     user_id: user_1,
  #     friend_id: user_2,
  #     status_code: rand(0..3),
  #     action_user_id: user_1
  #   )
  #   companion.save
  # end
puts "Donezo!!!"