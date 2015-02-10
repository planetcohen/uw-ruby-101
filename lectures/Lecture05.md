footer: UW Ruby Programming 110 : Winter 2015 : Michael Cohen : Lecture 5
slidenumbers: true

# [fit] UW Ruby Programming 110
# [fit] Winter 2015
# [fit] Michael Cohen

-

# [fit] Lecture 5
# [fit] Feb 5, 2015


---

# Lecture 5

1. Test Driven Development
1. Web Scraping
1. Method Missing
1. Meta Programming
1. Assignments


---

## Section 1
#  [fit] Test Driven Development


---

## Section 1: TDD
#  Philosophy

Write tests first
to help evolve your design


---

## Section 1: TDD
#  Benefits

1. Validate implementation conforms to spec
2. Enable safe refactoring


---

## Section 1: TDD
#  Types of tests

1. Unit
2. Functional
3. Integration


---

## Section 1: TDD
#  Tools

- TestUnit
- RSpec
- MiniTest


---

## Section 1: TDD
#  MiniTest

```ruby
require 'minitest/autorun'

class TestMyClass < Minitest::Test
  def setup
    ...
  end

  def test_thing1
    ...
  end

  def test_thing2
    ...
  end
end
```

---

## Section 1: TDD
#  MiniTest

```ruby
assert something
assert_nil obj
assert_empty obj
assert_equal value, obj
assert_instance_of <class>, obj
assert_kind_of <class>, obj
```

---

## Section 1: TDD
#  MiniTest

```ruby
refute something
refute_nil obj
refute_empty obj
refute_equal value, obj
refute_instance_of <class>, obj
refute_kind_of <class>, obj
```

---

## Section 1: TDD
#  Demo


---

## Section 2
#  [fit] Web Scraping


---

## Section 2: Web Scraping
#  Overview

1. read document over http
1. convert document to objects
1. manipulate objects
1. render output


---

## Section 2: Web Scraping
#  Examples

1. Find links on Wikipedia article.
2. Render article summary for RSS feed.


---

## Section 2: Web Scraping
#  Example 1: Wikipedia

```ruby
# read document:

require 'open-uri'

url = 'http://en.wikipedia.org/wiki/Ruby'
html = open(url)
```

---

## Section 2: Web Scraping
#  Example 1: Wikipedia

```ruby
# convert to objects:

require 'nokogiri'

doc = Nokogiri::HTML(html)
```

---

## Section 2: Web Scraping
#  Example 1: Wikipedia

```ruby
# manipulate objects:

# use css selectors to find all <a> tags:
anchors = doc.css('a')
anchors.length
hrefs = anchors.map {|node| node.attribute 'href'}
```

---

## Section 2: Web Scraping
#  Example 2: RSS Feed

```ruby
# read document:

require 'open-uri'

url = 'http://scripting.com/rss.xml'
rss = open(url)
```

---

## Section 2: Web Scraping
#  Example 2: RSS Feed

```ruby
# convert to objects:

require 'nokogiri'

rss_doc = Nokogiri::XML(rss)
```

---

## Section 2: Web Scraping
#  Example 2: RSS Feed

```ruby
# manipulate objects:

# use xpath to find all items:
item_nodes = rss_doc.xpath('/rss/channel/item')
item_nodes.length

items = item_nodes.map do |node|
  node.elements.reduce({}) do |item, el|
    item[el.name] = el.content
    item
  end
end
```

---

## Section 3
#  [fit] Method Missing


---

## Section 3: Method Missing
#  Method Missing

`method_missing` is invoked when a message is sent to an object, and there is no method defined to respond to the message.


---

## Section 3: Method Missing
#  Method Missing

```ruby
class MethodMissingDemo
  def method_missing(method, *args)
    puts "method_missing: #{method}"
  end
end

obj = MethodMissingDemo.new
obj.random_method
```


---

## Section 3: Method Missing
#  LoggingProxy

```ruby
class LoggingProxy
  def initialize(target)
    @target = target
  end
  def method_missing(method, *args)
    puts "calling #{method}"
    @target.send method, *args
  end
  def respond_to?(method)
    @target.respond_to? method
  end
end
```


---

## Section 4
#  [fit] Meta Programming


---

## Section 4: Meta Programming
#  Definition

Meta-programming:
program that writes a program.


---

## Section 4: Meta Programming
#  Trivial Example

```ruby
class Trivial
  if DEBUG
    def log(msg); puts msg; end
  else
    def log(msg); end
  end
end
```

---

## Section 4: Meta Programming
#  Real Example

```ruby
class Article
  attr :title, :author, :published_on, :content
end
```

What is `attr`?

It's not a language construct, it's just a method call that writes code.

Let's see how that's done.


---

## Section 4: Meta Programming
#  attr

`attr` creates a getter and a setter:

```ruby
  attr :title
```

becomes:

```ruby
  def title
    @title
  end
  def title=(new_title)
    @title = new_title
  end
```


---

## Section 4: Meta Programming
#  attr

How do we implement that?

Let's try to build our own version, `prop`

```ruby
class IceCream
  prop :flavor, :temperature
end
```


---

## Section 4: Meta Programming
#  `prop` is a method

We want

```ruby
  prop :flavor
```

to become:

```ruby
  def flavor
    @flavor
  end
  def flavor=(new_flavor)
    @flavor = new_flavor
  end
```


---

## Section 4: Meta Programming
#  `prop` is a method

```ruby
def prop(prop_name)
  # ???
end
```


---

## Section 4: Meta Programming
#  `prop` is a method

Something like this:

```ruby
def prop(prop_name)
  def <prop_name>
    @<prop_name>
  end
  def <prop_name>=(value)
    @<prop_name> = value
  end
end
```


---

## Section 4: Meta Programming
#  define_method

We need `define_method`:

```ruby
def prop(prop_name)
  define_method prop_name do
    # ??? @<prop_name>
  end
  define_method "#{prop_name}=" do |value|
    # ??? @<prop_name> = value
  end
end
```


---

## Section 4: Meta Programming
#  instance_variable_get/set

We need `instance_variable_get/set`:

```ruby
def prop(prop_name)
  define_method prop_name do
    instance_variable_get "@#{prop_name}"
  end
  define_method "#{prop_name}=" do |value|
    instance_variable_set "@#{prop_name}", value
  end
end
```


---

## Section 4: Meta Programming
#  multiple properties

We want to support multiple properties:

```ruby
def prop(*prop_names)
  prop_names.each do |prop_name|
    define_method prop_name do
      instance_variable_get "@#{prop_name}"
    end
    define_method "#{prop_name}=" do |new_value|
      instance_variable_set "@#{prop_name}", new_value
    end
  end
end
```


---

## Section 4: Meta Programming
#  `prop`

Where does this belong?


---

## Section 4: Meta Programming
#  add to Class

It adds behavior to Class:

```ruby
class Class
  def prop(*prop_names)
    prop_names.each do |prop_name|
      define_method prop_name do
        instance_variable_get "@#{prop_name}"
      end
      define_method "#{prop_name}=" do |new_value|
        instance_variable_set "@#{prop_name}", new_value
      end
    end
  end
end
```


---

## Section 4: Meta Programming
#  use it

```ruby
class Article
  prop :title, :author, :published_on, :content
end

article = Article.new
article.title = "Ruby Meta-programming Secrets"
article.title     #=> "Ruby Meta-programming Secrets"
```


---

## Section 4: Meta Programming
#  Dynamic Object

Another example of meta-programming:
create a dynamic object


---

## Section 4: Meta Programming
#  Hash vs. Object

A hash can have arbitrary properties, but you need to use [] to access them:

```ruby
h = {}
h[:flavor] = "chocolate"
h[:flavor]               #=> "chocolate"
h.flavor                 #=> ERROR
h[:temperature]          #=> nil
```


---

## Section 4: Meta Programming
#  Hash vs. Object

An object has fixed properties/attributes, but you can use dot notation:

```ruby
class FixedProperty
  prop :flavor
end

fp = FixedProperty.new
fp.flavor = "vanilla"
fp.flavor               #=> "vanilla"
fp.temperature          #=> ERROR
```


---

## Section 4: Meta Programming
#  Hash vs. Object

Can we combine these - arbitrary properties with dot notation?

The secret is `method_missing`.


---

## Section 4: Meta Programming
#  Prop with Method Missing

Let's combine `prop` with `method_missing` to give us an object that can dynamically add properties using dot notation.


---

## Section 4: Meta Programming
#  Prop with Method Missing

```ruby
class DynamicObject
  def method_missing(method, *args)
    # does method exist yet?
    unless respond_to? method
      # property doesn't exist yet, need to create it:
      prop_name = method[-1] == "=" ? method.to_s.chop.to_sym : method
      self.class.prop prop_name
    end

    # now invoke the method:
    send method, *args
  end
end
```


---

## Section 4: Meta Programming
#  DynamicObject

```ruby
obj = DynamicObject.new

obj.flavor = "vanilla"
obj.flavor                 #=> "vanilla"
obj.temperature            #=> nil
obj.temperature = "cold"   #=> "cold"
obj.texture = "smooth"     #=> "smooth"
```


---

## Section 5
# [fit] Assignment #5


---

## Section 5: Assignment #5
#  Problem 1

```ruby
# implement prop_reader, write MiniTest unit tests

# expected results:
class PropReader
  prop_reader :flavor
  def initialize(flavor)
    @flavor = flavor
  end
end

obj = PropReader.new "spicy"
obj.respond_to? :flavor     #=> true
obj.respond_to? :"flavor="  #=> false
obj.flavor                  #=> "spicy"
```
