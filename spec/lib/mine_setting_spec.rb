RSpec.describe MineSetting do
  let(:cls) do
    Class.new { extend MineSetting }
  end
  let(:config_dir) { File.expand_path('../../settings', __FILE__) }


  it 'include should raise error' do
    expect {
      Class.new { include MineSetting }
    }.to raise_error(/\ACannot include SimpleSettings/)
  end


  describe '.load_dir' do
    it 'should define config methods' do
      expect {
        cls.load_dir(config_dir, :development)
      }.to change { cls.respond_to?(:base) && cls.respond_to?(:secrets) }.to(true)
    end
  end


  describe 'config_methods' do
    it 'should retrun config' do
      cls.load_dir(config_dir, :development)

      expect(cls.base).to eq({
        'name' => 'base',
        'number' => 333,
        'env' => 'development'
      })

      expect(cls.secrets).to eq({
        'name' => 'secrets',
        'key' => 'this my key'
      })
    end

    it 'load with env should correct' do
      cls.load_dir(config_dir, :test)

      expect(cls.base).to eq({
        'name' => 'base',
        'number' => 123,
        'env' => 'test'
      })

      expect(cls.secrets).to eq({
        'name' => 'secrets',
        'key' => 'what my key?'
      })
    end
  end
end

