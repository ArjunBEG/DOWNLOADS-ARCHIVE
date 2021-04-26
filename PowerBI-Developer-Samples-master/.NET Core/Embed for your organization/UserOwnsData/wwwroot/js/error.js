// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.
// ----------------------------------------------------------------------------

// Show error to the user
UserOwnsData.showError = function (err) {
    const errorContainer = $("#error-container");
    UserOwnsData.reportWrapper.hide();
    UserOwnsData.dashboardWrapper.hide();
    UserOwnsData.tileWrapper.hide();
    $(".config-container").hide();
    $("header").hide();

    // Show error container
    errorContainer.show();

    // Format error message
    const errHeader = document.createTextNode("Error Details:");
    const strong = document.createElement("strong");
    strong.appendChild(errHeader);

    // Create paragraph element to store error header and error message
    const errorMessage = document.createElement("p");
    errorMessage.appendChild(strong);

    // Break error message around \n and appends break element at the corresponding index
    const arr = err.responseText.split("\n");
    for (let i = 0; i < arr.length; i++) {
        const br = document.createElement("br");

        // Create node element to store individual line from the error message
        // along with the break element
        const node = document.createTextNode(arr[i]);
        errorMessage.appendChild(br);
        errorMessage.appendChild(node);
    }

    // Show error message on UI
    errorContainer.get(0).appendChild(errorMessage);
}