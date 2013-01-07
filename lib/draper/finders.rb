module Draper
  # Provides automatically-decorated finder methods for your decorators. You
  # do not have to extend this module directly; it is extended by
  # {Decorator.decorates_finders}.
  module Finders

    def find(id, options = {})
      decorate(source_class.find(id), options)
    end

    def all(options = {})
      decorate_collection(source_class.all, options)
    end

    def first(options = {})
      decorate(source_class.first, options)
    end

    def last(options = {})
      decorate(source_class.last, options)
    end

    # Decorates dynamic finder methods (`find_all_by_` and friends).
    def method_missing(method, *args, &block)
      result = super
      options = args.extract_options!

      case method.to_s
      when /^find_((last_)?by_|or_(initialize|create)_by_)/
        decorate(result, options)
      when /^find_all_by_/
        decorate_collection(result, options)
      else
        result
      end
    end
  end
end
