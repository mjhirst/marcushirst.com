const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./src/**/*.html",
    "./src/**/*.erb",
    "./src/*.html",
    "./src/*.erb",
    "./frontend/styles/**/*.css'"
  ],
  theme: {
    screens: {
      sm: "640px",
      md: "768px",
      lg: "1024px",
      xl: "1280px",
    },
    extend: {
      fontFamily: {
        serif: ["Quattrocento", ...defaultTheme.fontFamily.serif],
        quattrocento: ["Quattrocento"],
        playfair: ["Playfair Display"],
        mono: ["IBM Plex Mono", ...defaultTheme.fontFamily.mono],
      },
    },
  },
  variants: {
    extend: {
      grayscale: ["hover", "focus"],
      margin: ["last"],
    },
    container: [],
  },
  plugins: [require("@tailwindcss/typography"), require("@tailwindcss/forms")],
};
