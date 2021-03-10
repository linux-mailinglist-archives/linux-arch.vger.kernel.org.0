Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D3334ABD
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 23:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhCJWBw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 17:01:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:64260 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233794AbhCJWBU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 17:01:20 -0500
IronPort-SDR: PyjtRH37Y+S20QzxRJj0CuuWi8FvuGLso86ZyYB0ERmfT51tVLWE5UKQkmqnAB3KI7r9RjRerC
 uF9M6M1AlgRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="167846468"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="167846468"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:01:20 -0800
IronPort-SDR: MLwQyyEuGSfs0mpDFDo4j5RMxrErO/tsIaouTXtVQky65miZXBd+cdCNfaMYlFy1A9la1RNJRG
 +GdMZ1grIVsQ==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="403847675"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:01:19 -0800
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v22 28/28] mm: Introduce PROT_SHSTK for shadow stack
Date:   Wed, 10 Mar 2021 14:00:46 -0800
Message-Id: <20210310220046.15866-29-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210310220046.15866-1-yu-cheng.yu@intel.com>
References: <20210310220046.15866-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are three possible options to create a shadow stack allocation API:
an arch_prctl, a new syscall, or adding PROT_SHSTK to mmap()/mprotect().
Each has its advantages and compromises.

An arch_prctl() is the least intrusive.  However, the existing x86
arch_prctl() takes only two parameters.  Multiple parameters must be
passed in a memory buffer.  There is a proposal to pass more parameters in
registers [1], but no active discussion on that.

A new syscall minimizes compatibility issues and offers an extensible frame
work to other architectures, but this will likely result in some overlap of
mmap()/mprotect().

The introduction of PROT_SHSTK to mmap()/mprotect() takes advantage of
existing APIs.  The x86-specific PROT_SHSTK is translated to VM_SHSTK and
a shadow stack mapping is created without reinventing the wheel.  There are
potential pitfalls though.  The most obvious one would be using this as a
bypass to shadow stack protection.  However, the attacker would have to get
to the syscall first.

[1] https://lore.kernel.org/lkml/20200828121624.108243-1-hjl.tools@gmail.com/

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/mman.h      | 57 +++++++++++++++++++++++++++++++-
 arch/x86/include/uapi/asm/mman.h |  1 +
 include/linux/mm.h               |  1 +
 mm/mmap.c                        |  8 ++++-
 4 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
index 629f6c81263a..bd94e30b5d34 100644
--- a/arch/x86/include/asm/mman.h
+++ b/arch/x86/include/asm/mman.h
@@ -20,11 +20,66 @@
 		((vm_flags) & VM_PKEY_BIT2 ? _PAGE_PKEY_BIT2 : 0) |	\
 		((vm_flags) & VM_PKEY_BIT3 ? _PAGE_PKEY_BIT3 : 0))
 
-#define arch_calc_vm_prot_bits(prot, key) (		\
+#define pkey_vm_prot_bits(prot, key) (			\
 		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
 		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
 		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
 		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
+#else
+#define pkey_vm_prot_bits(prot, key) (0)
+#endif
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+						   unsigned long pkey)
+{
+	unsigned long vm_prot_bits = pkey_vm_prot_bits(prot, pkey);
+
+	if (!(prot & PROT_WRITE) && (prot & PROT_SHSTK))
+		vm_prot_bits |= VM_SHSTK;
+
+	return vm_prot_bits;
+}
+
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+#ifdef CONFIG_X86_CET
+static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
+{
+	unsigned long valid = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
+
+	if (prot & ~(valid | PROT_SHSTK))
+		return false;
+
+	if (prot & PROT_SHSTK) {
+		struct vm_area_struct *vma;
+
+		if (!current->thread.cet.shstk_size)
+			return false;
+
+		/*
+		 * A shadow stack mapping is indirectly writable by only
+		 * the CALL and WRUSS instructions, but not other write
+		 * instructions).  PROT_SHSTK and PROT_WRITE are mutually
+		 * exclusive.
+		 */
+		if (prot & PROT_WRITE)
+			return false;
+
+		vma = find_vma(current->mm, addr);
+		if (!vma)
+			return false;
+
+		/*
+		 * Shadow stack cannot be backed by a file or shared.
+		 */
+		if (vma->vm_file || (vma->vm_flags & VM_SHARED))
+			return false;
+	}
+
+	return true;
+}
+
+#define arch_validate_prot arch_validate_prot
 #endif
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 3ce1923e6ed9..39bb7db344a6 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -4,6 +4,7 @@
 
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 
+#define PROT_SHSTK	0x10		/* shadow stack pages */
 
 #include <asm-generic/mman.h>
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2731889f49c1..da177a843a14 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -342,6 +342,7 @@ extern unsigned int kobjsize(const void *objp);
 
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
+# define VM_ARCH_CLEAR	VM_SHSTK
 #elif defined(CONFIG_PPC)
 # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
 #elif defined(CONFIG_PARISC)
diff --git a/mm/mmap.c b/mm/mmap.c
index 99077171010b..934cb3cbe952 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1481,6 +1481,12 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		struct inode *inode = file_inode(file);
 		unsigned long flags_mask;
 
+		/*
+		 * Call stack cannot be backed by a file.
+		 */
+		if (vm_flags & VM_SHSTK)
+			return -EINVAL;
+
 		if (!file_mmap_ok(file, inode, pgoff, len))
 			return -EOVERFLOW;
 
@@ -1545,7 +1551,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	} else {
 		switch (flags & MAP_TYPE) {
 		case MAP_SHARED:
-			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
+			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP|VM_SHSTK))
 				return -EINVAL;
 			/*
 			 * Ignore pgoff.
-- 
2.21.0

