<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Review.aspx.cs" Inherits="RecruiterManagement.Review" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <title>Review Jobs Profile</title>
</head>
<body>
    <form id="form1" runat="server" class="px-4">
        <div class="flex gap-2 text-center py-4 justify-between">
            <div class="text-2xl font-bold">Review CVs</div>
            <div class="flex items-center gap-3">
                <a href="/Logout"
                    class="px-4 text-center text-black text-decoration-none bg-gray-200 hover:bg-gray-300 text-gray-800 py-2 rounded-lg font-medium transition w-max">Logout</a>
                <a href="/Profile"
                    class="px-4 text-center text-black text-decoration-none bg-gray-900 hover:bg-gray-800 text-gray-300 py-2 rounded-lg font-medium transition w-max">Profile</a>
            </div>
        </div>
        <% if (isAssignedAnyJob)
            {
        %>
        <div class="flex bg-gray-100 rounded-md p-2 flex-col">
            <div class="text-center text-xl font-semibold">Job Details</div>
            <div class="flex items-start justify-between gap-4 mt-5">
                <div class="flex flex-col gap-3">
                    <div class="font-semibold text-gray-700">
                        Title: <span runat="server" id="jobTitle" class="text-black font-normal" />
                    </div>
                    <div class="font-semibold text-gray-700">
                        Description: <span runat="server" id="jobDesc" class="text-black font-normal" />
                    </div>
                    <div class="font-semibold text-gray-700">
                        Status: <span runat="server" id="statusText" class="text-black font-normal" />
                    </div>
                    <div class="font-semibold text-gray-700">
                        Job Type: <span runat="server" id="jobType" class="text-black font-normal" />
                    </div>
                    <div class="font-semibold text-gray-700">
                        Stipend: <span runat="server" id="stipend" class="text-black font-normal" />
                    </div>
                    <div class="font-semibold text-gray-700">
                        Salary Range: <span runat="server" id="salary_range" class="text-black font-normal" />
                    </div>
                    <div class="font-semibold text-gray-700">
                        Required Skills: <span runat="server" id="requiredSkils" class="text-black font-normal" />
                    </div>
                    <div class="font-semibold text-gray-700">
                        Preferred Skills: <span runat="server" id="preferredSkills" class="text-black font-normal" />
                    </div>
                </div>
            </div>
        </div>

        <div class="my-2 mt-4 text-xl font-medium text-center">Applied Candidates</div>
        <div class="overflow-x-auto bg-whiterounded-lg shadow">
            <table class="min-w-full border border-gray-200">
                <thead class="bg-gray-100">
                    <tr>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">#
                        </th>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Name
                        </th>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Email
                        </th>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Phone
                        </th>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Resume
                        </th>
                        <th class="px-4 py-3 text-left text-sm font-semibold text-gray-700">Status
                        </th>
                        <th class="px-4 py-3 text-center text-sm font-semibold text-gray-700">Action
                        </th>
                    </tr>
                </thead>

                <tbody class="divide-y divide-gray-200">
                    <asp:Repeater ID="rptCandidates" runat="server">
                        <ItemTemplate>
                            <tr class="hover:bg-gray-50">
                                <td class="px-4 py-3 text-sm text-gray-600">1</td>
                                <td class="px-4 py-3 text-sm font-medium text-gray-900">
                                    <%# Eval("name") %>
                                </td>
                                <td class="px-4 py-3 text-sm text-gray-600">
                                    <%# Eval("email") %>
                                </td>
                                <td class="px-4 py-3 text-sm text-gray-600">
                                    <%# Eval("phone") %>
                                </td>
                                <td class="px-4 py-3 text-sm">
                                    <a <%# String.IsNullOrEmpty(Eval("cv_file_name").ToString()) ? "hidden" : "" %> href="/ViewCV.aspx?file=<%# Eval("cv_file_name") %>" target="_blank" class="text-blue-600 hover:underline">View Resume
                                    </a>

                                    <div <%# String.IsNullOrEmpty(Eval("cv_file_name").ToString()) ? "" : "hidden" %> class="flex flex-col gap-1">
                                        <div>
                                            Resume not uploaded
                                        </div>
                                        <asp:Button
                                            runat="server"
                                            ID="sendReminderBtn"
                                            CommandName="SendReminder"
                                            CommandArgument='<%# Eval("email") %>'
                                            OnCommand="sendReminderBtn_Click"
                                            CssClass="text-white bg-slate-800 rounded-md px-4 p-1 cursor-pointer w-max"
                                            Text="Send Reminder to update" />
                                    </div>
                                </td>
                                <td class="px-4 py-3 text-sm text-gray-600">
                                    <%# Eval("applied_status") %>
                                </td>
                                <td class="px-4 py-3 text-center">
                                    <asp:Button
                                        runat="server"
                                        Visible='<%# Convert.ToString(Eval("applied_status")).Equals("APPLIED") ? true : false %>'
                                        ID="ShortlistCandidate"
                                        CommandName="ShortlistCandidate"
                                        CommandArgument='<%# Eval("id") %>'
                                        OnCommand="ShortlistCandidate_Command"
                                        CssClass="bg-green-600 text-white hover:bg-green-700 rounded-md px-4 p-1 cursor-pointer w-max"
                                        Text="Shortlist Candidate" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>

        <%
            }
            else
            {
        %>
        <div class="text-xl font-medium text-center w-full">
            No Jobs Assigned to you!!!
        </div>
        <%
            }
        %>
    </form>
</body>
</html>
