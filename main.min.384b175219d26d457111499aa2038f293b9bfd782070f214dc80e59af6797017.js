(()=>{function t(e,t){const n=document.getElementById("results");if(console.log("main.js Results:",e),e.length){let s="";for(const o in e){const n=t[e[o].ref],i=n.title.split(" ");i.length>1&&(s+=`
          <li class="flex flex-row items-center gap-y-3 mt-6 mx-2 md:mx-0 rounded-lg shadow-md bg-white dark:bg-gray-700">
            <div class="flex flex-col w-full  p-6 mt-6 mx-2 md:mx-0">
              <h2 class="text-3xl font-semibold text-slate-800 dark:text-slate-200">
                <a href="${n.url}">${n.title}</a>
              </h2>
              <div class="flex flex-wrap gap-2 mt-2">
              <p class="py-1 text-sm mx-auto  text-gray-800  dark:text-white ">
              ${n.description}
              </p>
              </div>
            </div>
          </li> `)}n.innerHTML=s}else n.innerHTML="No results found."}var n=new URLSearchParams(window.location.search),e=n.get("query");if(console.log("Query:",e),e){document.getElementById("search-input").setAttribute("value",e);const n=lunr(function(){this.ref("id"),this.field("title",{boost:15}),this.field("description");for(const e in window.store)this.add({id:e,title:window.store[e].title,description:window.store[e].description})});console.log("Index:",n);const s=n.search(e);console.log("Search Results2:",s),t(s,window.store),document.getElementById("search-title").innerText="Search Results for "+e}})()