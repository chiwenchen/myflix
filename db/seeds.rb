# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

science = Category.create(title: 'Science Fiction')
thriller = Category.create(title: 'Thriller')
comedy = Category.create(title: 'Comedy')
action = Category.create(title: 'Action')

inception = Video.create(title: 'Inception', 
            description: 'Very cool movie',
            image: File.open(File.join(Rails.root, "public/tmp/inception_large.jpg")),
            thumb_image: File.open(File.join(Rails.root, "public/tmp/inception_small.jpg")),
            video_url: %Q[<iframe width="560" height="315" src="https://www.youtube.com/embed/8hP9D6kZseM" frameborder="0" allowfullscreen></iframe>],
            category: science)
Video.create(title: 'Interstellar', 
            description: 'Very cool movie', 
            image: File.open(File.join(Rails.root, "public/tmp/interstellar_large.jpg")),
            thumb_image:  File.open(File.join(Rails.root, "public/tmp/interstellar_small.jpg")),
            video_url: %Q[<iframe width="560" height="315" src="https://www.youtube.com/embed/0vxOhd4qlnA" frameborder="0" allowfullscreen></iframe>],
            category: science)
Video.create(title: 'Mission Impossible 3', 
            description: 'Very cool movie', 
            image: File.open(File.join(Rails.root, "public/tmp/MI3_large.jpg")),
            thumb_image: File.open(File.join(Rails.root, "public/tmp/MI3_small.jpg")),
            video_url: %Q[<iframe width="560" height="315" src="https://www.youtube.com/embed/ssWbGKTgXFc" frameborder="0" allowfullscreen></iframe>],
            category: action)
Video.create(title: 'Insidious', 
            description: 'Very cool movie', 
            image: File.open(File.join(Rails.root, "public/tmp/insidious_large.jpg")),
            thumb_image:  File.open(File.join(Rails.root, "public/tmp/insidious_small.jpg")),
            video_url: %Q[<iframe width="560" height="315" src="https://www.youtube.com/embed/zuZnRUcoWos" frameborder="0" allowfullscreen></iframe>],
            category: thriller)
Video.create(title: 'Monk', 
            description: 'Very cool movie', 
            image: File.open(File.join(Rails.root, "public/tmp/monk_large.jpg")),
            thumb_image:  File.open(File.join(Rails.root, "public/tmp/monk_small.jpg")),
            video_url: %Q[<iframe width="560" height="315" src="https://www.youtube.com/embed/VaAGug8AFcs" frameborder="0" allowfullscreen></iframe>],
            category: comedy)
chiwen = User.create(name: 'Chiwen', password: 'password', email: 'cwchen2000@gmail.com')
admin = User.create(name: 'Admin', password: 'password', email: 'admin@example.com', admin: true)
Review.create(rating: 5,
                        body: 'this is the best movie I have ever seen',
                        video: inception,
                        user: chiwen)
Review.create(rating: 1,
                        body: 'I do not want to see this anymore',
                        video: inception,
                        user: chiwen)














