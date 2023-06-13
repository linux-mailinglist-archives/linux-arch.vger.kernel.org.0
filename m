Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6602672D5EB
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbjFMAMd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbjFMAM2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:12:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF31197;
        Mon, 12 Jun 2023 17:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615143; x=1718151143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7eVLFaUcP7DtfYYGhz2IcxmOiAMntCwFG2k86EQ1hPY=;
  b=goZUV0P6gFKBYGIKAOm/P0F/uIFo+IlIBLC+CXnTZAKZTtfIaxNeMohx
   4tz0GWKQ+EVG3QOAW9wWITARrbKuhMNG7ESA1iOIoDDNSa8YJNFnYnRsC
   r3EyEpyZiimgCLOXcgaUoOhdhZlLBft3QayzYw2AEXABMCUpSkUEC+9Y7
   SIfHSFCpQ6pB5O7wngp8uqidh3HioAcL+B+VIMlI7vqBFk4eC/g0K0p/z
   I7RSv3/BjQFHzw3fJuYNhy46j8fl79eSiTTQOD/uUY4Dt2QqXIm+9KwHi
   2hzm9LCaHCzBcNOZ5IGzKZIMtZwZrcoYHMJJofZoYNab2LUTKsB2D/P24
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361556918"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361556918"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671013"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671013"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:17 -0700
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
Subject: [PATCH v9 12/42] x86/mm: Start actually marking _PAGE_SAVED_DIRTY
Date:   Mon, 12 Jun 2023 17:10:38 -0700
Message-Id: <20230613001108.3040476-13-rick.p.edgecombe@intel.com>
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

The recently introduced _PAGE_SAVED_DIRTY should be used instead of the
HW Dirty bit whenever a PTE is Write=0, in order to not inadvertently
create shadow stack PTEs. Update pte_mk*() helpers to do this, and apply
the same changes to pmd and pud. Since there is no x86 version of
pte_mkwrite() to hold this arch specific logic, create one. Add it to
x86/mm/pgtable.c instead of x86/asm/include/pgtable.h as future patches
will require it to live in pgtable.c and it will make the diff easier
for reviewers.

Since CPUs without shadow stack support could create Write=0,Dirty=1
PTEs, only return true for pte_shstk() if the CPU also supports shadow
stack. This will prevent these HW creates PTEs as showing as true for
pte_write().

For pte_modify() this is a bit trickier. It takes a "raw" pgprot_t which
was not necessarily created with any of the existing PTE bit helpers.
That means that it can return a pte_t with Write=0,Dirty=1, a shadow
stack PTE, when it did not intend to create one.

Modify it to also move _PAGE_DIRTY to _PAGE_SAVED_DIRTY. To avoid
creating Write=0,Dirty=1 PTEs, pte_modify() needs to avoid:
1. Marking Write=0 PTEs Dirty=1
2. Marking Dirty=1 PTEs Write=0

The first case cannot happen as the existing behavior of pte_modify() is to
filter out any Dirty bit passed in newprot. Handle the second case by
shifting _PAGE_DIRTY=1 to _PAGE_SAVED_DIRTY=1 if the PTE was write
protected by the pte_modify() call. Apply the same changes to pmd_modify().

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v9:
 - Use bit shifting helpers that don't need any extra conditional
   logic. (Linus)
 - Handle the harmless Write=0->Write=1 pte_modify() case with the
   shifting helpers.
 - Don't ever return true for pte_shstk() if the CPU does not support
   shadow stack.
---
 arch/x86/include/asm/pgtable.h | 151 ++++++++++++++++++++++++++++-----
 arch/x86/mm/pgtable.c          |  14 +++
 2 files changed, 144 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 99b54ab0a919..d8724f5b1202 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -124,9 +124,15 @@ extern pmdval_t early_pmd_flags;
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
+	return cpu_feature_enabled(X86_FEATURE_SHSTK) &&
+	       (pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
 }
 
 static inline int pte_young(pte_t pte)
@@ -134,9 +140,16 @@ static inline int pte_young(pte_t pte)
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
+	return cpu_feature_enabled(X86_FEATURE_SHSTK) &&
+	       (pmd_flags(pmd) & (_PAGE_RW | _PAGE_DIRTY | _PAGE_PSE)) ==
+	       (_PAGE_DIRTY | _PAGE_PSE);
 }
 
 #define pmd_young pmd_young
@@ -145,9 +158,9 @@ static inline int pmd_young(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_ACCESSED;
 }
 
-static inline int pud_dirty(pud_t pud)
+static inline bool pud_dirty(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_DIRTY;
+	return pud_flags(pud) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pud_young(pud_t pud)
@@ -157,13 +170,21 @@ static inline int pud_young(pud_t pud)
 
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
@@ -350,7 +371,14 @@ static inline pte_t pte_clear_saveddirty(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_RW);
+	pte = pte_clear_flags(pte, _PAGE_RW);
+
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PTE (Write=0,Dirty=1). Move the hardware
+	 * dirty value to the software bit, if present.
+	 */
+	return pte_mksaveddirty(pte);
 }
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
@@ -388,7 +416,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -403,7 +431,16 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pte = pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+
+	return pte_mksaveddirty(pte);
+}
+
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	pte = pte_clear_flags(pte, _PAGE_RW);
+
+	return pte_set_flags(pte, _PAGE_DIRTY);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
@@ -416,6 +453,10 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return pte_set_flags(pte, _PAGE_RW);
 }
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkhuge(pte_t pte)
 {
 	return pte_set_flags(pte, _PAGE_PSE);
@@ -480,7 +521,14 @@ static inline pmd_t pmd_clear_saveddirty(pmd_t pmd)
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
-	return pmd_clear_flags(pmd, _PAGE_RW);
+	pmd = pmd_clear_flags(pmd, _PAGE_RW);
+
+	/*
+	 * Blindly clearing _PAGE_RW might accidentally create
+	 * a shadow stack PMD (RW=0, Dirty=1). Move the hardware
+	 * dirty value to the software bit.
+	 */
+	return pmd_mksaveddirty(pmd);
 }
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
@@ -507,12 +555,21 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
-	return pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
 }
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
-	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pmd = pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+
+	return pmd_mksaveddirty(pmd);
+}
+
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
+{
+	pmd = pmd_clear_flags(pmd, _PAGE_RW);
+
+	return pmd_set_flags(pmd, _PAGE_DIRTY);
 }
 
 static inline pmd_t pmd_mkdevmap(pmd_t pmd)
@@ -535,6 +592,9 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_RW);
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
 {
 	pudval_t v = native_pud_val(pud);
@@ -574,17 +634,26 @@ static inline pud_t pud_mkold(pud_t pud)
 
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
+	return pud_mksaveddirty(pud);
 }
 
 static inline pud_t pud_mkdirty(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pud = pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+
+	return pud_mksaveddirty(pud);
 }
 
 static inline pud_t pud_mkdevmap(pud_t pud)
@@ -604,7 +673,9 @@ static inline pud_t pud_mkyoung(pud_t pud)
 
 static inline pud_t pud_mkwrite(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_RW);
+	pud = pud_set_flags(pud, _PAGE_RW);
+
+	return pud_clear_saveddirty(pud);
 }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
@@ -721,6 +792,7 @@ static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pteval_t val = pte_val(pte), oldval = val;
+	pte_t pte_result;
 
 	/*
 	 * Chop off the NX bit (if present), and add the NX portion of
@@ -729,17 +801,54 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	val &= _PAGE_CHG_MASK;
 	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
 	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
-	return __pte(val);
+
+	pte_result = __pte(val);
+
+	/*
+	 * To avoid creating Write=0,Dirty=1 PTEs, pte_modify() needs to avoid:
+	 *  1. Marking Write=0 PTEs Dirty=1
+	 *  2. Marking Dirty=1 PTEs Write=0
+	 *
+	 * The first case cannot happen because the _PAGE_CHG_MASK will filter
+	 * out any Dirty bit passed in newprot. Handle the second case by
+	 * going through the mksaveddirty exercise. Only do this if the old
+	 * value was Write=1 to avoid doing this on Shadow Stack PTEs.
+	 */
+	if (oldval & _PAGE_RW)
+		pte_result = pte_mksaveddirty(pte_result);
+	else
+		pte_result = pte_clear_saveddirty(pte_result);
+
+	return pte_result;
 }
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 	pmdval_t val = pmd_val(pmd), oldval = val;
+	pmd_t pmd_result;
 
-	val &= _HPAGE_CHG_MASK;
+	val &= (_HPAGE_CHG_MASK & ~_PAGE_DIRTY);
 	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
 	val = flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
-	return __pmd(val);
+
+	pmd_result = __pmd(val);
+
+	/*
+	 * To avoid creating Write=0,Dirty=1 PMDs, pte_modify() needs to avoid:
+	 *  1. Marking Write=0 PMDs Dirty=1
+	 *  2. Marking Dirty=1 PMDs Write=0
+	 *
+	 * The first case cannot happen because the _PAGE_CHG_MASK will filter
+	 * out any Dirty bit passed in newprot. Handle the second case by
+	 * going through the mksaveddirty exercise. Only do this if the old
+	 * value was Write=1 to avoid doing this on Shadow Stack PTEs.
+	 */
+	if (oldval & _PAGE_RW)
+		pmd_result = pmd_mksaveddirty(pmd_result);
+	else
+		pmd_result = pmd_clear_saveddirty(pmd_result);
+
+	return pmd_result;
 }
 
 /*
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e4f499eb0f29..0ad2c62ac0a8 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -880,3 +880,17 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 #endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	pte = pte_mkwrite_novma(pte);
+
+	return pte_clear_saveddirty(pte);
+}
+
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	pmd = pmd_mkwrite_novma(pmd);
+
+	return pmd_clear_saveddirty(pmd);
+}
-- 
2.34.1

