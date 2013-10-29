require "active_support/core_ext/date/calculations"
require "active_support/core_ext/time/calculations"
require "ostruct"

require "hamster_time/version"
require "hamster_time/hamster"
require "hamster_time/pivotal_tracker"

module HamsterTime
  class App
    attr_reader :activities, :site

    def initialize report_day = nil
      @activities = []
      @report_day = report_day
      @site       = PivotalTracker::Site.new
    end

    def run
      Hamster.establish_connection
      collect_activities
      group_activities_by_name
      publish_activities
    end

    private

    def collect_activities
      @activities = Hamster::Fact.includes(:activity).joins(:activity).where(%^
        start_time > ? AND end_time < ? AND synced IS NOT 1
        ^, report_day.beginning_of_day, report_day.end_of_day
      )
    end

    def publish_activities
      site.sign_in
      activities.each do |_, activity|
        if site.add_activity activity
          puts "Added activity: #{activity.name}"
        else
          puts "Failed to add activity: #{activity.name}"
        end
        sleep rand(3)
      end
      puts "-" * 50
      puts "Total: #{activities.map{|_, item| item.hours }.sum}"
    end

    def report_day
      @report_day || Date.yesterday
    end

    def group_activities_by_name
      @activities = activities.inject({}) do |result, item|
        unless result.key?(item.activity_id)
          result[item.activity_id] = OpenStruct.new({
            name: item.activity.name,
            hours: round_time(item.end_time - item.start_time),
            start_time: item.start_time,
            category: item.activity.category.name,
            description: "#{item.tag_names}, #{item.activity.name[/#.+/] || item.activity.name}"
          })
        else
          result[item.activity_id].hours += round_time(item.end_time - item.start_time)
        end
        result
      end
    end

    def round_time diff
      ((diff / 60 / 60).round(2) / 0.25).round * 0.25
    end
  end
end