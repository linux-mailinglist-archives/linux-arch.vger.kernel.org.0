Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C3230661F
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 22:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhA0Va1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 16:30:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:48887 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234507AbhA0V23 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 16:28:29 -0500
IronPort-SDR: 2F6CrsWupO1jhER4jr8z922yOWKp9yZQm8s4MmIVumi+1sgNADHuAzG2cHUCFrISy8eU1UFzrG
 VoF9gfg4ImNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="177573144"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="177573144"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:25:56 -0800
IronPort-SDR: A4Gcmb38MdT1UtYNYrK/Hp2wjJ6uWqJg0pZpdbMY/drs4r78YatA6pcAPC9xD8NnO0I0Jw2zr3
 6zHJCQPOLDBg==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="353948232"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:25:56 -0800
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
Subject: [PATCH v18 14/25] x86/mm: Update maybe_mkwrite() for shadow stack
Date:   Wed, 27 Jan 2021 13:25:13 -0800
Message-Id: <20210127212524.10188-15-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210127212524.10188-1-yu-cheng.yu@intel.com>
References: <20210127212524.10188-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When serving a page fault, maybe_mkwrite() makes a PTE writable if its vma
has VM_WRITE.

A shadow stack vma has VM_SHSTK.  Its PTEs have _PAGE_DIRTY, but not
_PAGE_WRITE.  In fork(), _PAGE_DIRTY is cleared to effect copy-on-write,
and in page fault, _PAGE_DIRTY is restored and the shadow stack page is
writable again.

Update maybe_mkwrite() by introducing arch_maybe_mkwrite(), which sets
_PAGE_DIRTY for a shadow stack PTE.

Apply the same changes to maybe_pmd_mkwrite().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig        |  4 ++++
 arch/x86/mm/pgtable.c   | 18 ++++++++++++++++++
 include/linux/mm.h      |  2 ++
 include/linux/pgtable.h | 24 ++++++++++++++++++++++++
 mm/huge_memory.c        |  2 ++
 5 files changed, 50 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2d080a2335df..1204a6dcc0da 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1954,6 +1954,9 @@ config X86_SGX
 config ARCH_HAS_SHADOW_STACK
 	def_bool n
 
+config ARCH_MAYBE_MKWRITE
+	def_bool n
+
 config X86_CET
 	prompt "Intel Control-flow protection for user-mode"
 	def_bool n
@@ -1961,6 +1964,7 @@ config X86_CET
 	depends on AS_WRUSS
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_SHADOW_STACK
+	select ARCH_MAYBE_MKWRITE
 	help
 	  Control-flow protection is a hardware security hardening feature
 	  that detects function-return address or jump target changes by
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f6a9e2e36642..0f4fbf51a9fc 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -610,6 +610,24 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_ARCH_MAYBE_MKWRITE
+pte_t arch_maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_flags & VM_SHSTK))
+		pte = pte_mkwrite_shstk(pte);
+	return pte;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+pmd_t arch_maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_flags & VM_SHSTK))
+		pmd = pmd_mkwrite_shstk(pmd);
+	return pmd;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_ARCH_MAYBE_MKWRITE */
+
 /**
  * reserve_top_address - reserves a hole in the top of kernel address space
  * @reserve - size of hole to reserve
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7be5f8b874aa..abd756e426fc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -993,6 +993,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
 		pte = pte_mkwrite(pte);
+	else
+		pte = arch_maybe_mkwrite(pte, vma);
 	return pte;
 }
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8fcdfa52eb4b..d8452218d09b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1439,6 +1439,30 @@ static inline bool arch_has_pfn_modify_check(void)
 }
 #endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
 
+#ifdef CONFIG_MMU
+#ifdef CONFIG_ARCH_MAYBE_MKWRITE
+pte_t arch_maybe_mkwrite(pte_t pte, struct vm_area_struct *vma);
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+pmd_t arch_maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+#else /* !CONFIG_ARCH_MAYBE_MKWRITE */
+static inline pte_t arch_maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	return pte;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline pmd_t arch_maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	return pmd;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+#endif /* CONFIG_ARCH_MAYBE_MKWRITE */
+#endif /* CONFIG_MMU */
+
 /*
  * Architecture PAGE_KERNEL_* fallbacks
  *
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9237976abe72..bfec65c9308b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -478,6 +478,8 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
 		pmd = pmd_mkwrite(pmd);
+	else
+		pmd = arch_maybe_pmd_mkwrite(pmd, vma);
 	return pmd;
 }
 
-- 
2.21.0

