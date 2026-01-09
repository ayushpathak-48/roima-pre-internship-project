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
    </form>
</body>
</html>
