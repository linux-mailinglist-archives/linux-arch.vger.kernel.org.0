Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3184A39F5
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356583AbiA3VWF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:22:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:52019 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356499AbiA3VV6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577718; x=1675113718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=W6imSLOXTOIpBYqoUozg9ybVACMS4TFkDAllXYnU9RI=;
  b=hWpRyuWjaRiiHpNSwlXed2xIAG55vVf27ywF94VCVe9HQgCIdWVcmeKL
   y12wCKZKLg8rG41BzBxQ/oVN+AjR2rj7THZxTFtkcTIN2mKn5lctEaZnL
   fg3fa0L7meZVh5xv5xOlgsDTvx9nzZXYMw4Lb6xsHKFPNe+87EIK2Ywuk
   N7fUF53b1wMS+8eF9uexMllNGfMAUA2bPumZSbUAVV8cQ2HhT//RwT9zx
   wExhP8FfrYp3VQlqpoa8cBPXAQDrerXn+X0Rb6QXt0sGcjVeGAjyLt7+y
   9jt9Glr8XizipB8muT8hCLldGzf0O87qKUOQfmlKohSTrRbXm6Vl6mXB/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104923"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104923"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856760"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:55 -0800
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
Subject: [PATCH 12/35] x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Date:   Sun, 30 Jan 2022 13:18:15 -0800
Message-Id: <20220130211838.8382-13-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

When Shadow Stack is introduced, [R/O + _PAGE_DIRTY] PTE is reserved for
shadow stack.  Copy-on-write PTEs have [R/O + _PAGE_COW].

When a PTE goes from [R/W + _PAGE_DIRTY] to [R/O + _PAGE_COW], it could
become a transient shadow stack PTE in two cases:

The first case is that some processors can start a write but end up seeing
a read-only PTE by the time they get to the Dirty bit, creating a transient
shadow stack PTE.  However, this will not occur on processors supporting
Shadow Stack, and a TLB flush is not necessary.

The second case is that when _PAGE_DIRTY is replaced with _PAGE_COW non-
atomically, a transient shadow stack PTE can be created as a result.
Thus, prevent that with cmpxchg.

Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
insights to the issue.  Jann Horn provided the cmpxchg solution.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

Yu-cheng v30:
 - Replace (pmdval_t) cast with CONFIG_PGTABLE_LEVELES > 2 (Borislav Petkov).
 
 arch/x86/include/asm/pgtable.h | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5c3886f6ccda..e1061b9cba6a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1295,6 +1295,24 @@ static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
+	/*
+	 * If Shadow Stack is enabled, pte_wrprotect() moves _PAGE_DIRTY
+	 * to _PAGE_COW (see comments at pte_wrprotect()).
+	 * When a thread reads a RW=1, Dirty=0 PTE and before changing it
+	 * to RW=0, Dirty=0, another thread could have written to the page
+	 * and the PTE is RW=1, Dirty=1 now.  Use try_cmpxchg() to detect
+	 * PTE changes and update old_pte, then try again.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		pte_t old_pte, new_pte;
+
+		old_pte = READ_ONCE(*ptep);
+		do {
+			new_pte = pte_wrprotect(old_pte);
+		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
+
+		return;
+	}
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
 }
 
@@ -1347,6 +1365,26 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
+#if CONFIG_PGTABLE_LEVELS > 2
+	/*
+	 * If Shadow Stack is enabled, pmd_wrprotect() moves _PAGE_DIRTY
+	 * to _PAGE_COW (see comments at pmd_wrprotect()).
+	 * When a thread reads a RW=1, Dirty=0 PMD and before changing it
+	 * to RW=0, Dirty=0, another thread could have written to the page
+	 * and the PMD is RW=1, Dirty=1 now.  Use try_cmpxchg() to detect
+	 * PMD changes and update old_pmd, then try again.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		pmd_t old_pmd, new_pmd;
+
+		old_pmd = READ_ONCE(*pmdp);
+		do {
+			new_pmd = pmd_wrprotect(old_pmd);
+		} while (!try_cmpxchg(&pmdp->pmd, &old_pmd.pmd, new_pmd.pmd));
+
+		return;
+	}
+#endif
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
 }
 
-- 
2.17.1

