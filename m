Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4E84A3A1F
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356544AbiA3VYm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:24:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:52029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356694AbiA3VWZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577745; x=1675113745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hiUiL5XEyP01F3eBPpddRbZ/NlSqoVCcrqhafbq6fac=;
  b=gJ3i3vXxNPNDw6kI4OOHUmrOBSJ+VxasyqLtSL356cz0pH1vSba5fW4u
   m9CTx8MqHw0yz6DwY2ME32kaQIT2INjEx29xMOMPt/hHfNsENJFiERvUa
   D5gky980ohw/zm85jlhNh+1CQe5/Ade7k4bJHC5MuC5Xfn7UnfhFdCx1l
   0eFGJrtSKbc/ZNskCK519R8RrMei63ZAamY1WYHKNw0eX/bEYVegoz+WG
   JWNNoept4vjzAWUTVRLUpgRfVTRqbL1WF1qbMpaQVFMM4reZYdGjUpwKk
   WvzqgmDyd3WokT7t21f1vJ7GUl5BfISsR/3tuXQuDphLUGbVtqrg0Ro2z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104955"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104955"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856855"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:02 -0800
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 22/35] x86/mm: Prevent VM_WRITE shadow stacks
Date:   Sun, 30 Jan 2022 13:18:25 -0800
Message-Id: <20220130211838.8382-23-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow stack accesses are writes from handle_mm_fault() perspective. So to
generate the correct PTE, maybe_mkwrite() will rely on the presence of
VM_SHADOW_STACK or VM_WRITE in the vma.

In future patches, when VM_SHADOW_STACK is actually creatable by
userspace, a problem could happen if a user calls
mprotect( , , PROT_WRITE) on VM_SHADOW_STACK shadow stack memory. The code
would then be confused in the event of shadow stack accesses, and create a
writable PTE for a shadow stack access. Then the process would fault in a
loop.

Prevent this from happening by blocking this kind of memory (VM_WRITE and
VM_SHADOW_STACK) from being created, instead of complicating the fault
handler logic to handle it.

Add an x86 arch_validate_flags() implementation to handle the check.
Rename the uapi/asm/mman.h header guard to be able to use it for
arch/x86/include/asm/mman.h where the arch_validate_flags() will be.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v1:
 - New patch.

 arch/x86/include/asm/mman.h      | 21 +++++++++++++++++++++
 arch/x86/include/uapi/asm/mman.h |  6 +++---
 2 files changed, 24 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/mman.h

diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
new file mode 100644
index 000000000000..b44fe31deb3a
--- /dev/null
+++ b/arch/x86/include/asm/mman.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_MMAN_H
+#define _ASM_X86_MMAN_H
+
+#include <linux/mm.h>
+#include <uapi/asm/mman.h>
+
+#ifdef CONFIG_X86_SHADOW_STACK
+static inline bool arch_validate_flags(unsigned long vm_flags)
+{
+	if ((vm_flags & VM_SHADOW_STACK) && (vm_flags & VM_WRITE))
+		return false;
+
+	return true;
+}
+
+#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
+
+#endif /* CONFIG_X86_SHADOW_STACK */
+
+#endif /* _ASM_X86_MMAN_H */
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index d4a8d0424bfb..9704e27c4d24 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_X86_MMAN_H
-#define _ASM_X86_MMAN_H
+#ifndef _UAPI_ASM_X86_MMAN_H
+#define _UAPI_ASM_X86_MMAN_H
 
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 
@@ -28,4 +28,4 @@
 
 #include <asm-generic/mman.h>
 
-#endif /* _ASM_X86_MMAN_H */
+#endif /* _UAPI_ASM_X86_MMAN_H */
-- 
2.17.1

