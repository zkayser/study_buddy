// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";

import Elm from "./main.js";

const token = localStorage.getItem('studyBuddyToken');
const userToken = token ? token : null
const ELM_DIV = document.getElementById("elm-main");
const elmApp =Elm.Main.embed(ELM_DIV, {token: userToken});

elmApp.ports.storeToken.subscribe((token) => {
    localStorage.setItem('studyBuddyToken', token);
});

elmApp.ports.removeToken.subscribe(() => {
    console.log("Logging out...")
    localStorage.removeItem('studyBuddyToken');
    console.log("Success")
});
