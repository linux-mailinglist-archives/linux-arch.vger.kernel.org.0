Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D973061A452
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiKDWkq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiKDWkI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:40:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2DA419AB;
        Fri,  4 Nov 2022 15:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601572; x=1699137572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yxqLIMvVIC0HjvdAAoTTOb3e0gYLZmNcBxDEff9qZxI=;
  b=HyqxOKbsfPwZMovWHT1TLH/0vFBJ9T+YRQK4yWrPndLDCdX+dCpbQjtK
   UEWdkbaweJHyawfXAVgL5hnDyo/dNPue/D/Z2QXh5EYFad01mDJLRyEp1
   oIwRGtUNPXPiFoTrOcuXy3iPZVaed3ykKsAQ+7SUXHPOh+yZO5YagWO0G
   2LA0f3MppqqPDDyRLrTcMQamd6Obskgu7LjTn2tC/pGonCEPuZ+XrP8ow
   4DKJ2dzuSkgBNPavTUxUD8932RJ9+iK+lH5zZ6BeC13kbLEo6YEhvWecp
   PdfoZALsYin5XlgODgM6eQaL7si1yfteCeIdJQf3xxyE5mI4prIdv0ckz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840513"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840513"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514022"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514022"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:30 -0700
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
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 10/37] x86/mm: Introduce _PAGE_COW
Date:   Fri,  4 Nov 2022 15:35:37 -0700
Message-Id: <20221104223604.29615-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Some OSes have a greater dependence on software available bits in PTEs than
Linux. That left the hardware architects looking for a way to represent a
new memory type (shadow stack) within the existing bits. They chose to
repurpose a lightly-used state: Write=0,Dirty=1. So in order to support
shadow stack memory, Linux should avoid creating memory with this PTE bit
combination unless it intends for it to be shadow stack.

The reason it's lightly used is that Dirty=1 is normally set by HW
_before_ a write. A write with a Write=0 PTE would typically only generate
a fault, not set Dirty=1. Hardware can (rarely) both set Dirty=1 *and*
generate the fault, resulting in a Write=0,Dirty=1 PTE. Hardware which
supports shadow stacks will no longer exhibit this oddity.

So that leaves Write=0,Dirty=1 PTEs created in software. To achieve this,
in places where Linux normally creates Write=0,Dirty=1, it can use the
software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY. In other
words, whenever Linux needs to create Write=0,Dirty=1, it instead creates
Write=0,Cow=1 except for shadow stack, which is Write=0,Dirty=1.
Further differentiated by VMA flags, these PTE bit combinations would be
set as follows for various types of memory:

(Write=0,Cow=1,Dirty=0):
 - A modified, copy-on-write (COW) page. Previously when a typical
   anonymous writable mapping was made COW via fork(), the kernel would
   mark it Write=0,Dirty=1. Now it will instead use the Cow bit. This
   happens in copy_present_pte().
 - A R/O page that has been COW'ed. The user page is in a R/O VMA,
   and get_user_pages(FOLL_FORCE) needs a writable copy. The page fault
   handler creates a copy of the page and sets the new copy's PTE as
   Write=0 and Cow=1.
 - A shared shadow stack PTE. When a shadow stack page is being shared
   among processes (this happens at fork()), its PTE is made Dirty=0, so
   the next shadow stack access causes a fault, and the page is
   duplicated and Dirty=1 is set again. This is the COW equivalent for
   shadow stack pages, even though it's copy-on-access rather than
   copy-on-write.

(Write=0,Cow=0,Dirty=1):
 - A shadow stack PTE.
 - A Cow PTE created when a processor without shadow stack support set
   Dirty=1.

Define _PAGE_COW and update pte_*() helpers and apply the same changes to
pmd and pud.

There are six bits left available to software in the 64-bit PTE after
consuming a bit for _PAGE_COW. No space is consumed in 32-bit kernels
because shadow stacks are not enabled there.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v3:
 - Add comment around _PAGE_TABLE in response to comment
   from (Andrew Cooper)
 - Check for PSE in pmd_shstk (Andrew Cooper)
 - Get to the point quicker in commit log (Andrew Cooper)
 - Clarify and reorder commit log for why the PTE bit examples have
   multiple entries. Apply same changes for comment. (peterz)
 - Fix comment that implied dirty bit for COW was a specific x86 thing
   (peterz)
 - Fix swapping of Write/Dirty (PeterZ)

v2:
 - Update commit log with comments (Dave Hansen)
 - Add comments in code to explain pte modification code better (Dave)
 - Clarify info on the meaning of various Write,Cow,Dirty combinations

 arch/x86/include/asm/pgtable.h       | 211 ++++++++++++++++++++++++---
 arch/x86/include/asm/pgtable_types.h |  59 +++++++-
 2 files changed, 245 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a1d6f121ee35..c284bb6f62a5 100644
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
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return false;
+
+	return (pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
 }
 
 static inline int pte_young(pte_t pte)
@@ -134,9 +142,18 @@ static inline int pte_young(pte_t pte)
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
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return false;
+
+	return (pmd_flags(pmd) & (_PAGE_RW | _PAGE_DIRTY | _PAGE_PSE)) ==
+	       (_PAGE_DIRTY | _PAGE_PSE);
 }
 
 static inline int pmd_young(pmd_t pmd)
@@ -144,9 +161,9 @@ static inline int pmd_young(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_ACCESSED;
 }
 
-static inline int pud_dirty(pud_t pud)
+static inline bool pud_dirty(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_DIRTY;
+	return pud_flags(pud) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pud_young(pud_t pud)
@@ -156,13 +173,21 @@ static inline int pud_young(pud_t pud)
 
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
@@ -300,6 +325,44 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+/*
+ * Normally COW memory can result in Dirty=1,Write=0 PTs. But in the case
+ * of X86_FEATURE_USER_SHSTK, the software COW bit is used, since the
+ * Dirty=1,Write=0 will result in the memory being treated as shaodw stack
+ * by the HW. So when creating COW memory, a software bit is used
+ * _PAGE_BIT_COW. The following functions pte_mkcow() and pte_clear_cow()
+ * take a PTE marked conventially COW (Dirty=1) and transition it to the
+ * shadow stack compatible version of COW (Cow=1).
+ */
+
+static inline pte_t pte_mkcow(pte_t pte)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pte;
+
+	pte = pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_set_flags(pte, _PAGE_COW);
+}
+
+static inline pte_t pte_clear_cow(pte_t pte)
+{
+	/*
+	 * _PAGE_COW is unnecessary on !X86_FEATURE_USER_SHSTK kernels.
+	 * See the _PAGE_COW definition for more details.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
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
@@ -319,7 +382,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -329,7 +392,16 @@ static inline pte_t pte_mkold(pte_t pte)
 
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
@@ -339,7 +411,19 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pteval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating Dirty=1,Write=0 PTEs */
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) && !pte_write(pte))
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
@@ -349,7 +433,12 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
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
@@ -396,6 +485,26 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 	return native_make_pmd(v & ~clear);
 }
 
+/* See comments above pte_mkcow() */
+static inline pmd_t pmd_mkcow(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pmd;
+
+	pmd = pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_set_flags(pmd, _PAGE_COW);
+}
+
+/* See comments above pte_mkcow() */
+static inline pmd_t pmd_clear_cow(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pmd;
+
+	pmd = pmd_set_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_COW);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pmd_uffd_wp(pmd_t pmd)
 {
@@ -420,17 +529,36 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
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
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) && !pmd_write(pmd))
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
@@ -450,7 +578,11 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 
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
@@ -467,6 +599,26 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 	return native_make_pud(v & ~clear);
 }
 
+/* See comments above pte_mkcow() */
+static inline pud_t pud_mkcow(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pud;
+
+	pud = pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_set_flags(pud, _PAGE_COW);
+}
+
+/* See comments above pte_mkcow() */
+static inline pud_t pud_clear_cow(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pud;
+
+	pud = pud_set_flags(pud, _PAGE_DIRTY);
+	return pud_clear_flags(pud, _PAGE_COW);
+}
+
 static inline pud_t pud_mkold(pud_t pud)
 {
 	return pud_clear_flags(pud, _PAGE_ACCESSED);
@@ -474,17 +626,32 @@ static inline pud_t pud_mkold(pud_t pud)
 
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
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) && !pud_write(pud))
+		dirty = _PAGE_COW;
+
+	return pud_set_flags(pud, dirty | _PAGE_SOFT_DIRTY);
 }
 
 static inline pud_t pud_mkdevmap(pud_t pud)
@@ -504,7 +671,11 @@ static inline pud_t pud_mkyoung(pud_t pud)
 
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
index ff82237e7b6b..2bb49e62398d 100644
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
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+#define _PAGE_BIT_COW		_PAGE_BIT_SOFTW5 /* copy-on-write */
+#else
+#define _PAGE_BIT_COW		0
+#endif
+
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
 /* - if the user mapped it with PROT_NONE; pte_present gives true */
 #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
@@ -117,6 +127,40 @@
 #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
+/*
+ * The hardware requires shadow stack to be read-only and Dirty.
+ * _PAGE_COW is a software-only bit used to separate copy-on-write PTEs
+ * from shadow stack PTEs:
+ *
+ * (Write=0,Cow=1,Dirty=0):
+ *  - A modified, copy-on-write (COW) page. Previously when a typical
+ *    anonymous writable mapping was made COW via fork(), the kernel would
+ *    mark it Write=0,Dirty=1. Now it will instead use the Cow bit. This
+ *    happens in copy_present_pte().
+ *  - A R/O page that has been COW'ed. The user page is in a R/O VMA,
+ *    and get_user_pages(FOLL_FORCE) needs a writable copy. The page fault
+ *    handler creates a copy of the page and sets the new copy's PTE as
+ *    Write=0 and Cow=1.
+ *  - A shared shadow stack PTE. When a shadow stack page is being shared
+ *    among processes (this happens at fork()), its PTE is made Dirty=0, so
+ *    the next shadow stack access causes a fault, and the page is
+ *    duplicated and Dirty=1 is set again. This is the COW equivalent for
+ *    shadow stack pages, even though it's copy-on-access rather than
+ *    copy-on-write.
+ *
+ * (Write=0,Cow=0,Dirty=1):
+ *  - A shadow stack PTE.
+ *  - A Cow PTE created when a processor without shadow stack support set
+ *    Dirty=1.
+ */
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+#define _PAGE_COW	(_AT(pteval_t, 1) << _PAGE_BIT_COW)
+#else
+#define _PAGE_COW	(_AT(pteval_t, 0))
+#endif
+
+#define _PAGE_DIRTY_BITS (_PAGE_DIRTY | _PAGE_COW)
+
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 /*
@@ -186,12 +230,17 @@ enum page_cache_mode {
 #define PAGE_READONLY	     __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
 #define PAGE_READONLY_EXEC   __pg(__PP|   0|_USR|___A|   0|   0|   0|   0)
 
-#define __PAGE_KERNEL		 (__PP|__RW|   0|___A|__NX|___D|   0|___G)
-#define __PAGE_KERNEL_EXEC	 (__PP|__RW|   0|___A|   0|___D|   0|___G)
-#define _KERNPG_TABLE_NOENC	 (__PP|__RW|   0|___A|   0|___D|   0|   0)
-#define _KERNPG_TABLE		 (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
+/*
+ * Page tables needs to have Write=1 in order for any lower PTEs to be
+ * writable. This includes shadow stack memory (Write=0, Dirty=1)
+ */
 #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
+#define _KERNPG_TABLE_NOENC	 (__PP|__RW|   0|___A|   0|___D|   0|   0)
+#define _KERNPG_TABLE		 (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
+
+#define __PAGE_KERNEL		 (__PP|__RW|   0|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_EXEC	 (__PP|__RW|   0|___A|   0|___D|   0|___G)
 #define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|   0|   0|___G)
 #define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|   0|   0|___G)
 #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
-- 
2.17.1

