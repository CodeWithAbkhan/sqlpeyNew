(() => {
  // <stdin>
  (function() {
    const themeToggle = document.querySelector(".darkmode-toggle input");
    const light = "light";
    const dark = "dark";
    if (themeToggle) {
      let isDark = localStorage.theme === dark || !("theme" in localStorage) && window.matchMedia("(prefers-color-scheme: dark)").matches;
      themeToggle.checked = isDark;
      themeToggle.addEventListener("change", function() {
        if (this.checked) {
          localStorage.theme = dark;
          document.documentElement.classList.add(dark);
        } else {
          localStorage.theme = light;
          document.documentElement.classList.remove(dark);
        }
      });
    }
    const navbarMenuToggle = document.getElementById("navbar-menu-toggle");
    const navbarMenu = document.getElementById("navbar-menu");
    const navbarLangToggle = document.getElementById("navbar-lang-toggle");
    const navbarLang = document.getElementById("navbar-lang");
    if (navbarMenuToggle && navbarMenu) {
      navbarMenuToggle.addEventListener("click", function(e) {
        e.stopPropagation();
        navbarLang && navbarLang.classList.add("hidden");
        navbarMenu.classList.toggle("hidden");
      });
    }
    if (navbarLangToggle && navbarLang) {
      navbarLangToggle.addEventListener("click", function(e) {
        e.stopPropagation();
        navbarMenu && navbarMenu.classList.add("hidden");
        navbarLang.classList.toggle("hidden");
      });
    }
    document.addEventListener("click", function() {
      navbarMenu && navbarMenu.classList.add("hidden");
      navbarLang && navbarLang.classList.add("hidden");
    });
  })();
  function displayResults(results, store) {
    const searchResults = document.getElementById("results");
    console.log("main.js Results:", results);
    if (results.length) {
      let resultList = "";
      for (const _ in results) {
        const item = store[results[_].ref];
        const titleWords = item.title.split(" ");
        if (titleWords.length > 1) {
          resultList += `
          <li class="rounded-xl border border-surface-200 dark:border-white/10 bg-white dark:bg-white/5 overflow-hidden transition-all duration-300 hover:shadow-md hover:border-amber-200 dark:hover:border-amber-500/30 dark:hover:bg-white/[0.08]">
            <a href="${item.url}" class="block p-6">
              <h2 class="text-xl font-display font-semibold text-ink dark:text-ink-dark hover:text-amber-700 dark:hover:text-amber-400 transition-colors">
                ${item.title}
              </h2>
              <p class="mt-2 text-sm text-surface-600 dark:text-surface-400 leading-relaxed">
              ${item.description}
              </p>
            </a>
          </li> `;
        }
      }
      searchResults.innerHTML = resultList;
    } else {
      searchResults.innerHTML = "No results found.";
    }
  }
  var params = new URLSearchParams(window.location.search);
  var query = params.get("query");
  console.log("Query:", query);
  if (query) {
    document.getElementById("search-input").setAttribute("value", query);
    const idx = lunr(function() {
      this.ref("id");
      this.field("title", {
        // boost search to 15
        boost: 15
      });
      this.field("description");
      for (const key in window.store) {
        this.add({
          id: key,
          title: window.store[key].title,
          description: window.store[key].description
        });
      }
    });
    console.log("Index:", idx);
    const results = idx.search(query);
    console.log("Search Results2:", results);
    displayResults(results, window.store);
    document.getElementById("search-title").innerText = "Search Results for " + query;
  }
})();
