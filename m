Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051A7306650
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 22:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhA0Ve5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 16:34:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:48884 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235246AbhA0VcD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 16:32:03 -0500
IronPort-SDR: 9lIGtZQJCuG2eu/FlOfS2yDfSaQggkBxVnOdXPwVCylAkaeSZxzsDufXBBBCoPqTfFKyEU32+r
 +2cynIECkg7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="177573161"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="177573161"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:25:58 -0800
IronPort-SDR: TesAzg53yXsW1d+DExOfb8b3TTHd8HTCXkroeCTgmuG8VYh6R/in5KfTciP74cY0YefDZORrdB
 W+lhIuC5kkPA==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="353948242"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:25:57 -0800
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v18 17/25] mm/mmap: Add shadow stack pages to memory accounting
Date:   Wed, 27 Jan 2021 13:25:16 -0800
Message-Id: <20210127212524.10188-18-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210127212524.10188-1-yu-cheng.yu@intel.com>
References: <20210127212524.10188-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Account shadow stack pages to stack memory.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/mm/pgtable.c   |  7 +++++++
 include/linux/pgtable.h | 11 +++++++++++
 mm/mmap.c               |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 0f4fbf51a9fc..948d28c29964 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -895,3 +895,10 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 #endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
+#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
+bool arch_shadow_stack_mapping(vm_flags_t vm_flags)
+{
+	return (vm_flags & VM_SHSTK);
+}
+#endif
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index d8452218d09b..b888b246b8b1 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1463,6 +1463,17 @@ static inline pmd_t arch_maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma
 #endif /* CONFIG_ARCH_MAYBE_MKWRITE */
 #endif /* CONFIG_MMU */
 
+#ifdef CONFIG_MMU
+#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
+bool arch_shadow_stack_mapping(vm_flags_t vm_flags);
+#else
+static inline bool arch_shadow_stack_mapping(vm_flags_t vm_flags)
+{
+	return false;
+}
+#endif /* CONFIG_ARCH_HAS_SHADOW_STACK */
+#endif /* CONFIG_MMU */
+
 /*
  * Architecture PAGE_KERNEL_* fallbacks
  *
diff --git a/mm/mmap.c b/mm/mmap.c
index dc7206032387..51200b821898 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1720,6 +1720,9 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	if (file && is_file_hugepages(file))
 		return 0;
 
+	if (arch_shadow_stack_mapping(vm_flags))
+		return 1;
+
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
@@ -3389,6 +3392,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
 		mm->stack_vm += npages;
 	else if (is_data_mapping(flags))
 		mm->data_vm += npages;
+	else if (arch_shadow_stack_mapping(flags))
+		mm->stack_vm += npages;
 }
 
 static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
-- 
2.21.0

