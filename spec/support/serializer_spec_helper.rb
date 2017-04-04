module SerializerSpecHelper

  def serialize(obj:, mod:)
    serializer_class = "#{mod}::#{obj.class.name}Serializer".constantize
    serializer = serializer_class.send(:new, obj)
    adapter = ActiveModelSerializers::Adapter.create(serializer)

    return JSON.parse(adapter.to_json)
  end

end
