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
                    <a href="/cinemas">Cinemas</a>
                </li>
                <li>
                    <span class="sub-nav-toggle plus"></span>
                    <a href="#">Menu</a>
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
                    <span class="sub-nav-toggle plus"></span>
                    <a href="#">Mega menu</a>
                    <ul class="mega-menu container">
                        <li class="col-md-3 mega-menu__coloum">
                            <h4 class="mega-menu__heading">Now in the cinema</h4>
                            <ul class="mega-menu__list">
                                <#list movies_cinema as movie>
                                    <#if movie?counter lte 5>
                                        <li class="mega-menu__nav-item"><a href="/item/${movie.id}">${movie.title}</a></li>
                                    </#if>
                                </#list>
                            </ul>
                        </li>

                       <li class="col-md-3 mega-menu__coloum mega-menu__coloum--outheading">
                            <ul class="mega-menu__list">
                                <#list movies_cinema as movie>
                                    <#if movie?counter gt 5>
                                        <li class="mega-menu__nav-item"><a href="/item/${movie.id}">${movie.title}</a></li>
                                    </#if>
                                </#list>
                            </ul>
                        </li>

                        <li class="col-md-3 mega-menu__coloum">
                            <h4 class="mega-menu__heading">Ending soon</h4>
                            <ul class="mega-menu__list">
                                <#list movies_coming as movie>
                                    <li class="mega-menu__nav-item"><a href="/item/${movie.id}">${movie.title}</a></li>
                                </#list>
                            </ul>
                        </li>

                        <li class="col-md-3 mega-menu__coloum mega-menu__coloum--outheading">
                            <ul class="mega-menu__list">
                                <#list movies_coming as movie>
                                    <#if movie?counter gt 5>
                                        <li class="mega-menu__nav-item"><a href="/item/${movie.id}">${movie.title}</a></li>
                                    </#if>
                                </#list>
                            </ul>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="/contact-us">Contact Us</a>
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
