Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0681BEBDE
	for <lists+linux-arch@lfdr.de>; Thu, 30 Apr 2020 00:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgD2WKL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Apr 2020 18:10:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:61302 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbgD2WIp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Apr 2020 18:08:45 -0400
IronPort-SDR: r2OocehcYBDuPcMVou8xZGhNm5xLx/lcsap43JsyEF3UAs0J5OWL+AyrQ0vbBiB/i1P6vQ3BAb
 NMh8RiEJ/HdA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 15:08:44 -0700
IronPort-SDR: LwnvSIOPS9ZNghJEg9Q3e0591vT8jzse97LcmPXjjexO8ShrgePxM+ghZSIwpWhfQQYcc1Jmes
 3OTmpai2OZ+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="276308874"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2020 15:08:43 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v10 08/26] x86/mm: Introduce _PAGE_COW
Date:   Wed, 29 Apr 2020 15:07:14 -0700
Message-Id: <20200429220732.31602-9-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is essentially no room left in the x86 hardware PTEs on some OSes
(not Linux).  That left the hardware architects looking for a way to
represent a new memory type (shadow stack) within the existing bits.
They chose to repurpose a lightly-used state: Write=0,Dirty=1.

The reason it's lightly used is that Dirty=1 is normally set by hardware
and cannot normally be set by hardware on a Write=0 PTE.  Software must
normally be involved to create one of these PTEs, so software can simply
opt to not create them.

But that leaves us with a Linux problem: we need to ensure we never create
Write=0,Dirty=1 PTEs.  In places where we do create them, we need to find
an alternative way to represent them _without_ using the same hardware bit
combination.  Thus, enter _PAGE_COW.  This results in the following:

(a) A modified, copy-on-write (COW) page: (R/O + _PAGE_COW)
(b) A R/O page that has been COW'ed: (R/O + _PAGE_COW)
    The user page is in a R/O VMA, and get_user_pages() needs a writable
    copy.  The page fault handler creates a copy of the page and sets
    the new copy's PTE as R/O and _PAGE_COW.
(c) A shadow stack PTE: (R/O + _PAGE_DIRTY_HW)
(d) A shared shadow stack PTE: (R/O + _PAGE_COW)
    When a shadow stack page is being shared among processes (this happens
    at fork()), its PTE is cleared of _PAGE_DIRTY_HW, so the next shadow
    stack access causes a fault, and the page is duplicated and
    _PAGE_DIRTY_HW is set again.  This is the COW equivalent for shadow
    stack pages, even though it's copy-on-access rather than copy-on-write.
(e) A page where the processor observed a Write=1 PTE, started a write, set
    Dirty=1, but then observed a Write=0 PTE.  That's possible today, but
    will not happen on processors that support shadow stack.

Use _PAGE_COW in pte_wrprotect() and _PAGE_DIRTY_HW in pte_mkwrite().
Apply the same changes to pmd and pud.

When this patch is applied, there are six free bits left in the 64-bit PTE.
There are no more free bits in the 32-bit PTE (except for PAE) and shadow
stack is not implemented for the 32-bit kernel.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v10:
- Change _PAGE_BIT_DIRTY_SW to _PAGE_BIT_COW, as it is used for copy-on-
  write PTEs.
- Update pte_write() and treat shadow stack as writable.
- Change *_mkdirty_shstk() to *_mkwrite_shstk() as these make shadow stack
  pages writable.
- Use bit test & shift to move _PAGE_BIT_DIRTY_HW to _PAGE_BIT_COW.
- Change static_cpu_has() to cpu_feature_enabled().
- Revise commit log.

v9:
- Remove pte_move_flags() etc. and put the logic directly in
  pte_wrprotect()/pte_mkwrite() etc.
- Change compile-time conditionals to run-time checks.
- Split out pte_modify()/pmd_modify() to a new patch.
- Update comments.

 arch/x86/include/asm/pgtable.h       | 120 ++++++++++++++++++++++++---
 arch/x86/include/asm/pgtable_types.h |  41 ++++++++-
 2 files changed, 150 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 90f9a73881ad..5f89035d1e60 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -122,9 +122,9 @@ extern pmdval_t early_pmd_flags;
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-static inline int pte_dirty(pte_t pte)
+static inline bool pte_dirty(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_DIRTY_HW;
+	return pte_flags(pte) & _PAGE_DIRTY_BITS;
 }
 
 
@@ -161,9 +161,9 @@ static inline int pte_young(pte_t pte)
 	return pte_flags(pte) & _PAGE_ACCESSED;
 }
 
-static inline int pmd_dirty(pmd_t pmd)
+static inline bool pmd_dirty(pmd_t pmd)
 {
-	return pmd_flags(pmd) & _PAGE_DIRTY_HW;
+	return pmd_flags(pmd) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pmd_young(pmd_t pmd)
@@ -171,9 +171,9 @@ static inline int pmd_young(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_ACCESSED;
 }
 
-static inline int pud_dirty(pud_t pud)
+static inline bool pud_dirty(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_DIRTY_HW;
+	return pud_flags(pud) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pud_young(pud_t pud)
@@ -183,6 +183,12 @@ static inline int pud_young(pud_t pud)
 
 static inline int pte_write(pte_t pte)
 {
+	/*
+	 * If _PAGE_DIRTY_HW is set, the PTE must either have
+	 * _PAGE_RW or be a shadow stack PTE, which is logically writable.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY_HW);
 	return pte_flags(pte) & _PAGE_RW;
 }
 
@@ -333,7 +339,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY_HW);
+	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -343,6 +349,17 @@ static inline pte_t pte_mkold(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PTE (RW=0,Dirty=1).  Move the hardware
+	 * dirty value to the software bit.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		pte.pte |= (pte.pte & _PAGE_DIRTY_HW) >>
+			   _PAGE_BIT_DIRTY_HW << _PAGE_BIT_COW;
+		pte = pte_clear_flags(pte, _PAGE_DIRTY_HW);
+	}
+
 	return pte_clear_flags(pte, _PAGE_RW);
 }
 
@@ -353,6 +370,18 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
+	pteval_t dirty = _PAGE_DIRTY_HW;
+
+	/* Avoid creating (HW)Dirty=1,Write=0 PTEs */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pte_write(pte))
+		dirty = _PAGE_COW;
+
+	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	pte = pte_clear_flags(pte, _PAGE_COW);
 	return pte_set_flags(pte, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
@@ -363,6 +392,13 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
 static inline pte_t pte_mkwrite(pte_t pte)
 {
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		if (pte_flags(pte) & _PAGE_COW) {
+			pte = pte_clear_flags(pte, _PAGE_COW);
+			pte = pte_set_flags(pte, _PAGE_DIRTY_HW);
+		}
+	}
+
 	return pte_set_flags(pte, _PAGE_RW);
 }
 
@@ -434,16 +470,41 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
-	return pmd_clear_flags(pmd, _PAGE_DIRTY_HW);
+	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
 }
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PMD (RW=0,Dirty=1).  Move the hardware
+	 * dirty value to the software bit.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		pmdval_t v = native_pmd_val(pmd);
+
+		v |= (v & _PAGE_DIRTY_HW) >> _PAGE_BIT_DIRTY_HW <<
+		     _PAGE_BIT_COW;
+		pmd = pmd_clear_flags(__pmd(v), _PAGE_DIRTY_HW);
+	}
+
 	return pmd_clear_flags(pmd, _PAGE_RW);
 }
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
+	pmdval_t dirty = _PAGE_DIRTY_HW;
+
+	/* Avoid creating (HW)Dirty=1,Write=0 PMDs */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pmd_flags(pmd) & _PAGE_RW))
+		dirty = _PAGE_COW;
+
+	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
+{
+	pmd = pmd_clear_flags(pmd, _PAGE_COW);
 	return pmd_set_flags(pmd, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
@@ -464,6 +525,13 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 
 static inline pmd_t pmd_mkwrite(pmd_t pmd)
 {
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		if (pmd_flags(pmd) & _PAGE_COW) {
+			pmd = pmd_clear_flags(pmd, _PAGE_COW);
+			pmd = pmd_set_flags(pmd, _PAGE_DIRTY_HW);
+		}
+	}
+
 	return pmd_set_flags(pmd, _PAGE_RW);
 }
 
@@ -488,17 +556,36 @@ static inline pud_t pud_mkold(pud_t pud)
 
 static inline pud_t pud_mkclean(pud_t pud)
 {
-	return pud_clear_flags(pud, _PAGE_DIRTY_HW);
+	return pud_clear_flags(pud, _PAGE_DIRTY_BITS);
 }
 
 static inline pud_t pud_wrprotect(pud_t pud)
 {
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PUD (RW=0,Dirty=1).  Move the hardware
+	 * dirty value to the software bit.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		pudval_t v = native_pud_val(pud);
+
+		v |= (v & _PAGE_DIRTY_HW) >> _PAGE_BIT_DIRTY_HW <<
+		     _PAGE_BIT_COW;
+		pud = pud_clear_flags(__pud(v), _PAGE_DIRTY_HW);
+	}
+
 	return pud_clear_flags(pud, _PAGE_RW);
 }
 
 static inline pud_t pud_mkdirty(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
+	pudval_t dirty = _PAGE_DIRTY_HW;
+
+	/* Avoid creating (HW)Dirty=1,Write=0 PUDs */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pud_flags(pud) & _PAGE_RW))
+		dirty = _PAGE_COW;
+
+	return pud_set_flags(pud, dirty | _PAGE_SOFT_DIRTY);
 }
 
 static inline pud_t pud_mkdevmap(pud_t pud)
@@ -518,6 +605,13 @@ static inline pud_t pud_mkyoung(pud_t pud)
 
 static inline pud_t pud_mkwrite(pud_t pud)
 {
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		if (pud_flags(pud) & _PAGE_COW) {
+			pud = pud_clear_flags(pud, _PAGE_COW);
+			pud = pud_set_flags(pud, _PAGE_DIRTY_HW);
+		}
+	}
+
 	return pud_set_flags(pud, _PAGE_RW);
 }
 
@@ -1218,6 +1312,12 @@ extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #define pmd_write pmd_write
 static inline int pmd_write(pmd_t pmd)
 {
+	/*
+	 * If _PAGE_DIRTY_HW is set, then the PMD must either have
+	 * _PAGE_RW or be a shadow stack PMD, which is logically writable.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pmd_flags(pmd) & (_PAGE_RW | _PAGE_DIRTY_HW);
 	return pmd_flags(pmd) & _PAGE_RW;
 }
 
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 522b80b952f4..74229db078ce 100644
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
@@ -36,6 +37,16 @@
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
+/*
+ * This bit indicates a copy-on-write page, and is different from
+ * _PAGE_BIT_SOFT_DIRTY, which tracks which pages a task writes to.
+ */
+#ifdef CONFIG_X86_64
+#define _PAGE_BIT_COW		_PAGE_BIT_SOFTW5 /* copy-on-write */
+#else
+#define _PAGE_BIT_COW		0
+#endif
+
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
 /* - if the user mapped it with PROT_NONE; pte_present gives true */
 #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
@@ -117,6 +128,34 @@
 #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
 #endif
 
+/*
+ * _PAGE_COW is used to separate R/O and copy-on-write PTEs created by
+ * software from the shadow stack PTE setting required by the hardware:
+ * (a) A modified, copy-on-write (COW) page: (R/O + _PAGE_COW)
+ * (b) A R/O page that has been COW'ed: (R/O +_PAGE_COW)
+ *     The user page is in a R/O VMA, and get_user_pages() needs a
+ *     writable copy.  The page fault handler creates a copy of the page
+ *     and sets the new copy's PTE as R/O and _PAGE_COW.
+ * (c) A shadow stack PTE: (R/O + _PAGE_DIRTY_HW)
+ * (d) A shared (copy-on-access) shadow stack PTE: (R/O + _PAGE_COW)
+ *     When a shadow stack page is being shared among processes (this
+ *     happens at fork()), its PTE is cleared of _PAGE_DIRTY_HW, so the
+ *     next shadow stack access causes a fault, and the page is duplicated
+ *     and _PAGE_DIRTY_HW is set again.  This is the COW equivalent for
+ *     shadow stack pages, even though it's copy-on-access rather than
+ *     copy-on-write.
+ * (e) A page where the processor observed a Write=1 PTE, started a write,
+ *     set Dirty=1, but then observed a Write=0 PTE.  That's possible
+ *     today, but will not happen on processors that support shadow stack.
+ */
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+#define _PAGE_COW	(_AT(pteval_t, 1) << _PAGE_BIT_COW)
+#else
+#define _PAGE_COW	(_AT(pteval_t, 0))
+#endif
+
+#define _PAGE_DIRTY_BITS (_PAGE_DIRTY_HW | _PAGE_COW)
+
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 /*
-- 
2.21.0

