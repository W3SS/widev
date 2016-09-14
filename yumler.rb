require 'yard'
require 'active_support'
require 'set'

class ModelHandler < YARD::Handlers::Ruby::Base
  handles :class

  def process
    return unless statement[1]
    sclass = statement[1].source
    if sclass != "ActiveRecord::Base"
      ensure_loaded!(klass = P(sclass))
      if klass.type != :proxy && klass.inheritance_tree.include?(P("ActiveRecord::Base"))
        this = statement[0].source
        $connections << Connection.new(sclass, 0, this, 0, nil, false, true)
      end
    end
  end
end

class RelationshipHandler < YARD::Handlers::Ruby::Base
  handles method_call(:has_one)
  handles method_call(:belongs_to)
  handles method_call(:has_many)
  handles method_call(:has_and_belongs_to_many)

  def process
    eval(statement.source)
  end

  def self.const_missing(symbol)
    obj = Object.new
    def obj.method_missing(*args) end
    obj
  end

  protected

  def has_one(model, opts = {})
    connect(model, 1, 1, opts)
  end

  def has_many(model, opts = {})
    connect(model, 1, '*', opts)
  end

  def belongs_to(model, opts = {})
    connect(model, 1, 1, opts, false)
  end

  def has_and_belongs_to_many(model, opts = {})
    connect(model, '*', '*', opts)
  end

  private

  def connect(model, mleft, mright, opts = {}, high_priority = true)
    title = nil
    dotted = false
    if opts.has_key?(:through)
      if opts.has_key?(:source)
        model = opts[:source]
        title = model_name(model).pluralize.titleize
        dotted = true
      end
    end

    if opts.has_key?(:class_name)
      title = model_name(model).titleize
      model = opts[:class_name]
    end

    this = namespace.name.to_s
    other = model_name(model)
    conn = Connection.new(this, mleft, other, mright, title, dotted)
    $connections.delete(conn) if high_priority
    $connections << conn
  end

  def model_name(model) model.to_s.camelcase.singularize end
end

class Connection
  attr_accessor :left, :right, :title, :dotted, :superclass
  attr_accessor :multiplicity_left, :multiplicity_right

  def initialize(l, ml, r, mr, title = nil, dotted = false, superclass = false)
    self.left = l.to_s
    self.right = r.to_s
    self.multiplicity_left = ml.to_s
    self.multiplicity_right = mr.to_s
    self.title = title
    self.dotted = dotted
    self.superclass = superclass
  end

  def hash
    [left, right, title.to_s].sort.hash
  end

  def eql?(other)
    [left, right, title.to_s, superclass.to_s].sort.eql? [
                                                             other.left, other.right, other.title.to_s, other.superclass.to_s].sort
  end

  def to_s
    return "[#{left}]^-[#{right}]" if superclass
    line = ""
    line << "[#{left}]"
    if multiplicity_left == "1" && multiplicity_right != "1"
      line << "++" unless dotted
    else
      line << "#{multiplicity_left}-"
    end
    line << "-#{title}" if title
    line << "-#{dotted ? '.-' : ''}"
    if multiplicity_right == "1" && multiplicity_left != "1"
      line << "++" unless dotted
    else
      line << "#{multiplicity_right}"
    end
    line << "[#{right}]"
    line
  end
end

log.level = Logger::ERROR
%w(instiki gemcutter seed radiant mephisto insoshi spree).each do |name|
  $connections = Set.new
  YARD::Registry.clear
  YARD.parse(name + '/app/models/*.rb')
  puts name.capitalize + ":"
  puts "<img src=\"http://yuml.me/diagram/scruffy/class/" + $connections.to_a.join(',') + "\" />"
  puts
  puts $connections.to_a.join("\n") if $DEBUG
end