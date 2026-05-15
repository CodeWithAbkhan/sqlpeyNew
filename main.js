(() => {
  // <stdin>
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
          <li class="flex flex-row items-center gap-y-3 mt-6 mx-2 md:mx-0 rounded-lg shadow-md bg-white dark:bg-gray-700">
            <div class="flex flex-col w-full  p-6 mt-6 mx-2 md:mx-0">
              <h2 class="text-3xl font-semibold text-slate-800 dark:text-slate-200">
                <a href="${item.url}">${item.title}</a>
              </h2>
              <div class="flex flex-wrap gap-2 mt-2">
              <p class="py-1 text-sm mx-auto  text-gray-800  dark:text-white ">
              ${item.description}
              </p>
              </div>
            </div>
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
