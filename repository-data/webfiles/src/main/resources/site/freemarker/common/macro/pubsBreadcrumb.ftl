<#ftl output_format="HTML">

<#macro pubsBreadcrumb title>
<div class="grid-wrapper">
    <div class="grid-row">
        <div class="column column--reset">
            <ol class="breadcrumb">
                <li class="breadcrumb__crumb">
                    <a href="<@hst.link siteMapItemRefId='root'/>" class="breadcrumb__link">NHS Digital</a>    
                </li>
                
                <#if title?has_content>
                <li class="breadcrumb__crumb">
                    <img src="<@hst.webfile  path="images/icon-arrow.png"/>" alt="Right arrow icon" class="breadcrumb__sep"/>
                    <span class="breadcrumb__link breadcrumb__link--secondary">${title}</span>
                </li>
                </#if>
            </ol>
        </div>
    </div>
</div>
</#macro>
