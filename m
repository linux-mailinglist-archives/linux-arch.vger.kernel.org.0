Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F395F0041
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiI2WbM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiI2Wag (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:30:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D438A0C;
        Thu, 29 Sep 2022 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490612; x=1696026612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=g1pYpuPS14apQh0BEoJpa6H8/WMotUpKE4DNuLPNKDA=;
  b=hkjNmB7Z5TWcPEEOgQeeTa0SOc9/0ZBxRUlWBgw5fGrvVAwqt3Is9jlh
   g0Y02MdO5j+V9TRQ1bfEC0vI5wwUolhwhI2J/B2qBljPNKMMsp/H2TSiB
   llbVgSmTb6QjBPSQDk8/IhSuYZCr1lHnwuzA9Fw/ZyYNsRp2AgYYynJ9d
   TOHvkRiej017v+9VBW5kbSGWOzA6eOFAvdvMGfQzrw2AlSogsJcVaMCYo
   UgANeVAKBigHMO4XeqqF6FyqgEJ7JyAijH7dykU07higPoAG+l8whQQw+
   kmZD3aA3qyBBwqJJUOvl0W9rNwGpG9y43LrKx54QDN+ZEpMma/mDK8gtT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303531379"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="303531379"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016164"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016164"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:04 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Date:   Thu, 29 Sep 2022 15:29:07 -0700
Message-Id: <20220929222936.14584-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

There is essentially no room left in the x86 hardware PTEs on some OSes
(not Linux). That left the hardware architects looking for a way to
represent a new memory type (shadow stack) within the existing bits.
They chose to repurpose a lightly-used state: Write=0,Dirty=1.

The reason it's lightly used is that Dirty=1 is normally set _before_ a
write. A write with a Write=0 PTE would typically only generate a fault,
not set Dirty=1. Hardware can (rarely) both set Write=1 *and* generate the
fault, resulting in a Dirty=0,Write=1 PTE. Hardware which supports shadow
stacks will no longer exhibit this oddity.

The kernel should avoid inadvertently creating shadow stack memory because
it is security sensitive. So given the above, all it needs to do is avoid
manually crating Write=0,Dirty=1 PTEs in software.

In places where Linux normally creates Write=0,Dirty=1, it can use the
software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY. In other
words, whenever Linux needs to create Write=0,Dirty=1, it instead creates
Write=0,Cow=1 except for shadow stack, which is Write=0,Dirty=1. This
clearly separates shadow stack from other data, and results in the
following:

(a) (Write=0,Cow=1,Dirty=0) A modified, copy-on-write (COW) page.
    Previously when a typical anonymous writable mapping was made COW via
    fork(), the kernel would mark it Write=0,Dirty=1. Now it will instead
    use the Cow bit.
(b) (Write=0,Cow=1,Dirty=0) A R/O page that has been COW'ed. The user page
    is in a R/O VMA, and get_user_pages() needs a writable copy. The page
    fault handler creates a copy of the page and sets the new copy's PTE
    as Write=0 and Cow=1.
(c) (Write=0,Cow=0,Dirty=1) A shadow stack PTE.
(d) (Write=0,Cow=1,Dirty=0) A shared shadow stack PTE. When a shadow stack
    page is being shared among processes (this happens at fork()), its PTE
    is made Dirty=0, so the next shadow stack access causes a fault, and
    the page is duplicated and Dirty=1 is set again. This is the COW
    equivalent for shadow stack pages, even though it's copy-on-access
    rather than copy-on-write.
(e) (Write=0,Cow=0,Dirty=1) A Cow PTE created when a processor without
    shadow stack support set Dirty=1.

Define _PAGE_COW and update pte_*() helpers and apply the same changes to
pmd and pud.

There are six bits left available to software in the 64-bit PTE after
consuming a bit for _PAGE_COW. No space is consumed in 32-bit kernels
because shadow stacks are not enabled there.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - Update commit log with comments (Dave Hansen)
 - Add comments in code to explain pte modification code better (Dave)
 - Clarify info on the meaning of various Write,Cow,Dirty combinations

 arch/x86/include/asm/pgtable.h       | 210 ++++++++++++++++++++++++---
 arch/x86/include/asm/pgtable_types.h |  42 +++++-
 2 files changed, 231 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 6496ec84b953..ad201dae7316 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -124,9 +124,17 @@ extern pmdval_t early_pmd_flags;
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-static inline int pte_dirty(pte_t pte)
+static inline bool pte_dirty(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_DIRTY;
+	return pte_flags(pte) & _PAGE_DIRTY_BITS;
+}
+
+static inline bool pte_shstk(pte_t pte)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return false;
+
+	return (pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
 }
 
 static inline int pte_young(pte_t pte)
@@ -134,9 +142,17 @@ static inline int pte_young(pte_t pte)
 	return pte_flags(pte) & _PAGE_ACCESSED;
 }
 
-static inline int pmd_dirty(pmd_t pmd)
+static inline bool pmd_dirty(pmd_t pmd)
 {
-	return pmd_flags(pmd) & _PAGE_DIRTY;
+	return pmd_flags(pmd) & _PAGE_DIRTY_BITS;
+}
+
+static inline bool pmd_shstk(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return false;
+
+	return (pmd_flags(pmd) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
 }
 
 static inline int pmd_young(pmd_t pmd)
@@ -144,9 +160,9 @@ static inline int pmd_young(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_ACCESSED;
 }
 
-static inline int pud_dirty(pud_t pud)
+static inline bool pud_dirty(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_DIRTY;
+	return pud_flags(pud) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pud_young(pud_t pud)
@@ -156,13 +172,21 @@ static inline int pud_young(pud_t pud)
 
 static inline int pte_write(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_RW;
+	/*
+	 * Shadow stack pages are logically writable, but do not have
+	 * _PAGE_RW.  Check for them separately from _PAGE_RW itself.
+	 */
+	return (pte_flags(pte) & _PAGE_RW) || pte_shstk(pte);
 }
 
 #define pmd_write pmd_write
 static inline int pmd_write(pmd_t pmd)
 {
-	return pmd_flags(pmd) & _PAGE_RW;
+	/*
+	 * Shadow stack pages are logically writable, but do not have
+	 * _PAGE_RW.  Check for them separately from _PAGE_RW itself.
+	 */
+	return (pmd_flags(pmd) & _PAGE_RW) || pmd_shstk(pmd);
 }
 
 #define pud_write pud_write
@@ -300,6 +324,44 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+/*
+ * Normally the Dirty bit is used to denote COW memory on x86. But
+ * in the case of X86_FEATURE_SHSTK, the software COW bit is used,
+ * since the Dirty=1,Write=0 will result in the memory being treated
+ * as shaodw stack by the HW. So when creating COW memory, a software
+ * bit is used _PAGE_BIT_COW. The following functions pte_mkcow() and
+ * pte_clear_cow() take a PTE marked conventially COW (Dirty=1) and
+ * transition it to the shadow stack compatible version of COW (Cow=1).
+ */
+
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
+	/*
+	 * _PAGE_COW is unnecessary on !X86_FEATURE_SHSTK kernels.
+	 * See the _PAGE_COW definition for more details.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pte;
+
+	/*
+	 * PTE is getting copied-on-write, so it will be dirtied
+	 * if writable, or made shadow stack if shadow stack and
+	 * being copied on access. Set they dirty bit for both
+	 * cases.
+	 */
+	pte = pte_set_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_COW);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
@@ -319,7 +381,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -329,7 +391,16 @@ static inline pte_t pte_mkold(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_RW);
+	pte = pte_clear_flags(pte, _PAGE_RW);
+
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PTE (Write=0,Dirty=1). Move the hardware
+	 * dirty value to the software bit.
+	 */
+	if (pte_dirty(pte))
+		pte = pte_mkcow(pte);
+	return pte;
 }
 
 static inline pte_t pte_mkexec(pte_t pte)
@@ -339,7 +410,19 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pteval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating Dirty=1,Write=0 PTEs */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pte_write(pte))
+		dirty = _PAGE_COW;
+
+	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	/* pte_clear_cow() also sets Dirty=1 */
+	return pte_clear_cow(pte);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
@@ -349,7 +432,12 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
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
@@ -396,6 +484,26 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 	return native_make_pmd(v & ~clear);
 }
 
+/* See comments above pte_mkcow() */
+static inline pmd_t pmd_mkcow(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pmd;
+
+	pmd = pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_set_flags(pmd, _PAGE_COW);
+}
+
+/* See comments above pte_mkcow() */
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
@@ -420,17 +528,36 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
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
+	 * a shadow stack PMD (RW=0, Dirty=1). Move the hardware
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
@@ -450,7 +577,11 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 
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
@@ -467,6 +598,26 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 	return native_make_pud(v & ~clear);
 }
 
+/* See comments above pte_mkcow() */
+static inline pud_t pud_mkcow(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return pud;
+
+	pud = pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_set_flags(pud, _PAGE_COW);
+}
+
+/* See comments above pte_mkcow() */
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
@@ -474,17 +625,32 @@ static inline pud_t pud_mkold(pud_t pud)
 
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
+	 * a shadow stack PUD (RW=0, Dirty=1). Move the hardware
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
@@ -504,7 +670,11 @@ static inline pud_t pud_mkyoung(pud_t pud)
 
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
index ff82237e7b6b..85d88c0f9618 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -21,7 +21,8 @@
 #define _PAGE_BIT_SOFTW2	10	/* " */
 #define _PAGE_BIT_SOFTW3	11	/* " */
 #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
-#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
+#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
+#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
 #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
 #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
 #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
@@ -34,6 +35,15 @@
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
 #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
+/*
+ * The hardware requires shadow stack to be read-only and Dirty.
+ * _PAGE_COW is a software-only bit used to separate copy-on-write PTEs
+ * from shadow stack PTEs:
+ *  (a) (Write=0,Cow=1,Dirty=0) A modified, copy-on-write (COW) page.
+ *	Previously when a typical anonymous writable mapping was made COW via
+ *	fork(), the kernel would mark it Write=0,Dirty=1. Now it will instead
+ *	use the Cow bit.
+ *  (b) (Write=0,Cow=1,Dirty=0) A R/O page that has been COW'ed. The user page
+ *	is in a R/O VMA, and get_user_pages() needs a writable copy. The page
+ *	fault handler creates a copy of the page and sets the new copy's PTE
+ *	as Write=0 and Cow=1.
+ *  (c) (Write=0,Cow=0,Dirty=1) A shadow stack PTE.
+ *  (d) (Write=0,Cow=1,Dirty=0) A shared shadow stack PTE. When a shadow stack
+ *	page is being shared among processes (this happens at fork()), its PTE
+ *	is made Dirty=0, so the next shadow stack access causes a fault, and
+ *	the page is duplicated and Dirty=1 is set again. This is the COW
+ *	equivalent for shadow stack pages, even though it's copy-on-access
+ *	rather than copy-on-write.
+ *  (e) (Write=0,Cow=0,Dirty=1) A Cow PTE created when a processor without
+ *	shadow stack support set Dirty=1.
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
2.17.1

