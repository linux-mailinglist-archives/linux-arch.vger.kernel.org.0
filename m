Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C8026AD14
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 21:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgIOTJA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 15:09:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:52246 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbgIOTIl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 15:08:41 -0400
IronPort-SDR: wEJPL2D2YxNoX4aoXR8EOZvfYmStzeVpfakiUs7ZIKosHYbCOioNu6XY9HChu0YHRh7kT6GwiH
 +83CtJPmlsgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="223514203"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="223514203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 12:08:32 -0700
IronPort-SDR: OFTTewbAkvdHWZHGMhtZm5I4ydmfEL6sextRvrMFELVZdC+qC6fPIIYy+YccEXpkMHK7bXtCjG
 2qEefI5zbTcA==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="482946506"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 12:08:29 -0700
Message-ID: <2f137667122486a0cea3b0dbfa99d02f74870673.camel@intel.com>
Subject: Re: [NEEDS-REVIEW] Re: [PATCH v11 25/25] x86/cet/shstk: Add
 arch_prctl functions for shadow stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Tue, 15 Sep 2020 12:08:28 -0700
In-Reply-To: <bf2ab309-f8c4-83da-1c0a-5684e5bc5c82@intel.com>
References: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
         <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
         <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
         <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
         <20200901102758.GY6642@arm.com>
         <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
         <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
         <32005d57-e51a-7c7f-4e86-612c2ff067f3@intel.com>
         <46dffdfd-92f8-0f05-6164-945f217b0958@intel.com>
         <ed929729-4677-3d3b-6bfd-b379af9272b8@intel.com>
         <6e1e22a5-1b7f-2783-351e-c8ed2d4893b8@intel.com>
         <5979c58d-a6e3-d14d-df92-72cdeb97298d@intel.com>
         <ab1a3344-60f4-9b9d-81d4-e6538fdcafcf@intel.com>
         <08c91835-8486-9da5-a7d1-75e716fc5d36@intel.com>
         <a881837d-c844-30e8-a614-8b92be814ef6@intel.com>
         <cbec8861-8722-ec31-2c02-1cfed20255eb@intel.com>
         <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
         <a1efc4330a3beff10671949eddbba96f8cde96da.camel@intel.com>
         <41aa5e8f-ad88-2934-6d10-6a78fcbe019b@intel.com>
         <bf2ab309-f8c4-83da-1c0a-5684e5bc5c82@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2020-09-14 at 17:12 -0700, Yu, Yu-cheng wrote:
> On 9/14/2020 7:50 AM, Dave Hansen wrote:
> > On 9/11/20 3:59 PM, Yu-cheng Yu wrote:
> > ...
> > > Here are the changes if we take the mprotect(PROT_SHSTK) approach.
> > > Any comments/suggestions?
> > 
> > I still don't like it. :)
> > 
> > I'll also be much happier when there's a proper changelog to accompany
> > this which also spells out the alternatives any why they suck so much.

[...]

I revised it.  If this turns out needing more work/discussion, we can split it
out from the shadow stack series.

Thanks,
Yu-cheng

------

From 114f3108207e3eb15fe13b3ff43d1ac273b5072a Mon Sep 17 00:00:00 2001
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 10 Sep 2020 16:41:30 -0700
Subject: [PATCH] mm: Introduce PROT_SHSTK for shadow stack

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
existing APIs.  The x86-specific PROT_SHSTK is translated to VM_SHSTK, and
a shadow stack mapping is created without reinventing the wheel.  There are
potential pitfalls though.  The most obvious one would be using this as a
bypass to shadow stack protection.  However, the attacker would have to get
to the syscall first.

Since arch_calc_vm_prot_bits() is modified, I have moved arch_vm_get_page
_prot() and arch_calc_vm_prot_bits() to x86/include/asm/mman.h.
This will be more consistent with other architectures.

[1] https://lore.kernel.org/lkml/20200828121624.108243-1-hjl.tools@gmail.com/

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/mman.h      | 63 ++++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/mman.h | 28 ++------------
 mm/mprotect.c                    | 10 +++++
 3 files changed, 77 insertions(+), 24 deletions(-)
 create mode 100644 arch/x86/include/asm/mman.h

diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
new file mode 100644
index 000000000000..2f19e429c9e2
--- /dev/null
+++ b/arch/x86/include/asm/mman.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_MMAN_H
+#define _ASM_X86_MMAN_H
+
+#include <asm/cpufeature.h>
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
+#define pkey_vm_prot_bits(prot, key) (			\
+		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
+		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
+		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
+		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
+#else
+#define pkey_vm_prot_bits(prot, key) (0)
+#endif
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+	unsigned long pkey)
+{
+	unsigned long vm_prot_bits = pkey_vm_prot_bits(prot, pkey);
+
+	vm_prot_bits |= ((prot & PROT_SHSTK) ? VM_SHSTK : 0);
+	return vm_prot_bits;
+}
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
+{
+	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
+
+	if (IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER) &&
+	    static_cpu_has(X86_FEATURE_SHSTK) && (prot & PROT_SHSTK)) {
+		supported |= PROT_SHSTK;
+
+		/*
+		 * A shadow stack mapping is indirectly writable by only
+		 * the CALL and WRUSS instructions, but not other write
+		 * instructions).  PROT_SHSTK and PROT_WRITE are mutually
+		 * exclusive.
+		 */
+		supported &= ~PROT_WRITE;
+	}
+
+	return (prot & ~supported) == 0;
+}
+#define arch_validate_prot arch_validate_prot
+
+#endif /* _ASM_X86_MMAN_H */
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index d4a8d0424bfb..39bb7db344a6 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -1,31 +1,11 @@
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
+#define PROT_SHSTK	0x10		/* shadow stack pages */
 
 #include <asm-generic/mman.h>
 
-#endif /* _ASM_X86_MMAN_H */
+#endif /* _UAPI_ASM_X86_MMAN_H */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index a8edbcb3af99..27a1b7a4e89c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -571,6 +571,16 @@ static int do_mprotect_pkey(unsigned long start, size_t
len,
 				goto out;
 		}
 	}
+
+	/*
+	 * Only anonymous mapping is suitable for shadow stack.  A function
+	 * call stack should not be backed by a file.
+	 */
+	if ((prot & PROT_SHSTK) && (vma->vm_file)) {
+		error = -EINVAL;
+		goto out;
+	}
+
 	if (start > vma->vm_start)
 		prev = vma;
 
-- 
2.21.0

