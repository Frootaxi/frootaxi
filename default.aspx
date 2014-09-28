<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="FrootaxiMain.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
Home | Frootaxi
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <link href="css/landingPage.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var markers = [];
        var map;
        var marker;
        var polyOptions;

        $(document).ready(function () {
            $("#txtSearchAddress").autocomplete({
                //This bit uses the geocoder to fetch address values
                source: function (request, response) {
                    geocoder.geocode({ 'address': request.term }, function (results, status) {
                        response($.map(results, function (item) {
                            return{
                                label: item.formatted_address,
                                value: item.formatted_address,
                                latitude: item.geometry.location.lat(),
                                longitude: item.geometry.location.lng()
                            };
                        }));
                    });
                },
                //This bit is executed upon selection of an address
                select: function (event, ui) {
                    
                    $("#osgb36lat").val(ui.item.latitude);
                    $("#osgb36lon").val(ui.item.longitude);

                    var location = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);
                    addLatLng2(location);

                    setTimeout(clearSearchBox, 200);
                }
            });

            initialize('map-canvas', true);
            initializeUserJourney('map-canvas-snapshot');
        });

        function clearSearchBox() {
            $("#txtSearchAddress").val('');
        }

        function toggleAndClick() {
            //TODO: Check that at least two markers are on the map before proceeding
            loadPanelOverlay();

            for (var i = 0; i < markers.length; i++)
                codeLatLng(i);

            setTimeout(codeBehind, 6000);
        }

        function codeBehind() {
            document.getElementById('<%=btnHailATaxi.ClientID%>').click();
        }

        function loadPanelOverlay() {
            document.getElementById('divCoverSmall').className = 'panel overlay cursor';
            document.getElementById('divPleaseWait').className = 'pleaseWait';

            var x = document.getElementById('btnHail');
            x.innerHTML = "Please wait...";
        }

        function codeLatLng(counter) {
            var input = markers[counter];
            geocoder.geocode({ 'latLng': input }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[1]) {
                        document.getElementById('<%=txtLatLngAddress.ClientID%>').value += counter + ': ' + results[1].formatted_address + ';';
                    };
                } else {
                    alert("Geocoder failed due to: " + status);
                }
            });
        }

        function unloadPanelOverlay() {
            document.getElementById('divCoverSmall').className = '';
            document.getElementById('divPleaseWait').className = '';

            var x = document.getElementById('btnHail');
            x.innerHTML = "Hail me a taxi!";
        }

        $(function () {
            $(document).tooltip({
                track: true,
                delay: 0,
                fade: 250
            });
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
    <asp:TextBox ID="txtLatLngAddress" runat="server" CssClass="hide"></asp:TextBox>
        <div id="payg_fare">
	        <h3>Your Trip Details</h3>
            <div class="top_payg_content">
                <div id="map-canvas-snapshot"></div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <asp:TextBox ID="txtCost" runat="server" Text="GHC 0.00" CssClass="trip_cost"></asp:TextBox>
                        <!--<label for="tripDistance">Distance: </label><input id="txtTripDistance" type="text" runat="server" />-->
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Label ID="lblConfirmationDetails" runat="server" 
                        Text="Please review your trip details and confirm your order by clicking on the 'Yes, get me a taxi' button." 
                            CssClass="trip_confirmation_text"></asp:Label>
            </div>
            <div class="bottom_payg_content">
                <asp:Button ID="btnMakePayment" runat="server" Text="Yes, get me a taxi" onclick="btnMakePayment_Click" CssClass="button alt bleft confirm_button" />
                <input id="btnCancel" type="button" value="Cancel Request" onclick="clearMaps()" class="button alt bright" />
            </div>
            <a id="popupBoxClose" onclick="unloadPopupBox()">x</a>
        </div>
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
    <div id="panel">
        <div id="divCoverSmall"><div id="divPleaseWait"></div></div>
        <input id="txtSearchAddress" type="text" placeholder="Take me to..." title="Search for your destination location here" class="search_address transition" />
        <button id="btnSearch" type="button" class="search _button transition" onclick="locate_address();">Search</button>
        <button id="btnHail" type="button" class="hail _button transition" onclick="toggleAndClick();">Hail me a taxi!</button>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Button ID="btnHailATaxi" runat="server" Text="" CssClass="hide" onclick="btnHailATaxi_Click" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <input id="txtTripCoordinates" type="text" runat="server" class="hide" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <span id="clearMarkers" onclick="clearMaps();" title="clear all markers"></span>
    </div>
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
			<li class="title padding"><span class="imgContainer lpi1"></span>Our quality promise</li>
			<li>
				<p class="landingPageText">
					We provide clean, fairly new to brand new taxi cabs. All Frootaxi drivers hold valid licenses and are vetted as added measure for your safety. You are always assured a comfortable and safe ride to your destination.
				</p>
			</li>
		</ul>
	</fieldset>
	<fieldset class="padding2">
		<ul>
            <li class="title padding"><span class="imgContainer  lpi2"></span>Hail a taxi conveniently</li>
            <li>
            	<p class="landingPageText">
            		Request for a taxi from the comfort of your home, office or anywhere in town. At a click or tap of a button we will deliver a taxi to you within minutes. 
            	</p>
            </li>
        </ul>
	</fieldset>
	<fieldset class="last-child">
		<ul>
            <li class="title padding"><span class="imgContainer  lpi3"></span>You pay the right price</li>
            <li>
            	<p class="landingPageText">
            		We have daily rates as well as metered charging for journeys without a specified destination. We accept cash as well as all forms of electronic payment including credit/debit cards and mobile money.
                </p>
            </li>
        </ul>
	</fieldset>
    <fieldset class="padding2 .close">
        <ul>
			<li class="title padding right">Trip type</li>
            <li class="style">Please indicate what type of trip this will be.</li>
            <li>
		        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
		            <ContentTemplate>
                        <asp:RadioButtonList ID="rblTripType" runat="server"></asp:RadioButtonList>
		            </ContentTemplate>
		        </asp:UpdatePanel>
			</li>
            <li class="style">Choose the duration.</li>
            <li class="no_bottom_border">
		        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
		            <ContentTemplate>
                        <asp:DropDownList ID="ddlPeriod" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlRate" runat="server"></asp:DropDownList>
		            </ContentTemplate>
		        </asp:UpdatePanel>
			</li>
        </ul>
        <ul>
			<li class="title padding right">Arrival Time</li>
            <li class="style">What time would you like your taxi to arrive?</li>
            <li class="no_bottom_border">
		        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
		            <ContentTemplate>
		                <script src="js/jquery-ui.js"></script>
                        <script src="js/jquery-ui-timepicker-addon.js"></script>
                        <script type="text/javascript">
                            function pageLoad() {
                                $(function () {
                                    $('#rightSideContent_basic_example_2').timepicker({
                                        timeFormat: "hh:mm tt"
                                    });
                                });
                            }
                        </script>
                        <asp:TextBox ID="basic_example_2" placeholder="due time..."
                            CssClass="textBox basic_example_2" runat="server"></asp:TextBox>
		            </ContentTemplate>
		        </asp:UpdatePanel>
			</li>
        </ul>
	</fieldset>
	<fieldset id="submitButtonStyle">
		<ul>
			<li id="footer"><p>Copyright &copy; 2013  Frootaxi , All rights reserved.</p></li>
		</ul>
	</fieldset>
</asp:Content>
