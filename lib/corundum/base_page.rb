module ElementBuilder
  def element(name, friendly_name, by_type, by)
    define_method name.to_s do
      Element.new(friendly_name, by_type, by)
    end
  end

  def sub_page(name, clazz, *args)
    define_method name.to_s do
      @mapped_sub_page ||= {}
      @mapped_sub_page[name.to_s] ||= clazz.new *args
      @mapped_sub_page[name.to_s]
    end
  end
end

class BasePage
  extend ElementBuilder

  def initialize
    wait_for_elements
  end

  def wait_for_elements

  end
end