from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

@given(u'I navigate to "/"')
def step_impl(context):
    context.base_url = "http://ts-scratch:8080"
    context.wd_root = "http://selenium-hub:4444"
    context.driver = webdriver.Remote(
        command_executor=f"{context.wd_root}/wd/hub",
        desired_capabilities=DesiredCapabilities.CHROME
    )

@then(u'I see the landing page')
def step_impl(context):
    context.get(context.base_url)
    assert "ts-scratch" in driver.title
