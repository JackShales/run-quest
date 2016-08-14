User.destroy_all
Quest.destroy_all
Activity.destroy_all

names = ["Alaric", "William", "Charlemagne", "Joan", "Halfdan"]

names.each do |name|
  puts name
  x = User.new(
    email: "#{name}@#{name}.com".downcase,
    char_name: name,
    password: "password",
    experience: rand(1..1000),
    speed: rand(1..10),
    endurance: rand(1..10),
    mental: rand(1..10),
    level: rand(1..5)
  )
  x.save
end

users = User.all
date = Date.new(2016, 9, 23)
time = Time.new(2016, 8, 3, 8, 0, 0)

users.each do |user|
  rand(1..3).times do
    quest = Quest.create(
      name: ["New Quest", "Long Run", "Short Run", "Palace Raid", "Genie"].sample,
      status: ["active", "complete", "cancelled", "awaiting response"].sample,
      quest_type: ["self", "retrieved", "assigned"].sample,
      deadline: date.days_ago(rand(1..30)),
      assigner_id: user.id,
      assignee_id: users.sample.id
    )

    user_quest = UserQuest.create(
      quest_id: quest.id,
      user_id: user.id
    )

    2.times do
      start_time = time + rand(1..30).days
      end_time = start_time + rand(15..45).minutes
      total_time = (end_time - start_time) / 60
      distance = rand(1..10)
      avg_pace = total_time / distance
      activity = Activity.create(
        quest_id: quest.id,
        user_id: user.id,
        distance: distance,
        start_time: start_time,
        duration: rand(500..5000),
        calories: rand(100..1000)
      )
    end
  end
end

puts "Donezo!!!"