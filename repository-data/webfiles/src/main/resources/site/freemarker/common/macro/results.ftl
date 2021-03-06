<#ftl output_format="HTML">
<@hst.setBundle basename="publicationsystem.labels,nationalindicatorlibrary.headers,nationalindicatorlibrary.labels,website.labels,homepage.website.labels,rb.doctype.published-work"/>

<#macro searchResults items>
    <div class="cta-list">
        <#list items as document>
            <#if document.class.name == "uk.nhs.digital.ps.beans.Publication">
                <@publication item=document />
            <#elseif document.class.name == "uk.nhs.digital.ps.beans.LegacyPublication">
                <@legacypublication item=document />
            <#elseif document.class.name == "uk.nhs.digital.ps.beans.Archive">
                <@archive item=document />
            <#elseif document.class.name == "uk.nhs.digital.ps.beans.Series">
                <@series item=document />
            <#elseif document.class.name == "uk.nhs.digital.ps.beans.Dataset">
                <@dataset item=document />
            <#elseif document.class.name == "uk.nhs.digital.nil.beans.Indicator">
                <@indicator item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.Service">
                <@service item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.General" ||
                     document.class.name == "uk.nhs.digital.website.beans.Hub" ||
                     document.class.name == "uk.nhs.digital.website.beans.VisualHub">
                <@general item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.Event">
                <@event item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.News">
                <@news item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.Gdprtransparency">
                <@gdpr item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.Publishedwork">
                <@publishedwork item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.Publishedworkchapter">
                <@publishedworkchapter item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.ComponentList">
                <@componentlist item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.Roadmap">
                <@roadmap item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.RoadmapItem">
                <@roadmapitem item=document />
            <#elseif document.class.name == "uk.nhs.digital.website.beans.GlossaryList">
                <@glossarylist item=document />
            </#if>
        </#list>
    </div>
</#macro>

<#macro publication item>
    <#assign stampedPublication = false />
    <#if item.informationType?has_content>
        <#list item.informationType as type>
            <#if type == "National statistics">
                <#assign stampedPublication = true />
                <#break>
            </#if>
        </#list>
    </#if>

    <div class="cta cta--detailed ${stampedPublication?then(" cta--stamped", "")}" data-uipath="ps.search-results.result">
        <#if stampedPublication>
            <div class="cta__stamped-header">
                <div class="cta__stamped-header-col cta__stamped-header-col--left">
        </#if>

        <div>
            <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.publication"/></span>
        </div>

        <a class="cta__title cta__button" href="<@hst.link hippobean=item.selfLinkBean/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <span class="cta__meta" data-uipath="ps.search-results.result.date"><@formatRestrictableDate value=item.nominalPublicationDate/></span>

        <#if stampedPublication>
                </div>

                <div class="cta__stamped-header-col cta__stamped-header-col--right">
                    <img src="<@hst.webfile  path="images/national-statistics-logo.svg"/>" data-uipath="ps.search-results.result.national-statistics" alt="National Statistics" title="National Statistics" class="image-icon image-icon--large" />
                </div>
            </div>
        </#if>

        <#if item.publiclyAccessible>
            <p class="cta__text" data-uipath="ps.search-results.result.summary">
                <@truncate text=item.summary.firstParagraph size="300"/>
            </p>
        <#else>
            <span class="cta__meta" data-uipath="ps.search-results.result.summary">
                <@fmt.message key="labels.upcoming-publication"/>
            </span>
        </#if>
    </div>
</#macro>

<#macro legacypublication item>
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <div>
            <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.publication"/></span>
        </div>
        <a class="cta__title cta__button" href="<@hst.link hippobean=item.selfLinkBean/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <span class="cta__meta" data-uipath="ps.search-results.result.date"><@formatRestrictableDate value=item.nominalPublicationDate/></span>
    </div>
</#macro>

<#macro series item>
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <div>
            <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.series"/></span>
        </div>
        <a class="cta__title cta__button" href="<@hst.link hippobean=item.selfLinkBean/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.summary.firstParagraph size="300"/></p>

        <#if item.latestPublication??>
        <p class="cta__text" data-uipath="ps.search-results.result.latest-publication">
            Latest publication:
            <a href="<@hst.link hippobean=item.latestPublication.selfLinkBean/>" title="${item.latestPublication.title}">
                ${item.latestPublication.title}
            </a>
        </p>
        </#if>
    </div>
</#macro>

<#macro archive item>
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <div>
            <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.archive"/></span>
        </div>
        <a class="cta__title cta__button" href="<@hst.link hippobean=item.selfLinkBean/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.summary.firstParagraph size="300"/></p>
    </div>
</#macro>

<#macro dataset item>
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <div>
            <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.dataset"/></span>
        </div>
        <a class="cta__title cta__button" href="<@hst.link hippobean=item.selfLinkBean/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <span class="cta__meta" data-uipath="ps.search-results.result.date"><@formatRestrictableDate value=item.nominalDate/></span>
        <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.summary.firstParagraph size="300"/></p>
    </div>
</#macro>

<#macro indicator item>
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <div>
            <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.indicator"/></span>
        </div>
        <a class="cta__title cta__button" href="<@hst.link hippobean=item.selfLinkBean/>" title="${item.title}" data-uipath="ps.search-results.result.title">
                ${item.title}
        </a>

        <p class="cta__text" data-uipath="ps.search-results.result.brief-description">${item.details.briefDescription}</p>

        <#if item.assuredStatus>
            <div class="cta__assurance">
                <div class="cta__metas">
                    <span class="cta__meta" data-uipath="ps.search-results.result.assured-status"><@fmt.message key="labels.assured"/></span>
                    <span class="cta__meta" data-uipath="ps.search-results.result.publisher-and-date">
                    <span class="strong"><@fmt.message key="headers.publishedBy"/>:</span> ${item.publishedBy}.
                    <span class="strong"><@fmt.message key="headers.assured"/>:</span> <@formatDate date=item.assuranceDate.time/></span>
                </div>
                <div class="cta__badge">
                    <span data-uipath="ps.search-results.result.assured-indicator-icon" title="Assured Indicator" class="badge badge--assured"></span>
                </div>
            </div>
        <#else>
            <div class="cta__metas">
                <span class="cta__meta" data-uipath="ps.search-results.result.assured-status"><@fmt.message key="labels.unassured"/></span>
                <span class="cta__meta" data-uipath="ps.search-results.result.publisher-and-date"><span class="strong"><@fmt.message key="headers.publishedBy"/>:</span> ${item.publishedBy}. <@fmt.message key="headers.unassured"/>: <@formatDate date=item.assuranceDate.time/></span>
            </div>
        </#if>
    </div>
</#macro>

<#macro service item>
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <div>
            <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.service"/></span>
        </div>
        <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>
    </div>
</#macro>

<#macro general item>
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>
    </div>
</#macro>

<#macro event item>
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <div>
            <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.event"/></span>
        </div>
        <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>

        <#assign dateRangeData = getEventDateRangeData(item.events) />
        <#if dateRangeData?size gt 0>
            <#if dateRangeData.comparableStartDate == dateRangeData.comparableEndDate>
            <p class="cta__meta">
                <span class="strong"><@fmt.message key="labels.date-label"/>: </span>
                <span><@fmt.formatDate value=dateRangeData.minStartTime type="Date" pattern="d MMMM yyyy" timeZone="${getTimeZone()}" /></span>
            </p>
            <#else>
            <p class="cta__meta">
                <span class="strong"><@fmt.message key="labels.date-label"/>: </span>
                <span>
                    <@fmt.formatDate value=dateRangeData.minStartTime type="Date" pattern="d MMMM yyyy" timeZone="${getTimeZone()}" /> - <@fmt.formatDate value=dateRangeData.maxEndTime type="Date" pattern="d MMMM yyyy" timeZone="${getTimeZone()}" />
                </span>
            </p>
            </#if>
        </#if>
    </div>
</#macro>

<#macro news item>
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <div>
            <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.news"/></span>
        </div>
        <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>

        <#if item.publisheddatetime?? && item.publisheddatetime.time??>
            <div class="cta__metas cta__metas--spaced">
                <p class="cta__meta">
                    <span class="strong"><@fmt.message key="about-us.newsDateLabel"/>: </span>
                    <@fmt.formatDate value=item.publisheddatetime.time type="Date" pattern="yyyy-MM-dd HH:mm:ss" var="publishedDateTime" timeZone="${getTimeZone()}" />
                    <@fmt.formatDate value=item.publisheddatetime.time type="Date" pattern="d MMMM yyyy" var="publishedDateTimeForHumans" timeZone="${getTimeZone()}" />
                    <time datetime="${publishedDateTime}">${publishedDateTimeForHumans}</time>
                </p>
            </div>
        </#if>
    </div>
</#macro>

<#macro gdpr item>
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <div>
            <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.gdpr"/></span>
        </div>
        <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>
    </div>
</#macro>

<#macro publishedwork item>
<div class="cta cta--detailed" data-uipath="ps.search-results.result">
    <div>
        <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.publishedwork"/></span>
    </div>
    <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
        ${item.title}
    </a>
    <span class="cta__meta" data-uipath="ps.search-results.result.date"><@formatDate date=item.publicationDate.time/></span>
    <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>
</div>
</#macro>

<#macro publishedworkchapter item>
<div class="cta cta--detailed" data-uipath="ps.search-results.result">
    <div>
        <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.publishedworkchapter"/></span>
    </div>
    <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
        ${item.title}
    </a>
    <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>
</div>
</#macro>

<#macro componentlist item>

<div class="cta cta--detailed" data-uipath="ps.search-results.result">
    <div class="cta cta--detailed" data-uipath="ps.search-results.result">
        <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
            ${item.title}
        </a>
        <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>
    </div>
</div>
</#macro>

<#macro roadmap item>
<div class="cta cta--detailed" data-uipath="ps.search-results.result">
    <div>
        <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.roadmap"/></span>
    </div>
    <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
        ${item.title}
    </a>
    <span class="cta__meta" data-uipath="ps.search-results.result.date"><@formatDate date=item.publicationDate.time/></span>
    <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>
</div>
</#macro>

<#macro roadmapitem item>
<div class="cta cta--detailed" data-uipath="ps.search-results.result">
    <div>
        <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.roadmapitem"/></span>
    </div>
    <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
        ${item.title}
    </a>
    <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>
</div>
</#macro>

<#macro glossarylist item>
<div class="cta cta--detailed" data-uipath="ps.search-results.result">
    <div>
        <span class="cta__label" data-uipath="ps.search-results.result.type"><@fmt.message key="labels.glossarylist"/></span>
    </div>
    <a class="cta__title cta__button" href="<@hst.link hippobean=item/>" title="${item.title}" data-uipath="ps.search-results.result.title">
        ${item.title}
    </a>
    <p class="cta__text" data-uipath="ps.search-results.result.summary"><@truncate text=item.shortsummary size="300"/></p>
</div>
</#macro>
