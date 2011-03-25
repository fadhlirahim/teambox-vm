bash "set ruby enterpise as default ruby" do
  user "root"
  code <<-EOH
  echo "PATH=#{node["ruby_enterprise"]["install_path"]}/bin:$PATH" >> /etc/profile
  EOH
  not_if "grep #{node["ruby_enterprise"]["install_path"]} /etc/profile"
end

