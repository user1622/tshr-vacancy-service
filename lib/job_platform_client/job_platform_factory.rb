module JobPlatformClient
  class JobPlatformFactory
    def self.client(job_platform)
      case job_platform.id
      when 1
        JobPlatform::DevBy.new
      end
    end
  end
end