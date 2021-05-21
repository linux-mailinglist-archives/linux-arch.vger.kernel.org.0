Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5B38D0C6
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 00:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhEUWO7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 18:14:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:31091 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhEUWOl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 18:14:41 -0400
IronPort-SDR: 9SSAw2wwSVpozYP6TIaFZbKUmIB7SNmy3unNF7BdZF4ZqlRu/uss9K3Rk5c5TuW3k0PyPeHsjb
 QwZZhQBjrxBw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201636836"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201636836"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:13:17 -0700
IronPort-SDR: xr08qBF3F4VaRJSHfWZDVm1p6L6aLng6J47mx8kzH/mF7GfNlocueTf4Oq6H5rtwGksQVyIQjm
 UfAQmXJuRFqQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441116202"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:13:16 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v27 19/31] mm/mmap: Add shadow stack pages to memory accounting
Date:   Fri, 21 May 2021 15:11:59 -0700
Message-Id: <20210521221211.29077-20-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210521221211.29077-1-yu-cheng.yu@intel.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Account shadow stack pages to stack memory.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v26:
- Remove redundant #ifdef CONFIG_MMU.

v25:
- Remove #ifdef CONFIG_ARCH_HAS_SHADOW_STACK for is_shadow_stack_mapping().

v24:
- Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().
- Change VM_SHSTK to VM_SHADOW_STACK.

 arch/x86/include/asm/pgtable.h | 3 +++
 arch/x86/mm/pgtable.c          | 5 +++++
 include/linux/pgtable.h        | 7 +++++++
 mm/mmap.c                      | 5 +++++
 4 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 996ce14d8ab4..43380a6127f7 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1692,6 +1692,9 @@ static inline bool arch_faults_on_old_pte(void)
 #define maybe_mkwrite maybe_mkwrite
 extern pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma);
 
+#define is_shadow_stack_mapping is_shadow_stack_mapping
+extern bool is_shadow_stack_mapping(vm_flags_t vm_flags);
+
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_H */
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 702112a86c8a..57364518268a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -884,3 +884,8 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 #endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
+bool is_shadow_stack_mapping(vm_flags_t vm_flags)
+{
+	return vm_flags & VM_SHADOW_STACK;
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 46b13780c2c8..cf0f316c643b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1458,6 +1458,13 @@ static inline bool arch_has_pfn_modify_check(void)
 }
 #endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
 
+#ifndef is_shadow_stack_mapping
+static inline bool is_shadow_stack_mapping(vm_flags_t vm_flags)
+{
+	return false;
+}
+#endif
+
 /*
  * Architecture PAGE_KERNEL_* fallbacks
  *
diff --git a/mm/mmap.c b/mm/mmap.c
index 0584e540246e..5075282a007d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1724,6 +1724,9 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	if (file && is_file_hugepages(file))
 		return 0;
 
+	if (is_shadow_stack_mapping(vm_flags))
+		return 1;
+
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
@@ -3377,6 +3380,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
 		mm->stack_vm += npages;
 	else if (is_data_mapping(flags))
 		mm->data_vm += npages;
+	else if (is_shadow_stack_mapping(flags))
+		mm->stack_vm += npages;
 }
 
 static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
-- 
2.21.0

