<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="payg.aspx.cs" Inherits="FrootaxiMain.payg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
Payment Options | Frootaxi
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true" type="text/javascript"></script>
    <!--Accordion-->
    <link rel="stylesheet" href="css/jquery-ui.css"/>
    <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
     <script type="text/javascript">
         $(function () {
             $("#accordion").accordion({
                 collapsible: true,
                 active: 'none'
             });
         });

         $(document).ready(function () {
             initializePAYGMap();
         });

         function unloadActivationRequestInfo() {
             document.getElementById("activate").className = "close";
         }
    </script>
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
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <input id="txtTripCoordinates" type="text" runat="server" class="hide" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="map-canvas-2"></div>
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
	<fieldset>
		<ul id="activate">
			<li class="title padding right">Payment Information</li>
            <li class="style">Finally, we will need your mobile number and email address to send you feedback throughout your journey and provide a copy of your receipt.</li>
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
        </ul>
        <ul>
            <li class="style"><br />Indicate below your prefered payment option.</li>
            <li id="accordion">
                <h3>Pay with cash</h3>
                <div>
                    <br />
                    <p class="radioButton"><asp:RadioButton ID="rbtnCash" runat="server" GroupName="paymentOption" CssClass="radio" />Select this option</p>
                    <img src="../images/cash_story_board.png" id="Img1" alt="Instructions for paying with cash" />
                </div>
                <h3>Electronic payment</h3>
                <div>
                    <br />
                    <p class="radioButton"><asp:RadioButton ID="rbtnElectronic" runat="server" GroupName="paymentOption" CssClass="radio" />Select this option</p>
                    <ul>
                        <li class="style">Enter your MPower account information. When a charge is made to your account, you will receive an SMS prompting you to authorize the charge. 
                        Once the payment is complete, you will receive an email with a copy of your receipt.</li>
                        <li>
                            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
		                        <ContentTemplate>		                    
		                            <asp:TextBox CssClass="textBox account" placeholder="MPower Username/Mobile Number" ID="TextBox1" 
                                        runat="server"></asp:TextBox>
                                </ContentTemplate>
		                    </asp:UpdatePanel>
                        </li>
                        <li class="style">If you don't have an MPower account, click on the link below to create one. It only takes 5 minutes.
                        Remember to add money to your account before clicking on the "Confirm Payment" button.</li>
                        <li class="style textLink" id="Li1"><a href="https://app.mpowerpayments.com/signup" target="_blank">I don't have an MPower account</a></li>
                    </ul>
                </div>
            </li>
		</ul>
	</fieldset>
	<fieldset class="last-child">
		<ul>
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
			<li>
                <asp:UpdatePanel ID="upButtonTrigger" runat="server">
                    <ContentTemplate>
                        <asp:Button CssClass="button" ID="btnSubmit" runat="server" Text="Confirm Payment" 
                            onclick="btnSubmit_Click" OnClientClick="this.disabled = true; this.value = 'Submitting...';"   UseSubmitBehavior="false" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </li>
			<li id="footer"><p>Copyright &copy; 2013  Frootaxi , All rights reserved.</p></li>
		</ul>
	</fieldset>
</asp:Content>