<%@ Page Title="Edit Candidate Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Update.aspx.cs" Inherits="RecruiterManagement.Candidates.Update" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .scroll_checkboxes {
            height: 120px;
            width: 100%;
            padding: 5px;
            overflow: auto;
            border: 1px solid #ccc;
        }

        .skill-pill {
            display: inline-flex;
            align-items: center;
            background-color: #d1e7ff;
            color: #0b3d91;
            padding: 4px 10px;
            margin: 4px;
            border-radius: 20px;
            font-size: 14px;
        }

            .skill-pill .remove-btn {
                margin-left: 8px;
                cursor: pointer;
                font-weight: bold;
                color: #0b3d91;
            }

                .skill-pill .remove-btn:hover {
                    color: #ff0000;
                }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const table = document.getElementById("MainContent_skillsCheckboxList");
            const displayDiv = document.getElementById("MainContent_displaySkillsDiv");

            function createSkillPill(labelText, checkboxId) {
                const pill = document.createElement("span");
                pill.className = "skill-pill";
                pill.dataset.label = labelText;
                pill.textContent = labelText;

                const removeBtn = document.createElement("span");
                removeBtn.className = "remove-btn";
                removeBtn.textContent = "×";

                removeBtn.addEventListener("click", function () {
                    displayDiv.removeChild(pill);
                    const checkbox = document.getElementById(checkboxId);
                    if (checkbox) checkbox.checked = false;
                });

                pill.appendChild(removeBtn);
                return pill;
            }

            table.addEventListener("change", function (e) {
                if (e.target && e.target.type === "checkbox") {
                    const checkbox = e.target;
                    const label = table.querySelector(`label[for='${checkbox.id}']`);
                    const labelText = label ? label.textContent.trim() : "";
                    if (!labelText) return;

                    if (checkbox.checked) {
                        displayDiv.appendChild(createSkillPill(labelText, checkbox.id));
                    } else {
                        const existingPill = displayDiv.querySelector(`.skill-pill[data-label='${labelText}']`);
                        if (existingPill) displayDiv.removeChild(existingPill);
                    }
                }
            });
        });

        function toggleResumeClick(type) {
            let viewResumeDiv = document.getElementById("viewResumeDiv");
            let uploadResumeDiv = document.getElementById("uploadResumeDiv");
            let cancelUpdateBtn = document.getElementById("cancelUpdateBtn");
            if (type == "show") {
                viewResumeDiv.setAttribute("hidden", true);
                uploadResumeDiv.removeAttribute("hidden");
            } else {
                viewResumeDiv.removeAttribute("hidden");
                uploadResumeDiv.setAttribute("hidden", true);
            }
        }
    </script>

    <div class="flex items-center justify-center gap-3 py-2">
        <asp:Label Text="CV" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
        <div class="flex flex-col gap-3">
            <div class="flex items-center gap-2" id="viewResumeDiv" <%= String.IsNullOrEmpty(cvFilePath) ? "hidden" : "" %>>
                <a class="bg-gray-700 rounded-md text-white p-2 px-3 text-decoration-none" href="/ViewCV.aspx?file=<%=cvFilePath %>" target="_blank">View Resume
                </a>
                <button class="border border-gray-700 rounded-md p-2 px-3 h-max" type="button" id="toggleUpdateBtn" onclick="toggleResumeClick('show')">
                    Update Resume
                </button>
            </div>
            <div class="flex gap-2 items-center" id="uploadResumeDiv" <%= !String.IsNullOrEmpty(cvFilePath) ? "hidden" : "" %>>
                <asp:FileUpload ID="cvUploadControl" runat="server" class="border border-gray-500 p-3 rounded-sm" />
                <asp:Button ID="uploadBtn" runat="server" OnClick="uploadBtn_Click" Text="Upload" class="bg-gray-700 rounded-md text-white p-2 px-3 h-max" />
                <button type="button" class="border border-gray-700 rounded-md p-2 px-3 h-max" id="cancelUpdateBtn" onclick="toggleResumeClick('hide')">
                    Cancel
                </button>
            </div>
        </div>
    </div>
    <div class="text-center">
        <asp:Label runat="server" ID="lblCvStatus" />
    </div>

    <div class="min-h-screen bg-gray-100 flex items-center justify-center p-4">
        <div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8 flex items-center justify-center flex-col gap-2">
            <h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">Edit Candidate</h2>

            <div class="flex flex-col gap-2 w-full">
                <asp:HiddenField ID="hiddenCandidateId" runat="server" />



                <asp:Label Text="Name" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="txtName" runat="server" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" />


                <asp:Label Text="Email" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" ReadOnly="true" />

                <asp:Label Text="Phone" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="txtPhone" runat="server" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" />

                <asp:Label Text="Gender" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:RadioButtonList ID="radioGender" runat="server">
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Female" Value="Female" />
                    <asp:ListItem Text="Other" Value="Other" />
                </asp:RadioButtonList>

                <asp:Label Text="Date of Birth" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="dateOfBirth" runat="server" type="date" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" />

                <asp:Label Text="Address" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="txtAddress" runat="server" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" />

                <asp:Label Text="City" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="txtCity" runat="server" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" />

                <asp:Label Text="State" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="txtState" runat="server" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" />

                <asp:Label Text="Education" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="txtEducation" runat="server" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" />

                <asp:Label Text="Experience Years" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="txtExperienceYears" runat="server" type="number" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" />

                <asp:Label Text="Current Position" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="txtCurrentPosition" runat="server" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" />

                <asp:Label Text="Expected Salary" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <asp:TextBox ID="txtExpectedSalary" runat="server" type="number" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg" />

                <asp:Label Text="Skills" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                <div id="displaySkillsDiv" runat="server"></div>
                <div class="scroll_checkboxes">
                    <asp:CheckBoxList ID="skillsCheckboxList" runat="server" RepeatDirection="Vertical"></asp:CheckBoxList>
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="text-center text-green-600 font-medium" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update Candidate" CssClass="min-w-full bg-indigo-600 text-white font-medium py-2.5 rounded-lg" OnClick="btnUpdate_Click" />
            </div>
        </div>
    </div>
</asp:Content>
