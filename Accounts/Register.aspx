<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FrootaxiMain.Accounts.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
Register | Frootaxi
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
<script src="../js/script.js" type="text/javascript"></script>
    <script type="text/javascript">
        $('#promoOpener').click(function () {
            $('#body_txtPromotionCode').show('slow', function () {
                // Animation complete.
            });
        });

        /*$('#Button2').on("click", function (e) {
        $("#Button2").val("Please Wait");
        $('#Button2').attr('disabled', 'disabled');
        ClientScript.GetPostBackEventReference(bt1, null);
        });*/

        var prm = Sys.WebForms.PageRequestManager.getInstance();

        prm.add_endRequest(function () {
            $("#packages").hide();
            $("#packageOpener").hover(

            function () {
                $("#packages").slideToggle();
            });

            $('#promoOpener').click(function () {
                $('#body_txtPromotionCode').show('slow', function () {
                    // Animation complete.
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="promptContent" runat="server">
    <asp:UpdatePanel ID="upErrorMessage" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblErrorMessage" runat="server" Text=""></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="upModalDialog" style="display:none" runat="server">
	    <ContentTemplate>
	        <div id='errorDialog' title = "Confirm Registration?">
	            <p class="modalDialogText">
	                <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 50px 0;"></span>
	                <asp:Label ID="lblErrorMessage1" runat="server" Text=""></asp:Label>
	            </p>
	        </div>
	        <asp:Button ID="btnSave" runat="server" Text="" style="display:none" 
	            onclick="btnSave_Click" />
	    </ContentTemplate>
	</asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="loginStatus1" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="toRightContent" runat="server">
    <ul class="middleContent">
        <li class="defaultButtons"><a href="http://beta.frootaxi.com/HailACab.aspx">Hail a Frootaxi Cab</a></li>
	    <li class="defaultButtons"><a href="#">Become a Frootaxi Powered Fleet Company</a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="loginStatus2" runat="server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="rightSideContent" runat="server">
    <fieldset>
		<ul>
			<li class="title padding right">Register</li>
			<li>
                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
		            <ContentTemplate>
		                <asp:TextBox ID="txtFirstName" placeholder="First Name" CssClass="textBox" 
		                        runat="server"></asp:TextBox>
                    </ContentTemplate>
		        </asp:UpdatePanel>
			</li>
			<li>
		        <asp:TextBox ID="txtLastName" CssClass="textBox" placeholder="Surname" 
                    runat="server"></asp:TextBox>
			</li>
			<li>
		        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
		            <ContentTemplate>
		                <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="textBox" 
                            placeholder="Email"></asp:TextBox>
		            </ContentTemplate>
		        </asp:UpdatePanel>
			</li>
			<li>
		        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
		            <ContentTemplate>
		                <asp:TextBox ID="txtMobileNumber" placeholder="Mobile Number" 
                            CssClass="textBox" runat="server"></asp:TextBox>
		            </ContentTemplate>
		        </asp:UpdatePanel>
			</li>
			<li>
		        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
		            <ContentTemplate>
		                <asp:TextBox ID="txtPassword" CssClass="textBox" placeholder="Password" 
                            runat="server" TextMode="Password"></asp:TextBox>
		            </ContentTemplate>
		        </asp:UpdatePanel>
			</li>
			<li>	                
		        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
		            <ContentTemplate>
		                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="textBox" 
                            placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
		            </ContentTemplate>
		        </asp:UpdatePanel>
			</li>
			<li>
                <asp:UpdatePanel ID="upRegion" runat="server">
		            <ContentTemplate>
                        <asp:DropDownList CssClass="dropdownmenu" ID="ddlRegion" runat="server" 
		                    DataTextField="name_capitalized" DataValueField="id">
		                </asp:DropDownList>
                    </ContentTemplate>
		        </asp:UpdatePanel>
			</li>
		</ul>
	</fieldset>
	<fieldset>
		<ul id="packages" class="ui-corner-all">
            <li>
            	<p class="title">BRONZE</p><span class="bubbleTip"></span>
            	<p class="price">GHC30.00</p>
            	<p class="description">The Bronze package includes <span class="freeText">15 trips</span> costing GHC10 and <span class="freeText">1 Free </span>trip costing GHC5.00</p>
            </li>
            <li>
            	<p class="title">GOLD</p>
            	<p class="price">GHC60.00</p>
            	<p class="description">You get <span class="freeText">30 trips</span> costing GHC10 and <span class="freeText">2 Free </span>trips costing GHC5.00</p>
            </li>
			<li>
            	<p class="title">DIAMOND</p>
            	<p class="price">GHC90.00</p>
            	<p class="description">The Diamond package gives you <span class="freeText">45 trips</span> costing GHC10 and <span class="freeText">3 Free </span>trips costing GHC5.00</p>
            </li>
        </ul>
	</fieldset>
	<fieldset>
		<ul id="packages2">
            <li>
            	<p class="title">BRONZE</p>
            	<p class="price">GHC30.00</p>
            	<p class="description">The Bronze package includes <span class="freeText">15 trips</span> costing GHC10 and <span class="freeText">1 Free </span>trip costing GHC5.00</p>
            </li>
            <li>
            	<p class="title">GOLD</p>
            	<p class="price">GHC60.00</p>
            	<p class="description">You get <span class="freeText">30 trips</span> costing GHC10 and <span class="freeText">2 Free </span>trips costing GHC5.00</p>
            </li>
			<li>
            	<p class="title">DIAMOND</p>
            	<p class="price">GHC90.00</p>
            	<p class="description">The Diamond package gives you <span class="freeText">45 trips</span> costing GHC10 and <span class="freeText">3 Free </span>trips costing GHC5.00</p>
            </li>
        </ul>
	</fieldset>
	<fieldset class="last-child">
		<ul>
			<li class="title padding">Payment Information</li>
			<li>
                <asp:UpdatePanel ID="upPaymentPackage" runat="server">
		            <ContentTemplate>
	                    <asp:DropDownList CssClass="dropdownmenu" ID="ddlPaymentPackage" runat="server" DataTextField="name_capitalized" 
		                    DataValueField="id">
		                </asp:DropDownList><span id="packageOpener">[?]</span>
                    </ContentTemplate>
		        </asp:UpdatePanel>
            </li>
            <li>
                <asp:UpdatePanel ID="upPaymentType" runat="server">
		            <ContentTemplate>
	                    <asp:DropDownList CssClass="dropdownmenu" ID="ddlPaymentType" runat="server" DataTextField="type_capitalized" 
		                    DataValueField="id">
		                </asp:DropDownList>
                    </ContentTemplate>
		        </asp:UpdatePanel>
            </li>
			<li>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
		            <ContentTemplate>		                    
		                <asp:TextBox CssClass="textBox account" placeholder="MPower Username/Mobile Number" ID="txtAccountNumber" 
                            runat="server"></asp:TextBox>
                    </ContentTemplate>
		        </asp:UpdatePanel>
			</li>
			<li class="style textLink" id="mpowerLink"><a href="https://app.mpowerpayments.com/signup" target="_blank">I don't have an MPower account</a></li>
			<li class="style">If you have a promotion code enter it below to claim it</li>
			<li>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
		            <ContentTemplate>
                        <asp:TextBox CssClass="textBox" ID="txtPromotionCode" runat="server"
                                placeholder="I have a promotion code"></asp:TextBox>
                    </ContentTemplate>
		        </asp:UpdatePanel>
            </li>
		</ul>
	</fieldset>
	<fieldset id="submitButtonStyle">
		<ul>
			<li><p>By clicking register, I accept the <a href="../Information/Terms.aspx" id="terms">terms</a> of the Frootaxi Service.</p></li>
			<li>
                <asp:UpdatePanel ID="upButtonTrigger" runat="server">
                    <ContentTemplate>
                        <asp:Button CssClass="button" ID="btnSubmit" runat="server" Text="Register" 
                            onclick="btnSubmit_Click" OnClientClick="this.disabled = true; this.value = 'Submitting...';"   UseSubmitBehavior="false" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </li>
			<li id="footer"><p>Copyright &copy; 2013  Frootaxi , All rights reserved.</p></li>
		</ul>
	</fieldset>
</asp:Content>
