<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="SalesSystemWebSite.Dealer.Orders.Order" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
    </style>
</asp:Content>
<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <div class="card mainForm">
        <div class="card-header">
            <h3>פרטי הזמנה
                <u><asp:Label ID="OrderId" runat="server"></asp:Label></u>
            </h3>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h3>כללי</h3>
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <div class="col">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><u>מספר לקוח:</u></label>
                                <div class="col-sm-9">
                                    <label class="form-control" disabled="disabled">
                                        <asp:HyperLink ID="CustomerId" runat="server"></asp:HyperLink>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><u>שם לקוח:</u></label>
                                <div class="col-sm-9">
                                    <asp:TextBox CssClass="form-control" ID="CustomerName" disabled="disabled" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><u>סטטוס:</u></label>
                                <div class="col-sm-9">
                                    <asp:TextBox CssClass="form-control" ID="Status" disabled="disabled" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <h3>פרטים בהזמנה</h3>
                </div>
                <div class="card-body">
                    <table class="pageTable table table-bordered">
                        <thead class="thead-dark">
                            <tr>
                                <th>מק"ט</th>
                                <th>שם</th>
                                <th>תמונה</th>
                                <th>כמות מוזמנת</th>
                                <th>כמות מלוקטת</th>
                                <th>מחיר ליחידה</th>
                                <th>סה"כ מחיר</th>
                                <th>מלאי זמין</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="OrderItemsRpt" runat="server" OnItemDataBound="OrderItemsRpt_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Sku" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Name" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Image ID="Image" runat="server" Style="width: 50px;" />
                                        </td>
                                        <td>
                                            <asp:Label ID="Amount" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="ActualAmount" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Price" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="TotalPrice" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Available" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <h3>סיכום</h3>
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">סה"כ מחיר להזמנה:</label>
                        <div class="col-sm-2">
                            <asp:TextBox CssClass="form-control" ID="OrderPrice" runat="server" disabled="disabled"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">אחוז הנחה:</label>
                        <div class="col-sm-2">
                            <asp:TextBox CssClass="form-control" ID="Discount" runat="server" disabled="disabled"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">סה"כ מחיר להזמנה לאחר הנחה:</label>
                        <div class="col-sm-2">
                            <asp:TextBox CssClass="form-control" ID="FinalOrderPrice" runat="server" disabled="disabled"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <asp:HyperLink ID="Upsert" CssClass="btn btn-success float-left mx-2" Text="עדכון הזמנה" runat="server"></asp:HyperLink>
        </div>
    </div>
</asp:Content>
