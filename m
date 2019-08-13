Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7C8C308
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfHMVFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:05:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:16072 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfHMVCu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:02:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="187901416"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2019 14:02:49 -0700
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
Subject: [PATCH v8 13/27] x86/mm: Modify ptep_set_wrprotect and pmdp_set_wrprotect for _PAGE_DIRTY_SW
Date:   Tue, 13 Aug 2019 13:52:11 -0700
Message-Id: <20190813205225.12032-14-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205225.12032-1-yu-cheng.yu@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When Shadow Stack is enabled, the [R/O + PAGE_DIRTY_HW] setting is
reserved only for the Shadow Stack.  Non-Shadow Stack R/O PTEs use
[R/O + PAGE_DIRTY_SW].

When a PTE goes from [R/W + PAGE_DIRTY_HW] to [R/O + PAGE_DIRTY_SW],
it could become a transient Shadow Stack PTE in two cases.

The first case is that some processors can start a write but end up
seeing a read-only PTE by the time they get to the Dirty bit,
creating a transient Shadow Stack PTE.  However, this will not occur
on processors supporting Shadow Stack therefore we don't need a TLB
flush here.

The second case is that when the software, without atomic, tests &
replaces PAGE_DIRTY_HW with PAGE_DIRTY_SW, a transient Shadow Stack
PTE can exist.  This is prevented with cmpxchg.

Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided
many insights to the issue.  Jann Horn provided the cmpxchg solution.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/pgtable.h | 58 ++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 1448fb38f248..81c8c5ec221e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1222,7 +1222,36 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+	pte_t new_pte, pte = READ_ONCE(*ptep);
+
+	/*
+	 * Some processors can start a write, but end up
+	 * seeing a read-only PTE by the time they get
+	 * to the Dirty bit.  In this case, they will
+	 * set the Dirty bit, leaving a read-only, Dirty
+	 * PTE which looks like a Shadow Stack PTE.
+	 *
+	 * However, this behavior has been improved and
+	 * will not occur on processors supporting
+	 * Shadow Stacks.  Without this guarantee, a
+	 * transition to a non-present PTE and flush the
+	 * TLB would be needed.
+	 *
+	 * When changing a writable PTE to read-only and
+	 * if the PTE has _PAGE_DIRTY_HW set, we move
+	 * that bit to _PAGE_DIRTY_SW so that the PTE is
+	 * not a valid Shadow Stack PTE.
+	 */
+	do {
+		new_pte = pte_wrprotect(pte);
+		new_pte.pte |= (new_pte.pte & _PAGE_DIRTY_HW) >>
+				_PAGE_BIT_DIRTY_HW << _PAGE_BIT_DIRTY_SW;
+		new_pte.pte &= ~_PAGE_DIRTY_HW;
+	} while (!try_cmpxchg(ptep, &pte, new_pte));
+#else
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
+#endif
 }
 
 #define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
@@ -1285,7 +1314,36 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+	pmd_t new_pmd, pmd = READ_ONCE(*pmdp);
+
+	/*
+	 * Some processors can start a write, but end up
+	 * seeing a read-only PMD by the time they get
+	 * to the Dirty bit.  In this case, they will
+	 * set the Dirty bit, leaving a read-only, Dirty
+	 * PMD which looks like a Shadow Stack PMD.
+	 *
+	 * However, this behavior has been improved and
+	 * will not occur on processors supporting
+	 * Shadow Stacks.  Without this guarantee, a
+	 * transition to a non-present PMD and flush the
+	 * TLB would be needed.
+	 *
+	 * When changing a writable PMD to read-only and
+	 * if the PMD has _PAGE_DIRTY_HW set, we move
+	 * that bit to _PAGE_DIRTY_SW so that the PMD is
+	 * not a valid Shadow Stack PMD.
+	 */
+	do {
+		new_pmd = pmd_wrprotect(pmd);
+		new_pmd.pmd |= (new_pmd.pmd & _PAGE_DIRTY_HW) >>
+				_PAGE_BIT_DIRTY_HW << _PAGE_BIT_DIRTY_SW;
+		new_pmd.pmd &= ~_PAGE_DIRTY_HW;
+	} while (!try_cmpxchg(pmdp, &pmd, new_pmd));
+#else
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
+#endif
 }
 
 #define pud_write pud_write
-- 
2.17.1

