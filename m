Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7E261A46C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKDWlz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKDWkt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:40:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599C84B99D;
        Fri,  4 Nov 2022 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601577; x=1699137577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5QjeO1hUpatOnGhS13rjzsuKy1aDnHsoqPiBGBWzrX0=;
  b=QbvRcO/+ZCWaHHF5YvwVQbUxea6vlKziKJAaalcgJdadAG6CRJZKPGyB
   TLt/z0BRPrDKC84A2xpLCHg8NEp8lwny5szzoFsIQsPpfrFxfEDRHnIHb
   IdlrCH+2lzSLBdUD74wKJqG6U4DnJhPOf0viALQFcEtM4mmTbhtf//N+4
   lUluDI2Rn4M7K3OQFo4i/waFTMhpogSINCcbHYDcAAMDjga2T0epfGqPL
   SWSAtdxuWCJ2CNJfvTvDX+Bun+cYkmXOEZvN6URDdJj8R4hrW/GZgxt8k
   nuYWd0AAD3p095SAzKOfaMtI5llv66sQxotda4bvwmjn8pmVfkOfzLsl2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840541"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840541"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514069"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514069"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:36 -0700
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 16/37] x86/mm: Update maybe_mkwrite() for shadow stack
Date:   Fri,  4 Nov 2022 15:35:43 -0700
Message-Id: <20221104223604.29615-17-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index f252c42f3ca1..df67bcf9f69e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -420,6 +420,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
 }
 
+#define pte_mkwrite_shstk pte_mkwrite_shstk
 static inline pte_t pte_mkwrite_shstk(pte_t pte)
 {
 	/* pte_clear_cow() also sets Dirty=1 */
@@ -556,6 +557,7 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
 }
 
+#define pmd_mkwrite_shstk pmd_mkwrite_shstk
 static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
 {
 	return pmd_clear_cow(pmd);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 42c4e4bc972d..5d9536fa860a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1015,12 +1015,19 @@ void free_compound_page(struct page *page);
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
index a108b60a6962..5ce6732a6b65 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -493,6 +493,13 @@ static inline pte_t pte_sw_mkyoung(pte_t pte)
 #define pte_mk_savedwrite pte_mkwrite
 #endif
 
+#ifndef pte_mkwrite_shstk
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return pte;
+}
+#endif
+
 #ifndef pte_clear_savedwrite
 #define pte_clear_savedwrite pte_wrprotect
 #endif
@@ -501,6 +508,13 @@ static inline pte_t pte_sw_mkyoung(pte_t pte)
 #define pmd_savedwrite pmd_write
 #endif
 
+#ifndef pmd_mkwrite_shstk
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
+{
+	return pmd;
+}
+#endif
+
 #ifndef pmd_mk_savedwrite
 #define pmd_mk_savedwrite pmd_mkwrite
 #endif
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 561a42567477..73b9b78f8cf4 100644
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

