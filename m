Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C801636CCAD
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 22:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbhD0UpU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 16:45:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:31798 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239110AbhD0UpI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Apr 2021 16:45:08 -0400
IronPort-SDR: U2jTelwDvwUlO5OEB5XEEq01ZL7Y35EpaJWuAkkoNMwMP6/dx885CTOAfdW6pscYEpFL1ytMn0
 gUHz50vHWnlA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="281922463"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="281922463"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:44:12 -0700
IronPort-SDR: YEqKw5Clm46VkyL7SMI1DkZfYOGTKDUy8ls0zTVWqGqnGjcJ6L7LStffc1UqIvFtwlFZCfNm1p
 Yrj/IZidempA==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="465623466"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:44:11 -0700
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
Subject: [PATCH v26 09/30] x86/mm: Introduce _PAGE_COW
Date:   Tue, 27 Apr 2021 13:42:54 -0700
Message-Id: <20210427204315.24153-10-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210427204315.24153-1-yu-cheng.yu@intel.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is essentially no room left in the x86 hardware PTEs on some OSes
(not Linux).  That left the hardware architects looking for a way to
represent a new memory type (shadow stack) within the existing bits.
They chose to repurpose a lightly-used state: Write=0, Dirty=1.

The reason it's lightly used is that Dirty=1 is normally set by hardware
and cannot normally be set by hardware on a Write=0 PTE.  Software must
normally be involved to create one of these PTEs, so software can simply
opt to not create them.

In places where Linux normally creates Write=0, Dirty=1, it can use the
software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY.  In other
words, whenever Linux needs to create Write=0, Dirty=1, it instead creates
Write=0, Cow=1, except for shadow stack, which is Write=0, Dirty=1.  This
clearly separates shadow stack from other data, and results in the
following:

(a) A modified, copy-on-write (COW) page: (Write=0, Cow=1)
(b) A R/O page that has been COW'ed: (Write=0, Cow=1)
    The user page is in a R/O VMA, and get_user_pages() needs a writable
    copy.  The page fault handler creates a copy of the page and sets
    the new copy's PTE as Write=0 and Cow=1.
(c) A shadow stack PTE: (Write=0, Dirty=1)
(d) A shared shadow stack PTE: (Write=0, Cow=1)
    When a shadow stack page is being shared among processes (this happens
    at fork()), its PTE is made Dirty=0, so the next shadow stack access
    causes a fault, and the page is duplicated and Dirty=1 is set again.
    This is the COW equivalent for shadow stack pages, even though it's
    copy-on-access rather than copy-on-write.
(e) A page where the processor observed a Write=1 PTE, started a write, set
    Dirty=1, but then observed a Write=0 PTE.  That's possible today, but
    will not happen on processors that support shadow stack.

Define _PAGE_COW and update pte_*() helpers and apply the same changes to
pmd and pud.

After this, there are six free bits left in the 64-bit PTE, and no more
free bits in the 32-bit PTE (except for PAE) and Shadow Stack is not
implemented for the 32-bit kernel.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v24:
- Replace CONFIG_X86_CET with CONFIG_X86_SHADOW_STACK, to reflect the Kconfig
  changes.

 arch/x86/include/asm/pgtable.h       | 195 ++++++++++++++++++++++++---
 arch/x86/include/asm/pgtable_types.h |  42 +++++-
 2 files changed, 216 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index c1650d0af1b5..9c056d5815de 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -121,11 +121,21 @@ extern pmdval_t early_pmd_flags;
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-static inline int pte_dirty(pte_t pte)
+static inline bool pte_dirty(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_DIRTY;
+	/*
+	 * A dirty PTE has Dirty=1 or Cow=1.
+	 */
+	return pte_flags(pte) & _PAGE_DIRTY_BITS;
 }
 
+static inline bool pte_shstk(pte_t pte)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return false;
+
+	return (pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
+}
 
 static inline u32 read_pkru(void)
 {
@@ -160,9 +170,20 @@ static inline int pte_young(pte_t pte)
 	return pte_flags(pte) & _PAGE_ACCESSED;
 }
 
-static inline int pmd_dirty(pmd_t pmd)
+static inline bool pmd_dirty(pmd_t pmd)
+{
+	/*
+	 * A dirty PMD has Dirty=1 or Cow=1.
+	 */
+	return pmd_flags(pmd) & _PAGE_DIRTY_BITS;
+}
+
+static inline bool pmd_shstk(pmd_t pmd)
 {
-	return pmd_flags(pmd) & _PAGE_DIRTY;
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return false;
+
+	return (pmd_flags(pmd) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
 }
 
 static inline int pmd_young(pmd_t pmd)
@@ -170,9 +191,12 @@ static inline int pmd_young(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_ACCESSED;
 }
 
-static inline int pud_dirty(pud_t pud)
+static inline bool pud_dirty(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_DIRTY;
+	/*
+	 * A dirty PUD has Dirty=1 or Cow=1.
+	 */
+	return pud_flags(pud) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pud_young(pud_t pud)
@@ -182,13 +206,23 @@ static inline int pud_young(pud_t pud)
 
 static inline int pte_write(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_RW;
+	/*
+	 * Shadow stack pages are always writable - but not by normal
+	 * instructions, and only by shadow stack operations.  Therefore,
+	 * the W=0,D=1 test with pte_shstk().
+	 */
+	return (pte_flags(pte) & _PAGE_RW) || pte_shstk(pte);
 }
 
 #define pmd_write pmd_write
 static inline int pmd_write(pmd_t pmd)
 {
-	return pmd_flags(pmd) & _PAGE_RW;
+	/*
+	 * Shadow stack pages are always writable - but not by normal
+	 * instructions, and only by shadow stack operations.  Therefore,
+	 * the W=0,D=1 test with pmd_shstk().
+	 */
+	return (pmd_flags(pmd) & _PAGE_RW) || pmd_shstk(pmd);
 }
 
 #define pud_write pud_write
@@ -326,6 +360,24 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+static inline pte_t pte_mkcow(pte_t pte)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pte;
+
+	pte = pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_set_flags(pte, _PAGE_COW);
+}
+
+static inline pte_t pte_clear_cow(pte_t pte)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pte;
+
+	pte = pte_set_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_COW);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
@@ -345,7 +397,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -355,7 +407,16 @@ static inline pte_t pte_mkold(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_RW);
+	pte = pte_clear_flags(pte, _PAGE_RW);
+
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PTE (RW=0, Dirty=1).  Move the hardware
+	 * dirty value to the software bit.
+	 */
+	if (pte_dirty(pte))
+		pte = pte_mkcow(pte);
+	return pte;
 }
 
 static inline pte_t pte_mkexec(pte_t pte)
@@ -365,7 +426,18 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pteval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating (HW)Dirty=1, Write=0 PTEs */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pte_write(pte))
+		dirty = _PAGE_COW;
+
+	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return pte_clear_cow(pte);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
@@ -375,7 +447,12 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
 static inline pte_t pte_mkwrite(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_RW);
+	pte = pte_set_flags(pte, _PAGE_RW);
+
+	if (pte_dirty(pte))
+		pte = pte_clear_cow(pte);
+
+	return pte;
 }
 
 static inline pte_t pte_mkhuge(pte_t pte)
@@ -422,6 +499,24 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 	return native_make_pmd(v & ~clear);
 }
 
+static inline pmd_t pmd_mkcow(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pmd;
+
+	pmd = pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_set_flags(pmd, _PAGE_COW);
+}
+
+static inline pmd_t pmd_clear_cow(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pmd;
+
+	pmd = pmd_set_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_COW);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pmd_uffd_wp(pmd_t pmd)
 {
@@ -446,17 +541,36 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
-	return pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
 }
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
-	return pmd_clear_flags(pmd, _PAGE_RW);
+	pmd = pmd_clear_flags(pmd, _PAGE_RW);
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PMD (RW=0, Dirty=1).  Move the hardware
+	 * dirty value to the software bit.
+	 */
+	if (pmd_dirty(pmd))
+		pmd = pmd_mkcow(pmd);
+	return pmd;
 }
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
-	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pmdval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating (HW)Dirty=1, Write=0 PMDs */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pmd_write(pmd))
+		dirty = _PAGE_COW;
+
+	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
+{
+	return pmd_clear_cow(pmd);
 }
 
 static inline pmd_t pmd_mkdevmap(pmd_t pmd)
@@ -476,7 +590,11 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 
 static inline pmd_t pmd_mkwrite(pmd_t pmd)
 {
-	return pmd_set_flags(pmd, _PAGE_RW);
+	pmd = pmd_set_flags(pmd, _PAGE_RW);
+
+	if (pmd_dirty(pmd))
+		pmd = pmd_clear_cow(pmd);
+	return pmd;
 }
 
 static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
@@ -493,6 +611,24 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 	return native_make_pud(v & ~clear);
 }
 
+static inline pud_t pud_mkcow(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pud;
+
+	pud = pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_set_flags(pud, _PAGE_COW);
+}
+
+static inline pud_t pud_clear_cow(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pud;
+
+	pud = pud_set_flags(pud, _PAGE_DIRTY);
+	return pud_clear_flags(pud, _PAGE_COW);
+}
+
 static inline pud_t pud_mkold(pud_t pud)
 {
 	return pud_clear_flags(pud, _PAGE_ACCESSED);
@@ -500,17 +636,32 @@ static inline pud_t pud_mkold(pud_t pud)
 
 static inline pud_t pud_mkclean(pud_t pud)
 {
-	return pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_clear_flags(pud, _PAGE_DIRTY_BITS);
 }
 
 static inline pud_t pud_wrprotect(pud_t pud)
 {
-	return pud_clear_flags(pud, _PAGE_RW);
+	pud = pud_clear_flags(pud, _PAGE_RW);
+
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PUD (RW=0, Dirty=1).  Move the hardware
+	 * dirty value to the software bit.
+	 */
+	if (pud_dirty(pud))
+		pud = pud_mkcow(pud);
+	return pud;
 }
 
 static inline pud_t pud_mkdirty(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pudval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating (HW)Dirty=1, Write=0 PUDs */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pud_write(pud))
+		dirty = _PAGE_COW;
+
+	return pud_set_flags(pud, dirty | _PAGE_SOFT_DIRTY);
 }
 
 static inline pud_t pud_mkdevmap(pud_t pud)
@@ -530,7 +681,11 @@ static inline pud_t pud_mkyoung(pud_t pud)
 
 static inline pud_t pud_mkwrite(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_RW);
+	pud = pud_set_flags(pud, _PAGE_RW);
+
+	if (pud_dirty(pud))
+		pud = pud_clear_cow(pud);
+	return pud;
 }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 9db61817dfff..ce853c28c253 100644
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
@@ -36,6 +37,15 @@
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
+/*
+ * Indicates a copy-on-write page.
+ */
+#ifdef CONFIG_X86_SHADOW_STACK
+#define _PAGE_BIT_COW		_PAGE_BIT_SOFTW5 /* copy-on-write */
+#else
+#define _PAGE_BIT_COW		0
+#endif
+
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
 /* - if the user mapped it with PROT_NONE; pte_present gives true */
 #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
@@ -117,6 +127,36 @@
 #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
 #endif
 
+/*
+ * The hardware requires shadow stack to be read-only and Dirty.
+ * _PAGE_COW is a software-only bit used to separate copy-on-write PTEs
+ * from shadow stack PTEs:
+ * (a) A modified, copy-on-write (COW) page: (Write=0, Cow=1)
+ * (b) A R/O page that has been COW'ed: (Write=0, Cow=1)
+ *     The user page is in a R/O VMA, and get_user_pages() needs a
+ *     writable copy.  The page fault handler creates a copy of the page
+ *     and sets the new copy's PTE as Write=0, Cow=1.
+ * (c) A shadow stack PTE: (Write=0, Dirty=1)
+ * (d) A shared (copy-on-access) shadow stack PTE: (Write=0, Cow=1)
+ *     When a shadow stack page is being shared among processes (this
+ *     happens at fork()), its PTE is cleared of _PAGE_DIRTY, so the next
+ *     shadow stack access causes a fault, and the page is duplicated and
+ *     _PAGE_DIRTY is set again.  This is the COW equivalent for shadow
+ *     stack pages, even though it's copy-on-access rather than
+ *     copy-on-write.
+ * (e) A page where the processor observed a Write=1 PTE, started a write,
+ *     set Dirty=1, but then observed a Write=0 PTE (changed by another
+ *     thread).  That's possible today, but will not happen on processors
+ *     that support shadow stack.
+ */
+#ifdef CONFIG_X86_SHADOW_STACK
+#define _PAGE_COW	(_AT(pteval_t, 1) << _PAGE_BIT_COW)
+#else
+#define _PAGE_COW	(_AT(pteval_t, 0))
+#endif
+
+#define _PAGE_DIRTY_BITS (_PAGE_DIRTY | _PAGE_COW)
+
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 /*
-- 
2.21.0

