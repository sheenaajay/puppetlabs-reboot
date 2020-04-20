require 'spec_helper_acceptance'

describe 'Reboot when Finished' do
  let(:reboot_manifest) do
    <<-MANIFEST
      notify { 'step_1':
      } ~>
      reboot { 'now':
        apply => finished
      } ->
      notify { 'step_2':
      }
    MANIFEST
  end

  it 'Reboot After Finishing Complete Catalog' do
    apply_manifest(reboot_manifest, catch_failures: true) do |result|
      expect(result.stdout).to match(%r{defined 'message' as 'step_2'})
    end
    expect(reboot_issued_or_cancelled).to be(true)
  end
end
