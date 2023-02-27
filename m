Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD5B6A4E31
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjB0WcH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjB0Wbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:31:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8C9298E9;
        Mon, 27 Feb 2023 14:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537101; x=1709073101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7g52pRKve1b7v6zvBkrhRB55FfgM/NC0gEJKTUhkXLA=;
  b=ILh/wViGBia0gr1M+OzCyOgvQeGDvG2FKW6GdJyoN2uypH0rlycsl6dH
   oAVNt+yF/pPi0sPlpvQHZhJlruCChRijz9zh42cdpJNsic2763O/V8L/m
   Bi/zdN9GGi+2Kk8tukz+upuibnLcWPS54cEB60L9cbYs+IImR4AWUaqDE
   +JUOZOoRi096uJgY/zveVfHH/xGcbLuucNleJmNMv8VLCUzt7xcp67oGa
   IKtquQp1XwLHJZeQobjckRj9nx2sBwBL043KqkBRwN9RtNI7s/vu7+qdh
   h/HP6owIIZt1x2OzlFCEzytTZC9NjoEqFO1W2tqXKiLpwBSPGxjZ4ok71
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313657355"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313657355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="848024583"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="848024583"
Received: from leonqu-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.72.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:19 -0800
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
Subject: [PATCH v7 16/41] x86/mm: Start actually marking _PAGE_SAVED_DIRTY
Date:   Mon, 27 Feb 2023 14:29:32 -0800
Message-Id: <20230227222957.24501-17-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The recently introduced _PAGE_SAVED_DIRTY should be used instead of the
HW Dirty bit whenever a PTE is Write=0, in order to not inadvertently
create shadow stack PTEs. Update pte_mk*() helpers to do this, and apply
the same changes to pmd and pud.

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
protected by the pte_modify() call. Apply the same changes to
pmd_modify().

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
v6:
 - Rename _PAGE_COW to _PAGE_SAVED_DIRTY (David Hildenbrand)
 - Open code _PAGE_SAVED_DIRTY part in pte_modify() (Boris)
 - Change the logic so the open coded part is not too ugly
 - Merge pte_modify() patch with this one because of the above

v4:
 - Break part patch for better bisectability
---
 arch/x86/include/asm/pgtable.h | 168 ++++++++++++++++++++++++++++-----
 1 file changed, 145 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 349fcab0405a..05dfdbdf96b4 100644
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
 
 #define pmd_young pmd_young
@@ -145,9 +162,9 @@ static inline int pmd_young(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_ACCESSED;
 }
 
-static inline int pud_dirty(pud_t pud)
+static inline bool pud_dirty(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_DIRTY;
+	return pud_flags(pud) & _PAGE_DIRTY_BITS;
 }
 
 static inline int pud_young(pud_t pud)
@@ -157,13 +174,21 @@ static inline int pud_young(pud_t pud)
 
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
@@ -342,7 +367,16 @@ static inline pte_t pte_clear_saveddirty(pte_t pte)
 
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
+		pte = pte_mksaveddirty(pte);
+	return pte;
 }
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
@@ -380,7 +414,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -395,7 +429,19 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pteval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating Dirty=1,Write=0 PTEs */
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) && !pte_write(pte))
+		dirty = _PAGE_SAVED_DIRTY;
+
+	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	/* pte_clear_saveddirty() also sets Dirty=1 */
+	return pte_clear_saveddirty(pte);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
@@ -412,7 +458,12 @@ struct vm_area_struct;
 
 static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
-	return pte_mkwrite_kernel(pte);
+	pte = pte_mkwrite_kernel(pte);
+
+	if (pte_dirty(pte))
+		pte = pte_clear_saveddirty(pte);
+
+	return pte;
 }
 
 static inline pte_t pte_mkhuge(pte_t pte)
@@ -481,7 +532,15 @@ static inline pmd_t pmd_clear_saveddirty(pmd_t pmd)
 
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
+		pmd = pmd_mksaveddirty(pmd);
+	return pmd;
 }
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
@@ -508,12 +567,23 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
-	return pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
 }
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
-	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pmdval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating (HW)Dirty=1, Write=0 PMDs */
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) && !pmd_write(pmd))
+		dirty = _PAGE_SAVED_DIRTY;
+
+	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
+}
+
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
+{
+	return pmd_clear_saveddirty(pmd);
 }
 
 static inline pmd_t pmd_mkdevmap(pmd_t pmd)
@@ -533,7 +603,12 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 
 static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
-	return pmd_set_flags(pmd, _PAGE_RW);
+	pmd = pmd_set_flags(pmd, _PAGE_RW);
+
+	if (pmd_dirty(pmd))
+		pmd = pmd_clear_saveddirty(pmd);
+
+	return pmd;
 }
 
 static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
@@ -577,17 +652,32 @@ static inline pud_t pud_mkold(pud_t pud)
 
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
+		pud = pud_mksaveddirty(pud);
+	return pud;
 }
 
 static inline pud_t pud_mkdirty(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	pudval_t dirty = _PAGE_DIRTY;
+
+	/* Avoid creating (HW)Dirty=1, Write=0 PUDs */
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) && !pud_write(pud))
+		dirty = _PAGE_SAVED_DIRTY;
+
+	return pud_set_flags(pud, dirty | _PAGE_SOFT_DIRTY);
 }
 
 static inline pud_t pud_mkdevmap(pud_t pud)
@@ -607,7 +697,11 @@ static inline pud_t pud_mkyoung(pud_t pud)
 
 static inline pud_t pud_mkwrite(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_RW);
+	pud = pud_set_flags(pud, _PAGE_RW);
+
+	if (pud_dirty(pud))
+		pud = pud_clear_saveddirty(pud);
+	return pud;
 }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
@@ -724,6 +818,8 @@ static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pteval_t val = pte_val(pte), oldval = val;
+	bool wr_protected;
+	pte_t pte_result;
 
 	/*
 	 * Chop off the NX bit (if present), and add the NX portion of
@@ -732,17 +828,43 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	val &= _PAGE_CHG_MASK;
 	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
 	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
-	return __pte(val);
+
+	pte_result = __pte(val);
+
+	/*
+	 * Do the saveddirty fixup if the PTE was just write protected and
+	 * it's dirty.
+	 */
+	wr_protected = (oldval & _PAGE_RW) && !(val & _PAGE_RW);
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) && wr_protected &&
+	    (val & _PAGE_DIRTY))
+		pte_result = pte_mksaveddirty(pte_result);
+
+	return pte_result;
 }
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 	pmdval_t val = pmd_val(pmd), oldval = val;
+	bool wr_protected;
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
+	 * Do the saveddirty fixup if the PMD was just write protected and
+	 * it's dirty.
+	 */
+	wr_protected = (oldval & _PAGE_RW) && !(val & _PAGE_RW);
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) && wr_protected &&
+	    (val & _PAGE_DIRTY))
+		pmd_result = pmd_mksaveddirty(pmd_result);
+
+	return pmd_result;
 }
 
 /*
-- 
2.17.1

