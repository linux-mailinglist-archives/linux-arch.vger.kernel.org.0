Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4636CCCE
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 22:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbhD0UqF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 16:46:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:31780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239143AbhD0Upg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Apr 2021 16:45:36 -0400
IronPort-SDR: BWQDAM/MgOLtHwKyFjVecZwFnPlFapNB+VNriIIwF1Ira9zu9/If460yTs9Uh9VYEZOlKzQsng
 9R5z/GKIYl1w==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="281922478"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="281922478"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:44:16 -0700
IronPort-SDR: b+IqZB8TbrWPXFZwoFff+l6S2gaMlSjz2O1nskI0ZpK48AzDREpe4vmGWd+bAk+SZdf7mHXbyk
 yswdPssc7eBA==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="465623514"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:44:15 -0700
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v26 15/30] x86/mm: Update maybe_mkwrite() for shadow stack
Date:   Tue, 27 Apr 2021 13:43:00 -0700
Message-Id: <20210427204315.24153-16-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210427204315.24153-1-yu-cheng.yu@intel.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When serving a page fault, maybe_mkwrite() makes a PTE writable if its vma
has VM_WRITE.

A shadow stack vma has VM_SHADOW_STACK.  Its PTEs have _PAGE_DIRTY, but not
_PAGE_WRITE.  In fork(), _PAGE_DIRTY is cleared to cause copy-on-write,
and in the page fault handler, _PAGE_DIRTY is restored and the shadow stack
page is writable again.

Introduce an x86 version of maybe_mkwrite(), which sets proper PTE bits
according to VM flags.

Apply the same changes to maybe_pmd_mkwrite().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v24:
- Instead of doing arch_maybe_mkwrite(), overwrite maybe*_mkwrite() with x86
  versions.
- Change VM_SHSTK to VM_SHADOW_STACK.

 arch/x86/include/asm/pgtable.h |  6 ++++++
 arch/x86/mm/pgtable.c          | 20 ++++++++++++++++++++
 include/linux/mm.h             |  2 ++
 mm/huge_memory.c               |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 46d9394b884f..da5dea417663 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -308,6 +308,9 @@ static inline int pmd_trans_huge(pmd_t pmd)
 	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
 }
 
+#define maybe_pmd_mkwrite maybe_pmd_mkwrite
+extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline int pud_trans_huge(pud_t pud)
 {
@@ -1686,6 +1689,9 @@ static inline bool arch_faults_on_old_pte(void)
 	return false;
 }
 
+#define maybe_mkwrite maybe_mkwrite
+extern pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma);
+
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_H */
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f6a9e2e36642..e778dbbef3d8 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -610,6 +610,26 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 }
 #endif
 
+pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_flags & VM_WRITE))
+		pte = pte_mkwrite(pte);
+	else if (likely(vma->vm_flags & VM_SHADOW_STACK))
+		pte = pte_mkwrite_shstk(pte);
+	return pte;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_flags & VM_WRITE))
+		pmd = pmd_mkwrite(pmd);
+	else if (likely(vma->vm_flags & VM_SHADOW_STACK))
+		pmd = pmd_mkwrite_shstk(pmd);
+	return pmd;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /**
  * reserve_top_address - reserves a hole in the top of kernel address space
  * @reserve - size of hole to reserve
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 08282eb2f195..6ac9b3e9a865 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -993,12 +993,14 @@ void free_compound_page(struct page *page);
  * pte_mkwrite.  But get_user_pages can cause write faults for mappings
  * that do not have writing enabled, when used by access_process_vm.
  */
+#ifndef maybe_mkwrite
 static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
 		pte = pte_mkwrite(pte);
 	return pte;
 }
+#endif
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ae907a9c2050..8203bd6ae4bd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -478,12 +478,14 @@ static int __init setup_transparent_hugepage(char *str)
 }
 __setup("transparent_hugepage=", setup_transparent_hugepage);
 
+#ifndef maybe_pmd_mkwrite
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
 		pmd = pmd_mkwrite(pmd);
 	return pmd;
 }
+#endif
 
 #ifdef CONFIG_MEMCG
 static inline struct deferred_split *get_deferred_split_queue(struct page *page)
-- 
2.21.0

