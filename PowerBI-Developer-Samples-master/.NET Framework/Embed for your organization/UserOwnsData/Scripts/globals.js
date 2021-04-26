// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.
// ----------------------------------------------------------------------------

// Cache DOM objects
const globals = {
    workspaceSelect: null,
    workspaceDefaultOption: null,
    reportDiv: null,
    dashboardDiv: null,
    tileDiv: null,
    reportSelect: null,
    dashboardSelect: null,
    reportWrapper: null,
    dashboardWrapper: null,
    tileWrapper: null,
    reportDisplayText: null,
    dashboardDisplayText: null,
    tileDisplayText: null,
    embedButton: null,
    tileSelect: null,
    reportContainer: null,
    dashboardContainer: null,
    tileContainer: null
}

$(function() {
    globals.workspaceSelect = $("#workspace-select");
    globals.workspaceDefaultOption = $("#workspace-default-option").get(0);
    globals.reportDiv = $("#report-div");
    globals.dashboardDiv = $("#dashboard-div");
    globals.tileDiv = $("#tile-div");
    globals.reportSelect = $("#report-select");
    globals.dashboardSelect = $("#dashboard-select");
    globals.reportWrapper = $(".report-wrapper");
    globals.dashboardWrapper = $(".dashboard-wrapper");
    globals.tileWrapper = $(".tile-wrapper");
    globals.reportDisplayText = $(".report-display-text");
    globals.dashboardDisplayText = $(".dashboard-display-text");
    globals.tileDisplayText = $(".tile-display-text");
    globals.embedButton = $(".embed-button");
    globals.tileSelect = $("#tile-select");
    globals.reportContainer = $("#report-container");
    globals.dashboardContainer = $("#dashboard-container");
    globals.tileContainer = $("#tile-container");
    globals.reportSpinner = $("#report-spinner");
    globals.dashboardSpinner = $("#dashboard-spinner");
    globals.tileSpinner = $("#tile-spinner");
});