Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308244A3A01
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356467AbiA3VWM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:22:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:52029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356510AbiA3VV7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577719; x=1675113719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/0hTOGjoC4CyAc1QDDk6aPdkNAiEc470qCgFvhPkCgI=;
  b=bKLtdut3Ogdq4+oOSpJgsqPOgg+rV6mDdSuKtqY+S0ltre7UIHQK56w8
   Ai74Vr12IOm4fdRTQFyyt1OY3zFmCpv/PYtDLHieYQObCrLYt+uNeBoT4
   gX9lnQLs99NElKyFqpXa3KZECxlbkMuzVlDyfhybYN8KmX9OpnMyiVySS
   9TYf/Ov+L7MyGLi212ag/YNkpcH/ZHwyavEnYkW09rDaDh+pfEzI7WdyW
   g1Cb1MgsCLsO5z8SYWRlfCkVtZkutTvsbjqkMi+GbSihPwvh26rtBxqC1
   suV3tm8ouH3xnDJSrEVpvLjZKz/UvkKg9qvvtsuKi17YXuQgiZY9ZaK5v
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104936"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104936"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856798"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:58 -0800
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 16/35] x86/mm: Update maybe_mkwrite() for shadow stack
Date:   Sun, 30 Jan 2022 13:18:19 -0800
Message-Id: <20220130211838.8382-17-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

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
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

Yu-cheng v29:
 - Remove likely()'s.

 arch/x86/include/asm/pgtable.h |  6 ++++++
 arch/x86/mm/pgtable.c          | 20 ++++++++++++++++++++
 include/linux/mm.h             |  2 ++
 mm/huge_memory.c               |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e1061b9cba6a..36166bdd0b98 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -282,6 +282,9 @@ static inline int pmd_trans_huge(pmd_t pmd)
 	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
 }
 
+#define maybe_pmd_mkwrite maybe_pmd_mkwrite
+extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline int pud_trans_huge(pud_t pud)
 {
@@ -1660,6 +1663,9 @@ static inline bool arch_faults_on_old_pte(void)
 	return false;
 }
 
+#define maybe_mkwrite maybe_mkwrite
+extern pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma);
+
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_H */
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..c22c8e9c37e8 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -610,6 +610,26 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 }
 #endif
 
+pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_WRITE)
+		pte = pte_mkwrite(pte);
+	else if (vma->vm_flags & VM_SHADOW_STACK)
+		pte = pte_mkwrite_shstk(pte);
+	return pte;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_WRITE)
+		pmd = pmd_mkwrite(pmd);
+	else if (vma->vm_flags & VM_SHADOW_STACK)
+		pmd = pmd_mkwrite_shstk(pmd);
+	return pmd;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /**
  * reserve_top_address - reserves a hole in the top of kernel address space
  * @reserve - size of hole to reserve
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 311c6018d503..b3cb3a17037b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -955,12 +955,14 @@ void free_compound_page(struct page *page);
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
index 406a3c28c026..2adedcfca00b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -491,12 +491,14 @@ static int __init setup_transparent_hugepage(char *str)
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
2.17.1

