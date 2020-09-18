Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C927053C
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 21:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgIRTXi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 15:23:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:41779 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIRTWY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 15:22:24 -0400
IronPort-SDR: J11UPDp/UWPjiCHNRjTeKaXJnHtsXC5G/tqGUKIj+h7nHX44nmXvBzZphZf3FFyR1KVnDyWjxl
 AWpNxcB4anZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147766241"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="147766241"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:22:18 -0700
IronPort-SDR: nciM3pZA29UK7Jdwj59H+8M8Gm70xVWCPzwa02uNDERik40mWofDdT3s8H/LKGqKjDxKKlyMlL
 nxYDb7PiZ+/A==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484331850"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:22:18 -0700
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
Subject: [PATCH v12 12/26] mm: Introduce VM_SHSTK for shadow stack memory
Date:   Fri, 18 Sep 2020 12:21:10 -0700
Message-Id: <20200918192125.25473-13-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200918192125.25473-1-yu-cheng.yu@intel.com>
References: <20200918192125.25473-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A Shadow Stack PTE must be read-only and have _PAGE_DIRTY set.  However,
read-only and Dirty PTEs also exist for copy-on-write (COW) pages.  These
two cases are handled differently for page faults.  Introduce VM_SHSTK to
track shadow stack VMAs.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v9:
- Add VM_SHSTK case to arch_vma_name().
- Revise the commit log to explain why adding a new VM flag.

 arch/x86/mm/mmap.c | 2 ++
 fs/proc/task_mmu.c | 3 +++
 include/linux/mm.h | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index c90c20904a60..a22c6b6fc607 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -165,6 +165,8 @@ unsigned long get_mmap_base(int is_legacy)
 
 const char *arch_vma_name(struct vm_area_struct *vma)
 {
+	if (vma->vm_flags & VM_SHSTK)
+		return "[shadow stack]";
 	return NULL;
 }
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5066b0251ed8..682ea6f95fa4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -663,6 +663,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+		[ilog2(VM_SHSTK)]	= "ss",
+#endif
 	};
 	size_t i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ca6e6a81576b..cd69e2fa8026 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -302,11 +302,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -340,6 +342,12 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
 #endif
 
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+# define VM_SHSTK	VM_HIGH_ARCH_5
+#else
+# define VM_SHSTK	VM_NONE
+#endif
+
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
-- 
2.21.0

