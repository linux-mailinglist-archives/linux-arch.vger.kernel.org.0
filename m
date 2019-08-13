Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7338C2FA
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfHMVCz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:02:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:16076 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfHMVCy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:02:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:02:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="187901428"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2019 14:02:52 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 15/27] mm: Handle shadow stack page fault
Date:   Tue, 13 Aug 2019 13:52:13 -0700
Message-Id: <20190813205225.12032-16-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205225.12032-1-yu-cheng.yu@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a task does fork(), its shadow stack (SHSTK) must be duplicated
for the child.  This patch implements a flow similar to copy-on-write
of an anonymous page, but for SHSTK.

A SHSTK PTE must be RO and dirty.  This dirty bit requirement is used
to effect the copying.  In copy_one_pte(), clear the dirty bit from a
SHSTK PTE to cause a page fault upon the next SHSTK access.  At that
time, fix the PTE and copy/re-use the page.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/mm/pgtable.c         | 15 +++++++++++++++
 include/asm-generic/pgtable.h | 15 +++++++++++++++
 mm/memory.c                   |  7 ++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 44816ff6411f..0c10d0c5e329 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -876,3 +876,18 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 #endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+inline pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHSTK)
+		return pte_mkdirty_shstk(pte);
+	else
+		return pte;
+}
+
+inline bool arch_copy_pte_mapping(vm_flags_t vm_flags)
+{
+	return (vm_flags & VM_SHSTK);
+}
+#endif /* CONFIG_X86_INTEL_SHADOW_STACK_USER */
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 75d9d68a6de7..89b0fa132f1f 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1188,4 +1188,19 @@ static inline bool arch_has_pfn_modify_check(void)
 #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
 #endif
 
+#ifndef CONFIG_ARCH_HAS_SHSTK
+static inline pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma)
+{
+	return pte;
+}
+
+static inline bool arch_copy_pte_mapping(vm_flags_t vm_flags)
+{
+	return false;
+}
+#else
+pte_t pte_set_vma_features(pte_t pte, struct vm_area_struct *vma);
+bool arch_copy_pte_mapping(vm_flags_t vm_flags);
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
diff --git a/mm/memory.c b/mm/memory.c
index e2bb51b6242e..be93a73b5152 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -754,7 +754,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * If it's a COW mapping, write protect it both
 	 * in the parent and the child
 	 */
-	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
+	if ((is_cow_mapping(vm_flags) && pte_write(pte)) ||
+	    arch_copy_pte_mapping(vm_flags)) {
 		ptep_set_wrprotect(src_mm, addr, src_pte);
 		pte = pte_wrprotect(pte);
 	}
@@ -2273,6 +2274,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 	entry = pte_mkyoung(vmf->orig_pte);
 	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	entry = pte_set_vma_features(entry, vma);
 	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
 		update_mmu_cache(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -2348,6 +2350,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		entry = pte_set_vma_features(entry, vma);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
 		 * pte with the new entry. This will avoid a race condition
@@ -2866,6 +2869,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	pte = mk_pte(page, vma->vm_page_prot);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
+		pte = pte_set_vma_features(pte, vma);
 		vmf->flags &= ~FAULT_FLAG_WRITE;
 		ret |= VM_FAULT_WRITE;
 		exclusive = RMAP_EXCLUSIVE;
@@ -3008,6 +3012,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	entry = mk_pte(page, vma->vm_page_prot);
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
+	entry = pte_set_vma_features(entry, vma);
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
-- 
2.17.1

