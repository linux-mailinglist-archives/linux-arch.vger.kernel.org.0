Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB1C3614F0
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 00:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhDOWRR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 18:17:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:22365 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236918AbhDOWQw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 18:16:52 -0400
IronPort-SDR: ZRGAQodyf7e5bGg06LgorynxT2QplEWxXi9tGzEQO9Wir4NHtS0TzI2OSmU1fliW3mFfuPUmgN
 aOV0Oj98hHIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194513370"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194513370"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:37 -0700
IronPort-SDR: oKzu3r/9ullWkMf7HywTvwKzqQD4tutyRtGh7aVCOTjXKePpaJ4nc0dRh49DqvBQHesqGk7Rxx
 nBVftnQdpugA==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="451270918"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:37 -0700
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
Subject: [PATCH v25 18/30] mm/mmap: Add shadow stack pages to memory accounting
Date:   Thu, 15 Apr 2021 15:14:07 -0700
Message-Id: <20210415221419.31835-19-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210415221419.31835-1-yu-cheng.yu@intel.com>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Account shadow stack pages to stack memory.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v25:
- Remove #ifdef CONFIG_ARCH_HAS_SHADOW_STACK for is_shadow_stack_mapping().
v24:
- Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().
- Change VM_SHSTK to VM_SHADOW_STACK.

 arch/x86/include/asm/pgtable.h | 3 +++
 arch/x86/mm/pgtable.c          | 5 +++++
 include/linux/pgtable.h        | 9 +++++++++
 mm/mmap.c                      | 5 +++++
 4 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index da5dea417663..7f324edaedfa 100644
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
index e778dbbef3d8..69c0ef583c55 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -897,3 +897,8 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 #endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
+bool is_shadow_stack_mapping(vm_flags_t vm_flags)
+{
+	return (vm_flags & VM_SHADOW_STACK);
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5e772392a379..45b601fa1a1c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1446,6 +1446,15 @@ static inline bool arch_has_pfn_modify_check(void)
 }
 #endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
 
+#ifdef CONFIG_MMU
+#ifndef is_shadow_stack_mapping
+static inline bool is_shadow_stack_mapping(vm_flags_t vm_flags)
+{
+	return false;
+}
+#endif
+#endif /* CONFIG_MMU */
+
 /*
  * Architecture PAGE_KERNEL_* fallbacks
  *
diff --git a/mm/mmap.c b/mm/mmap.c
index 3f287599a7a3..d77fb39b6ab5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1718,6 +1718,9 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	if (file && is_file_hugepages(file))
 		return 0;
 
+	if (is_shadow_stack_mapping(vm_flags))
+		return 1;
+
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
@@ -3387,6 +3390,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
 		mm->stack_vm += npages;
 	else if (is_data_mapping(flags))
 		mm->data_vm += npages;
+	else if (is_shadow_stack_mapping(flags))
+		mm->stack_vm += npages;
 }
 
 static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
-- 
2.21.0

