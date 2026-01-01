<%@ Page Title="Jobs Page" Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Site.Master" CodeBehind="Index.aspx.cs"
    Inherits="RecruiterManagement.Jobs.Index" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex flex-col gap-3 p-5">
        <div class="flex items-center justify-between">
            <div class="font-semibold text-xl">All Jobs</div>
            <a
                href="/Jobs/Add"
                class="text-decoration-none bg-gray-700 p-2 px-3 !rounded-sm text-white">Add Job</a>
        </div>
        <div class="relative overflow-x-auto">
            <table
                class="w-full text-sm text-left rtl:text-right text-gray-500 border">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 !border-b-2">
                    <tr>
                        <th scope="col" class="px-6 py-3">Id</th>
                        <th scope="col" class="px-6 py-3">Name</th>
                        <th scope="col" class="px-6 py-3">Type</th>
                        <th scope="col" class="px-6 py-3">Salary From</th>
                        <th scope="col" class="px-6 py-3">Salary To</th>
                        <th scope="col" class="px-6 py-3">Stipend</th>
                        <th scope="col" class="px-6 py-3">Description</th>
                        <th scope="col" class="px-6 py-3">Required Skills</th>
                        <th scope="col" class="px-6 py-3">Preferred Skills</th>
                        <th scope="col" class="px-6 py-3">Status</th>
                        <th scope="col" class="px-6 py-3">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% JobsList.ForEach((job) =>
                        { %>
                    <tr class="bg-white border-b border-gray-200">
                        <td class="px-6 py-4"><%= job.Id%></td>
                        <th
                            scope="row"
                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                            <%= job.Name %>
                        </th>
                        <td
                            scope="row"
                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                            <%= job.Type %>
                        </td>

                        <td
                            scope="row"
                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                            <%= job.SalaryFrom %>
                        </td>
                        <td
                            scope="row"
                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                            <%= job.SalaryTo %>
                        </td>
                        <td
                            scope="row"
                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                            <%= job.Stipend %>
                        </td>
                        <td
                            scope="row"
                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                            <%= job.Description %>
                        </td>
                        <td
                            scope="row"
                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap max-w-[200px] text-ellipsis whitespace-nowrap overflow-hidden" title=" <%= job.Required_Skills %>">
                            <%= job.Required_Skills%>
                        </td>
                        <td
                            scope="row"
                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap max-w-[200px] text-ellipsis whitespace-nowrap overflow-hidden" title=" <%= job.Preferred_Skills %>">
                            <%= job.Preferred_Skills %>
                        </td>
                        <td
                            scope="row"
                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap <%=job.Status == "OPEN"?"text-green-500": job.Status == "HOLD"?"text-orange-500": "text-red-500" %>">
                            <%= job.Status %>
                        </td>

                        <td class="px-6 py-4 flex min-w-max gap-2">
                            <a
                                href="/Jobs/Update?id=<%=job.Id %>"
                                class="text-decoration-none font-medium border border-primary p-1 px-2 rounded-sm">Update</a>
                            <a
                                href="/Jobs/Delete?id=<%=job.Id %>"
                                class="text-decoration-none font-medium border !border-red-500 !text-red-500 p-1 px-2 rounded-sm"
                                onclick="return confirm('Are you sure you want to delete?');">Delete</a>
                            <a
                                href="/Jobs/ChangeStatus?id=<%=job.Id %>"
                                class="text-decoration-none font-medium border !border-gray-500 !text-gray-500 p-1 px-2 rounded-sm">Change Status</a>
                            <a
                                href="/Jobs/AssignReviewer?id=<%=job.Id %>"
                                class="text-decoration-none font-medium border !border-gray-500 !text-gray-500 p-1 px-2 rounded-sm">Assign Reviewer</a>
                        </td>
                    </tr>
                    <% }); %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
