<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavigationBar.ascx.cs" Inherits="SalesSystemWebSite.UserControls.NavigationBar" %>

<script>
    $(document).ready(function () {
        $('.navbar .dropdown').hover(function () {
            $(this).find('.dropdown-menu').first().stop(true, true).slideDown(150);
        }, function () {
            $(this).find('.dropdown-menu').first().stop(true, true).slideUp(105)
        });
    });
</script>

<nav class="navbar navbar-dark navbar-expand-sm" style="background-color: black">
    <asp:HyperLink ID="HomeLink" CssClass="navbar-brand" runat="server"><i class="fa fa-home" aria-hidden="true"></i>&nbsp;מונטקיו רוג תעשיות בע"מ</asp:HyperLink>    
    &nbsp;
    &nbsp;
    &nbsp;
    <i class="navbar-brand" style="cursor: text; color: #6c757d;">שלום,
        <b><asp:Label ID="userName" runat="server"></asp:Label></b>
        (<i><asp:Label ID="userRole" runat="server"></asp:Label></i>)
    </i>
    <div class="collapse navbar-collapse " id="navbarNavDropdown">
        <ul class="navbar-nav mr-auto">
            <asp:MultiView ID="navMltv" runat="server">
                <asp:View ID="dealerView" runat="server">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">הזמנות</a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink1">
                            <a class="dropdown-item" href="../../../Dealer/Orders/Upsert.aspx">הזמנה חדשה</a>
                            <a class="dropdown-item" href="../../../Dealer/Orders/Search.aspx">חיפוש הזמנות</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">לקוחות</a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink2">
                            <a class="dropdown-item" href="../../../Dealer/Customers/Upsert.aspx">לקוח חדש</a>
                            <a class="dropdown-item" href="../../../Dealer/Customers/Search.aspx">חיפוש לקוחות</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">קטלוג</a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink3">
                            <a class="dropdown-item" href="#">כל המוצרים</a>
                            <a class="dropdown-item" href="#">פרזול</a>
                            <a class="dropdown-item" href="#">מטחות</a>
                            <a class="dropdown-item" href="#">קנטים</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink4" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">דוחות</a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink4">
                            <a class="dropdown-item" href="#">דוח הזמנות</a>
                            <a class="dropdown-item" href="#">דוח לקוחות</a>
                            <a class="dropdown-item" href="#">דוח יעדים</a>
                        </div>
                    </li>
                </asp:View>
                <asp:View ID="managerView" runat="server">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink6" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">מלאי</a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink6">
                            <a class="dropdown-item" href="#">עדכון מלאי לפריט</a>
                            <a class="dropdown-item" href="#">יצירת ספירת מלאי</a>
                            <a class="dropdown-item" href="#">צפיה בסירת מלאי</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink7" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">קטלוג</a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink7">
                            <a class="dropdown-item" href="../../../Manager/Items/Upsert.aspx">יצירת פריט חדש</a>
                            <a class="dropdown-item" href="../../../Manager/Items/Search.aspx">עדכון פריט קיים</a>
                            <a class="dropdown-item" href="#">מוצרים לפי קטגוריות</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink8" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">דוחות</a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink8">
                            <a class="dropdown-item" href="../../../Manager/Orders/Search.aspx">דוח ליקוטים תקופתי</a>
                            <a class="dropdown-item" href="#">דוח תפוקות למלקט</a>
                        </div>
                    </li>
                </asp:View>
            </asp:MultiView>
            <li class="nav-item dropdown">
                <a class="nav-link" href="../../../Login.aspx" id="navbarDropdownMenuLink9"><u>התנתק</u></a>
            </li>
        </ul>
    </div>
</nav>
