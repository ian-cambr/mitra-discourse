## FOR MITRA RESEARCH STUDENTS

## Set up Virtual Machine and Ubuntu on Windows

1. Install VirtualBox, this will host the Ubuntu Operating System
  - Use this link
  - https://download.virtualbox.org/virtualbox/7.0.14/VirtualBox-7.0.14-161095-Win.exe

2. Install Ubuntu Package
  - Go to webpage linked below and download Ubuntu 22.04 LTS (or most recent LTS Ubuntu package)
  - https://ubuntu.com/download/desktop

3. Set up Ubuntu in VirtualBox (Start video at 1:08 if you followed previous 2 steps)
  ** IMPORTANT **
  - Reccomended allocation of at least 40-50gb of storage for Ubuntu
  - When making a username and password for your VM of Ubuntu make sure to write them down, they will be your login for Ubuntu

  - Follow video below to set up Ubuntu inside VirtualBox
  - https://www.youtube.com/watch?v=rJ9ysibH768

4. If you do not have sudo access by default run the following commands in terminal
  1. su -
    - enter password you used in VirtualBox set up
  2. apt-get install sudo
    - in case sudo isn't installed for some reason
  3. adduser "yourusername" sudo
    - replace "yourusername" with the username you used in VirtualBox set up
  4. Restart Ubuntu

  - Now you should have sudo access, you can check by running
    - sudo apt update



## Set up Local Hosting of Mitra Webpage

1. Follow Steps in Discourse Guide for Ubuntu Local Hosting
  ** IMPORTANT **
  - When creating a new admin on the last step write down the email and password used, this will be your login on the local host to obtain admin privileges

  - When you get to the "Clone Discourse" Step, use "git clone https://github.com/ian-cambr/mitra-discourse.git ~/discourse

  - This will clone the Mitra Discourse github repo instead of the example one in the guide

  - Now just follow the steps in the guide below and you will have local host set up!!
  - https://meta.discourse.org/t/install-discourse-on-ubuntu-or-debian-for-development/14727

2. Updating Github Repository
  - Once you have local host set up, go to your terminal and run the following commands
  1. cd discourse/
  2. git pull
  - this will ensure you have the most up to date version of our local host

## Run Local Host

  1. To run local host go to your terminal and run the following commands
    1. cd discourse/ 
    2. ./run.sh
      - If it is your first time running the local host and Ubuntu says you don't have permission run the following command in your terminal
      1. chmod +rx ./run.sh
      - now you should be able to follow the inital steps and run the local host
  - Once the local host is running navigate to in your web browser
  # http://localhost:4200

## Cloning plugins
1. (in terminal) cd discourse/plugins/
2. (in terminal) git clone "github repository link"
- So far we have one plug in so start by cloning https://github.com/ian-cambr/mitra-sorting.git (replace "github repository link" with this link)

## Set up Theme and Plugin Component
1. Run your local host and navigate to the website (see ##Run Local Host)
2. At the top right corner of the website click log in and sign in with your admin account that you created
3. Now that you're logged in, navigate to admin on the left sidebar and then press the customize tab at the top
4. Now you should be in the themes tab, under themes press blue install button and find "Material Design Theme" under popular themes
5. Now click on Material Design Theme and switch the "Color Palette" to "Material Dark"
6. Next navigate to the Components tab (next to Themes) and press the blue install button
7. Find "From a github repository" option and paste https://github.com/communiteq/plugin-outlets-theme-component and click install
8. Now click on "Plug in Outlet Locations" and find "Include component on these themes"
9. In the drop down menu find and select "Material Design Theme"
10. Reload your local host and you should have a plug looking button in the top right, when you press it, it will highlight all the areas of the webpage we can add plug ins



## Discourse

<a href="https://www.discourse.org/">
  <img src="images/discourse-readme-logo.png" width="300px">
</a>

Discourse is the online home for your community. We offer a 100% open source community platform to those who want complete control over how and where their site is run.

Our platform has been battle-tested for over a decade and continues to evolve to meet users’ needs for a powerful community platform. Discourse allows you to create discussion topics and connect using real-time chat, as well as access an ever-growing number of official and community themes. In addition, we offer a wide variety of plugins for features ranging from chatbots powered by [Discourse AI](https://meta.discourse.org/t/discourse-ai/259214) to functionalities like SQL analysis using the [Data Explorer](https://meta.discourse.org/t/discourse-data-explorer/32566) plugin.

To learn more, visit [**discourse.org**](https://www.discourse.org) and join our support community at [meta.discourse.org](https://meta.discourse.org).

## Screenshots

<a href="https://blog.discourse.org/2023/08/discourse-3-1-is-here/"><img alt="Discourse 3.1" src="https://github-production-user-asset-6210df.s3.amazonaws.com/5862206/261215898-ae95f963-5ab4-4509-b87a-f9f6e9a109bf.png" width="720px"></a>

<a href="https://bbs.boingboing.net"><img alt="Boing Boing" src="https://github-production-user-asset-6210df.s3.amazonaws.com/5862206/261580781-1413ac96-5d08-40b2-bc8e-27c3f2d3bfe6.png" width="720px"></a>

<a href="https://twittercommunity.com/"><img alt="X Community" src="https://github.com/discourse/discourse/assets/2790986/ebb63eee-1927-4060-ada1-cf1bc774084c.png" width="720px"></a>

<img src="https://user-images.githubusercontent.com/1681963/52239118-b304f800-289b-11e9-9904-16450680d9ec.jpg" alt="Mobile" width="414">

Browse [lots more notable Discourse instances](https://www.discourse.org/customers).

## Development

To get your environment set up, follow the community setup guide for your operating system.

1. If you're on macOS, try the [macOS development guide](https://meta.discourse.org/t/beginners-guide-to-install-discourse-on-macos-for-development/15772).
1. If you're on Ubuntu, try the [Ubuntu development guide](https://meta.discourse.org/t/beginners-guide-to-install-discourse-on-ubuntu-for-development/14727).
1. If you're on Windows, try the [Windows 10 development guide](https://meta.discourse.org/t/beginners-guide-to-install-discourse-on-windows-10-for-development/75149).
1. If you're looking to use a simpler Docker-based install, try the [Docker development guide](https://meta.discourse.org/t/install-discourse-for-development-using-docker/102009).

If you're familiar with how Rails works and are comfortable setting up your own environment, you can also try out the [**Discourse Advanced Developer Guide**](docs/DEVELOPER-ADVANCED.md), which is aimed primarily at Ubuntu and macOS environments.

Before you get started, ensure you have the following minimum versions: [Ruby 3.2+](https://www.ruby-lang.org/en/downloads/), [PostgreSQL 13](https://www.postgresql.org/download/), [Redis 7](https://redis.io/download). If you're having trouble, please see our [**TROUBLESHOOTING GUIDE**](docs/TROUBLESHOOTING.md) first!

## Setting up Discourse

If you want to set up a Discourse forum for production use, see our [**Discourse Install Guide**](docs/INSTALL.md).

If you're looking for official hosting, see [discourse.org/pricing](https://www.discourse.org/pricing/).

## Requirements

Discourse is built for the *next* 10 years of the Internet, so our requirements are high.

Discourse supports the **latest, stable releases** of all major browsers and platforms:

| Browsers              | Tablets      | Phones       |
| --------------------- | ------------ | ------------ |
| Apple Safari          | iPadOS       | iOS          |
| Google Chrome         | Android      | Android      |
| Microsoft Edge        |              |              |
| Mozilla Firefox       |              |              |

Additionally, we aim to support Safari on iOS 15.7+.

## Built With

- [Ruby on Rails](https://github.com/rails/rails) &mdash; Our back end API is a Rails app. It responds to requests RESTfully in JSON.
- [Ember.js](https://github.com/emberjs/ember.js) &mdash; Our front end is an Ember.js app that communicates with the Rails API.
- [PostgreSQL](https://www.postgresql.org/) &mdash; Our main data store is in Postgres.
- [Redis](https://redis.io/) &mdash; We use Redis as a cache and for transient data.
- [BrowserStack](https://www.browserstack.com/) &mdash; We use BrowserStack to test on real devices and browsers.

Plus *lots* of Ruby Gems, a complete list of which is at [/main/Gemfile](https://github.com/discourse/discourse/blob/main/Gemfile).

## Contributing

[![Build Status](https://github.com/discourse/discourse/actions/workflows/tests.yml/badge.svg)](https://github.com/discourse/discourse/actions)

Discourse is **100% free** and **open source**. We encourage and support an active, healthy community that
accepts contributions from the public &ndash; including you!

Before contributing to Discourse:

1. Please read the complete mission statements on [**discourse.org**](https://www.discourse.org). Yes we actually believe this stuff; you should too.
2. Read and sign the [**Electronic Discourse Forums Contribution License Agreement**](https://www.discourse.org/cla).
3. Dig into [**CONTRIBUTING.MD**](CONTRIBUTING.md), which covers submitting bugs, requesting new features, preparing your code for a pull request, etc.
4. Always strive to collaborate [with mutual respect](https://github.com/discourse/discourse/blob/main/docs/code-of-conduct.md).
5. Not sure what to work on? [**We've got some ideas.**](https://meta.discourse.org/t/so-you-want-to-help-out-with-discourse/3823)


We look forward to seeing your pull requests!

## Security

We take security very seriously at Discourse; all our code is 100% open source and peer reviewed. Please read [our security guide](https://github.com/discourse/discourse/blob/main/docs/SECURITY.md) for an overview of security measures in Discourse, or if you wish to report a security issue.

## The Discourse Team

The original Discourse code contributors can be found in [**AUTHORS.MD**](docs/AUTHORS.md). For a complete list of the many individuals that contributed to the design and implementation of Discourse, please refer to [the official Discourse blog](https://blog.discourse.org/2013/02/the-discourse-team/) and [GitHub's list of contributors](https://github.com/discourse/discourse/contributors).

## Copyright / License

Copyright 2014 - 2023 Civilized Discourse Construction Kit, Inc.

Licensed under the GNU General Public License Version 2.0 (or later);
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Discourse logo and “Discourse Forum” ®, Civilized Discourse Construction Kit, Inc.

## Accessibility

To guide our ongoing effort to build accessible software we follow the [W3C’s Web Content Accessibility Guidelines (WCAG)](https://www.w3.org/TR/WCAG21/). If you'd like to report an accessibility issue that makes it difficult for you to use Discourse, email accessibility@discourse.org. For more information visit [discourse.org/accessibility](https://discourse.org/accessibility).

## Dedication

Discourse is built with [love, Internet style.](https://www.youtube.com/watch?v=Xe1TZaElTAs)
