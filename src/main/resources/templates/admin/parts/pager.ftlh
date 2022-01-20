<#macro pager url page>
    <#if page.getTotalPages() gt 7>
        <#assign
        totalPages = page.getTotalPages()
        pageNumber = page.getNumber() + 1

        head = (pageNumber > 4)?then([1, -1], [1, 2, 3])
        tail = (pageNumber < totalPages - 3)?then([-1, totalPages], [totalPages - 2, totalPages - 1, totalPages])
        bodyBefore = (pageNumber > 4 && pageNumber < totalPages - 1)?then([pageNumber - 2, pageNumber - 1], [])
        bodyAfter = (pageNumber > 2 && pageNumber < totalPages - 3)?then([pageNumber + 1, pageNumber + 2], [])

        body = head + bodyBefore + (pageNumber > 3 && pageNumber < totalPages - 2)?then([pageNumber], []) + bodyAfter + tail
        >
    <#else>
        <#assign body = 1..page.getTotalPages()>
    </#if>
    <ul class="paginator__paginator">
        <#if page.hasPrevious()>
            <li>
                <a aria-label="Previous"
                   href="${url}?page=${page.getNumber() - 1}<#if search?has_content>&search=${search}</#if><#if sort?has_content>&sort=${sort}</#if>">
                    <svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M0.75 5.36475L13.1992 5.36475" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"></path><path d="M5.771 10.1271L0.749878 5.36496L5.771 0.602051" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"></path></svg>
                </a>
            </li>
        </#if>


        <#list body as p>
            <#if (p - 1) == page.getNumber()>
                <li class="active">
                    <a href="#" tabindex="-1">${p}</a>
                </li>
            <#elseif p == -1>
                <li class="disabled">
                    <a href="#" tabindex="-1">...</a>
                </li>
            <#else>
                <li>
                    <a tabindex="-1"
                       href="${url}?page=${p - 1}&size=${page.getSize()}<#if search?has_content>&search=${search}</#if><#if sort?has_content>&sort=${sort}</#if>">
                        ${p}
                    </a>
                </li>
            </#if>
        </#list>

        <#if page.hasNext()>
            <li class="page-item">
                <a class="page-link" aria-label="Next"
                   href="${url}?page=${page.getNumber() + 1}<#if search?has_content>&search=${search}</#if><#if sort?has_content>&sort=${sort}</#if>">
                    <svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M13.1992 5.3645L0.75 5.3645" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"></path><path d="M8.17822 0.602051L13.1993 5.36417L8.17822 10.1271" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"></path></svg>
                </a>
            </li>
        </#if>
    </ul>
</#macro>
