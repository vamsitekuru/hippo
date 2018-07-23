package uk.nhs.digital.common;

import org.apache.http.HttpHost;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.client.utils.URIUtils;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.client.LaxRedirectStrategy;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

public class ResolveLinksHelper {

    public HttpResponse resolveFinalDestination(String link) throws IOException, URISyntaxException {

        int statusCode;
        String finalDestination;

        try (CloseableHttpClient httpclient = HttpClients.custom()
            .setRedirectStrategy(new LaxRedirectStrategy())
            .build()) {

            HttpClientContext context = HttpClientContext.create();
            HttpGet httpGet = new HttpGet(link);
            CloseableHttpResponse response = httpclient.execute(httpGet, context);
            statusCode = response.getStatusLine().getStatusCode();

            HttpHost target = context.getTargetHost();
            List<URI> redirectLocations = context.getRedirectLocations();
            URI location = URIUtils.resolve(httpGet.getURI(), target, redirectLocations);
            finalDestination = location.toASCIIString();
        }
        return new HttpResponse(statusCode, finalDestination) ;
    }

    public int getInitialHttpStatusCode(String link) throws IOException {

        int statusCode;
        try (CloseableHttpClient httpclient = HttpClients.custom()
            .disableRedirectHandling()
            .build()) {

            HttpClientContext context = HttpClientContext.create();
            HttpGet httpGet = new HttpGet(link);
            CloseableHttpResponse response = httpclient.execute(httpGet, context);
            statusCode = response.getStatusLine().getStatusCode();
        }
        return statusCode;
    }


    public final class HttpResponse {
        private final int statusCode;
        private final String url;

        public HttpResponse(int statusCode, String url) {
            this.statusCode = statusCode;
            this.url = url;
        }

        public int getStatusCode() {
            return statusCode;
        }

        public String getUrl() {
            return url;
        }
    }
}

