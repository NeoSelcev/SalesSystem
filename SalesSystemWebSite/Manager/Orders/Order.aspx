<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="SalesSystemWebSite.Manager.Orders.Order" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
    </style>
</asp:Content>

<asp:Content ID="HeadScriptPlaceHolder" ContentPlaceHolderID="HeadScriptPlaceHolder" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.actualAmount').change(function () {
                validateStock();
            });

            function validateStock() {
                var invalid = false;
                $('.itemRow').each(function () {
                    if (parseInt($(this).find('.actualAmount').val()) > parseInt($(this).find('.itemAvailable').text())) {
                        invalid = true;
                        $('#amountErrorModal').modal();
                    }
                });
                $('.saveBtn').prop('disabled', invalid);
            }
        });
    </script>
</asp:Content>

<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <div class="card mainForm">
        <div class="card-header">
            <h3>ליקוט הזמנה מספר:
                <u>
                    <asp:Label ID="OrderId" runat="server"></asp:Label></u>
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
                                    <asp:DropDownList ID="Status" CssClass="form-control loaded" runat="server">
                                        <asp:ListItem Text="סטטוס"></asp:ListItem>
                                        <asp:ListItem Value="0" Text="הזמנה חדשה"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="ממתין לליקוט"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="הזמנה לוקטה"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="הזמנה הסתיימה"></asp:ListItem>
                                    </asp:DropDownList>
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
                                <th>מיקום במחסן</th>
                                <th>כמות מוזמנת</th>
                                <th>כמות מלוקטת</th>
                                <th>זמין במלאי</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="OrderItemsRpt" runat="server" OnItemDataBound="OrderItemsRpt_ItemDataBound">
                                <ItemTemplate>
                                    <tr class="itemRow">
                                        <td>
                                            <asp:HiddenField ID="Id" runat="server" />
                                            <asp:Label ID="Sku" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Name" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Image ID="Image" runat="server" Style="width: 50px;" />
                                        </td>
                                        <td>
                                            <asp:Label ID="WarehousePlace" runat="server"></asp:Label>                                            
                                        </td>
                                        <td>
                                            <asp:Label ID="Amount" runat="server" ></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox CssClass="form-control actualAmount" ID="ActualAmount" runat="server" Text="0" placeholder="כמות מלוקטת"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="Available" CssClass="itemAvailable" runat="server"></asp:Label>
                                        </td>                                        
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <asp:Button CssClass="btn btn-success float-left mx-2 saveBtn" Text="שמור" ID="SaveBtn" OnClick="SaveBtn_Click" runat="server" EnableViewState="true" />
            <asp:HyperLink ID="ToSearch" CssClass="btn btn-warning float-left mx-2" runat="server">חזרה לדף חיפוש הזמנות</asp:HyperLink>
        </div>
    </div>

    <div class="modal fade" id="amountErrorModal" tabindex="-1" role="dialog" aria-labelledby="amountErrorModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">שגיאה</h5>
                </div>
                <div class="modal-body">
                    כמות מלוקטת לא יכולה להיות גדולה יותר ממה שקיים במלאי
                </div>
            </div>
        </div>
    </div>
</asp:Content>
