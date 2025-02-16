---
layout: post
title:  "Bridgetown and Tailwind"
date:   2025-02-16 00:00:00 +0100
categories: how-to
headshot: tailwind-bridgetown.jpg
---

I'm a self-professed fan of Tailwind. Partly because I suck at CSS and Tailwind's utility-first approach feels as if you can cast spells on DOM elements with magic class words like `mx-auto` and `dark:hover:bg-red-500`. Bringing this magic to Bridgetown took a few more evenings than I had planned on spending. The internet was full of dark and outdated incantations. OK, I found it hard to find any documentation, and the Bridgetown's own automation didn't seem to work.

## TL;DR
Here's a GitHub repo if you just want to fork it and get on with your day
[https://github.com/mjhirst/bridgetown-tailwind-template](https://github.com/mjhirst/bridgetown-tailwind-template)

## How To
### Step 0

- Get set up with [Ruby on your machine](<%= link('_posts/2025-02-16-getting-ruby.md') %>).
- Install the [Bridgetown](https://www.bridgetownrb.com/docs/) gem and set up a blank site

### Step 1
Add Tailwind to your npm packages with yarn or npm. Usually to generate the `tailwind.config.js` file, running `npx tailwind init` conflicts with Yarn but here I'll just use Yarn and manually create the config.

Bridgetown already uses PostCSS so we'll hook into that to keep things as simple as we can.

```bash
yarn add tailwindcss @tailwindcss/forms @tailwindcss/typography
```

### Step 2
Create the `tailwind.config.js` file. This should live in the root directory of your Bridgetown project.
You can adjust the `content` array if you don't use liquid or erb as your templating strategy. I use erb since I come from the Rails world.
```js
/** @type {import('tailwindcss').Config} */

const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./src/**/*.{html,erb,md,liquid}",
    "./src/*.{html,erb,md,liquid}",
    "./frontend/styles/index.css'"
  ],
  theme: {
    extend: {},
  },
  plugins: [require("@tailwindcss/typography"), require("@tailwindcss/forms")],
};
```

### Step 3
Update PostCSS' config. This is to add tailwind to the list of modules.
```js
module.exports = {
  plugins: {
    'tailwindcss': {}, // ← This line, helps trigger automatic rebuilds
    'postcss-flexbugs-fixes': {},
    'postcss-preset-env': {
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 2
    }
  }
}
```

### Step 4
Finally, (this wasn't too hard in the end!) add tailwind to the CSS file at `frontend/styles/index.css` with
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```
And that should do it. The whole CSS file I used to recreate the Bridgetown theming is [available on GitHub](https://github.com/mjhirst/bridgetown-tailwind-template/blob/main/frontend/styles/index.css).

## Advanced

### Remote / CDN Hosted Fonts
Adding a Remote font from Google Fonts or BunnyCDN is an import statement at the top of your `index.css` file, above the tailwind imports and then extending your config. In your config, you can tell tailwind to create a special class, or extend the existing class helpers like `font-mono`, `font-serif`, or `font-sans`.
```css
/* frontend/styles/index.css */

@import url('https://fonts.bunny.net/css2?family=IBM+Plex+Mono:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0&display=swap');

@tailwind ...

/* omitted for brevity */
```

You'll need to import the `defaultTheme` at the top of your file.
```js
// tailwind.config.js

const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  /* omitted for brevity */
  theme: {
    // Make sure to use extend or you'll override other parts of the theme
    extend: { 
      fontFamily: {
        // Doing this gives you a font-ibm class
        ibm: ["IBM Plex Mono"],

        // this extends the font-mono class to prefer the IBM font
        mono: ["IBM Plex Mono", ...defaultTheme.fontFamily.mono], 
      },
    },
  },
}
```

### Local Fonts
A local font uses a different import in your CSS, but the same tailwind configuration as above.
This example expects a folder at `frontend/fonts`

```css
/* frontend/styles/index.css */

@font-face {
  font-family: 'Gotham-Black';
  src: url('../fonts/Gotham-Black.woff2') format('woff2')
}

@tailwind ...

/* omitted for brevity */
```

### Custom Colours
These are added into your `tailwind.config.js` and Tailwind will 🪄 automagically create your helper classes like (in this case, I'm using a 'maroon')`text-maroon`, `border-maroon`, `bg-maroon`, etc...

If the rest of your colours stop working, and you have no idea why (like I did...) it might be because you didn't `extend` the theme, and overrode it by directly editing the theme dictionary, not the 'extend' sub-dictionary. If `extend: {}` isn't there it's totally safe to add it.

```js
// tailwind.config.js

module.exports = {
  /* omitted for brevity */
  theme: {
    // Make sure to use extend or you'll override other parts of the theme
    extend: {
      colors: {
        maroon: '#D12229',
      },
    },
  },
}
```