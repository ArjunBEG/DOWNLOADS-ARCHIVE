# What is Azure Mobile Services? #
![AzureMobileServices](http://storage.chrisrisner.com/images/WAMobileServicesblue.png)

A highly-scalable cloud infrastructure for your mobile and client applications that allows you to store structured data in the cloud, as well as control how that data is accessed and transferred across devices. In addition to the above, Azure Mobile Services offer the ability to tightly integrate push notifications with connected apps.

# Getting started #

You can create your mobile app [here](https://azure.microsoft.com/en-us/services/app-service/mobile/). In addition to this, there is a very good tutorial that will guide you step-by-step through the process, available [here](https://azure.microsoft.com/en-us/documentation/articles/mobile-services-javascript-backend-windows-store-dotnet-get-started/).

# Offline Data Sync #
![OfflineDataSync](https://acom.azurecomcdn.net/80C57D/cdn/images/cvt-da35182c85142ec6c58af9a6f9cbba17a015756ad222136ed241a4595103ef12/page/services/app-service/mobile/03-sync.png?t=popn)

One of the hallmark features of Azure Mobile Services is the ability to push and pull content from applications that might not always be connected to a network. You can learn more about that [here](https://azure.microsoft.com/en-us/documentation/articles/mobile-services-windows-store-dotnet-get-started-offline-data/).

# Authentication #
![Auth](https://acom.azurecomcdn.net/80C57D/cdn/images/cvt-e1bf2d06fc9f0ce638b4990ea2f751e699e5ed6daa01932cdc6f7dd8f76952ad/page/services/app-service/mobile/04-enterprise.png?t=popn)

In some cases, it is important that only the right people have access to certain datasets. Azure Mobile Services covers that with flexible authentication tools. It has built-in support for providers such as [Google](https://azure.microsoft.com/en-us/documentation/articles/mobile-services-how-to-register-google-authentication/), [Facebook](https://azure.microsoft.com/en-us/documentation/articles/mobile-services-how-to-register-facebook-authentication/), [Twitter](https://azure.microsoft.com/en-us/documentation/articles/mobile-services-how-to-register-twitter-authentication/), [Microsoft Account](https://azure.microsoft.com/en-us/documentation/articles/mobile-services-how-to-register-microsoft-authentication/) and [Azure Active Directory](https://azure.microsoft.com/en-us/documentation/articles/mobile-services-how-to-register-active-directory-authentication/). You can follow a tutorial on how to add that to your application [here](https://azure.microsoft.com/en-us/documentation/articles/mobile-services-javascript-backend-windows-universal-dotnet-get-started-users/).

# Push Notifications#
![Push](https://acom.azurecomcdn.net/80C57D/cdn/images/cvt-07f04df7f8cd4771c38b394c2dea100b98b498ad8467b8c04ccdc357785f243e/page/services/app-service/mobile/05-push.png?t=popn)

Rich apps provide rich notifications to their users when something important is happening. With Azure Mobile Services, you can easily add push notifications in just a couple of lines of code. [Here's](https://azure.microsoft.com/en-us/documentation/articles/mobile-services-javascript-backend-windows-universal-dotnet-get-started-push/) how to do that.

#FAQ#
###Do I have to build my application for Windows to work with Azure Mobile Services?###
Not at all. Azure Mobile Services supports native Windows, Windows Phone, iOS, Android, as well as the Xamarin framework.
###A tutorial goes into deep detail about Windows. Where do I find a tutorial for my platform?###
At the top of each Azure Doc article there is a platform chooser dropdown - just pick the platform that you work with, and the right content will be shown below.
###Are there any quickstarts available?###
Absolutely! Download those [here](https://github.com/Azure/azure-mobile-services-quickstarts).
###What about samples?###
All available [here](https://github.com/Azure/mobile-services-samples). Those are fully-working apps that need small tweaks (e.g. add your own authentication key) to run.
###I have more questions!###
Ask me while I am on site. Can't find me? Just [shoot me an email](mailto:dendeli@microsoft.com) or [tweet @ me](https://twitter.com/DennisCode) **whenever you feel that you need help** (even if it's 1AM).