<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="RecruiterManagement.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <title>Login - RecruitManager</title>
</head>
<body>
    <div class="min-h-screen bg-gray-100 flex items-center justify-center p-4">
        <div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8">
            <h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">Recruitmanager Sign In</h2>
            <form runat="server" class="space-y-4">
                <div>
                    <asp:Label ID="lblEmail" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Email</asp:Label>
                    <asp:TextBox
                        ID="txtEmail"
                        runat="server"
                        type="email"
                        CssClass="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="your@email.com" />
                </div>

                <div>
                    <asp:Label ID="lblPassword" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Password</asp:Label>
                    <asp:TextBox
                        ID="txtPassword"
                        runat="server"
                        type="password"
                        CssClass="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="••••••••" />
                </div>

                <div>
                    <asp:Label runat="server"  ID="lblError" CssClass="text-red-500 text-center" Text=""/>
                </div>

                <asp:Button runat="server" Text="Sign In" ID="btnSubmit" CssClass="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2.5 rounded-lg transition-colors" OnClick="btnSignIn_Click"/>
            </form>
        </div>
    </div>
</body>
</html>
