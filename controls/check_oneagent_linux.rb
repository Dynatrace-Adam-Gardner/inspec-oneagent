title 'Check OneAgent (Linux)'

control 'check_oneagent_linux' do

  title 'Verify OneAgent'
  desc 'Ensure OneAgent is installed, enabled and running'
  desc 'Ensure OneAgent is in infrasture only mode'

  # To pass the test
  # service oneagent should be:
  # Installed, enabled and running
  describe service('oneagent') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  # To pass the test
  # /opt/dynatrace/oneagent/agent/tools/oneagentctl should exist
  describe file('/opt/dynatrace/oneagent/agent/tools/oneagentctl') do
    it { should exist }
  end

  # To pass the test
  # The output of sudo /opt/dynatrace/oneagent/agent/tools/oneagentctl --get-infra-only
  # Should be false ie. The agent is in fullstack mode
  describe command('sudo /opt/dynatrace/oneagent/agent/tools/oneagentctl --get-infra-only') do
    its('stdout') { should match 'false' }
  end

end
