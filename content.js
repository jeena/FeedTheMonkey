function $(id) {
    return document.getElementById(id);
}

function setArticle(article) {
    window.scrollTo(0, 0);

    $("date").innerHTML = "";
    $("title").innerHTML = "";
    $("title").href = "";
    $("title").title = "";
    $("feed_title").innerHTML = "";
    $("author").innerHTML = "";
    $("article").innerHTML = "";

    if(article === "empty") {

        $("article").innerHTML = "No unread articles to display.";

    } else if(article === "loading") {

        $("article").innerHTML = "Loading <blink>&hellip;</blink>";

    } else if (article === "logout") {

    } else if(article) {

        $("date").innerHTML = (new Date(parseInt(article.updated, 10) * 1000));
        $("title").innerHTML = article.title;
        $("title").href = article.link;
        $("title").title = article.link;
        $("feed_title").innerHTML = article.feed_title;
        $("title").className = article.marked ? "starred" : "";
        $("author").innerHTML = "";
        if(article.author && article.author.length > 0)
            $("author").innerHTML = "&ndash; " + article.author
        $("article").innerHTML = article.content;
    }
}
