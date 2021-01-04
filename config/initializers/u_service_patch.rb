# frozen_string_literal: true

Micro::Service::Pipeline::Reducer.class_eval do
  def call(arg = {})
    @services.reduce(initial_result(arg)) do |result, service|
      break result if result.failure?
      service.__new__(result, arg.merge!(result.value)).call
    end
  end
end

Micro::Service::Pipeline::SafeReducer.class_eval do
  def call(arg = {})
    @services.reduce(initial_result(arg)) do |result, service|
      break result if result.failure?
      result.instance_variable_set(:@value, arg.merge!(result.value))
      service_result(service, result)
    end
  end
end
