Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8825352228
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhDAWLh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:11:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:34674 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234719AbhDAWLd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:11:33 -0400
IronPort-SDR: LS2sTBB8c8BQokEEb2XP0+MU1SEq7jyrEXT0uZYBUx8Tq6DAFvLe3iof6jQWHclUu2Z1RKhdJo
 oYYEFJD+/IpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189084563"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="189084563"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:23 -0700
IronPort-SDR: 01ZLiSSK9pHOWotGnhwjUpG1WlhFXMcoOyniXoZfLseCkjifVT0hGt1nt7abI1BfaWNNUvp7BW
 uspdFrJ/IIfA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517513903"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:23 -0700
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
Subject: [PATCH v24 13/30] mm: Introduce VM_SHADOW_STACK for shadow stack memory
Date:   Thu,  1 Apr 2021 15:10:47 -0700
Message-Id: <20210401221104.31584-14-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221104.31584-1-yu-cheng.yu@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A shadow stack PTE must be read-only and have _PAGE_DIRTY set.  However,
read-only and Dirty PTEs also exist for copy-on-write (COW) pages.  These
two cases are handled differently for page faults.  Introduce
VM_SHADOW_STACK to track shadow stack VMAs.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v24:
- Change VM_SHSTK to VM_SHADOW_STACK.
- Change CONFIG_X86_CET to CONFIG_X86_SHADOW_STACK to reflect Kconfig changes.

 Documentation/filesystems/proc.rst | 1 +
 arch/x86/mm/mmap.c                 | 2 ++
 fs/proc/task_mmu.c                 | 3 +++
 include/linux/mm.h                 | 8 ++++++++
 4 files changed, 14 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 48fbfc336ebf..5d8a2d75c799 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -549,6 +549,7 @@ encoded manner. The codes are the following:
     mg    mergable advise flag
     bt    arm64 BTI guarded page
     mt    arm64 MTE allocation tags are enabled
+    ss    shadow stack page
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index c90c20904a60..f3f52c5e2fd6 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -165,6 +165,8 @@ unsigned long get_mmap_base(int is_legacy)
 
 const char *arch_vma_name(struct vm_area_struct *vma)
 {
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return "[shadow stack]";
 	return NULL;
 }
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e862cab69583..0aa57de9dfab 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -661,6 +661,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
+#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
+		[ilog2(VM_SHADOW_STACK)]= "ss",
+#endif
 	};
 	size_t i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ba434287387..08282eb2f195 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -312,11 +312,13 @@ extern unsigned int kobjsize(const void *objp);
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
@@ -332,6 +334,12 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
+#ifdef CONFIG_X86_SHADOW_STACK
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#else
+# define VM_SHADOW_STACK	VM_NONE
+#endif
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
-- 
2.21.0

