---
layout: post
title:  "Static Site Generators"
date:   2024-09-26 22:47:36 +0100
categories: how-to
headshot: patrick-tomasso-Oaqk7qqNh_c-unsplash.jpg
---

I’ve been moving this website around from host to host. I believe the first iteration was WordPress on a Media Temple VPS… I was one of the Kickstarter Backers for [Ghost](https://ghost.org/) and now I’ve found [Bridgetown](https://www.bridgetownrb.com/).

Bridgetown presents itself as a grown-up version of Jekyll, which I believe so far from my experimentation!

Earlier this year I was tasked with writing a site for my mother-in-law’s book. I chose Jekyll because I’m familiar(-ish) with Liquid and a Rubyist at heart. It didn’t need anything fancy like logins or dynamic content. Rails would have been complete overkill. I’m not proficient enough to make a theme for Ghost, plus there won’t be multiple pages/posts to begin with. For a landing page, Jekyll should be cool?

Ohh, nope. I found setup tricky, locked at Ruby 3.1.1 to get Tailwind to operate properly. I spent most of my time fighting a losing battle with PostCSS. Nobody needs that. The dependencies feel like they’re in a state of equilibrium, but we did achieve equilibrium. Bridgetown offered a solution with a sharp alternative: none of that nonsense. About 2 hours later I’ve moved everything over and managed to jam the Tailwind nom package without all the endless rabbit holes which Jekyll offered.

The other motivation is that I can move my Activepeices installation away. I won’t require a dedicated VPS to run Ghost. Markdown is highly portable. I’ve found I don’t benefit from Ghost’s features since - at this stage at least - I don’t have a huge audience. I’ll get it to build the site, either as a GitHub action or on Cloudflare directly and push it to their CDN. Done. I won’t have to worry about my lets-encrypt! So much overhead gone.

Oh, best of all, Bridgetown supports ERB templates. I can rely on my Rails muscle memory.

I tried running a session with some colleagues of mine outside the engineering team and have just only realised what an uphill battle it can be to write websites now. You’re faced with a WYSIWYG third party you shell out a fortune for, have to scaffold your laptop to run a language of your choice and the installers for the libraries (Brew, RVM, asdf, an IDE, bundler - for a Jekyll example) to add a language you’re not familiar with on top of HTML, CSS and JS. Handwriting HTML doesn’t seem too bad once you’ve got one page you like, set up.

Anyway, we got there at the end of our hour, after navigating the Terminal and its cryptic messages. As a newbie, it’s hard to tell what’s an error, what needs to be actioned, and filenames with underscores are generally off-putting. Are examples of some of the lessons I learned from the session.

### What I did for Bridgetown:

I abandoned using the Tailwind gem in favour of the NPM package since Bridgetown comes with PostCSS support, and it saves me having to set up Overmind or Foreman and a Procfile.

```bash
gem install bridgetown -N
bridgetown new marcushirst.com -t erb
```
How darned easy is that?

To get Tailwind required some kerfuffling with files. I added the package(s)
```bash
yarn add tailwind @tailwind/forms @tailwind/typography
```
Copied a `tailwind.config.js` file from another project I had lying around and then added the plugins from the first step to PostCSS’s config file.

I do think it's important to carve a piece of the internet. Away from the prying eyes of social media and something just for yourself. I'm hoping (like I do every time I move this site around) that this tooling will reduce the friction and prompt me to write more.