Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA01537D4
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 19:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgBESWC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 13:22:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:20937 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgBESU2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 10:20:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="279447771"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2020 10:20:26 -0800
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
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 08/27] x86/mm: Change _PAGE_DIRTY to _PAGE_DIRTY_HW
Date:   Wed,  5 Feb 2020 10:19:16 -0800
Message-Id: <20200205181935.3712-9-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200205181935.3712-1-yu-cheng.yu@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Before introducing _PAGE_DIRTY_SW for non-hardware memory management
purposes in the next patch, rename _PAGE_DIRTY to _PAGE_DIRTY_HW and
_PAGE_BIT_DIRTY to _PAGE_BIT_DIRTY_HW to make these PTE dirty bits
more clear.  There are no functional changes from this patch.

v9:
- At some places _PAGE_DIRTY were not changed to _PAGE_DIRTY_HW, because
  they will be changed again in the next patch to _PAGE_DIRTY_BITS.
  However, this causes compile issues if the next patch is not yet applied.
  Fix it by changing all _PAGE_DIRTY to _PAGE_DRITY_HW.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/pgtable.h       | 18 +++++++++---------
 arch/x86/include/asm/pgtable_types.h | 17 +++++++++--------
 arch/x86/kernel/relocate_kernel_64.S |  2 +-
 arch/x86/kvm/vmx/vmx.c               |  2 +-
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index ad97dc155195..ab50d25f9afc 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -122,7 +122,7 @@ extern pmdval_t early_pmd_flags;
  */
 static inline int pte_dirty(pte_t pte)
 {
-	return pte_flags(pte) & _PAGE_DIRTY;
+	return pte_flags(pte) & _PAGE_DIRTY_HW;
 }
 
 
@@ -161,7 +161,7 @@ static inline int pte_young(pte_t pte)
 
 static inline int pmd_dirty(pmd_t pmd)
 {
-	return pmd_flags(pmd) & _PAGE_DIRTY;
+	return pmd_flags(pmd) & _PAGE_DIRTY_HW;
 }
 
 static inline int pmd_young(pmd_t pmd)
@@ -171,7 +171,7 @@ static inline int pmd_young(pmd_t pmd)
 
 static inline int pud_dirty(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_DIRTY;
+	return pud_flags(pud) & _PAGE_DIRTY_HW;
 }
 
 static inline int pud_young(pud_t pud)
@@ -312,7 +312,7 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_DIRTY_HW);
 }
 
 static inline pte_t pte_mkold(pte_t pte)
@@ -332,7 +332,7 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return pte_set_flags(pte, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
@@ -396,7 +396,7 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
 
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
-	return pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_DIRTY_HW);
 }
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
@@ -406,7 +406,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
-	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return pmd_set_flags(pmd, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
 static inline pmd_t pmd_mkdevmap(pmd_t pmd)
@@ -450,7 +450,7 @@ static inline pud_t pud_mkold(pud_t pud)
 
 static inline pud_t pud_mkclean(pud_t pud)
 {
-	return pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_clear_flags(pud, _PAGE_DIRTY_HW);
 }
 
 static inline pud_t pud_wrprotect(pud_t pud)
@@ -460,7 +460,7 @@ static inline pud_t pud_wrprotect(pud_t pud)
 
 static inline pud_t pud_mkdirty(pud_t pud)
 {
-	return pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return pud_set_flags(pud, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
 static inline pud_t pud_mkdevmap(pud_t pud)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b5e49e6bac63..e647e3c75578 100644
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
@@ -45,7 +45,7 @@
 #define _PAGE_PWT	(_AT(pteval_t, 1) << _PAGE_BIT_PWT)
 #define _PAGE_PCD	(_AT(pteval_t, 1) << _PAGE_BIT_PCD)
 #define _PAGE_ACCESSED	(_AT(pteval_t, 1) << _PAGE_BIT_ACCESSED)
-#define _PAGE_DIRTY	(_AT(pteval_t, 1) << _PAGE_BIT_DIRTY)
+#define _PAGE_DIRTY_HW	(_AT(pteval_t, 1) << _PAGE_BIT_DIRTY_HW)
 #define _PAGE_PSE	(_AT(pteval_t, 1) << _PAGE_BIT_PSE)
 #define _PAGE_GLOBAL	(_AT(pteval_t, 1) << _PAGE_BIT_GLOBAL)
 #define _PAGE_SOFTW1	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW1)
@@ -73,7 +73,7 @@
 			 _PAGE_PKEY_BIT3)
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
-#define _PAGE_KNL_ERRATUM_MASK (_PAGE_DIRTY | _PAGE_ACCESSED)
+#define _PAGE_KNL_ERRATUM_MASK (_PAGE_DIRTY_HW | _PAGE_ACCESSED)
 #else
 #define _PAGE_KNL_ERRATUM_MASK 0
 #endif
@@ -111,9 +111,9 @@
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 #define _PAGE_TABLE_NOENC	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |\
-				 _PAGE_ACCESSED | _PAGE_DIRTY)
+				 _PAGE_ACCESSED | _PAGE_DIRTY_HW)
 #define _KERNPG_TABLE_NOENC	(_PAGE_PRESENT | _PAGE_RW |		\
-				 _PAGE_ACCESSED | _PAGE_DIRTY)
+				 _PAGE_ACCESSED | _PAGE_DIRTY_HW)
 
 /*
  * Set of bits not changed in pte_modify.  The pte's
@@ -122,7 +122,7 @@
  * pte_modify() does modify it.
  */
 #define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
-			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
+			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY_HW |	\
 			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
 
@@ -167,7 +167,8 @@ enum page_cache_mode {
 					 _PAGE_ACCESSED)
 
 #define __PAGE_KERNEL_EXEC						\
-	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_GLOBAL)
+	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY_HW | _PAGE_ACCESSED | \
+	 _PAGE_GLOBAL)
 #define __PAGE_KERNEL		(__PAGE_KERNEL_EXEC | _PAGE_NX)
 
 #define __PAGE_KERNEL_RO		(__PAGE_KERNEL & ~_PAGE_RW)
@@ -186,7 +187,7 @@ enum page_cache_mode {
 #define _PAGE_ENC	(_AT(pteval_t, sme_me_mask))
 
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED |	\
-			 _PAGE_DIRTY | _PAGE_ENC)
+			 _PAGE_DIRTY_HW | _PAGE_ENC)
 #define _PAGE_TABLE	(_KERNPG_TABLE | _PAGE_USER)
 
 #define __PAGE_KERNEL_ENC	(__PAGE_KERNEL | _PAGE_ENC)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index ef3ba99068d3..3acd75f97b61 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -15,7 +15,7 @@
  */
 
 #define PTR(x) (x << 3)
-#define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
+#define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY_HW)
 
 /*
  * control_page + KEXEC_CONTROL_CODE_MAX_SIZE
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3394c839dea..fbbbf621b0d9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3503,7 +3503,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
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

