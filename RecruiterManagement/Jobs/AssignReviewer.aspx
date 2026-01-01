<%@ Page Title="Jobs Page" Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Site.Master" CodeBehind="AssignReviewer.aspx.cs"
    Inherits="RecruiterManagement.Jobs.AssignReviewer" %>

<asp:Content ID="assignReviewerContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="p-3 flex flex-col gap-2">
        <div class="text-xl font-medium">Assign Reviewer Selected id:</div>
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
                <tbody>
                    <%
                        ReviewersList.ForEach((reviewer) =>
                        {
                    %>
                    <tr class="bg-white border-b border-gray-200">
                        <td class="px-6 py-4"><%= reviewer.Id%>
                        </td>
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= reviewer.Name %>
                        </th>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= reviewer.Email %>
                        </td>
                        <td class="px-6 py-4">
                            <asp:Button runat="server"
                                CommandName="AssignReviewer"
                                CommandArgument='<%# Eval("id") %>'
                                OnCommand="btnAssign_Command"
                                class="text-decoration-none font-medium border border-primary p-1 px-2 rounded-sm" Text="Assign" />
                        </td>
                    </tr>
                    <%
                        });
                    %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
