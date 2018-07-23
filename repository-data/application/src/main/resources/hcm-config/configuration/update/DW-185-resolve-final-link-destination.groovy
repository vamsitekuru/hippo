package org.hippoecm.frontend.plugins.cms.admin.updater

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils
import org.hippoecm.repository.util.JcrUtils
import org.htmlcleaner.CleanerProperties
import org.htmlcleaner.HtmlCleaner
import org.htmlcleaner.TagNode
import org.onehippo.repository.update.BaseNodeUpdateVisitor
import uk.nhs.digital.common.ResolveLinksHelper

import javax.jcr.Node
import javax.jcr.PropertyIterator
/**
 * Rewrite redirected links to their final desitination
 */
class ResolveFinalLinkDestination extends BaseNodeUpdateVisitor {

    private static final String TYPE_RELATED_LINK = "publicationsystem:relatedlink"
    private static final String PROPERTY_HIPPO_HTML = "hippostd:content"
    private static final String PROPERTY_HIPPO_LINK_URL = "publicationsystem:linkUrl"

    def DOWNLOAD_EXTENSIONS = [
        "DOC", "DOCX", "XLS", "XLSX", "PDF", "CSV", "ZIP", "TXT", "RAR", "PPT",
        "PPTX", "JPEG", "JPG", "PNG", "DOCM", "XLSM", "PPTM", "WAV", "MP4"
    ];

    ResolveLinksHelper helper = new ResolveLinksHelper()
    private static boolean htmlCleanerInitialized;
    private static HtmlCleaner cleaner;

    private static synchronized void initCleaner() {
        if (!htmlCleanerInitialized) {
            cleaner = new HtmlCleaner();
            CleanerProperties properties = cleaner.getProperties();
            properties.setRecognizeUnicodeChars(false);
            properties.setOmitComments(true);
            htmlCleanerInitialized = true;
        }
    }

    protected static HtmlCleaner getHtmlCleaner() {
        if (!htmlCleanerInitialized) {
            initCleaner();
        }
        return cleaner;
    }


    boolean doUpdate(Node node) {
        try {
            return parseContentAndReWrite(node)
        } catch (e) {
            log.error("Failed to process record.", e)
        }

        return false
    }

    boolean parseContentAndReWrite(Node node) {

        if (TYPE_RELATED_LINK.equals(node.getPrimaryNodeType().getName())) {

            // Related link url
            def originalLink = node.getProperty(PROPERTY_HIPPO_LINK_URL).getString()

            if (checkLink(originalLink)) {

                try {
                    def initialStatusCode = helper.getInitialHttpStatusCode(originalLink)

                    // if redirect (temp/perm), get final destination
                    if (initialStatusCode == 301 || initialStatusCode == 302) {
                        ResolveLinksHelper.HttpResponse response = helper.resolveFinalDestination(originalLink)
                        String finalLink = response.url

                        if (!originalLink.equals(finalLink)) {
                            log.warn(originalLink + " ======> " + finalLink)
                            JcrUtils.ensureIsCheckedOut(node)
                            node.setProperty(PROPERTY_HIPPO_LINK_URL, finalLink)
                            return true;
                        }
                    }

                } catch (Exception exception) {
                    //log.error("Link failed in path: [" + node.getPath() + "] - Link: " + originalLink)
                    log.error("ERROR (" + originalLink + ") : " + exception.getMessage())
                }
            }

        } else {


            def html = node.getProperty(PROPERTY_HIPPO_HTML).getString()

            if (html) {

                boolean updateRequired = false
                TagNode rootNode = getHtmlCleaner().clean(html)
                TagNode[] links = rootNode.getElementsByName("a", true)

                // rewrite of links
                for (TagNode link : links) {

                    String originalLink = link.getAttributeByName("href");

                    if (checkLink(originalLink)) {

                        try {
                            def initialStatusCode = helper.getInitialHttpStatusCode(originalLink)

                            // if redirect (temp/perm), get final destination
                            if (initialStatusCode == 301 || initialStatusCode == 302) {
                                ResolveLinksHelper.HttpResponse response = helper.resolveFinalDestination(originalLink)
                                String finalLink = response.url

                                if (!originalLink.equals(finalLink)) {
                                    updateRequired = true
                                    html = html.replace(originalLink, finalLink)
                                    log.warn(originalLink + " ======> " + finalLink)
                                }
                            }

                        } catch (Exception exception) {
                            //log.error("Link failed in path: [" + node.getPath() + "] - Link: " + originalLink)
                            log.error("ERROR (" + originalLink + ") : " + exception.getMessage())
                        }
                    }
                }

                if (updateRequired) {
                    JcrUtils.ensureIsCheckedOut(node)
                    node.setProperty(PROPERTY_HIPPO_HTML, html)
                    return true
                }

            }
        }

        return false
    }

    boolean checkLink(String url) {
        return  url != null &&
            isCandidateLinkToCheck(url) &&
            !isFileAttachment(url)
    }

    boolean isCandidateLinkToCheck(String url) {
        return !url.toLowerCase().startsWith("mailto:") &&
            !url.toLowerCase().startsWith("file:") &&
            !url.toLowerCase().contains("linkref") &&
            url.contains(".")
    }

    boolean isFileAttachment(final String url) {
        String extension = FilenameUtils.getExtension(url);
        return DOWNLOAD_EXTENSIONS.contains(extension.toUpperCase());
    }

    boolean undoUpdate(Node node) {
        log.error("UNDO is not available")
        return false
    }
}
