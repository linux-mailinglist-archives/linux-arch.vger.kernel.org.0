Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95CF250D74
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgHYAcc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:32:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:12300 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgHYA3k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:29:40 -0400
IronPort-SDR: 6eGLiMYQTrTqxJHgW3XcpSSK7x2lMaU9MXZK3TtKJa2CI4J8NO+5rgNY1uq6nGFPqtKQiLRGRa
 iU31wkl8E0hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136075298"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="136075298"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:38 -0700
IronPort-SDR: PwY2YUAEDmzoxJ//oekfj9daSHLGf7UAvu8e/8o+YAr661TgSKDpAG5bU5j2OfK/JnONoP0W34
 g/e+ae08qNbA==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474134992"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:38 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v11 14/25] x86/mm: Update maybe_mkwrite() for shadow stack
Date:   Mon, 24 Aug 2020 17:25:29 -0700
Message-Id: <20200825002540.3351-15-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200825002540.3351-1-yu-cheng.yu@intel.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow stack memory is writable, but its VMA has VM_SHSTK instead of
VM_WRITE.  Update maybe_mkwrite() to include the shadow stack.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig        |  4 ++++
 arch/x86/mm/pgtable.c   | 18 ++++++++++++++++++
 include/linux/mm.h      |  2 ++
 include/linux/pgtable.h | 24 ++++++++++++++++++++++++
 mm/huge_memory.c        |  2 ++
 5 files changed, 50 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4844649ee884..e93be385cd04 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1935,6 +1935,9 @@ config AS_HAS_SHADOW_STACK
 config X86_INTEL_CET
 	def_bool n
 
+config ARCH_MAYBE_MKWRITE
+	def_bool n
+
 config ARCH_HAS_SHADOW_STACK
 	def_bool n
 
@@ -1945,6 +1948,7 @@ config X86_INTEL_SHADOW_STACK_USER
 	depends on AS_HAS_SHADOW_STACK
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select X86_INTEL_CET
+	select ARCH_MAYBE_MKWRITE
 	select ARCH_HAS_SHADOW_STACK
 	help
 	  Shadow Stacks provides protection against program stack
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index dfd82f51ba66..a9666b64bc05 100644
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
index 62f5f496a6d1..9c2efefb9281 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -962,6 +962,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
 		pte = pte_mkwrite(pte);
+	else
+		pte = arch_maybe_mkwrite(pte, vma);
 	return pte;
 }
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a124c21e3204..4445d009f5ec 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1354,6 +1354,30 @@ static inline bool arch_has_pfn_modify_check(void)
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
index 2ccff8472cd4..a580b5fb6e1a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -464,6 +464,8 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
 		pmd = pmd_mkwrite(pmd);
+	else
+		pmd = arch_maybe_pmd_mkwrite(pmd, vma);
 	return pmd;
 }
 
-- 
2.21.0

