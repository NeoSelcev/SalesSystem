<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="SalesSystemWebSite.Dealer.Customers.Customer" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
    </style>
</asp:Content>

<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <div class="card mainForm">
        <div class="card-header">
            <h3>מספר לקוח: 
                <u><asp:Label ID="IdSbj" runat="server"></asp:Label></u>
                שם לקוח: 
                <u><asp:Label ID="NameSbj" runat="server"></asp:Label></u>
            </h3>
        </div>
        <div class="card-body">
            <div>
                <ul class="nav nav-pills nav-fill">
                    <li class="nav-item">
                        <asp:HyperLink CssClass="nav-link" ID="tabPrivateDetails" runat="server">נתונים כללים</asp:HyperLink>
                    </li>
                    <li class="nav-item">
                        <asp:HyperLink CssClass="nav-link" ID="tabOrders" runat="server">הזמנות</asp:HyperLink>
                    </li>
                </ul>
            </div>
            <asp:MultiView ID="customerMltv" runat="server">
                <asp:View ID="viewPrivateDetails" runat="server">
                    <div class="card">
                        <div class="card-header">
                            <h3>כללי</h3>
                        </div>
                        <div class="card-body">
                            <div class="form-group row">
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>מספר לקוח:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="Id" disabled="disabled" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>שם לקוח:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="Name" runat="server" disabled="disabled"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>שם סוכן:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="DealerName" disabled="disabled" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>סטטוס:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="Status" disabled="disabled" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>עיר:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="City" disabled="disabled" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>רחוב:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="Street" runat="server" disabled="disabled"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>מיקוד:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="Zip" runat="server" disabled="disabled"></asp:TextBox>
                                        </div>
                                    </div>
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
                                    <h3>איש קשר 1</h3>
                                </div>
                                <div class="card-body">
                                    <div class="form-group row">
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>שם פרטי:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact1FirstName" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>שם משפחה:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact1LastName" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>תפקיד:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact1Job" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>טלפון משרד:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact1OfficePhone" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>טלפון נייד:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact1CellPhone" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>מייל:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact1Email" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header">
                                    <h3>איש קשר 2</h3>
                                </div>
                                <div class="card-body">
                                    <div class="form-group row">
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>שם פרטי:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact2FirstName" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>שם משפחה:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact2LastName" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>תפקיד:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact2Job" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>טלפון משרד:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact2OfficePhone" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>טלפון נייד:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact2CellPhone" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"><u>מייל:</u></label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox CssClass="form-control" ID="Contact2Email" runat="server" disabled="disabled"></asp:TextBox>
                                                </div>
                                            </div>
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
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>בנק:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="Bank" runat="server" disabled="disabled"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>סניף:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="Branch" runat="server" disabled="disabled"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>חשבון:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="Account" runat="server" disabled="disabled"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>מסגרת אשראי:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="Credit" runat="server" disabled="disabled"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label"><u>יתרת מסגרת:</u></label>
                                        <div class="col-sm-8">
                                            <asp:TextBox CssClass="form-control" ID="CreditLeft" runat="server" disabled="disabled"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col"></div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <asp:HyperLink CssClass="btn btn-info float-left" ID="UpsertBtn" runat="server">עדכון פרטים</asp:HyperLink>
                </asp:View>
                <asp:View ID="viewOrders" runat="server">
                    <div class="card">
                        <div class="card-header">
                            <h3>פירוט הזמנות</h3>
                        </div>
                        <div class="card-body">
                            <asp:Panel ID="OrdersResult" runat="server" Visible="false">
                                <table class="pageTable table table-bordered">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">מספר הזמנה</th>
                                            <th scope="col">תאריך הזמנה</th>
                                            <th scope="col">תאריך הספקה</th>
                                            <th scope="col">סטטוס</th>
                                            <th scope="col">שווי הזמנה</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="CustomerOrdersRpt" runat="server" OnItemDataBound="CustomerOrdersRpt_ItemDataBound">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:HyperLink ID="OrderLink" Target="_blank" runat="server"></asp:HyperLink>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="DateCreated" runat="server"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="ShipmentDate" runat="server"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Status" runat="server"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="TotalPrice" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </asp:Panel>
                        </div>
                        <div class="card-footer">
                            <asp:HyperLink CssClass="btn btn-info float-left" ID="NewOrderBtn" runat="server">צור הזמנה חדשה</asp:HyperLink>
                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>
        </div>
    </div>
</asp:Content>
