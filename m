Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5B61A48B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiKDWnV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiKDWm1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:42:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0FC51C22;
        Fri,  4 Nov 2022 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601589; x=1699137589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xaioYoGXdFCH6JyKO39LB3gea0qfxKRbZWJ+Tm5uBgg=;
  b=UHBOlj4ytEwvcBfpxBSgF8ylCmyjaOQ3RUgLA0v9ABEZuBCeQBcFGqEz
   BHUiXbvlEOjIz++ZUNUF16jm52Pvuw8yiED6ZWJk2Cr9xWmWYCLcPYOBq
   M5/D9jNgXB2ozyZuRKGDwdrJ7cjFBo/xtrBy5sCbkVJhSIj8DZw8SLim3
   m2XLT7XjEWfpii+NVFe7iA8PLNonW+O1r5YU0p5Xxhu6wnDmWlJqMpdwo
   rCROKQ/wivWcjKQy/xIjHQxh1tSADNy+iImb/Pk+ja/w0eP37uqRPtxyP
   YG2pIGNhJACbjIyPjMEiQ5+XG/ubWtiCNtfchN/f5gSf4NnIRW74eVnwr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840573"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840573"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514099"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514099"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:42 -0700
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v3 23/37] mm: Warn on shadow stack memory in wrong vma
Date:   Fri,  4 Nov 2022 15:35:50 -0700
Message-Id: <20221104223604.29615-24-rick.p.edgecombe@intel.com>
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
implmentations for pte_shstk() and pmd_shstk().

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v3:
 - New patch

 arch/x86/include/asm/pgtable.h |  2 ++
 include/linux/pgtable.h        | 14 ++++++++++++++
 mm/huge_memory.c               |  2 ++
 mm/memory.c                    |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0d18f3a4373d..051c03e59468 100644
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
index 36926a207b6d..dd84af70b434 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -500,6 +500,20 @@ static inline pte_t pte_mkwrite_shstk(pte_t pte)
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
 #ifndef pte_clear_savedwrite
 #define pte_clear_savedwrite pte_wrprotect
 #endif
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7643a4db1b50..2540f0d4c8ff 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1656,6 +1656,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	orig_pmd = pmdp_huge_get_and_clear_full(vma, addr, pmd,
 						tlb->fullmm);
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pmd_shstk(orig_pmd));
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 	if (vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
diff --git a/mm/memory.c b/mm/memory.c
index b9bee283aad3..4331f33a02d6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1437,6 +1437,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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

