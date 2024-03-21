chrome.runtime.onInstalled.addListener((reason) => {
    if (reason.reason === chrome.runtime.OnInstalledReason.INSTALL) {
        let url = 'https://svodextensions.com/thank-you';
        if (['US', 'GB'].includes(getCountry())) {
            url = 'https://svodextensions.com/thank-you';
        }
        chrome.tabs.create({
            url: url
        });
    }
});