<%@ Page Title="AssignReviewer Page" Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Site.Master" CodeBehind="AssignReviewer.aspx.cs"
    Inherits="RecruiterManagement.Jobs.AssignReviewer" %>

<asp:Content ID="assignReviewerContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="p-3 flex flex-col gap-2">
        <div class="text-xl font-medium">Assign Reviewer</div>
        <div class="relative overflow-x-auto">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 border">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 !border-b-2">
                    <tr>
                        <th scope="col" class="px-6 py-3">Id</th>
                        <th scope="col" class="px-6 py-3">Name</th>
                        <th scope="col" class="px-6 py-3">Email</th>
                        <th scope="col" class="px-6 py-3">Actions</th>
                    </tr>
                </thead>
                <asp:Repeater ID="rptReviewers" runat="server" OnItemDataBound="rptReviewers_ItemDataBound">
                    <ItemTemplate>
                        <tr class="bg-white border-b border-gray-200">
                            <td class="px-6 py-4">
                                <%# Eval("id") %>
                            </td>

                            <td class="px-6 py-4 font-medium text-gray-900">
                                <%# Eval("name") %>
                            </td>

                            <td class="px-6 py-4 font-medium text-gray-900">
                                <%# Eval("email") %>
                            </td>

                            <td class="px-6 py-4">
                                <asp:Label
                                    ID="lblAssigned"
                                    runat="server"
                                    CssClass="border border-muted text-muted p-2 rounded-md"
                                    Text="Assigned"
                                    Visible="false" />

                                <asp:Button
                                    ID="btnAssign"
                                    runat="server"
                                    Text="Assign"
                                    CssClass="text-decoration-none font-medium border border-primary p-1 px-2 rounded-sm"
                                    CommandName="AssignReviewer"
                                    CommandArgument='<%# Eval("Id") %>'  />

                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Label ID="lblTest" runat="server" />
            </table>
        </div>
    </div>
</asp:Content>
