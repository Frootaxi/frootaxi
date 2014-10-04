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
        var spinner;

        jQ(document).ready(function ($) {
            $("input[id$='rightSideContent_rbtOpenTrip']").click(function () {
                $("#divDuration").slideDown("fast");
            });

            $("input[id$='rightSideContent_rbtOneWay']").click(function () {
                $("#divDuration").slideUp("fast");
            });

            $("input[id$='rightSideContent_rbtRoundTrip']").click(function () {
                $("#divDuration").slideUp("fast");
            });

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

        function displayWait() {
            var opts = {
                lines: 15, // The number of lines to draw
                length: 9, // The length of each line
                width: 4, // The line thickness
                radius: 14, // The radius of the inner circle
                corners: 1, // Corner roundness (0..1)
                rotate: 0, // The rotation offset
                direction: 1, // 1: clockwise, -1: counterclockwise
                color: '#000', // #rgb or #rrggbb or array of colors
                speed: 1, // Rounds per second
                trail: 35, // Afterglow percentage
                shadow: false, // Whether to render a shadow
                hwaccel: false, // Whether to use hardware acceleration
                className: 'spinner', // The CSS class to assign to the spinner
                zIndex: 2e9, // The z-index (defaults to 2000000000)
                top: '50%', // Top position relative to parent
                left: '50%' // Left position relative to parent
            };
            var target = document.getElementById('divPleaseWait');
            spinner = new Spinner(opts).spin(target);
        }

        function hideWait() {
            alert("hideWait() entered");
            spinner.stop();
        }

        function clearSearchBox() {
            jQ("#txtSearchAddress").val('');
        }

        function toggleAndClick() {
            //TODO: Check that at least two markers are on the map before proceeding

            var x = document.getElementById('<%=btnHail.ClientID%>');
            x.innerHTML = "Please wait...";

            unloadPanelOverlay();
            loadDivCover();
            displayWait();

            for (var i = 0; i < markers.length; i++)
                codeLatLng(i);

            setTimeout(codeBehind, 6000);
        }

        function codeBehind() {
            document.getElementById('<%=btnHailATaxi.ClientID%>').click();
        }

        function loadPanelOverlay() {
            document.getElementById('divCoverSmall').className = 'panel overlay cursor';

            var x = document.getElementById('btnNext');
            x.innerHTML = "Almost done...";
        }

        function unloadPanelOverlay() {
            document.getElementById('divCoverSmall').className = '';

            var x = document.getElementById('btnNext');
            x.innerHTML = "Hail me a taxi!";
        }

        function loadPopupBox() { // To Load the Popupbox
            document.getElementById('payg_details').className = 'show';
        }

        function loadDivCover() {
            unloadPanelOverlay();
            document.getElementById('divCover').className = 'overlay cursor fixed';
        }

        function codeLatLng(counter) {
            var input = markers[counter];
            geocoder.geocode({ 'latLng': input }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[1]) {
                        document.getElementById('<%=txtLatLngAddress.ClientID%>').value += counter + ': ' + results[1].formatted_address + ';';
                    }
                } else {
                    alert("Make sure your internet connection is working.");
                }
            });
        }

        function displayTripDetailsSection() {
            loadPanelOverlay();

            var x = document.getElementById("serviceDetails");
            x.className = "close";

            var y = document.getElementById("tripDetails");
            y.className = "padding2";

            var z = document.getElementById("rightSide");
            z.className = "adjustHeight";
        }

        function loadTime() {
            var h;
            var hr;
            var min;
            var ampm;

            var today = new Date();
            //var timeWithoutDate = new Date(today.getHours(), today.getMinutes(), today.getSeconds());

            hr = document.getElementById('<%=ddlHours.ClientID%>');
            ampm = document.getElementById('<%=ddlAmPmFormat.ClientID%>');

            if (today.getHours() > 12) {
                h = today.getHours();
                hr.value = h - 12;                
                ampm.value = "PM";
            }
            else if (today.getHours() === 0) {
                hr.value = 12;
                ampm.value = "AM";
            }
            else {
                hr.value = today.getHours();
                ampm.value = "AM";
            }

            min = document.getElementById('<%=ddlMinutes.ClientID%>');
            min.value = today.getMinutes();
        }

        function displayHelpTip(_div) {
            jQ("#" + _div).fadeIn("fast");
        }

        function hideHelpTip(_div) {
            jQ("#" + _div).fadeOut("fast");
        }

        jQ(function ($) {
            $(document).tooltip({
                track: true,
                delay: 0,
                fade: 250
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="promptContent" runat="server">
    <div id="divCover"><div id="divPleaseWait"></div></div>
    <asp:UpdatePanel ID="upErrorMessage" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblErrorMessage" runat="server" Text=""></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:TextBox ID="txtLatLngAddress" runat="server" CssClass="hide"></asp:TextBox>
        <div id="payg_details">
	        <h3>Summary of Your Trip Details</h3>
            <div class="top_payg_content">
                <div id="map-canvas-snapshot"></div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                        <asp:TextBox ID="txtCost" runat="server" Text="GHC 0.00" CssClass="trip_cost"></asp:TextBox>
                        <ul class="trip_dets">
                            <li><label for="tripDistance">Trip type: </label><asp:TextBox ID="txtTripType" runat="server" Text="RoundTrip" CssClass="trip_confirmation_text"></asp:TextBox></li>
                            <li><label for="tripDistance">Duration: </label><asp:TextBox ID="txtDuration" runat="server" Text="" CssClass="trip_confirmation_text"></asp:TextBox></li>
                            <li><label for="tripDistance">Pick-up time: </label><asp:TextBox ID="txtPickTime" runat="server" Text="7:30pm" CssClass="trip_confirmation_text"></asp:TextBox></li>
                            <!--<li><label for="tripDistance">Distance: </label><input id="txtTripDistance" type="text" runat="server" /></li>-->
                        </ul>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Label ID="lblConfirmationDetails" runat="server" 
                        Text="Please review your trip details and confirm your order by clicking on the 'Yes, hail me a taxi' button." 
                            CssClass="trip_confirmation_text"></asp:Label>
            </div>
            <div class="bottom_payg_content">
                <asp:Button ID="btnMakePayment" runat="server" Text="Yes, hail me a taxi" onclick="btnMakePayment_Click" CssClass="button alt bleft confirm_button" />
                <input id="btnCancel" type="button" value="Cancel Request" onclick="clearMaps()" class="button alt bright" />
            </div>
            <a id="popupBoxClose" onclick="unloadPopupBox();hideWait();">x</a>
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
        <div id="divCoverSmall"></div>
        <input id="txtSearchAddress" type="text" placeholder="Take me to..." title="Search for your destination location here" class="search_address transition" />
        <button id="btnSearch" type="button" class="search _button transition" onclick="locate_address();">Search</button>
        <button id="btnNext" type="button" class="hail _button transition" onclick="displayTripDetailsSection();">Hail me a taxi!</button>
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
    <div id="serviceDetails">
	    <fieldset class="padding2">
            <legend></legend>
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
            <legend></legend>
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
            <legend></legend>
		    <ul>
                <li class="title padding"><span class="imgContainer  lpi3"></span>You pay the right price</li>
                <li>
            	    <p class="landingPageText">
            		    We have daily rates as well as metered charging for journeys without a specified destination. We accept cash as well as all forms of electronic payment including credit/debit cards and mobile money.
                    </p>
                </li>
            </ul>
	    </fieldset>
    </div>
    <div id="tripDetails" class="fixed_height close">
        <fieldset class="padding2">
        <legend></legend>
            <ul>
			    <li class="title padding right">Trip type</li>
                <li class="style">What type of trip will this be?</li>
                <li class="no_bottom_border">
		            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
		                <ContentTemplate>
                            <ul>
                                <li class="pos_rel"><span class="radio"><asp:RadioButton ID="rbtOneWay" runat="server" GroupName="tripType" Checked="true" /></span>One way trip<span class="help" onclick="displayHelpTip('divHelpTip');">[?]</span>
                                    <div id="divHelpTip">
                                        <span class="bubbleTip"></span>
                                        <span class="helpText"><span class="container_close" onclick="hideHelpTip('divHelpTip');">x</span>Your trip ends at the last point you placed on the map.</span>
                                    </div>
                                </li>
                                <li class="pos_rel"><span class="radio"><asp:RadioButton ID="rbtRoundTrip" runat="server" GroupName="tripType" /></span>Round Trip<span class="help" onclick="displayHelpTip('divHelpTip1');">[?]</span>
                                    <div id="divHelpTip1">
                                        <span class="bubbleTip"></span>
                                        <span class="helpText"><span class="container_close" onclick="hideHelpTip('divHelpTip1');">x</span>You will be returning to your pickup point.</span>
                                    </div>
                                </li>
                                <li class="no_bottom_border pos_rel"><span class="radio"><asp:RadioButton ID="rbtOpenTrip" runat="server" GroupName="tripType" /></span>Open trip (hourly rate)<span class="help" onclick="displayHelpTip('divHelpTip2');">[?]</span>
                                    <div id="divHelpTip2">
                                        <span class="bubbleTip"></span>
                                        <span class="helpText"><span class="container_close" onclick="hideHelpTip('divHelpTip2');">x</span>You will be making several stops and prefer to pay an hourly rate.</span>
                                    </div>
                                </li>
                            </ul>
                            <asp:RadioButtonList ID="rdlbTripType" runat="server"></asp:RadioButtonList>
		                </ContentTemplate>
		            </asp:UpdatePanel>
			    </li>
            </ul>
            <ul id="divDuration">
                <li class="title padding right">Duration</li>
                <li class="style">How long will you need the taxi for?</li>
                <li class="no_bottom_border">
		            <asp:UpdatePanel ID="UpdatePanel7" runat="server">
		                <ContentTemplate>
                            <asp:DropDownList ID="ddlPeriod" runat="server"></asp:DropDownList>
                            <span class="style">&nbsp;Hour(s)</span>
		                </ContentTemplate>
		            </asp:UpdatePanel>
			    </li>
            </ul>
        </fieldset>
        <fieldset class="padding2">
            <legend></legend>
            <ul>
			    <li class="title padding right">Arrival Time</li>
                <li class="style">When do you need the taxi by? <!--Select a time below or click "Now" to get a taxi immediately.--></li>
                <!--<li class="no_bottom_border small_height">
                    <center><button id="btnNow" class="button btn_small" type="button" onclick="loadTime();">Now</button></center>
                </li>-->
                <li class="no_bottom_border">
		            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
		                <ContentTemplate>
                            <asp:DropDownList ID="ddlHours" runat="server" CssClass="dropdownmenu small_width"></asp:DropDownList> :
                            <asp:DropDownList ID="ddlMinutes" runat="server" CssClass="dropdownmenu small_width"></asp:DropDownList>&nbsp;&nbsp;
                            <asp:DropDownList ID="ddlAmPmFormat" runat="server" CssClass="dropdownmenu small_width"></asp:DropDownList>
		                </ContentTemplate>
		            </asp:UpdatePanel>
			    </li>
            </ul>
        </fieldset>
        <fieldset>
            <legend></legend>
            <ul>
                <li class="no_bottom_border">
                    <asp:UpdatePanel ID="upButtonTrigger" runat="server">
                        <ContentTemplate>
                            <button class="button shift_down" id="btnHail" runat="server"
                                onclick="toggleAndClick();">Hail me a taxi!</button>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </li>
            </ul>
	    </fieldset>
    </div>
    <fieldset id="submitButtonStyle">
        <legend></legend>
        <ul>
			<li id="footer"><p>Copyright &copy; 2013  Frootaxi , All rights reserved.</p></li>
		</ul>
    </fieldset>
</asp:Content>
