Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB9352275
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhDAWNa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:13:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:34674 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236013AbhDAWMr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:12:47 -0400
IronPort-SDR: BJMbCMlikUOfcl/EnW9rXAAKpsUDX81QlH215esidDqLpVRdmiRJNksZNBkUzOaWjrjtnPhfjF
 ljAvPzhUgi1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189084653"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="189084653"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:27 -0700
IronPort-SDR: 6r32JvEnAc0LlzbRHUQI51dKbXn6hAPlHogW2KrX2ukE34cw2Hka1bt4aLSS6TkyTozJgT2Sje
 RY6k0dd1j7bA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517513965"
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
Subject: [PATCH v24 28/30] mm: Move arch_calc_vm_prot_bits() to arch/x86/include/asm/mman.h
Date:   Thu,  1 Apr 2021 15:11:02 -0700
Message-Id: <20210401221104.31584-29-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221104.31584-1-yu-cheng.yu@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To prepare the introduction of PROT_SHSTK and be consistent with other
architectures, move arch_vm_get_page_prot() and arch_calc_vm_prot_bits() to
arch/x86/include/asm/mman.h.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mman.h      | 30 ++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/mman.h | 27 +++------------------------
 2 files changed, 33 insertions(+), 24 deletions(-)
 create mode 100644 arch/x86/include/asm/mman.h

diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
new file mode 100644
index 000000000000..629f6c81263a
--- /dev/null
+++ b/arch/x86/include/asm/mman.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_MMAN_H
+#define _ASM_X86_MMAN_H
+
+#include <linux/mm.h>
+#include <uapi/asm/mman.h>
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+/*
+ * Take the 4 protection key bits out of the vma->vm_flags
+ * value and turn them in to the bits that we can put in
+ * to a pte.
+ *
+ * Only override these if Protection Keys are available
+ * (which is only on 64-bit).
+ */
+#define arch_vm_get_page_prot(vm_flags)	__pgprot(	\
+		((vm_flags) & VM_PKEY_BIT0 ? _PAGE_PKEY_BIT0 : 0) |	\
+		((vm_flags) & VM_PKEY_BIT1 ? _PAGE_PKEY_BIT1 : 0) |	\
+		((vm_flags) & VM_PKEY_BIT2 ? _PAGE_PKEY_BIT2 : 0) |	\
+		((vm_flags) & VM_PKEY_BIT3 ? _PAGE_PKEY_BIT3 : 0))
+
+#define arch_calc_vm_prot_bits(prot, key) (		\
+		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
+		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
+		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
+		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
+#endif
+
+#endif /* _ASM_X86_MMAN_H */
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index d4a8d0424bfb..3ce1923e6ed9 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -1,31 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_X86_MMAN_H
-#define _ASM_X86_MMAN_H
+#ifndef _UAPI_ASM_X86_MMAN_H
+#define _UAPI_ASM_X86_MMAN_H
 
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-/*
- * Take the 4 protection key bits out of the vma->vm_flags
- * value and turn them in to the bits that we can put in
- * to a pte.
- *
- * Only override these if Protection Keys are available
- * (which is only on 64-bit).
- */
-#define arch_vm_get_page_prot(vm_flags)	__pgprot(	\
-		((vm_flags) & VM_PKEY_BIT0 ? _PAGE_PKEY_BIT0 : 0) |	\
-		((vm_flags) & VM_PKEY_BIT1 ? _PAGE_PKEY_BIT1 : 0) |	\
-		((vm_flags) & VM_PKEY_BIT2 ? _PAGE_PKEY_BIT2 : 0) |	\
-		((vm_flags) & VM_PKEY_BIT3 ? _PAGE_PKEY_BIT3 : 0))
-
-#define arch_calc_vm_prot_bits(prot, key) (		\
-		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
-		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
-		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
-		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
-#endif
 
 #include <asm-generic/mman.h>
 
-#endif /* _ASM_X86_MMAN_H */
+#endif /* _UAPI_ASM_X86_MMAN_H */
-- 
2.21.0

