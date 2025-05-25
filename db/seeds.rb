# Create user
user = User.create!(
  email: "user@example.com",
  password: "password123",
  password_confirmation: "password123"
)

20.times do |i|
  project = Project.create!(
    user: user,
    title: "Project #{i + 1}",
    description: "Description for project #{i + 1}",
    status: Project.statuses.keys.sample
  )

  Event.create!(
    project: project,
    user: user,
    from_status: 'draft',
    to_status: 'in_progress'
  )

  Event.create!(
    project: project,
    user: user,
    content: "Project started"
  )

  Event.create!(
    project: project,
    user: user,
    from_status: 'in_progress',
    to_status: 'completed'
  )

  Event.create!(
    project: project,
    user: user,
    content: "Project completed"
  )
end

puts "Created #{User.count} users"
puts "Created #{Project.count} projects"
puts "Created #{Event.count} events"
