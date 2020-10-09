Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30F28910A
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 20:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390589AbgJISeY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 14:34:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:9530 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390453AbgJISdO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 14:33:14 -0400
IronPort-SDR: UNwsjjPqlFLitJi2bRv29BAHR442T/IVSoBL4+8iNcIihJ2h9vkLgksSMTv1rPAyeUH5jj87qN
 5e85/jSQlSdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="164736600"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="164736600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:13 -0700
IronPort-SDR: xRi/Ix4/li5FeqCIhxbfZVk9oqsLgG8ak+XgiiuRR//88BtnPwC1MeqjLh2e2g048gOyET70Mc
 MwfO1+IWcmmA==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="529031129"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:13 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v14 06/26] x86/mm: Change _PAGE_DIRTY to _PAGE_DIRTY_HW
Date:   Fri,  9 Oct 2020 11:32:10 -0700
Message-Id: <20201009183230.26717-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201009183230.26717-1-yu-cheng.yu@intel.com>
References: <20201009183230.26717-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Before introducing _PAGE_COW for non-hardware memory management purposes in
the next patch, rename _PAGE_DIRTY to _PAGE_DIRTY_HW and _PAGE_BIT_DIRTY to
_PAGE_BIT_DIRTY_HW to make meanings more clear.  There are no functional
changes from this patch.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>

v9:
- At some places _PAGE_DIRTY were not changed to _PAGE_DIRTY_HW, because
  they will be changed again in the next patch to _PAGE_DIRTY_BITS.
  However, this causes compile issues if the next patch is not yet applied.
  Fix it by changing all _PAGE_DIRTY to _PAGE_DRITY_HW.
---
 arch/x86/include/asm/pgtable.h       | 18 +++++++++---------
 arch/x86/include/asm/pgtable_types.h | 11 +++++------
 arch/x86/kernel/relocate_kernel_64.S |  2 +-
 arch/x86/kvm/vmx/vmx.c               |  2 +-
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b836138ce852..86b7acd221c1 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -124,7 +124,7 @@ extern pmdval_t early_pmd_flags;
  */
 static inline int pte_dirty(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_DIRTY;
+	return pte_flags(pte) & _PAGE_DIRTY_HW;
 }
 
 
@@ -163,7 +163,7 @@ static inline int pte_young(pte_t pte)
 
 static inline int pmd_dirty(pmd_t pmd)
 {
-	return pmd_flags(pmd) & _PAGE_DIRTY;
+	return pmd_flags(pmd) & _PAGE_DIRTY_HW;
 }
 
 static inline int pmd_young(pmd_t pmd)
@@ -173,7 +173,7 @@ static inline int pmd_young(pmd_t pmd)
 
 static inline int pud_dirty(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_DIRTY;
+	return pud_flags(pud) & _PAGE_DIRTY_HW;
 }
 
 static inline int pud_young(pud_t pud)
@@ -334,7 +334,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_DIRTY_HW);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -354,7 +354,7 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return pte_set_flags(pte, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
@@ -435,7 +435,7 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
-	return pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_DIRTY_HW);
 }
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
@@ -445,7 +445,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
-	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return pmd_set_flags(pmd, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
 static inline pmd_t pmd_mkdevmap(pmd_t pmd)
@@ -489,7 +489,7 @@ static inline pud_t pud_mkold(pud_t pud)
 
 static inline pud_t pud_mkclean(pud_t pud)
 {
-	return pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_clear_flags(pud, _PAGE_DIRTY_HW);
 }
 
 static inline pud_t pud_wrprotect(pud_t pud)
@@ -499,7 +499,7 @@ static inline pud_t pud_wrprotect(pud_t pud)
 
 static inline pud_t pud_mkdirty(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return pud_set_flags(pud, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
 static inline pud_t pud_mkdevmap(pud_t pud)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 816b31c68550..192e1326b3db 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -15,7 +15,7 @@
 #define _PAGE_BIT_PWT		3	/* page write through */
 #define _PAGE_BIT_PCD		4	/* page cache disabled */
 #define _PAGE_BIT_ACCESSED	5	/* was accessed (raised by CPU) */
-#define _PAGE_BIT_DIRTY		6	/* was written to (raised by CPU) */
+#define _PAGE_BIT_DIRTY_HW	6	/* was written to (raised by CPU) */
 #define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page */
 #define _PAGE_BIT_PAT		7	/* on 4KB pages */
 #define _PAGE_BIT_GLOBAL	8	/* Global TLB entry PPro+ */
@@ -46,7 +46,7 @@
 #define _PAGE_PWT	(_AT(pteval_t, 1) << _PAGE_BIT_PWT)
 #define _PAGE_PCD	(_AT(pteval_t, 1) << _PAGE_BIT_PCD)
 #define _PAGE_ACCESSED	(_AT(pteval_t, 1) << _PAGE_BIT_ACCESSED)
-#define _PAGE_DIRTY	(_AT(pteval_t, 1) << _PAGE_BIT_DIRTY)
+#define _PAGE_DIRTY_HW	(_AT(pteval_t, 1) << _PAGE_BIT_DIRTY_HW)
 #define _PAGE_PSE	(_AT(pteval_t, 1) << _PAGE_BIT_PSE)
 #define _PAGE_GLOBAL	(_AT(pteval_t, 1) << _PAGE_BIT_GLOBAL)
 #define _PAGE_SOFTW1	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW1)
@@ -74,7 +74,7 @@
 			 _PAGE_PKEY_BIT3)
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
-#define _PAGE_KNL_ERRATUM_MASK (_PAGE_DIRTY | _PAGE_ACCESSED)
+#define _PAGE_KNL_ERRATUM_MASK (_PAGE_DIRTY_HW | _PAGE_ACCESSED)
 #else
 #define _PAGE_KNL_ERRATUM_MASK 0
 #endif
@@ -126,7 +126,7 @@
  * pte_modify() does modify it.
  */
 #define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
-			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
+			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY_HW |	\
 			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |  \
 			 _PAGE_UFFD_WP)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
@@ -163,7 +163,7 @@ enum page_cache_mode {
 #define __RW _PAGE_RW
 #define _USR _PAGE_USER
 #define ___A _PAGE_ACCESSED
-#define ___D _PAGE_DIRTY
+#define ___D _PAGE_DIRTY_HW
 #define ___G _PAGE_GLOBAL
 #define __NX _PAGE_NX
 
@@ -205,7 +205,6 @@ enum page_cache_mode {
 #define __PAGE_KERNEL_IO		__PAGE_KERNEL
 #define __PAGE_KERNEL_IO_NOCACHE	__PAGE_KERNEL_NOCACHE
 
-
 #ifndef __ASSEMBLY__
 
 #define __PAGE_KERNEL_ENC	(__PAGE_KERNEL    | _ENC)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index a4d9a261425b..e3bb4ff95523 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -17,7 +17,7 @@
  */
 
 #define PTR(x) (x << 3)
-#define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
+#define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY_HW)
 
 /*
  * control_page + KEXEC_CONTROL_CODE_MAX_SIZE
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 96979c09ebd1..57c5ad890597 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3620,7 +3620,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	/* Set up identity-mapping pagetable for EPT in real mode */
 	for (i = 0; i < PT32_ENT_PER_PAGE; i++) {
 		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
-			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
+			_PAGE_ACCESSED | _PAGE_DIRTY_HW | _PAGE_PSE);
 		r = kvm_write_guest_page(kvm, identity_map_pfn,
 				&tmp, i * sizeof(tmp), sizeof(tmp));
 		if (r < 0)
-- 
2.21.0

