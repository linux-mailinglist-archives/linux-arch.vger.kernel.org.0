Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895AB35227C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhDAWNi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:13:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:34672 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235720AbhDAWNB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:13:01 -0400
IronPort-SDR: ya1UdtCVLfuEtbkrThascwWQ4LJWMi9wTobAl/peR9tn3rWr+DpuK7dBJAc4pIqDwwA/y5lFhU
 mOswWuMnBzqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189084671"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="189084671"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:28 -0700
IronPort-SDR: QR6gEczVw8KG/gwWxKRuWr6huL9EnN04/TSvEqwDTGtJu5IMQKB/GLpXOXkq2iyput4CmcW0cN
 llMbPY9qUbyQ==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517513975"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:27 -0700
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
Subject: [PATCH v24 30/30] mm: Introduce PROT_SHSTK for shadow stack
Date:   Thu,  1 Apr 2021 15:11:04 -0700
Message-Id: <20210401221104.31584-31-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221104.31584-1-yu-cheng.yu@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
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
existing APIs.  The x86-specific PROT_SHSTK is translated to
VM_SHADOW_STACK and a shadow stack mapping is created without reinventing
the wheel.  There are potential pitfalls though.  The most obvious one
would be using this as a bypass to shadow stack protection.  However, the
attacker would have to get to the syscall first.

[1] https://lore.kernel.org/lkml/20200828121624.108243-1-hjl.tools@gmail.com/

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v24:
- Update arch_calc_vm_prot_bits(), leave PROT* checking to
  arch_validate_prot().
- Update arch_validate_prot(), leave vma flags checking to
  arch_validate_flags().
- Add arch_validate_flags().

 arch/x86/include/asm/mman.h      | 59 +++++++++++++++++++++++++++++++-
 arch/x86/include/uapi/asm/mman.h |  1 +
 include/linux/mm.h               |  1 +
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
index 629f6c81263a..1821c179f35d 100644
--- a/arch/x86/include/asm/mman.h
+++ b/arch/x86/include/asm/mman.h
@@ -20,11 +20,68 @@
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
 #endif
 
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+						   unsigned long pkey)
+{
+	unsigned long vm_prot_bits = pkey_vm_prot_bits(prot, pkey);
+
+	if (prot & PROT_SHSTK)
+		vm_prot_bits |= VM_SHADOW_STACK;
+
+	return vm_prot_bits;
+}
+
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+#ifdef CONFIG_X86_SHADOW_STACK
+static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
+{
+	unsigned long valid = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM |
+			      PROT_SHSTK;
+
+	if (prot & ~valid)
+		return false;
+
+	if (prot & PROT_SHSTK) {
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
+	}
+
+	return true;
+}
+
+#define arch_validate_prot arch_validate_prot
+
+static inline bool arch_validate_flags(unsigned long vm_flags, bool is_anon)
+{
+	if (vm_flags & VM_SHADOW_STACK) {
+		if ((vm_flags & VM_SHARED) || !is_anon)
+			return false;
+	}
+
+	return true;
+}
+
+#define arch_validate_flags(vm_flags, is_anon) arch_validate_flags(vm_flags, is_anon)
+
+#endif /* CONFIG_X86_SHADOW_STACK */
+
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
index 1ccec5cc399b..9a7652eea207 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -342,6 +342,7 @@ extern unsigned int kobjsize(const void *objp);
 
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
+# define VM_ARCH_CLEAR	VM_SHADOW_STACK
 #elif defined(CONFIG_PPC)
 # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
 #elif defined(CONFIG_PARISC)
-- 
2.21.0

