module AdminAuth
  class Repository
    attr_reader :klass

    def initialize
      @klass = Admin
    end

    def all
      klass.all
    end

    def new(attributes = {})
      klass.new(attributes)
    end

    def create(attributes)
      klass.create(attributes)
    end

    def find(attributes)
      klass.where(attributes).first
    end

    def update(id, attributes)
      model = find(id: id)
      model.update_attributes(attributes)

      model
    end

    def destroy(id)
      find(id: id).destroy
    end
  end
end
