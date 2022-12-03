Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B242641248
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiLCAi7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiLCAiE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:38:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F604F8195;
        Fri,  2 Dec 2022 16:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027823; x=1701563823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kpMw19wz7f4XheX0HpHvGFy0c4NCHOFCF5F75RrJvt0=;
  b=UZloUitvpE/KjhPhTc2u9EYqWXi+DAH7auDpy1d5tlP5+NdBduu9f0/p
   7dQjF5yCAgv0/tb0QCjF9UKDVMcNLXljTjnmzJikgSeXzdst9xokh1gnH
   E0AmdrRIJKWtc3/MfMqIVhIw26EHYnqdMSQpibQ9dzD2XSJba5YxewS4C
   gaPHy1FY6PbMcG4e6KSwMELN1j/wqrwPutOf7fujZE2zPc1exEjVyHYwu
   gGq6jWwvtOCfs6byTPfonG5jwCgeUUBE1o18NUTumxWSNTdGmRY1dEOo0
   8C1vUvCF9wVLFqwsKUbOwLAcb2+7j5IE+anYIQ0a6t8kjE8h3UXNaaa4a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313710962"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313710962"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479846"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479846"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:00 -0800
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
Subject: [PATCH v4 13/39] x86/mm: Start actually marking _PAGE_COW
Date:   Fri,  2 Dec 2022 16:35:40 -0800
Message-Id: <20221203003606.6838-14-rick.p.edgecombe@intel.com>
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

The recently introduced _PAGE_COW should be used instead of the HW Dirty
bit whenever a PTE is Write=0, in order to not inadvertently create
shadow stack PTEs. Update pte_mk*() helpers to do this, and apply the same
changes to pmd and pud.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v4:
 - Break part patch for better bisectability

 arch/x86/include/asm/pgtable.h | 133 ++++++++++++++++++++++++++++-----
 1 file changed, 113 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b68428099932..4a149cec0c07 100644
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
@@ -357,7 +382,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -367,7 +392,16 @@ static inline pte_t pte_mkold(pte_t pte)
 
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
@@ -377,7 +411,19 @@ static inline pte_t pte_mkexec(pte_t pte)
 
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
@@ -387,7 +433,12 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
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
@@ -478,17 +529,36 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
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
@@ -508,7 +578,11 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 
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
@@ -552,17 +626,32 @@ static inline pud_t pud_mkold(pud_t pud)
 
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
@@ -582,7 +671,11 @@ static inline pud_t pud_mkyoung(pud_t pud)
 
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
-- 
2.17.1

