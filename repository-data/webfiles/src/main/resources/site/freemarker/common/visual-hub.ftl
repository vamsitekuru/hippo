<#ftl output_format="HTML">

<#-- @ftlvariable name="document" type="uk.nhs.digital.website.beans.VisualHub" -->

<#include "../include/imports.ftl">
<#include "macro/metaTags.ftl">
<#include "macro/component/lastModified.ftl">

<#-- Add meta tags -->
<@metaTags></@metaTags>
<@hst.setBundle basename="site.website.labels"/>

<#assign hasSummaryContent = document.summary.content?has_content />
<#assign hasBannerImage = document.image?has_content />
<#assign hasTopicIcon = document.icon_xxxxx?has_content />
<#assign hasAdditionalInformation = document.additionalInformation.content?has_content />
<#assign hasLinks = document.links?? && document.links?size gt 0 />

<#-- TODO: implement frontend

    ${document.title}
    <@hst.html hippohtml=document.summary contentRewriter=gaContentRewriter/>
    ${document.shortsummary}
    ${document.seosummary}
    other fields...

-->

<article class="article">
    <#if hasTopicIcon>
        <div class="grid-wrapper grid-wrapper--full-width grid-wrapper--wide" aria-label="Document Header">
            <div class="local-header article-header article-header--with-icon">
                <div class="grid-wrapper">
                    <div class="article-header__inner">
                        <div class="grid-row">
                            <div class="column--two-thirds column--reset">
                                <h1 class="local-header__title" data-uipath="document.title">${document.title}</h1>
                                <p class="article-header__subtitle"><@hst.html hippohtml=document.summary contentRewriter=gaContentRewriter/></p>
                            </div>
                            <div class="column--one-third column--reset">
                                <@hst.link hippobean=document.icon.original fullyQualified=true var="iconImage" />
                                <img aria-hidden="true" src="${iconImage}" alt="" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <#elseif hasBannerImage>
        <div class="grid-wrapper grid-wrapper--full-width grid-wrapper--wide" aria-label="Document Header">
            <h1 class="local-header__title" data-uipath="document.title">${document.title}</h1>
            <@hst.link hippobean=document.image.original fullyQualified=true var="bannerImage" />
            <img aria-hidden="true" src="${bannerImage}" alt="" />
        </div>

        <div class="grid-wrapper">
            <div class="article-header__inner">
                <div class="grid-row">
                    <div class="column column--reset">
                        <p class="article-header__subtitle"><@hst.html hippohtml=document.summary contentRewriter=gaContentRewriter/></p>
                    </div>
                </div>
            </div>
        </div>
    </#if>



    <div class="grid-wrapper grid-wrapper--article">
        <div class="grid-row">
            <div class="column column--two-thirds page-block page-block--main">

                <#if hasLinks>

                </#if>

                <div class="article-section muted">
                    <@lastModified document.lastModified false></@lastModified>
                </div>
            </div>
        </div>
    </div>

</article>
