require_relative 'read'


module EnvBash
  def EnvBash.load(envbash, into: ENV, override: false, remove: false, **kwargs)
    loaded = read(envbash, **kwargs)
    is_env = into.equal? ENV
    into = into.to_h if is_env
    if loaded
      into.select! {|k| loaded.include? k} if remove
      loaded.reject! {|k| into.include? k} unless override
      into.merge! loaded
    end
    ENV.replace into if is_env
  end
end
