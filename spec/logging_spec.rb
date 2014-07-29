require 'rspec'
require 'spec_helper'
require 'corundum_context'

describe 'Corundum logging spec' do
  include_context 'corundum context'

  it 'should print each of the log statements' do
    site = Corundum::Config::URL #pulls from framework config
    Driver.visit(site) #Driver pulls from framework config
    $log.debug('DEBUG example.')
    sleep 1
    $log.info('INFO example.')
    sleep 1
    $log.warn('INFO example.')
    sleep 1
    $log.error('ERROR example.')
  end

end