<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Upsert.aspx.cs" Inherits="SalesSystemWebSite.Dealer.Customers.Upsert" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
        loaded
    </style>
</asp:Content>
<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <div class="card mainForm">
        <div class="card-header">
            <h3>יצירת לקוח חדש</h3>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h3>כללי</h3>
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <asp:Panel ID="IdWraper" runat="server">
                            <div class="col">
                                <asp:TextBox CssClass="form-control" ID="Id" disabled="disabled" runat="server"></asp:TextBox>
                            </div>
                        </asp:Panel>
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Name" runat="server" placeholder="שם לקוח"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:HiddenField ID="DealerIdHidden" runat="server" />
                            <asp:TextBox CssClass="form-control" ID="DealerName" disabled="disabled" runat="server"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:DropDownList ID="Status" CssClass="form-control" runat="server">
                                <asp:ListItem Text="פעיל" Value="0" />
                                <asp:ListItem Text="לא פעיל" Value="1" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:HiddenField ID="CityHidden" runat="server" />
                        <div class="col">
                            <asp:DropDownList ID="City" CssClass="form-control loaded" DataValueField="Value" DataTextField="Text" runat="server" ></asp:DropDownList>
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Street" runat="server" placeholder="רחוב"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Zip" runat="server" placeholder="מיקוד"></asp:TextBox>
                        </div>
                        <div class="col"></div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <h3>אנשי קשר</h3>
                </div>
                <div class="card-body">
                    <div class="card">
                        <div class="card-header">
                            <asp:HiddenField ID="Contact1IdHidden" runat="server" />
                            <h3>איש קשר 1</h3>
                        </div>
                        <div class="card-body">
                            <div class="form-group row">
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact1FirstName" runat="server" placeholder="שם פרטי"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact1LastName" runat="server" placeholder="שם משפחה"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact1Job" runat="server" placeholder="תפקיד"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact1OfficePhone" runat="server" placeholder="טלפון משרד"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact1CellPhone" runat="server" placeholder="טלפון נייד"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact1Email" runat="server" placeholder="מייל"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <asp:HiddenField ID="Contact2IdHidden" runat="server" />
                            <h3>איש קשר 2</h3>
                        </div>
                        <div class="card-body">
                            <div class="form-group row">
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact2FirstName" runat="server" placeholder="שם פרטי"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact2LastName" runat="server" placeholder="שם משפחה"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact2Job" runat="server" placeholder="תפקיד"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact2OfficePhone" runat="server" placeholder="טלפון משרד"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact2CellPhone" runat="server" placeholder="טלפון נייד"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <asp:TextBox CssClass="form-control" ID="Contact2Email" runat="server" placeholder="מייל"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <h3>נתונים פיננסים</h3>
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Bank" runat="server" placeholder="בנק"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Branch" runat="server" placeholder="סניף"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Account" runat="server" placeholder="חשבון"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Credit" runat="server" placeholder="מסגרת אשראי"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="CreditLeft" runat="server" placeholder="יתרת מסגרת"></asp:TextBox>
                        </div>
                        <div class="col"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <asp:Button CssClass="btn btn-success float-left mx-2" Text="שמור" ID="MainBtn" OnClick="MainBtn_Click" runat="server" />
            <a href="../Dashboard.aspx" class="btn btn-danger float-left mx-2">ביטול</a>
        </div>
    </div>
</asp:Content>
