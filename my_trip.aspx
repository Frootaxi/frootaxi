﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="my_trip.aspx.cs" Inherits="FrootaxiMain.my_trip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
My Trip | Frootaxi
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <link href="css/landingPage.css" rel="stylesheet" type="text/css" />
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true" type="text/javascript"></script>
    <script src="js/script.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            dothis('map-canvas');
            mapTrip();
        });
    </script>
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="promptContent" runat="server">
    <div id="divCover"></div>
    <asp:UpdatePanel ID="upErrorMessage" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblErrorMessage" runat="server" Text=""></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="loginStatus1" runat="server">
    <li>
        <asp:LoginStatus ID="LoginStatus2" runat="server" LoginText="Sign in" 
            LogoutAction="Redirect" LogoutPageUrl="~/Accounts/Login.aspx" 
            LogoutText="Sign Out" onloggingout="LoginStatus1_LoggingOut" />
    </li>
	<li id="registerLinkTop"><a href="Accounts/Register.aspx">Register</a></li>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="toRightContent" runat="server">
	<div id="map-canvas"></div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="loginStatus2" runat="server">
    <li>
        <asp:LoginStatus ID="LoginStatus1" runat="server" LoginText="Sign in" 
            LogoutAction="Redirect" LogoutPageUrl="~/Accounts/Login.aspx" 
            LogoutText="Sign Out" onloggingout="LoginStatus1_LoggingOut" />
    </li>
	<li id="registerLinkBottom"><a href="Accounts/Register.aspx">Register</a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="rightSideContent" runat="server">
	<fieldset class="padding2">
		<ul>
			<li class="title padding"><span class="imgContainer lpi1"></span>Hail a Taxi Conveniently</li>
			<li>
				<p class="landingPageText">
					Request for a taxi from the comfort of your home, office or anywhere in town. Cut out the hassle of standing in the sun or by the roadside to hail a cab. With a click or tap of a button we will deliver a taxi to you within minutes.
				</p>
			</li>
		</ul>
	</fieldset>
	<fieldset class="padding2">
		<ul>
            <li class="title padding"><span class="imgContainer  lpi2"></span>Clean and Safe Taxi Cabs</li>
            <li>
            	<p class="landingPageText">
            		All Frootaxi drivers hold valid licenses and are vetted as added measure for your safety. We provide clean, fairly new to brand new taxi cabs with amenities such as air conditioning. You are always assured a comfortable and safe ride to your destination.
            	</p>
            </li>
        </ul>
	</fieldset>
	<fieldset class="last-child">
		<ul>
            <li class="title padding"><span class="imgContainer  lpi3"></span>Standard pricing and hassle-free payment</li>
            <li>
            	<p class="landingPageText">
            		Our prices are based on market standards which mean you pay the right price for your journey every time. We have daily rates as well as metered charging for journeys without a specified destination. Payments are made either with cash or electronically through your bank account, credit card or mobile money account.
                </p>
            </li>
        </ul>
	</fieldset>
	<fieldset id="submitButtonStyle">
		<ul>
			<li id="footer"><p>Copyright &copy; 2013  Frootaxi , All rights reserved.</p></li>
		</ul>
	</fieldset>
</asp:Content>
