# Plan De Cours

[:tada: Participation](.scripts/Participation.md)

## :a: Github

:round_pushpin: Creer un compte sur [:octocat: Github](https://github.com)

- [ ] Explorer [Github Education](https://education.github.com)

:round_pushpin: Créer une page 

- [ ] créer un répertoire avec son :id: et ajouter le fichier `README.md`
- [ ] créer un répertoire dans son répertoire :id:, ajouter le répertoire `images` et ajouter le fichier `.gitkeep`
- [ ] Ajouter des images dans le répertoire `images`
- [ ] Ajouter les images au fichier `README.md`

:bulb: [Tutoriel sur GIT](https://github.com/CollegeBoreal/Tutoriels/tree/main/0.GIT)

## :b: Azure Education

:round_pushpin: S'enregistrer à Azure éducation 

- [ ] [Portail Azure](https://portal.azure.com) 
- [ ] [Le Menu Education](https://portal.azure.com/#view/Microsoft_Azure_Education/EducationMenuBlade)

## :ab: VPN

- [ ] [VPN: Demande d'accès ](https://services.collegeboreal.ca)


# References

---

- [ ] [TECHNIQUES DES SYSTÈMES INFORMATIQUES](https://collegeboreal.ca/wp-content/uploads/2023/04/tsiq_2301.pdf)

### Session d’automne – troisième étape – 14 semaines

| Titre | Code | Heures/semaine | Cours préalables |
|-|-|-|-|
| Système de gestion de bases de données | INF1096 | 4 | INF1094 |
| Développement d’applications | INF1083 | 3 | INF1093 |
| Réseautique 3 | INF1097 | 4 | INF1091 |
| Administration Windows | INF1084 | 4 | INF1092 |
| Administration Linux | INF1085 | 4 | INF1092 |
| Formation générale | GENxxxx | 3 | Aucun |
| Total | | 22 |



Of course. This is an excellent learning path for mastering Microsoft Active Directory fundamentals. Here is a detailed breakdown of how you would approach each module using actual Active Directory concepts and tools.

The key to dealing with this path is to set up a **lab environment**. This is non-negotiable for the hands-on labs. A typical setup would involve:

*   **Hardware:** A physical machine with enough RAM (16GB+) to run 3-4 virtual machines using Hyper-V or VMware.
*   **Virtual Machines (VMs):**
    *   **DC01:** A Windows Server VM that will be promoted to a Domain Controller.
    *   **CLIENT01:** A Windows 10/11 VM that will be joined to the domain.
    *   (Optional) **DC02:** A second Windows Server VM for advanced topics like replication.

---

### Module 1: Installation et configuration d'un domaine

*   **Quiz Focus:** Understanding what a domain is, the role of a Domain Controller (DC), the function of Active Directory Domain Services (AD DS), DNS requirements, and the concept of forests and trees.

*   **Laboratory Guide:**
    1.  **Prepare the Server:** Install Windows Server on your `DC01` VM. Set a static IP address (e.g., `192.168.1.10`).
    2.  **Install the AD DS Role:** Open Server Manager -> Add roles and features -> Select "Active Directory Domain Services". Install it.
    3.  **Promote to Domain Controller:** After installation, click the notification flag and "Promote this server to a domain controller".
    4.  **Deployment Configuration:** Choose "Add a new forest" and enter your root domain name (e.g., `lab.local`).
    5.  **Set DSRM Password:** Set a strong password for Directory Services Restore Mode.
    6.  **DNS Options:** It will warn about DNS delegation; this is expected. Proceed.
    7.  **Additional Options:** Set the NetBIOS domain name (usually auto-generated, e.g., `LAB`).
    8.  **Paths:** Leave the default paths for database, log files, and SYSVOL.
    9.  **Review and Install:** The server will install AD DS, configure DNS, and reboot. You now have a functional domain!
    10. **Verify:** Log in with your new domain admin credentials (e.g., `LAB\Administrator`). Open the **Active Directory Users and Computers (ADUC)** console from Administrative Tools to see your new domain structure.

---

### Module 2: Gestion de l'organisation administrative des comptes

*   **Quiz Focus:** Understanding Organizational Units (OUs), the difference between authenticating (e.g., `LAB\jdoe`) and UPN (e.g., `jdoe@lab.local`) logins, common user account attributes, and the principle of least privilege.

*   **Laboratory Guide:**
    1.  **Design an OU Structure:** Plan a logical structure. OUs are for organization and applying Group Policy, not for security.
        *   E.g., Create top-level OUs for `Users` and `Computers`.
        *   Inside `Users`, create child OUs for `Departments`, `Admins`, `ServiceAccounts`.
        *   Inside `Computers`, create child OUs for `Workstations`, `Servers`.
    2.  **Create OUs:** In **ADUC**, right-click your domain -> New -> Organizational Unit. Build your planned structure.
    3.  **Create User Accounts:** In your `Users\Departments` OU, right-click -> New -> User. Fill in details like First/Last name, User logon name. Practice using templates.
    4.  **Manage Properties:** Right-click a user -> Properties. Explore the tabs:
        *   **Member Of:** Add the user to a group (e.g., `Sales`).
        *   **Profile:** Set a profile path and home folder (to be mapped by a logon script or GPO later).
        *   **Account:** Set logon hours, workstation restrictions, and account expiration.

---

### Module 3: Gestion avancée des groupes et utilisateurs

*   **Quiz Focus:** Group Scopes (Domain Local, Global, Universal) and Group Types (Security vs. Distribution). Understanding AGDLP/AGUDLP best practice for assigning permissions.

*   **Laboratory Guide:**
    1.  **Understand AGDLP:**
        *   **(A)** Place user **Accounts** into a...
        *   **(G)** **Global** group. (e.g., `G_Sales_Users`)
        *   **(DL)** Place that Global group into a...
        *   **(P)** **Domain Local** group that has the necessary **Permissions** on a resource (e.g., `DL_Sales_Share_Read`).
    2.  **Create Groups:** In **ADUC**, create groups of different scopes and types. Note the icons.
    3.  **Implement AGDLP:**
        *   Create a shared folder on `DC01`.
        *   Create a `G_Sales_Users` (Global Security) group and add user accounts to it.
        *   Create a `DL_Sales_Share_Read` (Domain Local Security) group.
        *   On the shared folder's Security permissions, grant `Read` access to the `DL_Sales_Share_Read` group.
        *   In AD, add the `G_Sales_Users` group as a member of the `DL_Sales_Share_Read` group.
    4.  **Test:** Log into your `CLIENT01` VM (which must be joined to the domain) with a sales user account and verify you can read the share.

---

### Module 4: Stratégie de groupe (Group Policy)

*   **Quiz Focus:** The hierarchy of GPO application (Local -> Site -> Domain -> OU), processing order (LSDOU), and the difference between Computer Configuration and User Configuration policies.

*   **Laboratory Guide:**
    1.  **Open the Tools:** Open the **Group Policy Management Console (GPMC)**.
    2.  **Create and Link a GPO:** Right-click your `Computers\Workstations` OU -> "Create a GPO in this domain, and Link it here...". Name it (e.g., `Workstation Baseline`).
    3.  **Edit the GPO:** Right-click the GPO -> Edit. This opens the **Group Policy Management Editor**.
    4.  **Configure a Setting:**
        *   Navigate to **Computer Configuration -> Policies -> Administrative Templates -> System -> Logon**.
        *   Enable the setting "Do not display the Getting Started welcome screen at logon".
    5.  **Force Group Policy Update:** On your `CLIENT01` VM (which should be in the `Workstations` OU), open Command Prompt as admin and run `gpupdate /force`. Reboot and see the change.
    6.  **Create a User-based GPO:** Link a GPO to your `Users\Departments` OU that maps a network drive (User Config -> Preferences -> Windows Settings -> Drive Maps).

---

### Projet : Pensée Critique & Examen Final

This is where you combine all the skills.

*   **Project Scenario:** "You are the administrator for a new company. You need to set up an AD environment for two departments: Sales and IT."
    1.  **Module 1:** Install the domain `corp.company.com`.
    2.  **Module 2:** Create an OU structure that separates Sales and IT users and computers.
    3.  **Module 3:**
        *   Create all necessary user accounts in their correct OUs.
        *   Create Global groups: `G_Sales`, `G_IT`.
        *   Create Domain Local groups for permissions: `DL_Share_Sales_ReadWrite`, `DL_Share_IT_FullControl`.
        *   Implement AGDLP by adding the Global groups to the correct Domain Local groups.
    4.  **Module 4:**
        *   Create a GPO linked to the Sales Computers OU that sets a specific desktop wallpaper and prevents access to the Control Panel.
        *   Create a GPO linked to the IT Users OU that maps a network drive to an admin share.

*   **Final Exam:** This should test theoretical knowledge (e.g., "What is the difference between a Universal and Global group?") and practical troubleshooting (e.g., "A user in the Sales OU reports that their wallpaper did not change. What are the possible causes?"). Key topics include replication, GPO inheritance and enforcement, and group membership.
