Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07BA8C30D
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfHMVF3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:05:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:16072 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfHMVCs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:02:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="187901393"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2019 14:02:46 -0700
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
Subject: [PATCH v8 11/27] x86/mm: Introduce _PAGE_DIRTY_SW
Date:   Tue, 13 Aug 2019 13:52:09 -0700
Message-Id: <20190813205225.12032-12-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205225.12032-1-yu-cheng.yu@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A RO and dirty PTE exists in the following cases:

(a) A page is modified and then shared with a fork()'ed child;
(b) A R/O page that has been COW'ed;
(c) A SHSTK page.

The processor does not read the dirty bit for (a) and (b), but
checks the dirty bit for (c).  To prevent the use of non-SHSTK
memory as SHSTK, we introduce a spare bit of the 64-bit PTE as
_PAGE_BIT_DIRTY_SW and use that for (a) and (b).  This results
to the following possible PTE settings:

Modified PTE:             (R/W + DIRTY_HW)
Modified and shared PTE:  (R/O + DIRTY_SW)
R/O PTE COW'ed:           (R/O + DIRTY_SW)
SHSTK PTE:                (R/O + DIRTY_HW)
SHSTK PTE COW'ed:         (R/O + DIRTY_HW)
SHSTK PTE shared:         (R/O + DIRTY_SW)

Note that _PAGE_BIT_DRITY_SW is only used in R/O PTEs but
not R/W PTEs.

When this patch is applied, there are six free bits left in
the 64-bit PTE.  There is no more free bit in the 32-bit
PTE (except for PAE) and shadow stack is not implemented
for the 32-bit kernel.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/pgtable.h       | 129 ++++++++++++++++++++++-----
 arch/x86/include/asm/pgtable_types.h |  21 ++++-
 2 files changed, 128 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 8e38d87fce6e..1448fb38f248 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -120,9 +120,9 @@ extern pmdval_t early_pmd_flags;
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-static inline int pte_dirty(pte_t pte)
+static inline bool pte_dirty(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_DIRTY;
+	return pte_flags(pte) & _PAGE_DIRTY_BITS;
 }
 
 
@@ -159,9 +159,9 @@ static inline int pte_young(pte_t pte)
 	return pte_flags(pte) & _PAGE_ACCESSED;
 }
 
-static inline int pmd_dirty(pmd_t pmd)
+static inline bool pmd_dirty(pmd_t pmd)
 {
-	return pmd_flags(pmd) & _PAGE_DIRTY;
+	return pmd_flags(pmd) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pmd_young(pmd_t pmd)
@@ -169,9 +169,9 @@ static inline int pmd_young(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_ACCESSED;
 }
 
-static inline int pud_dirty(pud_t pud)
+static inline bool pud_dirty(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_DIRTY;
+	return pud_flags(pud) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pud_young(pud_t pud)
@@ -310,9 +310,23 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+#if defined(CONFIG_X86_INTEL_SHADOW_STACK_USER)
+static inline pte_t pte_move_flags(pte_t pte, pteval_t from, pteval_t to)
+{
+	if (pte_flags(pte) & from)
+		pte = pte_set_flags(pte_clear_flags(pte, from), to);
+	return pte;
+}
+#else
+static inline pte_t pte_move_flags(pte_t pte, pteval_t from, pteval_t to)
+{
+	return pte;
+}
+#endif
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -322,6 +336,7 @@ static inline pte_t pte_mkold(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
+	pte = pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
 	return pte_clear_flags(pte, _PAGE_RW);
 }
 
@@ -332,9 +347,24 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
+	pteval_t dirty = (!IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER) ||
+			   pte_write(pte)) ? _PAGE_DIRTY_HW:_PAGE_DIRTY_SW;
+	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
+}
+
+#ifdef CONFIG_ARCH_HAS_SHSTK
+static inline pte_t pte_mkdirty_shstk(pte_t pte)
+{
+	pte = pte_clear_flags(pte, _PAGE_DIRTY_SW);
 	return pte_set_flags(pte, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
+static inline bool pte_dirty_hw(pte_t pte)
+{
+	return pte_flags(pte) & _PAGE_DIRTY_HW;
+}
+#endif
+
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	return pte_set_flags(pte, _PAGE_ACCESSED);
@@ -342,6 +372,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
 static inline pte_t pte_mkwrite(pte_t pte)
 {
+	pte = pte_move_flags(pte, _PAGE_DIRTY_SW, _PAGE_DIRTY_HW);
 	return pte_set_flags(pte, _PAGE_RW);
 }
 
@@ -389,6 +420,20 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 	return native_make_pmd(v & ~clear);
 }
 
+#if defined(CONFIG_X86_INTEL_SHADOW_STACK_USER)
+static inline pmd_t pmd_move_flags(pmd_t pmd, pmdval_t from, pmdval_t to)
+{
+	if (pmd_flags(pmd) & from)
+		pmd = pmd_set_flags(pmd_clear_flags(pmd, from), to);
+	return pmd;
+}
+#else
+static inline pmd_t pmd_move_flags(pmd_t pmd, pmdval_t from, pmdval_t to)
+{
+	return pmd;
+}
+#endif
+
 static inline pmd_t pmd_mkold(pmd_t pmd)
 {
 	return pmd_clear_flags(pmd, _PAGE_ACCESSED);
@@ -396,19 +441,36 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
-	return pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
 }
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
+	pmd = pmd_move_flags(pmd, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
 	return pmd_clear_flags(pmd, _PAGE_RW);
 }
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
+	pmdval_t dirty = (!IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER) ||
+			  (pmd_flags(pmd) & _PAGE_RW)) ?
+			  _PAGE_DIRTY_HW:_PAGE_DIRTY_SW;
+	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
+}
+
+#ifdef CONFIG_ARCH_HAS_SHSTK
+static inline pmd_t pmd_mkdirty_shstk(pmd_t pmd)
+{
+	pmd = pmd_clear_flags(pmd, _PAGE_DIRTY_SW);
 	return pmd_set_flags(pmd, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
+static inline bool pmd_dirty_hw(pmd_t pmd)
+{
+	return  pmd_flags(pmd) & _PAGE_DIRTY_HW;
+}
+#endif
+
 static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_DEVMAP);
@@ -426,6 +488,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 
 static inline pmd_t pmd_mkwrite(pmd_t pmd)
 {
+	pmd = pmd_move_flags(pmd, _PAGE_DIRTY_SW, _PAGE_DIRTY_HW);
 	return pmd_set_flags(pmd, _PAGE_RW);
 }
 
@@ -443,6 +506,20 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 	return native_make_pud(v & ~clear);
 }
 
+#if defined(CONFIG_X86_INTEL_SHADOW_STACK_USER)
+static inline pud_t pud_move_flags(pud_t pud, pudval_t from, pudval_t to)
+{
+	if (pud_flags(pud) & from)
+		pud = pud_set_flags(pud_clear_flags(pud, from), to);
+	return pud;
+}
+#else
+static inline pud_t pud_move_flags(pud_t pud, pudval_t from, pudval_t to)
+{
+	return pud;
+}
+#endif
+
 static inline pud_t pud_mkold(pud_t pud)
 {
 	return pud_clear_flags(pud, _PAGE_ACCESSED);
@@ -450,17 +527,22 @@ static inline pud_t pud_mkold(pud_t pud)
 
 static inline pud_t pud_mkclean(pud_t pud)
 {
-	return pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_clear_flags(pud, _PAGE_DIRTY_BITS);
 }
 
 static inline pud_t pud_wrprotect(pud_t pud)
 {
+	pud = pud_move_flags(pud, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
 	return pud_clear_flags(pud, _PAGE_RW);
 }
 
 static inline pud_t pud_mkdirty(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
+	pudval_t dirty = (!IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER) ||
+			  (pud_flags(pud) & _PAGE_RW)) ?
+			  _PAGE_DIRTY_HW:_PAGE_DIRTY_SW;
+
+	return pud_set_flags(pud, dirty | _PAGE_SOFT_DIRTY);
 }
 
 static inline pud_t pud_mkdevmap(pud_t pud)
@@ -480,6 +562,7 @@ static inline pud_t pud_mkyoung(pud_t pud)
 
 static inline pud_t pud_mkwrite(pud_t pud)
 {
+	pud = pud_move_flags(pud, _PAGE_DIRTY_SW, _PAGE_DIRTY_HW);
 	return pud_set_flags(pud, _PAGE_RW);
 }
 
@@ -611,19 +694,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	val &= _PAGE_CHG_MASK;
 	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
 	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
+	if ((pte_write(pte) && !(pgprot_val(newprot) & _PAGE_RW)))
+		return pte_move_flags(__pte(val), _PAGE_DIRTY_HW,
+				      _PAGE_DIRTY_SW);
 	return __pte(val);
 }
 
-static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
-{
-	pmdval_t val = pmd_val(pmd), oldval = val;
-
-	val &= _HPAGE_CHG_MASK;
-	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
-	val = flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
-	return __pmd(val);
-}
-
 /* mprotect needs to preserve PAT bits when updating vm_page_prot */
 #define pgprot_modify pgprot_modify
 static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
@@ -1178,6 +1254,19 @@ static inline int pmd_write(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_RW;
 }
 
+static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
+{
+	pmdval_t val = pmd_val(pmd), oldval = val;
+
+	val &= _HPAGE_CHG_MASK;
+	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
+	val = flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
+	if ((pmd_write(pmd) && !(pgprot_val(newprot) & _PAGE_RW)))
+		return pmd_move_flags(__pmd(val), _PAGE_DIRTY_HW,
+				      _PAGE_DIRTY_SW);
+	return __pmd(val);
+}
+
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pmd_t *pmdp)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index e647e3c75578..cd95afc82e9f 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -23,6 +23,7 @@
 #define _PAGE_BIT_SOFTW2	10	/* " */
 #define _PAGE_BIT_SOFTW3	11	/* " */
 #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
+#define _PAGE_BIT_SOFTW5	57	/* available for programmer */
 #define _PAGE_BIT_SOFTW4	58	/* available for programmer */
 #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
 #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
@@ -34,6 +35,7 @@
 #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
+#define _PAGE_BIT_DIRTY_SW	_PAGE_BIT_SOFTW5 /* was written to */
 
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
 /* - if the user mapped it with PROT_NONE; pte_present gives true */
@@ -108,6 +110,21 @@
 #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
 #endif
 
+/*
+ * _PAGE_DIRTY_HW: set by the processor when a page is written.
+ * _PAGE_DIRTY_SW: a spare bit tracking a written, but now R/O page.
+ *   [R/W + _PAGE_DIRTY_HW] <-> [R/O + _PAGE_DIRTY_SW].
+ * _PAGE_SOFT_DIRTY: a spare bit used to track written pages since a time point
+ * set by the system admin; see Documentation/admin-guide/mm/soft-dirty.rst.
+ */
+#if defined(CONFIG_X86_INTEL_SHADOW_STACK_USER)
+#define _PAGE_DIRTY_SW	(_AT(pteval_t, 1) << _PAGE_BIT_DIRTY_SW)
+#else
+#define _PAGE_DIRTY_SW	(_AT(pteval_t, 0))
+#endif
+
+#define _PAGE_DIRTY_BITS (_PAGE_DIRTY_HW | _PAGE_DIRTY_SW)
+
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 #define _PAGE_TABLE_NOENC	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |\
@@ -121,9 +138,9 @@
  * instance, and is *not* included in this mask since
  * pte_modify() does modify it.
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
+#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |			\
 			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY_HW |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
+			 _PAGE_DIRTY_SW | _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
 
 /*
-- 
2.17.1

