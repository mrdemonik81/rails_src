# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

%w[listening reading speaking conversation pronunciation writing grammar].each do |w|
  Skill.find_or_create_by(name: w)
end
%w[work public personal education].each { |w| Domain.find_or_create_by(name: w) }

Level.transaction do
  {
    'A1' => 'Beginner',
    'A2' => 'Elementary',
    'B1' => 'Intermediate',
    'B2' => 'Upper-Intermediate',
    'C1' => 'Advanced',
    'C2' => 'Native'
  }.each do |short_name, name|
    Level.create_with(name: name).find_or_create_by(short_name: short_name)
  end
end

unless Rails.env.production?
  Client.create_with(org_id: '991 123 321').find_or_create_by(name: 'Hogwarts')
  Client.create_with(org_id: '892 299 299').find_or_create_by(name: 'Rosenhof')

  User.transaction do
    CSV.foreach(Rails.root.join('db', 'seed_users.csv')) do |row|
      user = User.create_with(
        fname: row[1],
        lname: row[2],
        role: row[4],
        status: row[5],
        password: SecureRandom.hex(4)
      ).find_or_create_by(email: row[0])
      user.identities.create(uid: row[3], provider: 'rowling')
      user.client_users.find_or_create_by(client_id: Client.last.id)
    end
  end

  # Create admin user
  admin = User.create(
    fname: 'John',
    lname: 'Smith',
    email: 'john@edun.no',
    password: 'password',
    role: 'admin',
    status: 'active'
  )
  admin.client_users.find_or_create_by(client_id: Client.first.id)

  Candidate.transaction do
    CSV.foreach(Rails.root.join('db', 'seed_candidates.csv')) do |row|
      candidate = Candidate.create_with(
        fname: row[1].titleize,
        lname: row[2].titleize,
        locale: row[5],
        gender: row[3],
        mobile: row[4],
        ssn: row[6]
      ).find_or_create_by(email: row[0])
      candidate.client_candidates.find_or_create_by(client_id: Client.first.id)
    end
  end

  Exam.create(name: 'Norskprøven muntlig', max_time: 3600, price: 990, max_tasks: 100, published: true, algorithm: 'adaptive')
  Exam.create(name: 'Norskprøven skriftlig', max_time: 10500, price: 990, max_tasks: 100, published: true)
  Exam.create(name: 'Advanced English test', max_time: 7200, price: 350, max_tasks: 100, published: true)
  Exam.create(name: 'German level test A1', max_time: 5400, price: 10, max_tasks: 100, published: true, algorithm: 'adaptive')

  Examination.create(exam_id: 1, client_candidate_id: 1, total_time_spent: 7232, status: 'completed', total_score: 83)
  Examination.create(exam_id: 2, client_candidate_id: 2, total_time_spent: 5332, status: 'completed', total_score: 0)
  Examination.create(exam_id: 2, client_candidate_id: 3, total_time_spent: 0, status: 'pending', total_score: 83)
  Examination.create(exam_id: 3, client_candidate_id: 4, total_time_spent: 2345, status: 'in_progress', total_score: 0)

  # Create Multiple choice task
  task = Task.create(
    name: 'Geography quiz',
    title: 'Geography quiz',
    introduction: 'Answer the questions below.',
    type: "Tasks::SelectText",
    performance: 1.0,
    complexity: 'low',
    published: true
  )
  item = task.items.create(
    type: 'TaskItems::SelectText',
    context: { "question": "Where is Anchorage?" }
  )
  item.options.create([
                        {
                          correct: true,
                          context: { "answer": "America" }
                        }, {
                          correct: false,
                          context: { "answer": "Africa" }
                        }, {
                          correct: false,
                          context: { "answer": "Asia" }
                        }
                      ]
  )
  item = task.items.create(
    type: 'TaskItems::SelectText',
    context: { "question": "Where is Yakutia?" }
  )
  item.options.create([
                        {
                          correct: false,
                          context: { "answer": "America" }
                        }, {
                          correct: false,
                          context: { "answer": "Africa" }
                        }, {
                          correct: true,
                          context: { "answer": "Asia" }
                        }
                      ]
  )
  item = task.items.create(
    type: 'TaskItems::SelectText',
    context: { "question": "Why don't polar bears eat penguins?" }
  )
  item.options.create([
                        {
                          correct: false,
                          context: { "answer": "Penguins taste bad" }
                        }, {
                          correct: false,
                          context: { "answer": "Penguins swim too fast." }
                        }, {
                          correct: true,
                          context: { "answer": "It's too far to swim to the south pole." }
                        }
                      ]
  )


  # Create Multiple choice Image task
  task = Task.create(
    name: 'Geography quiz 2',
    title: 'Geography quiz 2',
    introduction: '',
    type: "Tasks::SelectImage",
    performance: 1.0,
    complexity: 'low',
    published: true
  )
  item = task.items.create(
    type: 'TaskItems::SelectImage',
    context: { "question": "Which image is from New York?" }
  )
  item.options.create([
                        {
                          correct: true,
                          context: { "image": "image_1.jpg" }
                        }, {
                          correct: false,
                          context: { "image": "image_2.jpg" }
                        }, {
                          correct: false,
                          context: { "image": "image_3.jpg" }
                        }
                      ]
  )
  item = task.items.create(
    type: 'TaskItems::SelectImage',
    context: { "question": "Which continent is this image from?" }
  )
  item.options.create([
                        {
                          correct: false,
                          context: { "image": "image_4.jpg" }
                        }, {
                          correct: false,
                          context: { "image": "image_5.jpg" }
                        }, {
                          correct: true,
                          context: { "image": "image_6.jpg" }
                        }
                      ]
  )

  # Create Essay task
  task = Task.create(
    name: 'First essay',
    title: 'Introduce yourself to the world!',
    introduction: 'Write a 100 word essay about who you are and where you come from.',
    instruction: 'Enter your answer in the text box',
    type: "Tasks::Essay",
    performance: 1.0,
    score_method: 'manual',
    complexity: 'medium',
    published: true
  )
  task.items.create(
    type: 'TaskItems::Essay',
    context: { 'minimum_words': '100' }
  )

  # Create Audio task
  task = Task.create(
    name: 'Make an audio recording',
    title: 'Introduce yourself to the world!',
    introduction: 'Tell me about the weather where you are right now.',
    instruction: 'Click the red button to start recording.',
    type: "Tasks::Audio",
    performance: 1.0,
    complexity: 'medium',
    score_method: 'manual',
    published: true
  )
  task.items.create(
    type: 'TaskItems::Audio',
    context: { 'minimum_duration': '60' }
  )

  # Create True/false task
  task = Task.create(
    name: 'Are these statements true?',
    title: 'Are these statements true?',
    introduction: 'Answer true or false to each statement',
    instruction: 'Click true or false and then submit',
    type: "Tasks::TrueFalse",
    performance: 1.0,
    complexity: 'low',
    published: true
  )
  task.items.create(
    type: 'TaskItems::TrueFalse',
    context: { 'statement': 'Bilberries, also nearly black berries found in nutrient-poor soils.', veracity: true }
  )
  task.items.create(
    type: 'TaskItems::TrueFalse',
    context: { 'statement': 'Bilberries are also know as cloud berries.', veracity: false }
  )

  # Create Inline dropdown task
  task = Task.create(
    name: 'Choose the correct verbs',
    title: 'Which verb fits the text',
    introduction: 'Find the missing words in the texts below.',
    instruction: 'Click each dropdown field and select one option in the texts below',
    type: "Tasks::InlineDropdown",
    performance: 1.0,
    complexity: 'high',
    published: true
  )
  task.items.create(
    type: 'TaskItems::InlineDropdown',
    context: { 'statement': 'John *select:speaks/speak/spoke* English with his friend.' }
  )
  task.items.create(
    type: 'TaskItems::InlineDropdown',
    context: { 'statement': 'Lisa *select:wrote/written/writes* a letter to her friend.' }
  )

  # Create Mark word task
  task = Task.create(
    name: 'Mark the adjectives in the text',
    title: 'Find the adjectives',
    introduction: 'Which adjectives can you find in the text?',
    instruction: 'Mark the words in the text by clicking them.',
    type: "Tasks::MarkWord",
    performance: 1.0,
    complexity: 'high',
    published: true
  )
  task.items.create(
    type: 'TaskItems::MarkWord',
    context: { 'statement': 'Bilberries, also nearly *black* berries found in *nutrient-poor* soils.' }
  )
  task.items.create(
    type: 'TaskItems::MarkWord',
    context: { 'statement': 'Lisa sent a *short* letter to her *best* friend.' }
  )

  # Create Arrange words task
  task = Task.create(
    name: 'Create sentence',
    title: 'Put these words into a correct sentence',
    introduction: '',
    instruction: 'Tap the words to create a sentence.',
    type: "Tasks::ArrangeWords",
    performance: 1.0,
    complexity: 'high',
    score_method: 'true_false',
    published: true
  )
  task.items.create(
    type: 'TaskItems::ArrangeWords',
    context: { 'arrange_words': 'Polar bears do not eat penguins.',
               'additional_words': 'horrid foul grunt'
    }
  )
  task.items.create(
    type: 'TaskItems::ArrangeWords',
    context: { 'arrange_words': 'Lisa does her homework.',
               'additional_words': 'hopelessly void'
    }
  )
end
