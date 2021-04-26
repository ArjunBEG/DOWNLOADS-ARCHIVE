// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.
// ----------------------------------------------------------------------------

namespace EncryptCredentials.Services
{
	using EncryptCredentials.Models;
	using Microsoft.PowerBI.Api;
    using Microsoft.PowerBI.Api.Extensions;
    using Microsoft.PowerBI.Api.Models;
	using Microsoft.PowerBI.Api.Models.Credentials;
	using Microsoft.Rest;
	using System;

	public class PowerBIService 
	{
		private readonly AadService aadService;
		private readonly string urlPowerBiServiceApiRoot  = "https://api.powerbi.com";

		public PowerBIService(AadService aadService)
		{
			this.aadService = aadService;
		}

		/// <summary>
		/// Get Power BI client
		/// </summary>
		/// <returns>Power BI client object</returns>
		public PowerBIClient GetPowerBIClient()
		{
			var tokenCredentials = new TokenCredentials(aadService.GetAccessToken(), "Bearer");
			return new PowerBIClient(new Uri(urlPowerBiServiceApiRoot ), tokenCredentials);
		}

		/// <summary>
		/// Get Datasources in corresponding Power BI Workspace
		/// </summary>
		/// <param name="groupId">Power BI group Id</param>
		/// <param name="datasetId">Power BI dataset Id in corresponding Workspace</param>
		/// <returns>Datasources present in corresponding Power BI Workspace</returns>
		public Datasources GetDatasourcesInGroup(Guid groupId, Guid datasetId)
		{

			PowerBIClient pbiClient = this.GetPowerBIClient();

			// Get datasource info
			return pbiClient.Datasets.GetDatasourcesInGroup(groupId, datasetId.ToString());
		}

		/// <summary>
		/// Get Gateway public key
		/// </summary>
		/// <param name="gatewayId">Gateway Id of corresponding Dataset</param>
		/// <returns>Public key of corresponding gateway</returns>
		public GatewayPublicKey GetGatewayPublicKey(Guid gatewayId)
		{
			PowerBIClient pbiClient = this.GetPowerBIClient();

			// Get gateway info
			var gateway = pbiClient.Gateways.GetGateway(gatewayId);

			return gateway.PublicKey;
		}

		/// <summary>
		/// Get credentials for updating datasource
		/// </summary>
		/// <param name="credentialType">Type of credential selected by user</param>
		/// <param name="credentialsArray">Credentials entered by the user</param>
		/// <returns>Credentials for updating the datasource</returns>
		public CredentialsBase GetCredentials(string credentialType, string[] credentialsArray)
		{
            CredentialsBase credentials;

            // Capture credentials based on credential type selected by the user
            switch(credentialType)
            {
                case Constants.KeyCredentials:
                    credentials = new KeyCredentials(key: credentialsArray[0]);
                    break;
                case Constants.BasicCredentials:
                    credentials = new BasicCredentials(username: credentialsArray[0], password: credentialsArray[1]);
                    break;
                case Constants.OAuth2Credentials:
                    credentials = new OAuth2Credentials(accessToken: credentialsArray[0]);
                    break;
                case Constants.WindowsCredentials:
                    credentials = new WindowsCredentials(username: credentialsArray[0], password: credentialsArray[1]);
                    break;
                default:
                    Console.Error.WriteLine(Constants.InvalidCredType);
                    throw new Exception(Constants.InvalidCredType);
            }

            return credentials;
        }

		/// <summary>
		/// Get credential details
		/// </summary>
		/// <param name="gatewayId">Gateway Id of corresponding dataset</param>
		/// <param name="credentialType">Type of credential selected by user</param>
		/// <param name="credentialType">Type of credential selected by user</param>
		/// <param name="credentialsArray">Credentials entered by the user</param>
		/// <param name="privacyLevel">Privacy level selected by the user</param>
		/// <returns>Credentials details updating the datasource</returns>
		public CredentialDetails GetCredentialDetails(Guid gatewayId, string credentialType, string[] credentialsArray, string privacyLevel)
		{

			// Capture credentials based on credential type selected by the user
			var credentials = GetCredentials(credentialType, credentialsArray);

			// Get Public Key
			var publicKey = GetGatewayPublicKey(gatewayId);

			// Create Asymmetric key Encryptor
			var credentialsEncryptor = new AsymmetricKeyEncryptor(publicKey);

			// Capture Credential Details
			var credentialDetails = new CredentialDetails(
				credentials,
				privacyLevel: privacyLevel,
				EncryptedConnection.Encrypted,
				credentialsEncryptor
			);

			return credentialDetails;
		}

		/// <summary>
		/// Updates Datasource credentials
		/// </summary>
		/// <param name="gatewayId">Gateway Id of corresponding dataset</param>
		/// <param name="datasourceId">Datasource Id of corresponding gateway</param>
		/// <param name="dataSourceRequest">Request body for Update Datasource API</param>
		public void UpdateDatasource(Guid gatewayId, Guid datasourceId, UpdateDatasourceRequest dataSourceRequest)
		{

			PowerBIClient pbiClient = this.GetPowerBIClient();

			// Update credentials
			pbiClient.Gateways.UpdateDatasource(gatewayId, datasourceId, dataSourceRequest);
		}

		/// <summary>
		/// Add Datasource in corresponding Power BI Gateway
		/// </summary>
		/// <param name="gatewayId">Gateway Id of corresponding Dataset</param>
		/// <param name="publishDatasourceToGatewayRequest">Request body for Add Datasourcce API</param>
		public GatewayDatasource AddDatasource(Guid gatewayId, PublishDatasourceToGatewayRequest publishDatasourceToGatewayRequest)
		{
			PowerBIClient pbiClient = this.GetPowerBIClient();

			// Add datasource
			return pbiClient.Gateways.CreateDatasource(gatewayId, publishDatasourceToGatewayRequest);
		}
	}
}
