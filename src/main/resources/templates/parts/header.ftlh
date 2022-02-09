<#include "security.ftlh">

<header class="header-wrapper">
    <div class="container">
        <!-- Logo link-->
        <a href='/' class="logo">
            <img alt='logo' src="/static/main/images/logo.png">
        </a>

        <!-- Main website navigation-->
        <nav id="navigation-box">
            <!-- Toggle for mobile menu mode -->
            <a href="#" id="navigation-toggle">
                <span class="menu-icon">
                    <span class="icon-toggle" role="button" aria-label="Toggle Navigation">
                      <span class="lines"></span>
                    </span>
                </span>
            </a>

            <!-- Link navigation -->
            <ul id="navigation">
                <li>
                    <span class="sub-nav-toggle plus"></span>
                    <a href="#">Pages</a>
                    <ul>
                        <li class="menu__nav-item"><a href="/navigator">Navigator</a></li>
                        <li class="menu__nav-item"><a href="/navigator?sort=rating&category=Movie">Top Movies</a></li>
                        <li class="menu__nav-item"><a href="/navigator?sort=rating&category=TVShow">Top TV Shows</a></li>
                        <li class="menu__nav-item"><a href="/navigator?sort=popularity&category=Movie">Most popular Movies</a></li>
                        <li class="menu__nav-item"><a href="/navigator?sort=popularity&category=TVShow">Most popular TV Shows</a></li>
                        <li class="menu__nav-item"><a href="/stars?sort=popularity">Stars</a></li>
                    </ul>
                </li>
                <li>
                    <a href="/cinemas">Cinemas</a>
                </li>
                <li>
                    <span class="sub-nav-toggle plus"></span>
                    <a href="news-left.html">News</a>
                    <ul>
                        <li class="menu__nav-item"><a href="news-left.html">News (rigth sidebar)</a></li>
                        <li class="menu__nav-item"><a href="news-right.html">News (left sidebar)</a></li>
                        <li class="menu__nav-item"><a href="news-full.html">News (full widht)</a></li>
                        <li class="menu__nav-item"><a href="single-page-left.html">Single post (rigth sidebar)</a></li>
                        <li class="menu__nav-item"><a href="single-page-right.html">Single post (left sidebar)</a></li>
                        <li class="menu__nav-item"><a href="single-page-full.html">Single post (full widht)</a></li>
                    </ul>
                </li>
                <li>
                    <span class="sub-nav-toggle plus"></span>
                    <a href="#">Mega menu</a>
                    <ul class="mega-menu container">
                        <li class="col-md-3 mega-menu__coloum">
                            <h4 class="mega-menu__heading">Now in the cinema</h4>
                            <ul class="mega-menu__list">
                                <li class="mega-menu__nav-item"><a href="#">The Counselor</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Bad Grandpa</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Blue Is the Warmest Color</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Capital</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Spinning Plates</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Bastards</a></li>
                            </ul>
                        </li>

                        <li class="col-md-3 mega-menu__coloum mega-menu__coloum--outheading">
                            <ul class="mega-menu__list">
                                <li class="mega-menu__nav-item"><a href="#">Gravity</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Captain Phillips</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Carrie</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Cloudy with a Chance of Meatballs 2</a></li>
                            </ul>
                        </li>

                        <li class="col-md-3 mega-menu__coloum">
                            <h4 class="mega-menu__heading">Ending soon</h4>
                            <ul class="mega-menu__list">
                                <li class="mega-menu__nav-item"><a href="#">Escape Plan</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Rush</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Prisoners</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Enough Said</a></li>
                                <li class="mega-menu__nav-item"><a href="#">The Fifth Estate</a></li>
                                <li class="mega-menu__nav-item"><a href="#">Runner Runner</a></li>
                            </ul>
                        </li>

                        <li class="col-md-3 mega-menu__coloum mega-menu__coloum--outheading">
                            <ul class="mega-menu__list">
                                <li class="mega-menu__nav-item"><a href="#">Insidious: Chapter 2</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>

        <!-- Additional header buttons / Auth and direct link to booking-->
        <div class="control-panel">
            <#if name !="unknown">
                <div class="auth auth--home">
                    <div class="auth__show">
                        <span class="auth__image">
                          <img alt="" src="${user.imgUrl}">
                        </span>
                    </div>
                    <a href="#" class="btn btn--sign btn--singin">
                        ${name}
                    </a>
                    <ul class="auth__function">
                        <li><a href="/user/${currentUserId}" class="auth__function-item">Profile</a></li>
                        <li><a href="/user/${currentUserId}/watchlist" class="auth__function-item">Watchlist</a></li>
                        <li><a href="/tickets" class="auth__function-item">Booked tickets</a></li>
                        <li><a href="/profile" class="auth__function-item">Settings</a></li>
                        <#if isAdmin || isOwner><li><a href="/admin" class="auth__function-item">Admin</a></li></#if>
                        <li>
                            <form action="/logout" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                <a href="#" class="auth__function-item" onclick="$(this).parent().submit()">Logout</a>
                            </form>
                        </li>
                    </ul>

                </div>
            <#else>
                <a href="/login" class="btn btn--sign">Sign in</a>
                <a href="/registration" class="btn btn--sign">Sign up</a>
            </#if>
        </div>
    </div>
</header>
