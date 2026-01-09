<%@ Page Title="Profile" Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="RecruiterManagement.Profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <title>Profile</title>
</head>
<body>
    <form id="form1" runat="server" class="px-4">
        <div class="py-2 font-medium text-3xl text-center">
            Your Profile
        </div>
        <div class="bg-white shadow-xl rounded-xl w-full max-w-md p-6 mx-auto my-4">
            <div class="flex items-center gap-4 mb-6">
                <div>
                    <h2 class="text-xl font-semibold text-gray-800">
                        <asp:Label ID="ltName" runat="server"></asp:Label>
                    </h2>
                    <p class="text-sm text-gray-500">
                        <asp:Label ID="ltRole" runat="server"></asp:Label>
                    </p>
                </div>
            </div>

            <div class="space-y-4">
                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">Full Name</span>
                    <span class="text-gray-800 font-medium">
                        <asp:Label ID="ltNameDetail" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">Email</span>
                    <span class="text-gray-800 font-medium">
                        <asp:Label ID="ltEmail" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">Role</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-full bg-indigo-100 text-indigo-700 font-medium">
                        <asp:Label ID="ltRoleDetail" runat="server"></asp:Label>
                    </span>
                </div>

                <%
                    if (Session["role"].Equals("candidate"))
                    {
                %>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">Date of Birth</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="dateOfBirth" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between  border-b pb-2">
                    <span class="text-gray-500 text-sm">Phone</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="phoneLabel" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">Gender</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="gender" runat="server"></asp:Label>
                    </span>
                </div>
                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">Education</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="education" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">Experience (Years)</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="experience_years" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">Expected Salary</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="expected_salary" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">Current Position</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="current_position" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">status</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="status" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">City</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="city" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">State</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="state" runat="server"></asp:Label>
                    </span>
                </div>

                <div class="flex justify-between border-b pb-2">
                    <span class="text-gray-500 text-sm">Address</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md font-medium">
                        <asp:Label ID="address" runat="server"></asp:Label>
                    </span>
                </div>


                <div class="flex justify-between border-b pb-2 flex-col">
                    <span class="text-gray-500 text-sm">Skills</span>
                    <span class="inline-block px-3 py-1 text-sm rounded-md bg-slate-100 text-slate-700 font-medium">
                        <asp:Label ID="skills" runat="server"></asp:Label>
                    </span>
                </div>
                <%
                    }
                %>
            </div>


            <div class="mt-6 flex w-full gap-3">
                <a href="/Candidates/Update"
                    class="flex-1 text-center text-black text-decoration-none bg-gray-900 hover:bg-gray-800 text-gray-300 py-2 rounded-lg font-medium transition w-full">Edit Profile</a>
                <a href="/Logout"
                    class="flex-1 text-center text-black text-decoration-none bg-gray-200 hover:bg-gray-300 text-gray-800 py-2 rounded-lg font-medium transition w-full">Logout</a>
            </div>
        </div>
    </form>
</body>
</html>

