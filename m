Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620076BFE2D
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCSASV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCSARo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:17:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F842A151;
        Sat, 18 Mar 2023 17:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185006; x=1710721006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8dF02s3tOW4RiD+j+9DDrpVET91W8ytsL0rmu61SgrY=;
  b=GTz4RGlwZ0IlV/wZoI6aIaCBFrVSDbiYB9jF2RMJnfAva7HHNb7/QYvP
   SOSLQ3R6+FGMZ0foV+LANOoCjfOVtT2WEHf8LlZBnk6IfjA2Qd6Piw4ts
   R9SHi7pKxUykCqBko3hg5UAftHZD16qpvILAaKU79nAlVUn0BQyOplwZb
   uADGSZebSvKkx0VjWIooXslxc8PyRsUK4x/qvn0h7qgNQTsZkNTtgBbT1
   OKzfjPshdjPIUJIWgFS1FIedB7JPQnpNJ4EKM5/C+Wl+Deoj3Uq+TtM2L
   q/XP7xt37B6zGgPyL6K8tQYIIcP/ZPBDdvnejFESyVmBaG4N1XOYELQbv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491028"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491028"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749672837"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749672837"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:16 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 14/40] x86/mm: Introduce _PAGE_SAVED_DIRTY
Date:   Sat, 18 Mar 2023 17:15:09 -0700
Message-Id: <20230319001535.23210-15-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
References: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
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

So that leaves Write=0,Dirty=1 PTEs created in software. To avoid
inadvertently created shadow stack memory, in places where Linux normally
creates Write=0,Dirty=1, it can use the software-defined _PAGE_SAVED_DIRTY
in place of the hardware _PAGE_DIRTY. In other words, whenever Linux needs
to create Write=0,Dirty=1, it instead creates Write=0,SavedDirty=1 except
for shadow stack, which is Write=0,Dirty=1.

There are six bits left available to software in the 64-bit PTE after
consuming a bit for _PAGE_SAVED_DIRTY. No space is consumed in 32-bit
kernels because shadow stacks are not enabled there.

Implement only the infrastructure for _PAGE_SAVED_DIRTY. Changes to
actually begin creating _PAGE_SAVED_DIRTY PTEs will follow once other
pieces are in place.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v8:
 - Remove trailing whitespace (dhansen, Boris)

v7:
 - Use lightly edited comment verbiage from (David Hildenbrand)
 - Update commit log to reduce verbosity (David Hildenbrand)

v6:
 - Rename _PAGE_COW to _PAGE_SAVED_DIRTY (David Hildenbrand)
 - Add _PAGE_SAVED_DIRTY to _PAGE_CHG_MASK

v5:
 - Fix log, comments and whitespace (Boris)
 - Remove capitalization on shadow stack (Boris)
---
 arch/x86/include/asm/pgtable.h       | 79 ++++++++++++++++++++++++++++
 arch/x86/include/asm/pgtable_types.h | 50 +++++++++++++++---
 arch/x86/include/asm/tlbflush.h      |  3 +-
 3 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 66c514808276..7360783f2140 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -301,6 +301,45 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+/*
+ * Write protection operations can result in Dirty=1,Write=0 PTEs. But in the
+ * case of X86_FEATURE_USER_SHSTK, the software SavedDirty bit is used, since
+ * the Dirty=1,Write=0 will result in the memory being treated as shadow stack
+ * by the HW. So when creating dirty, write-protected memory, a software bit is
+ * used _PAGE_BIT_SAVED_DIRTY. The following functions pte_mksaveddirty() and
+ * pte_clear_saveddirty() take a conventional dirty, write-protected PTE
+ * (Write=0,Dirty=1) and transition it to the shadow stack compatible
+ * version. (Write=0,SavedDirty=1).
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
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	return pte_clear_flags(pte, _PAGE_RW);
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
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pmd_clear_flags(pmd, _PAGE_RW);
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
index 0646ad00178b..8f266788c0d7 100644
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
+#define _PAGE_BIT_SAVED_DIRTY		_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
+#else
+#define _PAGE_BIT_SAVED_DIRTY		0
+#endif
+
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
 /* - if the user mapped it with PROT_NONE; pte_present gives true */
 #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
@@ -117,6 +127,25 @@
 #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
+/*
+ * The hardware requires shadow stack to be Write=0,Dirty=1. However,
+ * there are valid cases where the kernel might create read-only PTEs that
+ * are dirty (e.g., fork(), mprotect(), uffd-wp(), soft-dirty  tracking). In
+ * this case, the _PAGE_SAVED_DIRTY bit is used instead of the HW-dirty bit,
+ * to avoid creating a wrong "shadow stack" PTEs. Such PTEs have
+ * (Write=0,SavedDirty=1,Dirty=0) set.
+ *
+ * Note that on processors without shadow stack support, the
+ * _PAGE_SAVED_DIRTY remains unused.
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
@@ -125,9 +154,9 @@
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
 
@@ -186,12 +215,17 @@ enum page_cache_mode {
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

