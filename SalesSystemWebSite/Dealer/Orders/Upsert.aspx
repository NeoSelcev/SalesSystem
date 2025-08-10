<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Upsert.aspx.cs" Inherits="SalesSystemWebSite.Dealer.Orders.Upsert" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
        .modal { text-align: right; }
    </style>
</asp:Content>

<asp:Content ID="HeadScriptPlaceHolder" ContentPlaceHolderID="HeadScriptPlaceHolder" runat="server">
    <script type="text/javascript">
        function showSearchResult() {
            $('#findItemModal').modal();
        }

        $(document).ready(function () {
            $('.itemAmount').change(function () {
                updatePrice();
                validateStock();
            });

            $('.orderDiscount').change(function () {
                updatePrice();
            });            

            function updatePrice() {
                var totalPrice = 0;
                $('.itemRow').each(function () {
                    totalPrice += (parseFloat($(this).find('.itemPrice').text()) * parseFloat($(this).find('.itemAmount').val()));
                });
                $('.orderPrice').val(totalPrice);
                $('.finalOrderPrice').val(totalPrice * ((100 - parseFloat($('.orderDiscount').val())) / 100));
                
            }

            function validateStock() {
                var invalid = false;
                $('.itemRow').each(function () {
                    if (parseInt($(this).find('.itemAmount').val()) > parseInt($(this).find('.itemAvailable').text())) {
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
            <h3>יצירת הזמנה חדשה</h3>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h3>כללי</h3>
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <asp:Panel ID="OrderIdWrap" CssClass="col" runat="server" Visible="false">
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label"><u>מספר הזמנה:</u></label>
                                <div class="col-sm-8">
                                    <asp:HiddenField ID="OrderIdHidden" runat="server" />
                                    <asp:TextBox CssClass="form-control" ID="OrderId" disabled="disabled" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </asp:Panel>
                        <div class="col">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><u>שם לקוח:</u></label>
                                <div class="col-sm-9">
                                    <asp:HiddenField ID="CustomerIdHidden" runat="server" />
                                    <asp:TextBox CssClass="form-control" ID="Customer" disabled="disabled" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label"><u>סטטוס:</u></label>
                                <div class="col-sm-9">
                                    <asp:HiddenField ID="StatusHidden" Value="0" runat="server" />
                                    <asp:TextBox CssClass="form-control" ID="Status" disabled="disabled" runat="server" Text="הזמנה חדשה"></asp:TextBox>
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
                                <th>תיאור</th>
                                <th>תמונה</th>
                                <th>כמות</th>
                                <th>מחיר ליחידה</th>
                                <th>סה"כ מחיר</th>
                                <th>מלאי זמין</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="OrderItemsRpt" runat="server" OnItemDataBound="OrderItemsRpt_ItemDataBound">
                                <ItemTemplate>
                                    <tr class="itemRow">
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
                                            <asp:TextBox CssClass="form-control itemAmount" ID="Amount" runat="server" Text="0" placeholder="כמות"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="Price" CssClass="itemPrice" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="TotalPrice" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Available" CssClass="itemAvailable" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="DeleteOrderItemBtn" runat="server" OnClick="DeleteOrderItemBtn_Click" EnableViewState="true">
                                                <i class="fa fa-trash" aria-hidden="true"></i>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="8">
                                    <button type="button" class="btn btn-info float-left" data-toggle="modal" data-target="#findItemModal">הוסף פריט</button>
                                </td>
                            </tr>
                        </tfoot>
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
                            <asp:TextBox CssClass="form-control orderPrice" ID="OrderPrice" runat="server" disabled="disabled"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">אחוז הנחה:</label>
                        <div class="col-sm-2">
                            <asp:TextBox CssClass="form-control orderDiscount" ID="Discount" runat="server" placeholder="אחוז הנחה" Text="0"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label">סה"כ מחיר להזמנה לאחר הנחה:</label>
                        <div class="col-sm-2">
                            <asp:TextBox CssClass="form-control finalOrderPrice" ID="FinalOrderPrice" runat="server" disabled="disabled"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <asp:Button CssClass="btn btn-success float-left mx-2 saveBtn" Text="שמור" ID="SaveBtn" OnClick="SaveBtn_Click" runat="server" EnableViewState="true" />
            <a href="../Dashboard.aspx" class="btn btn-danger float-left mx-2">ביטול</a>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="findItemModal" tabindex="-1" role="dialog" aria-labelledby="findItemModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">חפש פריט לפי:</h5>
                </div>
                <div class="modal-body">
                    <div class="card-body">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">מק"ט:</label>
                            <div class="col-sm-10">
                                <asp:TextBox CssClass="form-control" ID="SearchSku" runat="server" placeholder="מק''ט"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">שם פריט:</label>
                            <div class="col-sm-10">
                                <asp:TextBox CssClass="form-control" ID="SearchName" runat="server" placeholder="שם פריט"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <asp:Button CssClass="btn btn-info" Text="חפש" ID="SearchBtn" OnClick="SearchBtn_Click" runat="server" />
                    <asp:Panel ID="SearchResult" runat="server" Visible="false">
                        <div class="searchResult">
                            <hr />
                            <table class="pageTable table table-bordered">
                                <thead class="thead-dark">
                                    <tr>
                                        <th></th>
                                        <th>מק"ט</th>
                                        <th>שם</th>
                                        <th>תמונה</th>
                                        <th>מחיר ליחידה</th>
                                        <th>מלאי זמין</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="SearchItemsRpt" runat="server" OnItemDataBound="SearchItemsRpt_ItemDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="AddChB" runat="server" />
                                                </td>
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
                                                    <asp:Label ID="Price" runat="server"></asp:Label>
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
                    </asp:Panel>
                </div>
                <div class="modal-footer">
                    <asp:Button CssClass="btn btn-danger mx-2" Text="ביטול" ID="CancelSearch" OnClick="CancelSearch_Click" runat="server" EnableViewState="true" />
                    <asp:Button CssClass="btn btn-success mx-2" Text="הוסף פריט" ID="AddItems" OnClick="AddItems_Click" runat="server" EnableViewState="true" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="amountErrorModal" tabindex="-1" role="dialog" aria-labelledby="amountErrorModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">שגיאה</h5>
                </div>
                <div class="modal-body">
                    כמות כל פריט בהזמנה לא יכול להיות גדולה יותר ממה שקיים במלאי
                </div>
            </div>
        </div>
    </div>
</asp:Content>
