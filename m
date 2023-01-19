Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA16744A4
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjASVfl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjASVdj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:33:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E37A95BD;
        Thu, 19 Jan 2023 13:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163591; x=1705699591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=M7Xo1HXic3OeNqgtbqqoeSfgPr5lKe9tQj+QswBwq38=;
  b=DCMS9Lq1EUd+MJXo33q0ueut6cFPZ861HiL+7iRdUQ57cRC+bbr42uZp
   CJmtroMT3zAuuwDvJg/SXyk4TNZq5G6wilzeKa4PxZ0k89sw5G9SoQoae
   H59RzC4+CBG1W0xns9o7Zy9GiCszieUlagvDlL7KVsTGNi/9lC9GMGgqq
   hUtlrC7aU3XMOCQVfduaxyloAcn+dRafVAp8lOJHrndYXKAIlcSi1ftoS
   m5oXCRKaH7+jAeJIXMIU1ctkNV3RbLcpJWcI8RubK93yzQade9EAfujjS
   eFW2Ecp7AzerwjZ6jr8X+1uJbV4LarqxnnL5crsZKEIsjF0gW9JawifQN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323119553"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323119553"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989139076"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989139076"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:50 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v5 17/39] x86/mm: Update maybe_mkwrite() for shadow stack
Date:   Thu, 19 Jan 2023 13:22:55 -0800
Message-Id: <20230119212317.8324-18-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

When serving a page fault, maybe_mkwrite() makes a PTE writable if there is
a write access to it, and its vma has VM_WRITE. Shadow stack accesses to
shadow stack vma's are also treated as write accesses by the fault handler.
This is because setting shadow stack memory makes it writable via some
instructions, so COW has to happen even for shadow stack reads.

So maybe_mkwrite() should continue to set VM_WRITE vma's as normally
writable, but also set VM_WRITE|VM_SHADOW_STACK vma's as shadow stack.

Do this by adding a pte_mkwrite_shstk() and a cross-arch stub. Check for
VM_SHADOW_STACK in maybe_mkwrite() and call pte_mkwrite_shstk()
accordingly.

Apply the same changes to maybe_pmd_mkwrite().

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

v3:
 - Remove unneeded define for maybe_mkwrite (Peterz)
 - Switch to cleaner version of maybe_mkwrite() (Peterz)

v2:
 - Change to handle shadow stacks that are VM_WRITE|VM_SHADOW_STACK
 - Ditch arch specific maybe_mkwrite(), and make the code generic
 - Move do_anonymous_page() to next patch (Kirill)

Yu-cheng v29:
 - Remove likely()'s.

 arch/x86/include/asm/pgtable.h |  2 ++
 include/linux/mm.h             | 13 ++++++++++---
 include/linux/pgtable.h        | 14 ++++++++++++++
 mm/huge_memory.c               | 10 +++++++---
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e96558abc8ec..45b1a8f058fe 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -445,6 +445,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	return __pte_mkdirty(pte, true);
 }
 
+#define pte_mkwrite_shstk pte_mkwrite_shstk
 static inline pte_t pte_mkwrite_shstk(pte_t pte)
 {
 	/* pte_clear_cow() also sets Dirty=1 */
@@ -589,6 +590,7 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 	return __pmd_mkdirty(pmd, true);
 }
 
+#define pmd_mkwrite_shstk pmd_mkwrite_shstk
 static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
 {
 	return pmd_clear_cow(pmd);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 824e730b21af..e15d2fc04007 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1106,12 +1106,19 @@ void free_compound_page(struct page *page);
  * servicing faults for write access.  In the normal case, do always want
  * pte_mkwrite.  But get_user_pages can cause write faults for mappings
  * that do not have writing enabled, when used by access_process_vm.
+ *
+ * If a vma is shadow stack (a type of writable memory), mark the pte shadow
+ * stack.
  */
 static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
-		pte = pte_mkwrite(pte);
-	return pte;
+	if (!(vma->vm_flags & VM_WRITE))
+		return pte;
+
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pte_mkwrite_shstk(pte);
+
+	return pte_mkwrite(pte);
 }
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1159b25b0542..14a820a45a37 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -532,6 +532,20 @@ static inline pte_t pte_sw_mkyoung(pte_t pte)
 #define pte_sw_mkyoung	pte_sw_mkyoung
 #endif
 
+#ifndef pte_mkwrite_shstk
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return pte;
+}
+#endif
+
+#ifndef pmd_mkwrite_shstk
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
+{
+	return pmd;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PMDP_SET_WRPROTECT
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index abe6cfd92ffa..fbb8beb9265e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -553,9 +553,13 @@ __setup("transparent_hugepage=", setup_transparent_hugepage);
 
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
-		pmd = pmd_mkwrite(pmd);
-	return pmd;
+	if (!(vma->vm_flags & VM_WRITE))
+		return pmd;
+
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pmd_mkwrite_shstk(pmd);
+
+	return pmd_mkwrite(pmd);
 }
 
 #ifdef CONFIG_MEMCG
-- 
2.17.1

