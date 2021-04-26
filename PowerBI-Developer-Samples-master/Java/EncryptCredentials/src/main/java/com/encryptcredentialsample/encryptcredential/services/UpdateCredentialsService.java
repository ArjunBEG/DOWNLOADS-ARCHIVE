// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.
// ----------------------------------------------------------------------------

package com.encryptcredentialsample.encryptcredential.services;

import java.io.IOException;
import org.apache.http.client.ClientProtocolException;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

import com.encryptcredentialsample.encryptcredential.models.CredentialDetails;
import com.encryptcredentialsample.encryptcredential.models.CredentialDetailsRequestBody;
import com.encryptcredentialsample.encryptcredential.models.GatewayPublicKey;

public class UpdateCredentialsService {

	// Encrypts and makes PATCH request to update datasource
	public static ResponseEntity<String> updateDatasource(
			String accessToken, 
			String credType,
			String privacyLevel, 
			String[] credentialsArray, 
			GatewayPublicKey pubKey, 
			String gatewayId, 
			String datasourceId) throws Exception {

		// Serialize credentials for encryption
		String serializedCredentials = Utils.serializeCredentials(credentialsArray, credType);

		// Encrypt the credentials Asymmetric Key Encryption
		AsymmetricKeyEncryptorService credentialsEncryptor = new AsymmetricKeyEncryptorService(pubKey);
		String encryptedCredentialsString = credentialsEncryptor.encodeCredentials(serializedCredentials);

		// Credential Details class object for request body
		CredentialDetails credentialDetails = new CredentialDetails(credType, encryptedCredentialsString, privacyLevel);

		// Converting CredentialDetails class object to json string
		CredentialDetailsRequestBody requestBodyObj = new CredentialDetailsRequestBody(credentialDetails);

		return makeUpdateDataSourcePatchRequest(requestBodyObj, gatewayId, datasourceId, accessToken);
	}

	// Make an HTTP Patch request to update the encrypted credentials of the data source
	public static ResponseEntity<String> makeUpdateDataSourcePatchRequest(
			CredentialDetailsRequestBody requestBody, 
			String gatewayId, 
			String datasourceId, 
			String accessToken) throws ClientProtocolException, IOException {
		
		// Gateways - Update Datasource Power BI REST API
		// https://docs.microsoft.com/en-us/rest/api/power-bi/gateways/updatedatasource
		String endPointUrl = "https://api.powerbi.com/v1.0/myorg/gateways/" + gatewayId + "/datasources/" + datasourceId;

		// Request header
		HttpHeaders reqHeader = Utils.generateAuthorizationHeaders(accessToken);
		
		// HTTP entity object - contains header and body
		HttpEntity<CredentialDetailsRequestBody> reqEntity = new HttpEntity<CredentialDetailsRequestBody> (requestBody, reqHeader);

		// Call REST API
		RestTemplate updateDatasource = new RestTemplate(new HttpComponentsClientHttpRequestFactory());
		return updateDatasource.exchange(endPointUrl, HttpMethod.PATCH, reqEntity, String.class);
	}
}
