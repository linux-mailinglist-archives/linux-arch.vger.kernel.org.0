Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B5C69BCA0
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBRVT0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 16:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjBRVS2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 16:18:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC41A667;
        Sat, 18 Feb 2023 13:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676755020; x=1708291020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=s+JIElE36GvkH9//5+z8uWdNPHcLIVQVGfIRMsbLR5I=;
  b=W6gnYMI7pqs6plkGypUEojC30V72UfQcl/ilSO2VxniVnUV7eamR+cWM
   cF4XLIfN6qcKarbgbRb+GC377aYtQqtsgBfk6tiCjXdd6/DznwLC22u7/
   EVGVxvr0Xc/elLDgrhssJY4I5z/+Bki+OFZozj544lSUH0WK/a2VlXhvj
   rA9nTLS0Yp8Fp8eAWat/UULhJ5YJkvXaBwEb1XAnfHdcC/bHjKXCrCNWt
   LSDAHSqG6o5SZfPB2+DbOZ6dZ/x03Ie+NqCbC8zwDZ9Gk9C70uJHNrapa
   1kFbRBgaoB/bLqNxd/SxP7/YIXVsPNOfRONqHrvdGxAI+5VGuG7uNSxNV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427399"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427399"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241639"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241639"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:07 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Date:   Sat, 18 Feb 2023 13:14:06 -0800
Message-Id: <20230218211433.26859-15-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
software-defined _PAGE_SAVED_DIRTY in place of the hardware _PAGE_DIRTY.
In other words, whenever Linux needs to create Write=0,Dirty=1, it instead
creates Write=0,SavedDirty=1 except for shadow stack, which is
Write=0,Dirty=1. Further differentiated by VMA flags, these PTE bit
combinations would be set as follows for various types of memory:

(Write=0,SavedDirty=1,Dirty=0):
 - A modified, copy-on-write (COW) page. Previously when a typical
   anonymous writable mapping was made COW via fork(), the kernel would
   mark it Write=0,Dirty=1. Now it will instead use the SavedDirty bit.
   This happens in copy_present_pte().
 - A R/O page that has been COW'ed. The user page is in a R/O VMA,
   and get_user_pages(FOLL_FORCE) needs a writable copy. The page fault
   handler creates a copy of the page and sets the new copy's PTE as
   Write=0 and SavedDirty=1.
 - A shared shadow stack PTE. When a shadow stack page is being shared
   among processes (this happens at fork()), its PTE is made Dirty=0, so
   the next shadow stack access causes a fault, and the page is
   duplicated and Dirty=1 is set again. This is the COW equivalent for
   shadow stack pages, even though it's copy-on-access rather than
   copy-on-write.

(Write=0,SavedDirty=0,Dirty=1):
 - A shadow stack PTE.
 - A Cow PTE created when a processor without shadow stack support set
   Dirty=1.

There are six bits left available to software in the 64-bit PTE after
consuming a bit for _PAGE_SAVED_DIRTY. No space is consumed in 32-bit
kernels because shadow stacks are not enabled there.

Implement only the infrastructure for _PAGE_SAVED_DIRTY. Changes to start
creating _PAGE_SAVED_DIRTY PTEs will follow once other pieces are in place.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
v6:
 - Rename _PAGE_COW to _PAGE_SAVED_DIRTY (David Hildenbrand)
 - Add _PAGE_SAVED_DIRTY to _PAGE_CHG_MASK

v5:
 - Fix log, comments and whitespace (Boris)
 - Remove capitalization on shadow stack (Boris)

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
---
 arch/x86/include/asm/pgtable.h       | 79 ++++++++++++++++++++++++++++
 arch/x86/include/asm/pgtable_types.h | 65 ++++++++++++++++++++---
 arch/x86/include/asm/tlbflush.h      |  3 +-
 3 files changed, 138 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2b423d697490..110e552eb602 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -301,6 +301,45 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+/*
+ * COW and other write protection operations can result in Dirty=1,Write=0
+ * PTEs. But in the case of X86_FEATURE_USER_SHSTK, the software SavedDirty bit
+ * is used, since the Dirty=1,Write=0 will result in the memory being treated as
+ * shadow stack by the HW. So when creating dirty, write-protected memory, a
+ * software bit is used _PAGE_BIT_SAVED_DIRTY. The following functions
+ * pte_mksaveddirty() and pte_clear_saveddirty() take a conventional dirty,
+ * write-protected PTE (Write=0,Dirty=1) and transition it to the shadow stack
+ * compatible version. (Write=0,SavedDirty=1).
+ */
+static inline pte_t pte_mksaveddirty(pte_t pte)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pte;
+
+	pte = pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_set_flags(pte, _PAGE_SAVED_DIRTY);
+}
+
+static inline pte_t pte_clear_saveddirty(pte_t pte)
+{
+	/*
+	 * _PAGE_SAVED_DIRTY is unnecessary on !X86_FEATURE_USER_SHSTK kernels,
+	 * since the HW dirty bit can be used without creating shadow stack
+	 * memory. See the _PAGE_SAVED_DIRTY definition for more details.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pte;
+
+	/*
+	 * PTE is getting copied-on-write, so it will be dirtied
+	 * if writable, or made shadow stack if shadow stack and
+	 * being copied on access. Set the dirty bit for both
+	 * cases.
+	 */
+	pte = pte_set_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_SAVED_DIRTY);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
@@ -420,6 +459,26 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 	return native_make_pmd(v & ~clear);
 }
 
+/* See comments above pte_mksaveddirty() */
+static inline pmd_t pmd_mksaveddirty(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pmd;
+
+	pmd = pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_set_flags(pmd, _PAGE_SAVED_DIRTY);
+}
+
+/* See comments above pte_mksaveddirty() */
+static inline pmd_t pmd_clear_saveddirty(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pmd;
+
+	pmd = pmd_set_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_SAVED_DIRTY);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pmd_uffd_wp(pmd_t pmd)
 {
@@ -491,6 +550,26 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 	return native_make_pud(v & ~clear);
 }
 
+/* See comments above pte_mksaveddirty() */
+static inline pud_t pud_mksaveddirty(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pud;
+
+	pud = pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_set_flags(pud, _PAGE_SAVED_DIRTY);
+}
+
+/* See comments above pte_mksaveddirty() */
+static inline pud_t pud_clear_saveddirty(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pud;
+
+	pud = pud_set_flags(pud, _PAGE_DIRTY);
+	return pud_clear_flags(pud, _PAGE_SAVED_DIRTY);
+}
+
 static inline pud_t pud_mkold(pud_t pud)
 {
 	return pud_clear_flags(pud, _PAGE_ACCESSED);
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 0646ad00178b..3b420b6c0584 100644
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
+ * Indicates a Saved Dirty bit page.
+ */
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+#define _PAGE_BIT_SAVED_DIRTY		_PAGE_BIT_SOFTW5 /* copy-on-write */
+#else
+#define _PAGE_BIT_SAVED_DIRTY		0
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
+ * _PAGE_SAVED_DIRTY is a software-only bit used to separate copy-on-write
+ * PTEs from shadow stack PTEs:
+ *
+ * (Write=0,SavedDirty=1,Dirty=0):
+ *  - A modified, copy-on-write (COW) page. Previously when a typical
+ *    anonymous writable mapping was made COW via fork(), the kernel would
+ *    mark it Write=0,Dirty=1. Now it will instead use the Cow bit. This
+ *    happens in copy_present_pte().
+ *  - A R/O page that has been COW'ed. The user page is in a R/O VMA,
+ *    and get_user_pages(FOLL_FORCE) needs a writable copy. The page fault
+ *    handler creates a copy of the page and sets the new copy's PTE as
+ *    Write=0 and SavedDirty=1.
+ *  - A shared shadow stack PTE. When a shadow stack page is being shared
+ *    among processes (this happens at fork()), its PTE is made Dirty=0, so
+ *    the next shadow stack access causes a fault, and the page is
+ *    duplicated and Dirty=1 is set again. This is the COW equivalent for
+ *    shadow stack pages, even though it's copy-on-access rather than
+ *    copy-on-write.
+ *
+ * (Write=0,SavedDirty=0,Dirty=1):
+ *  - A shadow stack PTE.
+ *  - A Cow PTE created when a processor without shadow stack support set
+ *    Dirty=1.
+ */
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+#define _PAGE_SAVED_DIRTY	(_AT(pteval_t, 1) << _PAGE_BIT_SAVED_DIRTY)
+#else
+#define _PAGE_SAVED_DIRTY	(_AT(pteval_t, 0))
+#endif
+
+#define _PAGE_DIRTY_BITS (_PAGE_DIRTY | _PAGE_SAVED_DIRTY)
+
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 /*
@@ -125,9 +169,9 @@
  * instance, and is *not* included in this mask since
  * pte_modify() does modify it.
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
-			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |  \
+#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		     \
+			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY_BITS | \
+			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |	     \
 			 _PAGE_UFFD_WP)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
 
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
index cda3118f3b27..6c5ef14060a8 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -273,7 +273,8 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
 	const pteval_t flush_on_clear = _PAGE_DIRTY | _PAGE_PRESENT |
 					_PAGE_ACCESSED;
 	const pteval_t software_flags = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
-					_PAGE_SOFTW3 | _PAGE_SOFTW4;
+					_PAGE_SOFTW3 | _PAGE_SOFTW4 |
+					_PAGE_SAVED_DIRTY;
 	const pteval_t flush_on_change = _PAGE_RW | _PAGE_USER | _PAGE_PWT |
 			  _PAGE_PCD | _PAGE_PSE | _PAGE_GLOBAL | _PAGE_PAT |
 			  _PAGE_PAT_LARGE | _PAGE_PKEY_BIT0 | _PAGE_PKEY_BIT1 |
-- 
2.17.1

