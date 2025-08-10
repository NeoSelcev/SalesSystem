<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AnonymousMasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SalesSystemWebSite.Login" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { width: 745px; height: 469px; text-align: right; margin: 0; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); }
        .card .card-header { text-align: center; }
        .card .card-body { }
        .card .card-body .form-group { }
        .card .card-body .form-group .forgotPass { color: #007bff; text-decoration: underline; cursor: pointer; font-size: 0.9em; }
        .modal { text-align: right; }
    </style>
</asp:Content>

<asp:Content ID="HeadScriptPlaceHolder" ContentPlaceHolderID="HeadScriptPlaceHolder" runat="server">
    <script type="text/javascript">
        function showError(type) {
            $('#loginErrorModal').modal()
        }
    </script>
</asp:Content>

<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <asp:Panel ID="MainPanel" runat="server" DefaultButton="MainBtn">
        <div class="card loginForm">
            <div class="card-header">
                <h3>התחברות</h3>
            </div>
            <div class="card-body">
                <div class="form-group row">
                    <div class="col-5">
                        <img src="Styles/Images/images.png" />
                    </div>
                    <div class="col-7">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"></label>
                        </div>
                        <div class="form-group row">
                            <label for="userName" class="col-sm-4 col-form-label">שם משתמש</label>
                            <div class="col-sm-7">
                                <asp:TextBox CssClass="form-control" ID="inputUserName" runat="server" placeholder="שם משתמש">dealer@gmail.com</asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputPassword" class="col-sm-4 col-form-label">סיסמא</label>
                            <div class="col-sm-7">
                                <asp:TextBox CssClass="form-control" ID="inputPassword" runat="server" placeholder="סיסמא" TextMode="Password">d123456</asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-11 col-form-label forgotPass">שכחת סיסמא?</label>
                        </div>
                    </div>
                </div>
                <div class="form-group row col-12 btn">
                    <asp:Button ID="MainBtn" CssClass="btn btn-info" Text="הכנס" OnClick="MainBtn_ServerClick" runat="server" />
                </div>
            </div>
        </div>
    </asp:Panel>
    <div class="modal fade" id="loginErrorModal" tabindex="-1" role="dialog" aria-labelledby="loginErrorModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">שגיאה</h5>
                </div>
                <div class="modal-body">
                    שם משתמש או סיסמה לא תקינים
                </div>
            </div>
        </div>
    </div>
</asp:Content>
