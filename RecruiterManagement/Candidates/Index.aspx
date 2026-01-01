<%@ Page Title="Candidates Page" Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="RecruiterManagement.Candidates.Index" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="flex flex-col gap-3 p-5">
        <div class="flex items-center justify-between">
            <div class="font-semibold text-xl">
                All Candidates
            </div>
            <div class="flex items-center gap-2">
                <a href="/Candidates/BulkUpload" class="text-decoration-none border  border-gray-700 p-2 px-3 !rounded-sm !text-gray-700">Bulk Upload</a>
                <a href="/Candidates/Add" class="text-decoration-none bg-gray-700 p-2 px-3 !rounded-sm text-white">Add Candidate</a>
            </div>
        </div>
        <div class="relative overflow-x-auto">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 border">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 !border-b-2">
                    <tr>
                        <th scope="col" class="px-6 py-3">Id
                        </th>
                        <th scope="col" class="px-6 py-3">Name
                        </th>
                        <th scope="col" class="px-6 py-3">Email
                        </th>
                        <th scope="col" class="px-6 py-3">Phone
                        </th>
                        <th scope="col" class="px-6 py-3">Gender
                        </th>
                        <th scope="col" class="px-6 py-3">Date Of Birth
                        </th>
                        <th scope="col" class="px-6 py-3">Address
                        </th>
                        <th scope="col" class="px-6 py-3">City
                        </th>
                        <th scope="col" class="px-6 py-3">State
                        </th>
                        <th scope="col" class="px-6 py-3">Education
                        </th>
                        <th scope="col" class="px-6 py-3">Experience in Years
                        </th>
                        <th scope="col" class="px-6 py-3">Current Position
                        </th>
                        <th scope="col" class="px-6 py-3">Expected Salary
                        </th>
                        <th scope="col" class="px-6 py-3">Skills
                        </th>
                        <th scope="col" class="px-6 py-3">Status
                        </th>
                        <th scope="col" class="px-6 py-3">Actions
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        candidatesList.ForEach((candidate) =>
                        {
                    %>
                    <tr class="bg-white border-b border-gray-200">
                        <td class="px-6 py-4"><%= candidate.ID%>
                        </td>
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Name %>
                        </th>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Email%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Phone%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Gender%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Date_Of_Birth%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Address%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.City%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.State%>
                        </td>

                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Education%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Experience_Years%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Current_Position%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Expected_Salary%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 max-w-[300px] text-ellipsis whitespace-nowrap overflow-hidden" title=" <%= candidate.Skills%>">
                            <%= candidate.Skills%>
                        </td>
                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= candidate.Status%>
                        </td>
                        <td class="px-6 py-4 min-w-max flex items-center justify-center gap-2">
                            <a href="/Candidates/Update?id=<%=candidate.ID %>" class="text-decoration-none font-medium border border-primary p-1 px-2 rounded-sm min-w-max">Update</a>
                            <a href="/Candidates/Delete?id=<%=candidate.ID %>" class="text-decoration-none font-medium border !border-red-500 !text-red-500 p-1 px-2 rounded-sm min-w-max" onclick="return confirm('Are you sure you want to delete?');">Delete</a>
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
