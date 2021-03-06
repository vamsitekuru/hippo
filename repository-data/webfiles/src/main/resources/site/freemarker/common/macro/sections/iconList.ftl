<#ftl output_format="HTML">

<#macro iconList section>
    <#if section.title?has_content>
        <h3>${section.title}</h3>
    </#if>

    <dl class="iconList">
        <#list section.iconListItems as iconListItem>

            <!-- iconListItem -->
            <div class="iconList__item">
                <div class="iconList__icon">
                    <@hst.link hippobean=iconListItem.image.original fullyQualified=true var="iconImage" />
                    <img aria-hidden="true" src="${iconImage}" alt="" />
                </div>

                <div class="iconList__content">
                    <dt class="iconList__title" data-uipath="website.contentblock.iconlist.heading">${iconListItem.heading}</dt>

                    <dd class="iconList__body" data-uipath="website.contentblock.iconlist.description">
                        <@hst.html hippohtml=iconListItem.description contentRewriter=gaContentRewriter />
                    </dd>
                </div>
            </div>

        </#list>
    </dl>
</#macro>
