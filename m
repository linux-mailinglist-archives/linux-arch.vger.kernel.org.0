Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265141537BB
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 19:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBESVm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 13:21:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:20934 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgBESUa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 10:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="279447815"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2020 10:20:28 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 16/27] mm: Update can_follow_write_pte() for Shadow Stack
Date:   Wed,  5 Feb 2020 10:19:24 -0800
Message-Id: <20200205181935.3712-17-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200205181935.3712-1-yu-cheng.yu@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Can_follow_write_pte() verifies that a read-only page is the task's own
copy by ensuring the page has gone through faultin_page() and the PTE is
Dirty.

A Shadow Stack (SHSTK) PTE must be (read-only + _PAGE_DIRTY_HW).  When a
task does fork(), its SHSTK PTEs become (read-only + _PAGE_DIRTY_SW).  This
causes the next SHSTK access (i.e. CALL, RET, INCSSP) to trigger a fault;
the page is then copied, and (read-only + _PAGE_DIRTY_HW) is restored.

To update can_follow_write_pte() for SHSTK, introduce pte_exclusive().  It
verifies a data PTE is Dirty and a SHSTK PTE has _PAGE_DIRTY_HW.

Also rename can_follow_write_pte() to can_follow_write() to make its
meaning clear; i.e. "Can we write to the page?", not "Is the PTE writable?"

Also apply same changes to the huge memory case.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/mm/pgtable.c         | 18 ++++++++++++++++++
 include/asm-generic/pgtable.h | 12 ++++++++++++
 mm/gup.c                      |  8 +++++---
 mm/huge_memory.c              |  8 +++++---
 4 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3340b1d4e9da..fa8133f37918 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -887,6 +887,15 @@ inline pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma)
 		return pte;
 }
 
+inline bool pte_exclusive(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHSTK)
+		return pte_dirty_hw(pte);
+	else
+		return pte_dirty(pte);
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 inline pmd_t pmd_set_vma_features(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & VM_SHSTK)
@@ -894,4 +903,13 @@ inline pmd_t pmd_set_vma_features(pmd_t pmd, struct vm_area_struct *vma)
 	else
 		return pmd;
 }
+
+inline bool pmd_exclusive(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHSTK)
+		return pmd_dirty_hw(pmd);
+	else
+		return pmd_dirty(pmd);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif /* CONFIG_X86_INTEL_SHADOW_STACK_USER */
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index a9df093fdf45..ae9a84fffc25 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1202,18 +1202,30 @@ static inline pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma)
 	return pte;
 }
 
+static inline bool pte_exclusive(pte_t pte, struct vm_area_struct *vma)
+{
+	return pte_dirty(pte);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline pmd_t pmd_set_vma_features(pmd_t pmd, struct vm_area_struct *vma)
 {
 	return pmd;
 }
+
+static inline bool pmd_exclusive(pmd_t pmd, struct vm_area_struct *vma)
+{
+	return pmd_dirty(pmd);
+}
 #endif
 #else
 bool arch_copy_pte_mapping(vm_flags_t vm_flags);
 pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma);
+bool pte_exclusive(pte_t pte, struct vm_area_struct *vma);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 pmd_t pmd_set_vma_features(pmd_t pmd, struct vm_area_struct *vma);
+bool pmd_exclusive(pmd_t pmd, struct vm_area_struct *vma);
 #endif
 #endif
 #endif /* CONFIG_MMU */
diff --git a/mm/gup.c b/mm/gup.c
index 7646bf993b25..d1dbfbde8443 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -164,10 +164,12 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
  * FOLL_FORCE can write to even unwritable pte's, but only
  * after we've gone through a COW cycle and they are dirty.
  */
-static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
+static inline bool can_follow_write(pte_t pte, unsigned int flags,
+				    struct vm_area_struct *vma)
 {
 	return pte_write(pte) ||
-		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
+		((flags & FOLL_FORCE) && (flags & FOLL_COW) &&
+		 pte_exclusive(pte, vma));
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
@@ -205,7 +207,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 	if ((flags & FOLL_NUMA) && pte_protnone(pte))
 		goto no_page;
-	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
+	if ((flags & FOLL_WRITE) && !can_follow_write(pte, flags, vma)) {
 		pte_unmap_unlock(ptep, ptl);
 		return NULL;
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 93ef368df2dd..baad346e9f4a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1469,10 +1469,12 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
  * FOLL_FORCE can write to even unwritable pmd's, but only
  * after we've gone through a COW cycle and they are dirty.
  */
-static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags)
+static inline bool can_follow_write(pmd_t pmd, unsigned int flags,
+				    struct vm_area_struct *vma)
 {
 	return pmd_write(pmd) ||
-	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pmd_dirty(pmd));
+	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) &&
+		pmd_exclusive(pmd, vma));
 }
 
 struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
@@ -1485,7 +1487,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 
 	assert_spin_locked(pmd_lockptr(mm, pmd));
 
-	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
+	if (flags & FOLL_WRITE && !can_follow_write(*pmd, flags, vma))
 		goto out;
 
 	/* Avoid dumping huge zero page */
-- 
2.21.0

