Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8E41537D7
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgBESWD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 13:22:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:20940 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgBESU2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 10:20:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="279447778"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2020 10:20:26 -0800
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
Subject: [RFC PATCH v9 09/27] x86/mm: Introduce _PAGE_DIRTY_SW
Date:   Wed,  5 Feb 2020 10:19:17 -0800
Message-Id: <20200205181935.3712-10-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200205181935.3712-1-yu-cheng.yu@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When Shadow Stack (SHSTK) is introduced, a R/O and Dirty PTE exists in the
following cases:

(a) A modified, copy-on-write (COW) page;
(b) A R/O page that has been COW'ed;
(c) A SHSTK page.

To separate non-SHSTK memory from SHSTK, introduce a spare bit of the
64-bit PTE as _PAGE_BIT_DIRTY_SW and use that for case (a) and (b).
This results in the following possible settings:

Modified PTE:         (R/W + DIRTY_HW)
Modified and COW PTE: (R/O + DIRTY_SW)
R/O PTE COW'ed:       (R/O + DIRTY_SW)
SHSTK PTE:            (R/O + DIRTY_HW)
SHSTK shared PTE[1]:  (R/O + DIRTY_SW)
SHSTK PTE COW'ed:     (R/O + DIRTY_HW)

[1] When a SHSTK page is being shared among threads, its PTE is cleared of
    _PAGE_DIRTY_HW, so the next SHSTK access causes a fault, and the page
    is duplicated and _PAGE_DIRTY_HW is set again.

With this, in pte_wrprotect(), if SHSTK is active, use _PAGE_DIRTY_SW for
the Dirty bit, and in pte_mkwrite() use _PAGE_DIRTY_HW.  The same changes
apply to pmd and pud.

When this patch is applied, there are six free bits left in the 64-bit PTE.
There are no more free bits in the 32-bit PTE (except for PAE) and SHSTK is
not implemented for the 32-bit kernel.

v9:
- Remove pte_move_flags() etc. and put the logic directly in
  pte_wrprotect()/pte_mkwrite() etc.
- Change compile-time conditionals to run-time checks.
- Split out pte_modify()/pmd_modify() to a new patch.
- Update comments.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/pgtable.h       | 111 ++++++++++++++++++++++++---
 arch/x86/include/asm/pgtable_types.h |  31 +++++++-
 2 files changed, 131 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index ab50d25f9afc..62aeb118bc36 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -120,9 +120,9 @@ extern pmdval_t early_pmd_flags;
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-static inline int pte_dirty(pte_t pte)
+static inline bool pte_dirty(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_DIRTY_HW;
+	return pte_flags(pte) & _PAGE_DIRTY_BITS;
 }
 
 
@@ -159,9 +159,9 @@ static inline int pte_young(pte_t pte)
 	return pte_flags(pte) & _PAGE_ACCESSED;
 }
 
-static inline int pmd_dirty(pmd_t pmd)
+static inline bool pmd_dirty(pmd_t pmd)
 {
-	return pmd_flags(pmd) & _PAGE_DIRTY_HW;
+	return pmd_flags(pmd) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pmd_young(pmd_t pmd)
@@ -169,9 +169,9 @@ static inline int pmd_young(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_ACCESSED;
 }
 
-static inline int pud_dirty(pud_t pud)
+static inline bool pud_dirty(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_DIRTY_HW;
+	return pud_flags(pud) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pud_young(pud_t pud)
@@ -312,7 +312,7 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY_HW);
+	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -322,6 +322,17 @@ static inline pte_t pte_mkold(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
+	/*
+	 * Use _PAGE_DIRTY_SW on a R/O PTE to set it apart from
+	 * a Shadow Stack PTE, which is R/O + _PAGE_DIRTY_HW.
+	 */
+	if (static_cpu_has(X86_FEATURE_SHSTK)) {
+		if (pte_flags(pte) & _PAGE_DIRTY_HW) {
+			pte = pte_clear_flags(pte, _PAGE_DIRTY_HW);
+			pte = pte_set_flags(pte, _PAGE_DIRTY_SW);
+		}
+	}
+
 	return pte_clear_flags(pte, _PAGE_RW);
 }
 
@@ -332,9 +343,25 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
+	pteval_t dirty = _PAGE_DIRTY_HW;
+
+	if (static_cpu_has(X86_FEATURE_SHSTK) && !pte_write(pte))
+		dirty = _PAGE_DIRTY_SW;
+
+	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_mkdirty_shstk(pte_t pte)
+{
+	pte = pte_clear_flags(pte, _PAGE_DIRTY_SW);
 	return pte_set_flags(pte, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
+static inline bool pte_dirty_hw(pte_t pte)
+{
+	return pte_flags(pte) & _PAGE_DIRTY_HW;
+}
+
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	return pte_set_flags(pte, _PAGE_ACCESSED);
@@ -342,6 +369,13 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
 static inline pte_t pte_mkwrite(pte_t pte)
 {
+	if (static_cpu_has(X86_FEATURE_SHSTK)) {
+		if (pte_flags(pte) & _PAGE_DIRTY_SW) {
+			pte = pte_clear_flags(pte, _PAGE_DIRTY_SW);
+			pte = pte_set_flags(pte, _PAGE_DIRTY_HW);
+		}
+	}
+
 	return pte_set_flags(pte, _PAGE_RW);
 }
 
@@ -396,19 +430,46 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
-	return pmd_clear_flags(pmd, _PAGE_DIRTY_HW);
+	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
 }
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
+	/*
+	 * Use _PAGE_DIRTY_SW on a R/O PMD to set it apart from
+	 * a Shadow Stack PTE, which is R/O + _PAGE_DIRTY_HW.
+	 */
+	if (static_cpu_has(X86_FEATURE_SHSTK)) {
+		if (pmd_flags(pmd) & _PAGE_DIRTY_HW) {
+			pmd = pmd_clear_flags(pmd, _PAGE_DIRTY_HW);
+			pmd = pmd_set_flags(pmd, _PAGE_DIRTY_SW);
+		}
+	}
+
 	return pmd_clear_flags(pmd, _PAGE_RW);
 }
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
+	pmdval_t dirty = _PAGE_DIRTY_HW;
+
+	if (static_cpu_has(X86_FEATURE_SHSTK) && !(pmd_flags(pmd) & _PAGE_RW))
+		dirty = _PAGE_DIRTY_SW;
+
+	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pmd_t pmd_mkdirty_shstk(pmd_t pmd)
+{
+	pmd = pmd_clear_flags(pmd, _PAGE_DIRTY_SW);
 	return pmd_set_flags(pmd, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
+static inline bool pmd_dirty_hw(pmd_t pmd)
+{
+	return  pmd_flags(pmd) & _PAGE_DIRTY_HW;
+}
+
 static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_DEVMAP);
@@ -426,6 +487,13 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 
 static inline pmd_t pmd_mkwrite(pmd_t pmd)
 {
+	if (static_cpu_has(X86_FEATURE_SHSTK)) {
+		if (pmd_flags(pmd) & _PAGE_DIRTY_SW) {
+			pmd = pmd_clear_flags(pmd, _PAGE_DIRTY_SW);
+			pmd = pmd_set_flags(pmd, _PAGE_DIRTY_HW);
+		}
+	}
+
 	return pmd_set_flags(pmd, _PAGE_RW);
 }
 
@@ -450,17 +518,33 @@ static inline pud_t pud_mkold(pud_t pud)
 
 static inline pud_t pud_mkclean(pud_t pud)
 {
-	return pud_clear_flags(pud, _PAGE_DIRTY_HW);
+	return pud_clear_flags(pud, _PAGE_DIRTY_BITS);
 }
 
 static inline pud_t pud_wrprotect(pud_t pud)
 {
+	/*
+	 * Use _PAGE_DIRTY_SW on a R/O PUD to set it apart from
+	 * a Shadow Stack PTE, which is R/O + _PAGE_DIRTY_HW.
+	 */
+	if (static_cpu_has(X86_FEATURE_SHSTK)) {
+		if (pud_flags(pud) & _PAGE_DIRTY_HW) {
+			pud = pud_clear_flags(pud, _PAGE_DIRTY_HW);
+			pud = pud_set_flags(pud, _PAGE_DIRTY_SW);
+		}
+	}
+
 	return pud_clear_flags(pud, _PAGE_RW);
 }
 
 static inline pud_t pud_mkdirty(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
+	pudval_t dirty = _PAGE_DIRTY_HW;
+
+	if (static_cpu_has(X86_FEATURE_SHSTK) && !(pud_flags(pud) & _PAGE_RW))
+		dirty = _PAGE_DIRTY_SW;
+
+	return pud_set_flags(pud, dirty | _PAGE_SOFT_DIRTY);
 }
 
 static inline pud_t pud_mkdevmap(pud_t pud)
@@ -480,6 +564,13 @@ static inline pud_t pud_mkyoung(pud_t pud)
 
 static inline pud_t pud_mkwrite(pud_t pud)
 {
+	if (static_cpu_has(X86_FEATURE_SHSTK)) {
+		if (pud_flags(pud) & _PAGE_DIRTY_SW) {
+			pud = pud_clear_flags(pud, _PAGE_DIRTY_SW);
+			pud = pud_set_flags(pud, _PAGE_DIRTY_HW);
+		}
+	}
+
 	return pud_set_flags(pud, _PAGE_RW);
 }
 
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index e647e3c75578..826823df917f 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -23,7 +23,8 @@
 #define _PAGE_BIT_SOFTW2	10	/* " */
 #define _PAGE_BIT_SOFTW3	11	/* " */
 #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
-#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
+#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
+#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
 #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
 #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
 #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
@@ -35,6 +36,12 @@
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
+/*
+ * This bit indicates a copy-on-write page, and is different from
+ * _PAGE_BIT_SOFT_DIRTY, which tracks which pages a task writes to.
+ */
+#define _PAGE_BIT_DIRTY_SW	_PAGE_BIT_SOFTW5 /* was written to */
+
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
 /* - if the user mapped it with PROT_NONE; pte_present gives true */
 #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
@@ -108,6 +115,28 @@
 #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
 #endif
 
+/* A R/O and dirty PTE exists in the following cases:
+ *	(a) A modified, copy-on-write (COW) page;
+ *	(b) A R/O page that has been COW'ed;
+ *	(c) A SHSTK page.
+ * _PAGE_DIRTY_SW is used to separate case (c) from others.
+ * This results in the following settings:
+ *
+ *	Modified PTE:         (R/W + DIRTY_HW)
+ *	Modified and COW PTE: (R/O + DIRTY_SW)
+ *	R/O PTE COW'ed:       (R/O + DIRTY_SW)
+ *	SHSTK PTE:            (R/O + DIRTY_HW)
+ *	SHSTK PTE COW'ed:     (R/O + DIRTY_HW)
+ *	SHSTK PTE being shared among threads: (R/O + DIRTY_SW)
+ */
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+#define _PAGE_DIRTY_SW	(_AT(pteval_t, 1) << _PAGE_BIT_DIRTY_SW)
+#else
+#define _PAGE_DIRTY_SW	(_AT(pteval_t, 0))
+#endif
+
+#define _PAGE_DIRTY_BITS (_PAGE_DIRTY_HW | _PAGE_DIRTY_SW)
+
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 #define _PAGE_TABLE_NOENC	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |\
-- 
2.21.0

