---
layout: post
title:  "Getting Ruby"
date:   2025-02-16 00:00:00 +0100
categories: how-to
headshot: getting-ruby.jpg
---
I've run a few coding clubs and getting started with Ruby as a programming language from zero can seem intimidating. But it doesn't have to be!

This guide is written for someone with a Mac.

## The Terminal
You'll be spending a bit of time with this guy. The Terminal. You can find the Terminal in **Applications** → **Utilities** → **Terminal.app**. Once it's open, you'll be presented with what looks like a very, very stripped down text editor and a blinking box.

The blinking box is your cursor. You'll need to type any text that you want to run, you can't highlight and delete parts like you can in Word or Pages, so you can navigate around with the direction arrows on your keyboard. <span class="keycap">↑</span>, <span class="keycap">↓</span>, <span class="keycap">←</span> and <span class="keycap">→</span>. Hitting <span class="keycap">↩︎ Enter</span> will run the command.

> _Safety Notice: Don't blindly copy and paste code you find on the internet into the Terminal. Although this guide does have some copy and pasting from the internet—but from trusted sources!_

Try typing `echo 'Hello World'` including the commas. Congrats, you've written a little program that prints text!

## Getting Ruby
The Mac has a default version of Ruby installed. Type `ruby -v` into the terminal to find out which version you have. It probably starts with the number `2` which is a little old for what we want to do.

### Part 1: Homebrew
Homebrew is a package manager for Mac. It's a little like the App Store, but for lower-level programs we can use for development. It's open-source on GitHub, so other developers have inspected what it does, and it's considered very safe.

Let's install Homebrew using the instructions on https://brew.sh which involved copy and pasting the code from their site into your Terminal.
> _I did warn against blindly copy-and-pasting code. You can take a look at https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh directly to see what code will be run. It's a lot, but it's safe._

You'll see a lot of output in the terminal as your computer runs through the script and gets the things it needs, and puts them in the right place. I find, if something goes wrong, pasting the last line into Google usually turns up helpful results.

Now you have Homebrew, we can install Ruby! No, there's another step. We want to install a Version Manager to manage Ruby.

### Part 2: Version Manager rbenv
[Here is rbenv's README file](https://github.com/rbenv/rbenv?tab=readme-ov-file). Developers use these files to explain the projects and often come with helpful installation instructions.
1. Run `brew install rbenv` in your Terminal. Homebrew will add rbenv to your machine.
2. Run `rbenv init` and follow the onscreen instructions. Rbenv will install itself and make Ruby available to you.

### Part 3: Installing Ruby
Now we have **Homebrew** and **rbenv** we can install Ruby.

[These are the instructions to add a Ruby version with rbenv](https://github.com/rbenv/rbenv?tab=readme-ov-file#installing-ruby-versions). The warning is that if your machine doesn't have a package called `ruby-build`, rbenv will throw an error at you. The page linked has the instructions to install it from GitHub.

1. Install a modern Ruby like 3.1.2 by running `rbenv install 3.1.2` in the Terminal.
2. Make the version of Ruby available once it's installed with `rbenv global 3.1.2`.

Now we can install Gems! A bit like Homebrew, Ruby can also add packages to your machine with the `bundle` command. Install it with `gem install bundler`.

> _Remember `brew install` installs software packages of any language for us to use. `gem install` adds Ruby libraries._

3. Quit the Terminal. You can do this with <span class="keycap">⌘Q</span>. And re-open it.
4. Check the Ruby version you've installed works. If you type `ruby -v` into the Terminal now, you should see the version number reflected that you've just installed with rbenv!