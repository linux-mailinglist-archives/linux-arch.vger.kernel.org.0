Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947175F004F
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiI2WdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiI2WcX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:32:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5A26CD2C;
        Thu, 29 Sep 2022 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490641; x=1696026641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=VsTBZoElthVu/yGuB+Di9RxtRD1iZA84O3vOvi0lRyE=;
  b=C2eJwTGlM+pPif9UWz+TiDAjcKQRPVHxbvtsdo0iwHLaUTxMxmvMbYRX
   Vc8AMbmRTmzSfir7woHElHiGv/HknwMfTK5wnncsRj3efH/jt9Gh69FEJ
   Q3S+fc4elntBRHFKwd0opR4uSmt+JJhPGukPkQb680ti4JC7ejvIjNXl2
   NUxvWWz8UqO7o8oYb6q/6qHYjB60S3nJbAR83WcYhwTGdTkMVWtPiUaF6
   vB7V3WW9LyyOpUnw+ijVMnbnJVdzdVVNjIdoZ8YTK+vA7htFf0EE3LQ85
   EHidR4UaZgrkSCuaNV2wawAZieZQY68KFRwsCBR46GaRAXHmp5CcgE2Zy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285181974"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285181974"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016218"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016218"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:16 -0700
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
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 16/39] x86/mm: Update maybe_mkwrite() for shadow stack
Date:   Thu, 29 Sep 2022 15:29:13 -0700
Message-Id: <20220929222936.14584-17-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---

v2:
 - Change to handle shadow stacks that are VM_WRITE|VM_SHADOW_STACK
 - Ditch arch specific maybe_mkwrite(), and make the code generic

Yu-cheng v29:
 - Remove likely()'s.

 arch/x86/include/asm/pgtable.h |  2 ++
 include/linux/mm.h             | 14 +++++++++++++-
 include/linux/pgtable.h        | 14 ++++++++++++++
 mm/huge_memory.c               |  9 ++++++++-
 mm/memory.c                    |  3 +--
 5 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 58c7bf9d7392..7a769c4dbc1c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -419,6 +419,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
 }
 
+#define pte_mkwrite_shstk pte_mkwrite_shstk
 static inline pte_t pte_mkwrite_shstk(pte_t pte)
 {
 	/* pte_clear_cow() also sets Dirty=1 */
@@ -555,6 +556,7 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
 }
 
+#define pmd_mkwrite_shstk pmd_mkwrite_shstk
 static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
 {
 	return pmd_clear_cow(pmd);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8cd413c5a329..fef14ab3abcb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -981,13 +981,25 @@ void free_compound_page(struct page *page);
  * servicing faults for write access.  In the normal case, do always want
  * pte_mkwrite.  But get_user_pages can cause write faults for mappings
  * that do not have writing enabled, when used by access_process_vm.
+ *
+ * If a vma is shadow stack (a type of writable memory), mark the pte shadow
+ * stack.
  */
+#ifndef maybe_mkwrite
 static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
+	if (!(vma->vm_flags & VM_WRITE))
+		goto out;
+
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		pte = pte_mkwrite_shstk(pte);
+	else
 		pte = pte_mkwrite(pte);
+
+out:
 	return pte;
 }
+#endif
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 014ee8f0fbaa..21115b4895ca 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -480,6 +480,13 @@ static inline pte_t pte_sw_mkyoung(pte_t pte)
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
@@ -488,6 +495,13 @@ static inline pte_t pte_sw_mkyoung(pte_t pte)
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
index e9414ee57c5b..11fc69eb4717 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -554,8 +554,15 @@ __setup("transparent_hugepage=", setup_transparent_hugepage);
 
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
+	if (!(vma->vm_flags & VM_WRITE))
+		goto out;
+
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		pmd = pmd_mkwrite_shstk(pmd);
+	else
 		pmd = pmd_mkwrite(pmd);
+
+out:
 	return pmd;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 4ba73f5aa8bb..6e8379f6793c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4098,8 +4098,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	entry = mk_pte(page, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
-	if (vma->vm_flags & VM_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry));
+	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
-- 
2.17.1

