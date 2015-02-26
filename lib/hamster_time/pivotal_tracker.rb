require 'mechanize'

module PivotalTracker
  class Site
    attr_reader :username, :password, :agent, :page

    SIGN_IN_URL = 'https://www.pivotaltracker.com/signin'
    NEW_TIME_SHIFT_URL = 'https://www.pivotaltracker.com/time_shifts/new'

    def initialize
      @username = ENV['PIVOTAL_USERNAME']
      @password = ENV['PIVOTAL_PASSWORD']
      @agent    = Mechanize.new do |agent|
        agent.user_agent_alias = 'Linux Firefox'
      end
    end

    def sign_in
      page = agent.get(SIGN_IN_URL)
      form = page.form_with action: '/signin'
      form.field_with(id: 'credentials_username').value = username
      form.field_with(id: 'credentials_password').value = password
      form.submit
    end

    def add_activity(activity)
      page = agent.get(NEW_TIME_SHIFT_URL)
      form = page.form_with action: '/time_shifts'
      project = form.field_with(id: 'shift_project_id').options.detect { |option| option.text == activity.category }
      if project
        project.click
      else
        fail("Project '#{activity.category}' doesn't exist in project select box!")
      end
      form.add_field!('shift[date]', format_date(activity.start_time))
      form.field_with(id: 'shift_hours').value = activity.hours
      form.field_with(id: 'shift_description').value = activity.description
      form.submit
      page.search('#flash .errorText').blank?
    end

    private

    def format_date(time)
      time.strftime('%m/%d/%Y')
    end
  end
end
