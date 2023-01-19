Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033AA6744CF
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjASVi4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjASVh1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:37:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EDF1E1C8;
        Thu, 19 Jan 2023 13:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163657; x=1705699657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7r4JBhnxBM6qBcyW6ndYNR0sg/Hfe6OTwhDLlSBw690=;
  b=B8xsrRM/Vktn8dyxr859PtnNes3HxgBrt5XXeG7q/fI+y+66KX8EQytD
   cRVfBmldMk2eI0ef50IRzsNAcK1dbdexQjORESHjbLBNaAVDtPDJ7M7n0
   hLfQskMfOqkaawFNqm3Y/hh2keQ2K9pNmMGCdHDCC9WWOmVlnmvGVP4nC
   1sre+ZQ/LBZl3zEj9D/uYs/Th6GaqID8hdYz65vEV03YnQpPs9NffadiG
   YzxJxXW2XVwoshgbfxGr5nIcXrNXdqBXFU30DFGA9W+UKxs7gmwo8pID6
   GxUZMM8UBuJkvU2LKQks4SgEzfbVDnu8WQvU/PAnXw9XyeBg1HddZ06XB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323119771"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323119771"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:24:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989139124"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989139124"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:24:03 -0800
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v5 25/39] mm: Warn on shadow stack memory in wrong vma
Date:   Thu, 19 Jan 2023 13:23:03 -0800
Message-Id: <20230119212317.8324-26-rick.p.edgecombe@intel.com>
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

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

One sharp edge is that PTEs that are both Write=0 and Dirty=1 are
treated as shadow by the CPU, but this combination used to be created by
the kernel on x86. Previous patches have changed the kernel to now avoid
creating these PTEs unless they are for shadow stack memory. In case any
missed corners of the kernel are still creating PTEs like this for
non-shadow stack memory, and to catch any re-introductions of the logic,
warn if any shadow stack PTEs (Write=0, Dirty=1) are found in non-shadow
stack VMAs when they are being zapped. This won't catch transient cases
but should have decent coverage. It will be compiled out when shadow
stack is not configured.

In order to check if a pte is shadow stack in core mm code, add default
implementations for pte_shstk() and pmd_shstk().

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v5:
 - Fix typo in commit log

v3:
 - New patch

 arch/x86/include/asm/pgtable.h |  2 ++
 include/linux/pgtable.h        | 14 ++++++++++++++
 mm/huge_memory.c               |  2 ++
 mm/memory.c                    |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 425ded5dd6ec..356f1d43e403 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -129,6 +129,7 @@ static inline bool pte_dirty(pte_t pte)
 	return pte_flags(pte) & _PAGE_DIRTY_BITS;
 }
 
+#define pte_shstk pte_shstk
 static inline bool pte_shstk(pte_t pte)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
@@ -147,6 +148,7 @@ static inline bool pmd_dirty(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_DIRTY_BITS;
 }
 
+#define pmd_shstk pmd_shstk
 static inline bool pmd_shstk(pmd_t pmd)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 49ce1f055242..04d0bc466e43 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -539,6 +539,20 @@ static inline pte_t pte_mkwrite_shstk(pte_t pte)
 }
 #endif
 
+#ifndef pte_shstk
+static inline bool pte_shstk(pte_t pte)
+{
+	return false;
+}
+#endif
+
+#ifndef pmd_shstk
+static inline bool pmd_shstk(pmd_t pte)
+{
+	return false;
+}
+#endif
+
 #ifndef pmd_mkwrite_shstk
 static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fbb8beb9265e..5bd71da75dec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1700,6 +1700,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	orig_pmd = pmdp_huge_get_and_clear_full(vma, addr, pmd,
 						tlb->fullmm);
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pmd_shstk(orig_pmd));
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 	if (vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
diff --git a/mm/memory.c b/mm/memory.c
index 5e5107232a26..c4cc38baffc5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1381,6 +1381,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
+			VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+					pte_shstk(ptent));
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
 						      ptent);
-- 
2.17.1

