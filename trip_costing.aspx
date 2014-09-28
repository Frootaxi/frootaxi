<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="trip_costing.aspx.cs" Inherits="FrootaxiMain.trip_costing" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trip Costing | Frootaxi</title>
    <link rel="Stylesheet" type="text/css" href="css/costing.css" />
    <link href="css/typography.css" rel="stylesheet" type="text/css" />
    <link href="http://code.jquery.com/ui/1.10.3/themes/vader/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="http://code.jquery.com/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/ui/1.11.1/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">
        var x = 0;

        function hideErrorMsg() {
            setTimeout(unloadErrorMsg, 5000);
        }

        function unloadErrorMsg() {
            var x = document.getElementById('<%=lblErrorMessage.ClientID%>');
            var id = '#' + x;

            $(id).fadeOut('slow');
            //document.getElementById('lblErrorMessage').className = '';

            x.innerHTML = "";
        }
        $(document).ready(function () {
            var refreshInterval = '';
            refreshInterval = setInterval(function () {
                reloadPage();
            }, 6000);
        });

        function reloadPage() {
            window.location.reload();
        }

        function clickButton() {
            document.getElementById('<%=btnReloadList.ClientID%>').click();
        }
    </script>
</head>
<body>
    <form id="frmCosting" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <div class="background">
            <asp:UpdatePanel ID="upScriptLoader" runat="server"></asp:UpdatePanel>
            <asp:UpdatePanel ID="upErrorMessage" runat="server">
            <ContentTemplate>
                <asp:Label ID="lblErrorMessage" runat="server" Text=""></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="topcon">
			<div id="logo">
			</div><!-- 100% color all the way across padding:50px 55px; -->
            <div id="subscriptionPanel">
				<fieldset><legend></legend>
					<ol>
						<li>Please enter the cost of the trip below</li>
					</ol>
				</fieldset>
			</div>
		</div>
	</div>
	<div class="bottomcon text_color textShadow">
        <fieldset class="entry_form ui-corner">
            <legend></legend>
            <ul>
                <li>
                    <label id="lblTripId" >Trip Id:</label><asp:TextBox ID="txtTransactionId"
            runat="server" CssClass="ui-corner"></asp:TextBox>
                </li>
                <li>
                    <label id="lblTripPrice" >Price of trip: <span class="currency">GHC</span></label><asp:TextBox ID="txtTripPrice"
            runat="server"></asp:TextBox>
                </li>
                <li>
                    <asp:Button ID="btnAddPrice" runat="server" Text="Add Price" 
            onclick="btnAddPrice_Click" CssClass="btn display" />
                </li>
            </ul>
        </fieldset>
        <br /><br />
        <asp:UpdatePanel ID="upLatestRequests" runat="server" UpdateMode="Always">
            <ContentTemplate>
                <div class="requestCount">Total requests: <asp:Label ID="lblTotalRequestCount" runat="server" Text="" CssClass="count"></asp:Label></div>
                <br /><br />
                <div class="gridView">
                    <asp:Label ID="lblNoRequests" runat="server" Text="" CssClass="hide"></asp:Label>
                    <asp:GridView ID="gdvLatestRequests" runat="server" CellPadding="5" CellSpacing="5" DataMember="id"></asp:GridView>
                    <asp:Button ID="btnReloadList" runat="server" CssClass="hide" Text="" OnClick="btnReloadList_Click" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br /><br /><br /><br />
	</div>
    </form>
</body>
</html>
