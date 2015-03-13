class Article
  attr_accessor :id, :title, :abstract, :body, :publish_date
  
  @@next_id = 1

  def initialize(title, abstract, body, publish_date)
    @id = @@next_id
    @@next_id += 1

    @title = title
    @abstract = abstract
    @body = body
    @publish_date = publish_date
  end
  def to_h
    {id: id, title: title, abstract: abstract, body: body, publish_date: publish_date}
  end
  def to_s
    <<-TO_S
    id: #{id}
    title: #{title}
    abstract: #{abstract}
    body: #{body}
    publish_date: #{publish_date}
    TO_S
  end
  def to_json
    to_h.to_json
  end
  def update(params)
    puts "update => #{id} | #{params.keys}"
    puts to_s

    self.title = params[:title] || title
    self.abstract = params[:abstract] || abstract
    self.body = params[:body] || body
    self.publish_date = params[:publish_date] || publish_date

    puts to_s
    self
  end
end
