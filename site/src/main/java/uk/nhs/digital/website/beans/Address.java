package uk.nhs.digital.website.beans;

import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoCompound;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;


@HippoEssentialsGenerated(internalName = "website:address")
@Node(jcrType = "website:address")
public class Address extends HippoCompound {

    @HippoEssentialsGenerated(internalName = "website:buildinglocation")
    public String getBuildingLocation() {
        return getProperty("website:buildinglocation");
    }

    @HippoEssentialsGenerated(internalName = "website:buildingnamenumber")
    public String getBuildingNameNumber() {
        return getProperty("website:buildingnamenumber");
    }

    @HippoEssentialsGenerated(internalName = "website:street")
    public String getStreet() {
        return getProperty("website:street");
    }

    @HippoEssentialsGenerated(internalName = "website:area")
    public String getArea() {
        return getProperty("website:area");
    }

    @HippoEssentialsGenerated(internalName = "website:towncity")
    public String getTownCity() {
        return getProperty("website:towncity");
    }

    @HippoEssentialsGenerated(internalName = "website:county")
    public String getCounty() {
        return getProperty("website:county");
    }

    @HippoEssentialsGenerated(internalName = "website:country")
    public String getCountry() {
        return getProperty("website:country");
    }

    @HippoEssentialsGenerated(internalName = "website:postcode")
    public String getPostcode() {
        return getProperty("website:postcode");
    }

    @HippoEssentialsGenerated(internalName = "website:location")
    public String getLocation() {
        return getProperty("website:location");
    }

}
