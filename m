Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94E84A3A0D
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356500AbiA3VWr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:22:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:52029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356562AbiA3VWD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577723; x=1675113723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Xw4flY9LjZeFsLI8M4MTW65ZEVTonPqvM2qNAILyuVU=;
  b=fsoM62WVjv0xhc2R9pvK+nUEZzxIbNFxuoij1ZrAh7SYP7iIKoNBGKt8
   wV9lA1zYSw1orLIdR1cV+aEntH/0/iUCGgkCGvxH8Wkm9+UUBd3aEMD53
   MiEZ2NknidaJdmcgDFmsGgEaxm/oz4FBocOjraBVYYB2jfY1Lwgfh6WFE
   w5QrDPe1duYjsF028hJp4YKY+EvxKu+Yrsa/72MOI1EEUqWS14wvWtnT8
   blLtoUog/F9iO5swFqFXx4B10QkxXennNNoUP/AIXIuzUNFa8U8KelVxs
   Gbjd8+qodnMnkwaw2t7IAnwZWNLYwpiswx3QVKnTs0Hgwt+nZ0d9X5/XZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104945"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104945"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856820"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:00 -0800
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 19/35] mm/mmap: Add shadow stack pages to memory accounting
Date:   Sun, 30 Jan 2022 13:18:22 -0800
Message-Id: <20220130211838.8382-20-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Account shadow stack pages to stack memory.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

Yu-cheng v26:
 - Remove redundant #ifdef CONFIG_MMU.

Yu-cheng v25:
 - Remove #ifdef CONFIG_ARCH_HAS_SHADOW_STACK for is_shadow_stack_mapping().

Yu-cheng v24:
 - Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().
 - Change VM_SHSTK to VM_SHADOW_STACK.

 arch/x86/include/asm/pgtable.h | 3 +++
 arch/x86/mm/pgtable.c          | 5 +++++
 include/linux/pgtable.h        | 8 ++++++++
 mm/mmap.c                      | 5 +++++
 4 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 36166bdd0b98..55641498485c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1666,6 +1666,9 @@ static inline bool arch_faults_on_old_pte(void)
 #define maybe_mkwrite maybe_mkwrite
 extern pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma);
 
+#define is_shadow_stack_mapping is_shadow_stack_mapping
+extern bool is_shadow_stack_mapping(vm_flags_t vm_flags);
+
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_H */
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index c22c8e9c37e8..61a364b9ae0a 100644
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
index bc8713a76e03..21fdb1273571 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -911,6 +911,14 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 	__ptep_modify_prot_commit(vma, addr, ptep, pte);
 }
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
+
+#ifndef is_shadow_stack_mapping
+static inline bool is_shadow_stack_mapping(vm_flags_t vm_flags)
+{
+	return false;
+}
+#endif
+
 #endif /* CONFIG_MMU */
 
 /*
diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..9bab326332af 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1716,6 +1716,9 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	if (file && is_file_hugepages(file))
 		return 0;
 
+	if (is_shadow_stack_mapping(vm_flags))
+		return 1;
+
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
@@ -3345,6 +3348,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
 		mm->stack_vm += npages;
 	else if (is_data_mapping(flags))
 		mm->data_vm += npages;
+	else if (is_shadow_stack_mapping(flags))
+		mm->stack_vm += npages;
 }
 
 static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
-- 
2.17.1

