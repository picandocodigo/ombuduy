pid "/var/run/unicorn/unicorn.pid"
stderr_path "/var/log/unicorn/ombuduuy.error.log"
stdout_path "/var/log/unicorn/ombuduuy.access.log"
working_directory File.expand_path("../../", __FILE__)

listen "/var/run/unicorn/unicorn.sock"

worker_processes 4
preload_app true
timeout 30

# Added by martin@guruhub.com.uy 14/05/12
before_exec do |server|
  # reset spawned workers file
  fork_count = server.config[:pid].sub('unicorn.pid', "workers.spawn")
  system("echo -n '' > #{fork_count}")
end

after_fork do |server, worker|
  # reset redis connection after each fork
  # Redis.current.quit

  # Added by martin@guruhub.com.uy 14/05/12
  # Zabbix monitoring helpers
  child_pid = server.config[:pid].sub('unicorn.pid', "worker.#{worker.nr}.pid")
  system("echo #{Process.pid} > #{child_pid}")
  # track num of spawned workers
  fork_count = server.config[:pid].sub('unicorn.pid', "workers.spawn")
  system("echo -n '.' >> #{fork_count}")
end
