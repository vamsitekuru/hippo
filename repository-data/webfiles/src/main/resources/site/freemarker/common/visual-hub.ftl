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
                                <h1 class="local-header__title" data-uipath="document.title">${document.title}
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
            ${document.title}
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
                    <div class="article-section">
                        <div class="grid-row galleryItems">
                            <#list document.links as link>
                                <div class="column column--one-half galleryItems__item">


                                    <#if link.linkType == "internal">
                                        <h3 class="galleryItems__heading">${link.link.title}</h3>

                                        <div class="galleryItems__card">

                                            <@hst.link hippobean=link.icon.original fullyQualified=true var="icon" />
                                            <img src="${icon}" alt="${link.link.title}" />

                                            <div class="galleryItems__description">
                                                <@hst.html hippohtml=link.link.summary contentRewriter=gaContentRewriter />
                                            </div>

                                        </div>

                                    <#elseif link.linkType == "external">
                                        <#assign onClickMethodCall = getOnClickMethodCall(document.class.name, link.link) />
                                        <h2 class="cta__title"><a href="${link.link}" onClick="${onClickMethodCall}" onKeyUp="return vjsu.onKeyUp(event)">${link.title}</a></h2>
                                        <p class="cta__text">${link.shortsummary}</p>
                                    <#elseif link.linkType == "asset">
                                        <a href="<@hst.link hippobean=link.link />"
                                           class="block-link"
                                           onClick="${onClickMethodCall}"
                                           onKeyUp="return vjsu.onKeyUp(event)">
                                            <div class="block-link__header">
                                                <@fileIcon link.link.asset.mimeType></@fileIcon>
                                            </div>
                                            <div class="block-link__body">
                                                <span class="block-link__title">${link.title}</span>
                                                <@fileMetaAppendix link.link.asset.getLength()></@fileMetaAppendix>
                                            </div>
                                        </a>
                                    </#if>



                                    <h3 class="galleryItems__heading">${link.title}</h3>

                                    <div class="galleryItems__card">

                                        <@hst.link hippobean=link.image.original fullyQualified=true var="image" />
                                        <img src="${image}" alt="${galleryItem.title}" />

                                        <div class="galleryItems__description">
                                            <@hst.html hippohtml=link.description contentRewriter=gaContentRewriter />
                                        </div>

                                    </div>

                                </div>

                                <#if link?is_even_item>
                                    <div class="clearfix"></div>
                                </#if>
                            </#list>
                        </div>
                    </div>

                </#if>

                <div class="article-section muted">
                    <@lastModified document.lastModified false></@lastModified>
                </div>
            </div>
        </div>
    </div>

</article>
