require 'spec_helper'

describe AdminAuth::Engine do
  subject { AdminAuth::Engine }

  describe 'autoload controllers' do
    let(:root_path) { "#{subject.config.root}/app/controllers/admin" }

    it { expect(subject.config.autoload_paths).to include "#{root_path}/admins_controller.rb" }
    it { expect(subject.config.autoload_paths).to include "#{root_path}/sessions_controller.rb" }
  end

  describe 'autoload controllers' do
    let(:root_path) { "#{subject.config.root}/app/views/admin" }

    it { expect(subject.config.autoload_paths).to include "#{root_path}/admins/edit.haml" }
    it { expect(subject.config.autoload_paths).to include "#{root_path}/admins/index.haml" }
    it { expect(subject.config.autoload_paths).to include "#{root_path}/admins/new.haml" }
    it { expect(subject.config.autoload_paths).to include "#{root_path}/sessions/new.haml" }
  end
end
