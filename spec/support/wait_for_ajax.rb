# Многие при тестировании ajax-функционала в acceptance-тестах сталкиваются с тем,
# что js-код выполняется медленнее, чем проверки в тесте. В итоге, тест не проходит.
# http://connect.thinknetica.com/t/sovety-uvelichenie-vremeni-ozhidaniya-ajax-otveta/976
# https://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara


# лучше после нажатия проверить нужный элемент на странице, до щелчка на след ссылке :)"

module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end