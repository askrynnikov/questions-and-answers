# Многие при тестировании ajax-функционала в acceptance-тестах сталкиваются с тем,
# что js-код выполняется медленнее, чем проверки в тесте. В итоге, тест не проходит.
# http://connect.thinknetica.com/t/sovety-uvelichenie-vremeni-ozhidaniya-ajax-otveta/976
# https://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara


# лучше после нажатия проверить нужный элемент на странице, до щелчка на след ссылке :)"

module WaitForAjax
#   def finished_all_ajax_requests?
#     return_value = page.evaluate_script <<-SCRIPT.strip.gsub(/\s+/, ' ')
#     (function () {
#       if (typeof jQuery != 'undefined') {
#         return jQuery.active;
#       }
#       else {
#         console.log("Failed on the page: " + document.URL);
#         console.error("An error occurred when checking for `jQuery.active`.");
#       }
#     })()
#     SCRIPT
#     return_value and return_value.zero?
#   end
#
# # @see http://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara Automatically wait for AJAX with Capybara
#   def wait_for_ajax(task: 'Waiting for AJAX', wait_time: nil)
#     DebugHelpers.time_execution(task) do
#       wait_time ||= Capybara.default_wait_time
#
#       Timeout.timeout(wait_time) do
#         loop until finished_all_ajax_requests?
#       end
#     end
#   end


  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop do
        active = page.evaluate_script('jQuery.active')
        break if active == 0
      end
    end
  end

  # def wait_for_ajax
  #   Timeout.timeout(Capybara.default_max_wait_time) do
  #     loop until finished_all_ajax_requests?
  #   end
  # end
  #
  # def finished_all_ajax_requests?
  #   page.evaluate_script('jQuery.active').zero?
  # end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end