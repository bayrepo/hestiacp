#!/opt/brepo/ruby33/bin/ruby

class EmptyWorker < Kernel::ModuleCoreWorker
  MODULE_ID = "empty_module"

  def info
    {
      ID: 3,
      NAME: MODULE_ID,
      DESCR: "Just empty module for storing max module id",
      REQ: "",
      CONF: "",
    }
  end

  implements IPluginInterface
end

module EmptyModule
  def get_object
    Proc.new { EmptyWorker.new }
  end

  module_function :get_object
end

class Kernel::PluginConfiguration
  include EmptyModule

  @@loaded_plugins[EmptyWorker::MODULE_ID] = EmptyModule.get_object
end
