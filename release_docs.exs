Mix.Task.run "docs"
File.cd! "../placid-docs", fn -> System.cmd "git", ["checkout", "gh-pages"] end
File.rm_rf "../placid-docs/*"
File.cp_r "docs/.", "../placid-docs/"
File.rm_rf "docs"
File.cd! "../placid-docs", fn -> 
  System.cmd "git", ["add", "-A"]
  System.cmd "git", ["commit", "-m", "\"Update for #{Mix.Project.config[:version]}\""]
  System.cmd "git", ["push"]
end