
names = ["Alaric", "William", "Charlemagne", "Joan", "Halfdan"]

names.each do |name|
  user = User.new(
    email: "#{name}@#{name}.com".downcase,
    password: "password",
    experience: rand(1..1000),
    speed: rand(1..10),
    endurance: rand(1..10),
    mental: rand(1..10),
    level: rand(1..5)
  )
  user.save
end

users = User.all

date = Date.new(2016, 9, 23)
time = Time.new(2016, 8, 3, 8, 30, 0)

users.each do |user|
  (1..3).times do
    quest = Quest.new(
      name: ["New Quest", "Long Run", "Short Run", "Palace Raid", "Genie"].sample,
      status: ["active", "complete", "cancelled", "awaiting response"].sample,
      quest_type: ["self", "clan", "assigned"].sample,
      deadline: date.days_ago(rand(1..30)),
      assigner_id: user.id,
      assignee_id: users.sample.id
    )
    quest.save

    (1..3).times do
      start_time = time.days_since(rand(1..30))
      end_time = start_time + rand(15..100).minutes,
      distance = rand(1..10)
      activity = Activity.new(
        quest_id: quest.id,
        distance: distance,
        start_time: start_time,
        end_time: end_time,
        avg_pace: (end_time - start_time) / distance,
        calories: rand(100..1000),
        status: ["complete", "incomplete"].sample
      )
      activity.save
    end
  end
end

