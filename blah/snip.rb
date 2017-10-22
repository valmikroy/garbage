require 'erb'

module Helper
  class Template
    include ERB::Util
    attr_accessor :data, :template
    def initialize(data, template)
      @data = data
      @template = template
    end

    def render
      ERB.new(@template, nil, '-').result(binding)
    end

    def save(file)
      File.open(file, 'w+') { |f| f.write(render) }
    end
  end
end



########


require 'mixlib/shellout'

module Helper
  module Shell
    def shellout!(*c)
      cmd = Mixlib::ShellOut.new(*c)
      PerfPostProcess.logger.debug(c)
      cmd.timeout = 3600
      cmd.run_command
      cmd.error! # raises exception which will stop execution
      cmd.stdout
    end

    # Do you know FileUtils demands imagemagik as dependecy ?
    def mkdir(path)
      return if Dir.exist?(path)
      shellout!("mkdir -p #{path}")
    end

    def file_cp(src, dst)
      raise "#{src} does not exists" unless File.exist?(src)
      shellout!("cp #{src}  #{dst}")
    end

    def bin_exist(bin)
      return bin if File.executable?(bin)
      raise "#{bin} does not exists"
    end

    def which(name)
      shellout!("which #{name}").chomp
    end
  end
end


##########
require 'socket'
require 'timeout'


    def port_check?(host, port)
      seconds = 10
      return true if Tsung.dry?
      Timeout.timeout(seconds) do
        begin
          TCPSocket.new(host, port).close
          true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          false
        end
      end
    rescue Timeout::Error
      false
    end
    
    
##############

require 'aws-sdk'
require 'tempfile'

module  Helper
  module S3


    private

    def s3_client
      Aws.config[:ssl_verify_peer] = false
      Aws::S3::Client.new
    end

    def s3_resources
      Aws.config[:ssl_verify_peer] = false
      Aws::S3::Resource.new
    end

    def s3_download_stream(bucket, path)
      s3_client.get_object(bucket: bucket, key: path).body.read
    end

    def s3_download_file(bucket, path)
      # need error handling
      s3 = s3_client
      tmp = Tempfile.new('s3_download')
      s3.get_object(bucket: bucket, key: path) do |chunk|
        tmp.write(chunk)
      end
      tmp.flush
      tmp.close
      tmp.path
    end

    def s3_upload_file(bucket, path, file)
      obj = s3_resources.bucket(bucket).object(path)
      obj.upload_file(file)
    end

    def s3_upload_stream(bucket, path, blob)
      obj = s3_resources.bucket(bucket).object(path)
      obj.put(body: blob)
    end

    def upload_stream(glob)
      bucket = data[:s3_bucket]
      key = data[:s3_key]

      AWS.logger.info("action=upload_stream s3_bucket=#{bucket} s3_key=#{key}")
      s3_upload_stream(bucket,key,glob)
    end

    def upload_file(file)
      bucket = data[:s3_bucket]
      key = data[:s3_key]

      AWS.logger.info("action=upload_file s3_bucket=#{bucket} s3_key=#{key}")
      s3_upload_file(bucket, key, file)
    end

    def download_file
      bucket = data[:s3_bucket]
      key = data[:s3_key]
      AWS.logger.info("action=download_file s3_bucket=#{bucket} s3_key=#{key}")
      s3_download_file(bucket, key)
    end

    def download_stream
      bucket = data[:s3_bucket]
      key = data[:s3_key]
      AWS.logger.info("action=download_stream s3_bucket=#{bucket} s3_key=#{key}")
      s3_download_stream(bucket, key)
    end

  end
end
#############

module S3
  module Stub
    module Valid
      def s3_client
        c = Aws::S3::Client.new(stub_responses: true)
        c.stub_responses(:get_object, body: 'data')
        c
      end

      def s3_upload_file(bucket, path, file)
        [bucket, path, file]
      end

      def s3_upload_stream(bucket, path, blob)
        [bucket, path, blob]
      end
    end

    module Invalid
      def s3_client
        c = Aws::S3::Client.new(stub_responses: true)
        c.stub_responses(:get_object, 'NotFound')
        c
      end
    end
  end
end

