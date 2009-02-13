Factory.define :post do |p|
  p.title "A title"
  p.body "The body of the post"
end

Factory.define :comment do |c|
  c.association :post
  c.title "A comment title"
  c.body "Someone had a comment"
end
