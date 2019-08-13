Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5457E8C313
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfHMVFg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:05:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:16072 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfHMVCq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:02:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="187901384"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2019 14:02:45 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 10/27] x86/mm: Change _PAGE_DIRTY to _PAGE_DIRTY_HW
Date:   Tue, 13 Aug 2019 13:52:08 -0700
Message-Id: <20190813205225.12032-11-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205225.12032-1-yu-cheng.yu@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Before introducing _PAGE_DIRTY_SW for non-hardware, memory management
purposes in the next patch, rename _PAGE_DIRTY to _PAGE_DIRTY_HW and
_PAGE_BIT_DIRTY to _PAGE_BIT_DIRTY_HW to make these PTE dirty bits
more clear.  There are no functional changes in this patch.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/pgtable.h       |  6 +++---
 arch/x86/include/asm/pgtable_types.h | 17 +++++++++--------
 arch/x86/kernel/relocate_kernel_64.S |  2 +-
 arch/x86/kvm/vmx/vmx.c               |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0bc530c4eb13..8e38d87fce6e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -332,7 +332,7 @@ static inline pte_t pte_mkexec(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return pte_set_flags(pte, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
@@ -406,7 +406,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
-	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return pmd_set_flags(pmd, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
 }
 
 static inline pmd_t pmd_mkdevmap(pmd_t pmd)
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
index c51ccff5cd01..60b75e8f4c14 100644
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
index 42ed3faa6af8..226875fbfa45 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3395,7 +3395,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	/* Set up identity-mapping pagetable for EPT in real mode */
 	for (i = 0; i < PT32_ENT_PER_PAGE; i++) {
 		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
-			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
+			_PAGE_ACCESSED | _PAGE_DIRTY_HW | _PAGE_PSE);
 		r = kvm_write_guest_page(kvm, identity_map_pfn,
 				&tmp, i * sizeof(tmp), sizeof(tmp));
 		if (r < 0)
-- 
2.17.1

