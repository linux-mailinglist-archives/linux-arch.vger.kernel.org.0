Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD9F641216
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiLCAgk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiLCAgc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:36:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C9DF4EA3;
        Fri,  2 Dec 2022 16:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027791; x=1701563791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XOfd9JiLVYyEEu25Vb3yqxeb0WsD1mhiLPx5CYNxCNc=;
  b=PlHG5WK43S6P9kUl/JptEGRpDcoilpR3MskSZOp1hryttxp9SE9UNd8O
   IiS90F0YEgwhOk3miJoKpjnqBS7jlxiOPueF1qFSsaB4Xxfs9ilkPZ2tn
   gfuC7kLd1yjpPm/oZSxuhaVsEXLeQh0I8w8nGwbHC4wIvpZmJ5kt1LNTo
   9rEcpmgCRmcX6L6HujdcshcdsGJ4fI6/W7ntqelF9TklfBj9rhRDwoapC
   0Bkgmd9fA/+m78V1hVLD1WwEHWEXmqqRgHGVQNXNL1AM+lf7FyoYSDtF6
   pp9p+V3zoAx4wuvbcUHmQphKFJfAoYnKmTrhALJNbQQ3sJkeayqrdJrtF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313710642"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313710642"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479747"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479747"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:28 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 01/39] Documentation/x86: Add CET shadow stack description
Date:   Fri,  2 Dec 2022 16:35:28 -0800
Message-Id: <20221203003606.6838-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Introduce a new document on Control-flow Enforcement Technology (CET).

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

v4:
 - Drop clearcpuid piece (Boris)
 - Add some info about 32 bit

v3:
 - Clarify kernel IBT is supported by the kernel. (Kees, Andrew Cooper)
 - Clarify which arch_prctl's can take multiple bits. (Kees)
 - Describe ASLR characteristics of thread shadow stacks. (Kees)
 - Add exec section. (Andrew Cooper)
 - Fix some capitalization (Bagas Sanjaya)
 - Update new location of enablement status proc.
 - Add info about new user_shstk software capability.
 - Add more info about what the kernel pushes to the shadow stack on
   signal.

v2:
 - Updated to new arch_prctl() API
 - Add bit about new proc status

v1:
 - Update and clarify the docs.
 - Moved kernel parameters documentation to other patch.

 Documentation/x86/index.rst |   1 +
 Documentation/x86/shstk.rst | 162 ++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)
 create mode 100644 Documentation/x86/shstk.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c73d133fd37c..8ac64d7de4dc 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -22,6 +22,7 @@ x86-specific Documentation
    mtrr
    pat
    intel-hfi
+   shstk
    iommu
    intel_txt
    amd-memory-encryption
diff --git a/Documentation/x86/shstk.rst b/Documentation/x86/shstk.rst
new file mode 100644
index 000000000000..8e0b2fe83ef8
--- /dev/null
+++ b/Documentation/x86/shstk.rst
@@ -0,0 +1,162 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================
+Control-flow Enforcement Technology (CET) Shadow Stack
+======================================================
+
+CET Background
+==============
+
+Control-flow Enforcement Technology (CET) is term referring to several
+related x86 processor features that provides protection against control
+flow hijacking attacks. The HW feature itself can be set up to protect
+both applications and the kernel.
+
+CET introduces Shadow Stack and Indirect Branch Tracking (IBT). Shadow stack
+is a secondary stack allocated from memory and cannot be directly modified by
+applications. When executing a CALL instruction, the processor pushes the
+return address to both the normal stack and the shadow stack. Upon
+function return, the processor pops the shadow stack copy and compares it
+to the normal stack copy. If the two differ, the processor raises a
+control-protection fault. IBT verifies indirect CALL/JMP targets are intended
+as marked by the compiler with 'ENDBR' opcodes. Not all CPU's have both Shadow
+Stack and Indirect Branch Tracking. Today in the 64-bit kernel, only userspace
+Shadow Stack and kernel IBT is supported.
+
+Requirements to use Shadow Stack
+================================
+
+To use userspace shadow stack you need HW that supports it, a kernel
+configured with it and userspace libraries compiled with it.
+
+The kernel Kconfig option is X86_USER_SHADOW_STACK, and it can be disabled
+with the kernel parameter: nousershstk.
+
+To build a user shadow stack enabled kernel, Binutils v2.29 or LLVM v6 or later
+are required.
+
+At run time, /proc/cpuinfo shows CET features if the processor supports
+CET. "shstk" and "ibt" relate to the individual HW features. "user_shstk"
+relates to whether the userspace shadow stack specifically is supported.
+
+Application Enabling
+====================
+
+An application's CET capability is marked in its ELF note and can be verified
+from readelf/llvm-readelf output:
+
+    readelf -n <application> | grep -a SHSTK
+        properties: x86 feature: SHSTK
+
+The kernel does not process these applications markers directly. Applications
+or loaders must enable CET features using the interface described in section 4.
+Typically this would be done in dynamic loader or static runtime objects, as is
+the case in GLIBC.
+
+Enabling arch_prctl()'s
+=======================
+
+Elf features should be enabled by the loader using the below arch_prctl's. They
+are only supported in 64 bit user applciations.
+
+arch_prctl(ARCH_SHSTK_ENABLE, unsigned long feature)
+    Enable a single feature specified in 'feature'. Can only operate on
+    one feature at a time.
+
+arch_prctl(ARCH_SHSTK_DISABLE, unsigned long feature)
+    Disable a single feature specified in 'feature'. Can only operate on
+    one feature at a time.
+
+arch_prctl(ARCH_SHSTK_LOCK, unsigned long features)
+    Lock in features at their current enabled or disabled status. 'features'
+    is a mask of all features to lock. All bits set are processed, unset bits
+    are ignored. The mask is ORed with the existing value. So any feature bits
+    set here cannot be enabled or disabled afterwards.
+
+The return values are as following:
+    On success, return 0. On error, errno can be::
+
+        -EPERM if any of the passed feature are locked.
+        -EOPNOTSUPP if the feature is not supported by the hardware or
+         disabled by kernel parameter.
+        -EINVAL arguments (non existing feature, etc)
+
+The feature's bits supported are::
+
+    ARCH_SHSTK_SHSTK - Shadow stack
+    ARCH_SHSTK_WRSS  - WRSS
+
+Currently shadow stack and WRSS are supported via this interface. WRSS
+can only be enabled with shadow stack, and is automatically disabled
+if shadow stack is disabled.
+
+Proc Status
+===========
+To check if an application is actually running with shadow stack, the
+user can read the /proc/$PID/status. It will report "wrss" or "shstk"
+depending on what is enabled. The lines look like this::
+
+    x86_Thread_features: shstk wrss
+    x86_Thread_features_locked: shstk wrss
+
+Implementation of the Shadow Stack
+==================================
+
+Shadow Stack Size
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
+By default, the main program and its signal handlers use the same shadow
+stack. Because the shadow stack stores only return addresses, a large
+shadow stack covers the condition that both the program stack and the
+signal alternate stack run out.
+
+When a signal happens, the old pre-signal state is pushed on the stack. When
+shadow stack is enabled, the shadow stack specific state is pushed onto the
+shadow stack. Today this is only the old SSP (shadow stack pointer), pushed
+in a special format with bit 63 set. On sigreturn this old SSP token is
+verified and restored by the kernel. The kernel will also push the normal
+restorer address to the shadow stack to help userspace avoid a shadow stack
+violation on the sigreturn path that goes through the restorer.
+
+So the shadow stack signal frame format is as follows::
+
+    |1...old SSP| - Pointer to old pre-signal ssp in sigframe token format
+                    (bit 63 set to 1)
+    |        ...| - Other state may be added in the future
+
+
+32 bit ABI signals are not supported in shadow stack processes. Linux prevents
+this by clearing any 32 bit signals (those registered via a 32 bit syscall)
+when shadow stack is enabled, and blocking any new ones from being added.
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
+for the new thread. New shadow stack's behave like mmap() with respect to
+ASLR behavior.
+
+Exec
+----
+
+On exec, shadow stack features are disabled by the kernel. At which point,
+userspace can choose to re-enable, or lock them.
-- 
2.17.1

