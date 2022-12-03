Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ADD64123A
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiLCAiR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiLCAhk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:37:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E23F9E21;
        Fri,  2 Dec 2022 16:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027812; x=1701563812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=X9ae03J76p9UA9h1wU+FcFVEj90hHuMBkVwbiMfGTg4=;
  b=FPO4+lXCYxqerrMre3MDD8Gk/n718tnVw0d+kn6CUoAJSkUHyFbIk0Hu
   1CfOfTZg03cIt+6TbB5AP0lI9d+mHkWV5E9jIbgbYeAyEjDeILTD+AzpP
   b3bZLARTAVybtpBhg/JmOFHiu6DVKT/8JwZzlGWFTJiJmBqVvU46XWubF
   AnDZbZoQredl+nWcsGMFDBj06QaAi5K4OsA7GMw4zmQ3WkDgc+Xxr/HpF
   4/9LxzqmXdS4i8Kkt4D4ytmn5b74mhtY0s7cwYIdF7Jd9qAyH6qg0lLjp
   pM/kP90sPK9nfKbwTFGa+eJ5lqyOVGmo+1nG/5ESMmc4FkghScV28flUk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313710876"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313710876"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479803"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479803"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:50 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 10/39] x86/mm: Introduce _PAGE_COW
Date:   Fri,  2 Dec 2022 16:35:37 -0800
Message-Id: <20221203003606.6838-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

There are six bits left available to software in the 64-bit PTE after
consuming a bit for _PAGE_COW. No space is consumed in 32-bit kernels
because shadow stacks are not enabled there.

This is a prepratory patch. Changes to actually start marking _PAGE_COW
will follow once other pieces are in place.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v4:
 - Teach pte_flags_need_flush() about _PAGE_COW bit
 - Break apart patch for better bisectability

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

 arch/x86/include/asm/pgtable.h       | 78 ++++++++++++++++++++++++++++
 arch/x86/include/asm/pgtable_types.h | 59 +++++++++++++++++++--
 arch/x86/include/asm/tlbflush.h      |  3 +-
 3 files changed, 134 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a1d6f121ee35..ee5fbdc2615f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -300,6 +300,44 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
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
@@ -396,6 +434,26 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
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
@@ -467,6 +525,26 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
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
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 0646ad00178b..5c3f942865d9 100644
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
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 662598dea937..08d9b5fce4fd 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -283,7 +283,8 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
 	const pteval_t flush_on_clear = _PAGE_DIRTY | _PAGE_PRESENT |
 					_PAGE_ACCESSED;
 	const pteval_t software_flags = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
-					_PAGE_SOFTW3 | _PAGE_SOFTW4;
+					_PAGE_SOFTW3 | _PAGE_SOFTW4 |
+					_PAGE_COW;
 	const pteval_t flush_on_change = _PAGE_RW | _PAGE_USER | _PAGE_PWT |
 			  _PAGE_PCD | _PAGE_PSE | _PAGE_GLOBAL | _PAGE_PAT |
 			  _PAGE_PAT_LARGE | _PAGE_PKEY_BIT0 | _PAGE_PKEY_BIT1 |
-- 
2.17.1

