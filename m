Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575CC4A39CD
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356445AbiA3VVt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:21:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:52015 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356315AbiA3VVs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577708; x=1675113708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Sl3QurZ5nHWYFT7c2lQcYAYIIsbunX9GgpPAPWDc6Q8=;
  b=IpzG+qpkINBHgfqBZBvMLrqVC4/DU1CfR7bnjewpyYibB94/8RA42K+O
   WxzzlWlCrM9VR+BA5GMTtdxthwqFYsLYVUVLd5SUc7qhqVq8NRI5OvWEB
   fcJJzsuXqVwud92ls6VJ0LyasOrydgw5NM4GGNVhxEeJLcLT4zpri9V+w
   m8Ooc/cqj51SiBI59tZJ7UtJchVvQii++plazW99EN30x6OHwuRZhu7FJ
   lgZUCedSfUMjB8+gmg+7CejQ4U/cxv8q29MjP0gZOzyIz42UWsE/CGN9E
   Hcjltb1iHSWmM2ahVcYYYDN+Un+ehHv0DoEbiVxnVeI5IBqv5SKBA4Eep
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104876"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104876"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856649"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:46 -0800
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
Subject: [PATCH 01/35] Documentation/x86: Add CET description
Date:   Sun, 30 Jan 2022 13:18:04 -0800
Message-Id: <20220130211838.8382-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Introduce a new document on Control-flow Enforcement Technology (CET).

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---

v1:
 - Update and clarify the docs.
 - Moved kernel parameters documentation to other patch.

 Documentation/x86/cet.rst   | 145 ++++++++++++++++++++++++++++++++++++
 Documentation/x86/index.rst |   1 +
 2 files changed, 146 insertions(+)
 create mode 100644 Documentation/x86/cet.rst

diff --git a/Documentation/x86/cet.rst b/Documentation/x86/cet.rst
new file mode 100644
index 000000000000..ff0f9a148959
--- /dev/null
+++ b/Documentation/x86/cet.rst
@@ -0,0 +1,145 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+Control-flow Enforcement Technology (CET)
+=========================================
+
+[1] Overview
+============
+
+Control-flow Enforcement Technology (CET) is term referring to several
+related x86 processor features that provides protection against control
+flow hijacking attacks. The HW feature itself can be set up to protect
+both applications and the kernel. Only user-mode protection is implemented
+in the 64-bit kernel, including shadow stack support for running legacy
+32-bit applications.
+
+CET introduces Shadow Stack and Indirect Branch Tracking. Shadow stack is
+a secondary stack allocated from memory and cannot be directly modified by
+applications. When executing a CALL instruction, the processor pushes the
+return address to both the normal stack and the shadow stack. Upon
+function return, the processor pops the shadow stack copy and compares it
+to the normal stack copy. If the two differ, the processor raises a
+control-protection fault. Indirect branch tracking verifies indirect
+CALL/JMP targets are intended as marked by the compiler with 'ENDBR'
+opcodes. Not all CPU's have both Shadow Stack and Indirect Branch Tracking
+and only Shadow Stack is currently supported in the kernel.
+
+The Kconfig options is X86_SHADOW_STACK, and it can be disabled with
+no_user_shstk.
+
+To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or LLVM v10.0.1
+or later are required. To build a CET-enabled application, GLIBC v2.28 or
+later is also required.
+
+At run time, /proc/cpuinfo shows CET features if the processor supports
+CET.
+
+[2] Application Enabling
+========================
+
+An application's CET capability is marked in its ELF header and can be
+verified from readelf/llvm-readelf output:
+
+    readelf -n <application> | grep -a SHSTK
+        properties: x86 feature: SHSTK
+
+The kernel does not process these applications directly. Applications must
+enable them using the interface descriped in section 4. Typically this
+would be done in dynamic loader or static runtime objects, as is the case
+in glibc.
+
+[3] Backward Compatibility
+==========================
+
+GLIBC provides a few CET tunables via the GLIBC_TUNABLES environment
+variable:
+
+GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-WRSS
+    Turn off SHSTK/WRSS.
+
+GLIBC_TUNABLES=glibc.tune.x86_shstk=<on, permissive>
+    This controls how dlopen() handles SHSTK legacy libraries::
+
+        on         - continue with SHSTK enabled;
+        permissive - continue with SHSTK off.
+
+Details can be found in the GLIBC manual pages.
+
+[4] CET arch_prctl()'s
+======================
+
+Elf features are enabled using the below arch_prctl's.
+
+arch_prctl(ARCH_X86_FEATURE_STATUS, u64 *args)
+    Get feature status.
+
+    The parameter 'args' is a pointer to a user buffer. The kernel returns
+    the following information:
+
+    *args = shadow stack/IBT status
+    *(args + 1) = shadow stack base address
+    *(args + 2) = shadow stack size
+
+    32-bit binaries use the same interface, but only lower 32-bits of each
+    item.
+
+arch_prctl(ARCH_X86_FEATURE_DISABLE, unsigned int features)
+    Disable features specified in 'features'. Return -EPERM if any of the
+    passed feature are locked. Return -ECANCELED if any of the features
+    failed to disable. In this case call ARCH_X86_FEATURE_STATUS to find
+    out which features are still enabled.
+
+arch_prctl(ARCH_X86_FEATURE_ENABLE, unsigned int features)
+    Enable feature specified in 'features'. Return -EPERM if any of the
+    passed feature are locked. Return -ECANCELED if any of the features
+    failed to enable. In this case call ARCH_X86_FEATURE_STATUS to find
+    out which features were enabled.
+
+arch_prctl(ARCH_X86_FEATURE_LOCK, unsigned int features)
+    Lock in all features at their current enabled or disabled status.
+
+
+Currently shadow stack and WRSS are supported via this interface. WRSS
+can only be enabled with shadow stack, and is automatically disabled
+if shadow stack is disabled.
+
+[5] The implementation of the Shadow Stack
+==========================================
+
+Shadow Stack size
+-----------------
+
+A task's shadow stack is allocated from memory to a fixed size of
+MIN(RLIMIT_STACK, 4 GB). In other words, the shadow stack is allocated to
+the maximum size of the normal stack, but capped to 4 GB. However,
+a compat-mode application's address space is smaller, each of its thread's
+shadow stack size is MIN(1/4 RLIMIT_STACK, 4 GB).
+
+Signal
+------
+
+The main program and its signal handlers use the same shadow stack.
+Because the shadow stack stores only return addresses, a large shadow
+stack covers the condition that both the program stack and the signal
+alternate stack run out.
+
+The kernel creates a restore token for the shadow stack and pushes the
+restorer address to the shadow stack. Then verifies that token when
+restoring from the signal handler.
+
+Fork
+----
+
+The shadow stack's vma has VM_SHADOW_STACK flag set; its PTEs are required
+to be read-only and dirty. When a shadow stack PTE is not RO and dirty, a
+shadow access triggers a page fault with the shadow stack access bit set
+in the page fault error code.
+
+When a task forks a child, its shadow stack PTEs are copied and both the
+parent's and the child's shadow stack PTEs are cleared of the dirty bit.
+Upon the next shadow stack access, the resulting shadow stack page fault
+is handled by page copy/re-use.
+
+When a pthread child is created, the kernel allocates a new shadow stack
+for the new thread.
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f498f1d36cd3..b5f083a61eab 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -21,6 +21,7 @@ x86-specific Documentation
    tlb
    mtrr
    pat
+   cet
    intel-iommu
    intel_txt
    amd-memory-encryption
-- 
2.17.1

