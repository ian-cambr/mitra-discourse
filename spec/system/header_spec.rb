# frozen_string_literal: true

RSpec.describe "Glimmer Header", type: :system do
  fab!(:current_user) { Fabricate(:user) }
  before { SiteSetting.experimental_glimmer_header_groups = Group::AUTO_GROUPS[:everyone] }

  it "renders basics" do
    visit "/"
    expect(page).to have_css("header.d-header")
    expect(page).to have_css("#site-logo")
  end

  it "displays sign up / login buttons" do
    visit "/"
    expect(page).to have_css("button.sign-up-button")
    expect(page).to have_css("button.login-button")

    find("button.sign-up-button").click
    expect(page).to have_css(".d-modal.create-account")

    click_outside

    find("button.login-button").click
    expect(page).to have_css(".d-modal.login-modal")
  end

  it "shows login button when login required" do
    SiteSetting.login_required = true

    visit "/"
    expect(page).to have_css("button.login-button")
    expect(page).to have_css("button.sign-up-button")
    expect(page).not_to have_css("#search-button")
    expect(page).not_to have_css("button.btn-sidebar-toggle")
  end

  it "renders unread notifications count when user's notifications count is updated" do
    Fabricate(
      :notification,
      user: current_user,
      high_priority: true,
      read: false,
      created_at: 8.minutes.ago,
    )

    sign_in(current_user)
    visit "/"
    expect(page).to have_selector(
      ".header-dropdown-toggle.current-user .unread-notifications",
      text: "1",
    )
  end

  it "doesn't show pending reviewables count for non-legacy navigation menu" do
    SiteSetting.navigation_menu = "sidebar"
    current_user.update!(admin: true)
    Fabricate(:reviewable)

    sign_in(current_user)
    visit "/"
    expect(page).not_to have_selector(".hamburger-dropdown .badge-notification")
  end

  it "closes revamped menu when clicking outside" do
    sign_in(current_user)
    visit "/"
    find(".header-dropdown-toggle.current-user").click
    expect(page).to have_selector(".user-menu.revamped")
    find("header.d-header").click
    expect(page).not_to have_selector(".user-menu.revamped")
  end

  it "sets header's height css property" do
    sign_in(current_user)
    visit "/"
    resize_element(".d-header", 90)
    wait_for(timeout: 100) { get_computed_style_value(".d-header", "--header-offset") == "90px" }
    expect(get_computed_style_value(".d-header", "--header-offset")).to eq("90px")

    resize_element(".d-header", 60)
    wait_for(timeout: 100) { get_computed_style_value(".d-header", "--header-offset") == "60px" }
    expect(get_computed_style_value(".d-header", "--header-offset")).to eq("60px")
  end

  it "moves focus between tabs using arrow keys" do
    sign_in(current_user)
    visit "/"
    find(".header-dropdown-toggle.current-user").click
    expect(active_element_id).to eq("user-menu-button-all-notifications")

    find("##{active_element_id}").send_keys(:arrow_down)
    expect(active_element_id).to eq("user-menu-button-replies")

    4.times { find("##{active_element_id}").send_keys(:arrow_down) }
    expect(active_element_id).to eq("user-menu-button-profile")

    find("##{active_element_id}").send_keys(:arrow_down)
    expect(active_element_id).to eq("user-menu-button-all-notifications")

    find("##{active_element_id}").send_keys(:arrow_up)
    expect(active_element_id).to eq("user-menu-button-profile")
  end

  it "prioritizes new personal messages bubble over unseen reviewables and regular notifications bubbles" do
    Fabricate(:private_message_notification, user: current_user)
    Fabricate(
      :notification,
      user: current_user,
      high_priority: true,
      read: false,
      created_at: 8.minutes.ago,
    )

    sign_in(current_user)
    visit "/"
    expect(page).not_to have_selector(
      ".header-dropdown-toggle.current-user .badge-notification.unread-notifications",
    )
    expect(page).not_to have_selector(
      ".header-dropdown-toggle.current-user .badge-notification.with-icon.new-reviewables",
    )

    expect(page).to have_selector(
      ".header-dropdown-toggle.current-user .badge-notification.with-icon.new-pms",
    )
    expect(page).to have_css(".d-icon-envelope")
    expect(
      find(".header-dropdown-toggle.current-user .badge-notification.with-icon.new-pms")[:title],
    ).to eq(I18n.t("js.notifications.tooltip.new_message_notification", count: 1))
  end

  it "prioritizes unseen reviewables bubble over regular notifications" do
    current_user.update!(admin: true)
    Fabricate(:reviewable)

    sign_in(current_user)
    visit "/"
    expect(page).not_to have_selector(
      ".header-dropdown-toggle.current-user .badge-notification.unread-notifications",
    )
    expect(page).to have_selector(
      ".header-dropdown-toggle.current-user .badge-notification.with-icon.new-reviewables",
    )
    expect(page).not_to have_selector(
      ".header-dropdown-toggle.current-user .badge-notification.with-icon.new-pms",
    )
  end

  it "shows regular notifications bubble if there are neither new personal messages nor unseen reviewables" do
    Fabricate.times(
      3,
      :notification,
      user: current_user,
      high_priority: true,
      read: false,
      created_at: 8.minutes.ago,
    )

    sign_in(current_user)
    visit "/"
    expect(page).to have_selector(
      ".header-dropdown-toggle.current-user .badge-notification.unread-notifications",
      text: "3",
    )
    expect(
      find(".header-dropdown-toggle.current-user .badge-notification.unread-notifications")[:title],
    ).to eq(I18n.t("js.notifications.tooltip.regular", count: 3))
    expect(page).not_to have_selector(
      ".header-dropdown-toggle.current-user .badge-notification.with-icon.new-reviewables",
    )
    expect(page).not_to have_selector(
      ".header-dropdown-toggle.current-user .badge-notification.with-icon.new-pms",
    )
  end

  context "when logged in and login required" do
    fab!(:current_user) { Fabricate(:user) }

    it "displays current user when logged in and login required" do
      SiteSetting.login_required = true
      sign_in(current_user)

      visit "/"
      expect(page).not_to have_css("button.login-button")
      expect(page).not_to have_css("button.sign-up-button")
      expect(page).to have_css("#search-button")
      expect(page).to have_css("button.btn-sidebar-toggle")
      expect(page).to have_css("#current-user")
    end
  end

  private

  def get_computed_style_value(selector, property)
    page.evaluate_script(
      "window.getComputedStyle(document.querySelector('#{selector}')).getPropertyValue('#{property}')",
    ).strip
  end

  def resize_element(selector, size)
    page.evaluate_script("document.querySelector('#{selector}').style.height = '#{size}px'")
  end

  def active_element_id
    page.evaluate_script("document.activeElement.id")
  end

  def click_outside
    find(".d-modal").click(x: 0, y: 0)
  end
end
