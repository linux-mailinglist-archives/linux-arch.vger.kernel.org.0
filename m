Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7010572D5A5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbjFMAMg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbjFMAM0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:12:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43F199C;
        Mon, 12 Jun 2023 17:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615140; x=1718151140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n6G5K0m9WwVLI5yH5jOOTWumHDLO47Q1gA3TW71PVjE=;
  b=loB2opO6O87gwVNZFycyLg4y6ZdtdfzU/qRjxnCAsaar9EBTCJhlX1Tp
   OnROA2J8qh+hxo9aqhakfYp4Yw1MC2URHudZd6tFjsmthGKQ1GO0khw5v
   VAvOscEm1j67n7YylYi/qBbnDLsREinH9Tkd57skPB7xdmeLnXCO3A3kc
   LI2jHOVokAd6dBHwQaZkvizEUdSWXc5Sbo+Y1W/MO2KgrfvYaUj2x//tA
   pRczdsFGjVGUH6ELMBo7LAKKNjJT1pA+4glbEwwrngOMKttjp9IjdXYg9
   lK7GrcDS8cc+OEQMyd6iV+q/TPG7KBWgQC5OLk3Cs8h5awfz9OvLGwke+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361556869"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361556869"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671005"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671005"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:15 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 10/42] x86/mm: Introduce _PAGE_SAVED_DIRTY
Date:   Mon, 12 Jun 2023 17:10:36 -0700
Message-Id: <20230613001108.3040476-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
consuming a bit for _PAGE_SAVED_DIRTY. For 32 bit, the same bit as
_PAGE_BIT_UFFD_WP is used, since user fault fd is not supported on 32
bit. This leaves one unused software bit on 32 bit (_PAGE_BIT_SOFT_DIRTY,
as this is also not supported on 32 bit).

Implement only the infrastructure for _PAGE_SAVED_DIRTY. Changes to
actually begin creating _PAGE_SAVED_DIRTY PTEs will follow once other
pieces are in place.

Since this SavedDirty shifting is done for all x86 CPUs, this leaves
the possibility for the hardware oddity to still create Write=0,Dirty=1
PTEs in rare cases. Since these CPUs also don't support shadow stack, this
will be harmless as it was before the introduction of SavedDirty.

Implement the shifting logic to be branchless. Embed the logic of whether
to do the shifting (including checking the Write bits) so that it can be
called by future callers that would otherwise need additional branching
logic. This efficiency allows the logic of when to do the shifting to be
centralized, making the code easier to reason about.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v9:
 - Use bit shifting instead of conditionals (Linus)
 - Make saved dirty bit unconditional (Linus)
 - Add 32 bit support to make it extra unconditional
 - Don't re-order PAGE flags (Dave)
---
 arch/x86/include/asm/pgtable.h       | 83 ++++++++++++++++++++++++++++
 arch/x86/include/asm/pgtable_types.h | 38 +++++++++++--
 arch/x86/include/asm/tlbflush.h      |  3 +-
 3 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 768ee46782c9..a95f872c7429 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -301,6 +301,53 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+/*
+ * Write protection operations can result in Dirty=1,Write=0 PTEs. But in the
+ * case of X86_FEATURE_USER_SHSTK, these PTEs denote shadow stack memory. So
+ * when creating dirty, write-protected memory, a software bit is used:
+ * _PAGE_BIT_SAVED_DIRTY. The following functions take a PTE and transition the
+ * Dirty bit to SavedDirty, and vice-vesra.
+ *
+ * This shifting is only done if needed. In the case of shifting
+ * Dirty->SavedDirty, the condition is if the PTE is Write=0. In the case of
+ * shifting SavedDirty->Dirty, the condition is Write=1.
+ */
+static inline unsigned long mksaveddirty_shift(unsigned long v)
+{
+	unsigned long cond = !(v & (1 << _PAGE_BIT_RW));
+
+	v |= ((v >> _PAGE_BIT_DIRTY) & cond) << _PAGE_BIT_SAVED_DIRTY;
+	v &= ~(cond << _PAGE_BIT_DIRTY);
+
+	return v;
+}
+
+static inline unsigned long clear_saveddirty_shift(unsigned long v)
+{
+	unsigned long cond = !!(v & (1 << _PAGE_BIT_RW));
+
+	v |= ((v >> _PAGE_BIT_SAVED_DIRTY) & cond) << _PAGE_BIT_DIRTY;
+	v &= ~(cond << _PAGE_BIT_SAVED_DIRTY);
+
+	return v;
+}
+
+static inline pte_t pte_mksaveddirty(pte_t pte)
+{
+	pteval_t v = native_pte_val(pte);
+
+	v = mksaveddirty_shift(v);
+	return native_make_pte(v);
+}
+
+static inline pte_t pte_clear_saveddirty(pte_t pte)
+{
+	pteval_t v = native_pte_val(pte);
+
+	v = clear_saveddirty_shift(v);
+	return native_make_pte(v);
+}
+
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	return pte_clear_flags(pte, _PAGE_RW);
@@ -413,6 +460,24 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 	return native_make_pmd(v & ~clear);
 }
 
+/* See comments above mksaveddirty_shift() */
+static inline pmd_t pmd_mksaveddirty(pmd_t pmd)
+{
+	pmdval_t v = native_pmd_val(pmd);
+
+	v = mksaveddirty_shift(v);
+	return native_make_pmd(v);
+}
+
+/* See comments above mksaveddirty_shift() */
+static inline pmd_t pmd_clear_saveddirty(pmd_t pmd)
+{
+	pmdval_t v = native_pmd_val(pmd);
+
+	v = clear_saveddirty_shift(v);
+	return native_make_pmd(v);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pmd_clear_flags(pmd, _PAGE_RW);
@@ -484,6 +549,24 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 	return native_make_pud(v & ~clear);
 }
 
+/* See comments above mksaveddirty_shift() */
+static inline pud_t pud_mksaveddirty(pud_t pud)
+{
+	pudval_t v = native_pud_val(pud);
+
+	v = mksaveddirty_shift(v);
+	return native_make_pud(v);
+}
+
+/* See comments above mksaveddirty_shift() */
+static inline pud_t pud_clear_saveddirty(pud_t pud)
+{
+	pudval_t v = native_pud_val(pud);
+
+	v = clear_saveddirty_shift(v);
+	return native_make_pud(v);
+}
+
 static inline pud_t pud_mkold(pud_t pud)
 {
 	return pud_clear_flags(pud, _PAGE_ACCESSED);
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 447d4bee25c4..ee6f8e57e115 100644
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
@@ -34,6 +35,13 @@
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
+#ifdef CONFIG_X86_64
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
+#else
+/* Shared with _PAGE_BIT_UFFD_WP which is not supported on 32 bit */
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit */
+#endif
+
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
 /* - if the user mapped it with PROT_NONE; pte_present gives true */
 #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
@@ -117,6 +125,22 @@
 #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
+/*
+ * The hardware requires shadow stack to be Write=0,Dirty=1. However,
+ * there are valid cases where the kernel might create read-only PTEs that
+ * are dirty (e.g., fork(), mprotect(), uffd-wp(), soft-dirty tracking). In
+ * this case, the _PAGE_SAVED_DIRTY bit is used instead of the HW-dirty bit,
+ * to avoid creating a wrong "shadow stack" PTEs. Such PTEs have
+ * (Write=0,SavedDirty=1,Dirty=0) set.
+ */
+#ifdef CONFIG_X86_64
+#define _PAGE_SAVED_DIRTY	(_AT(pteval_t, 1) << _PAGE_BIT_SAVED_DIRTY)
+#else
+#define _PAGE_SAVED_DIRTY	(_AT(pteval_t, 0))
+#endif
+
+#define _PAGE_DIRTY_BITS (_PAGE_DIRTY | _PAGE_SAVED_DIRTY)
+
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 /*
@@ -125,9 +149,9 @@
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
 
@@ -188,10 +212,16 @@ enum page_cache_mode {
 
 #define __PAGE_KERNEL		 (__PP|__RW|   0|___A|__NX|___D|   0|___G)
 #define __PAGE_KERNEL_EXEC	 (__PP|__RW|   0|___A|   0|___D|   0|___G)
+
+/*
+ * Page tables needs to have Write=1 in order for any lower PTEs to be
+ * writable. This includes shadow stack memory (Write=0, Dirty=1)
+ */
 #define _KERNPG_TABLE_NOENC	 (__PP|__RW|   0|___A|   0|___D|   0|   0)
 #define _KERNPG_TABLE		 (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
 #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
+
 #define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|___D|   0|___G)
 #define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|___D|   0|___G)
 #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 75bfaa421030..965659d2c965 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -293,7 +293,8 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
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
2.34.1

