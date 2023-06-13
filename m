Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC572D615
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbjFMAQW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbjFMAPg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:15:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F82681;
        Mon, 12 Jun 2023 17:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615199; x=1718151199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QMw9iVo5bgNcqwrdr19MOUpW+koohCohKti/401XfIw=;
  b=lysIj8lU3aMzLbUK29LV7QLkk/p0zxuNXCKzD8t3kBMUIZkY4ydgR0aH
   ZtYsKNAOcJB1cYIYPCyMDx9Rkz8gjC5EcGt3pvXl+JyaovqGGRBg1KN/m
   jJ+PCDL0Fkii6uPyoAZWDKJY9vK2Nw4YASS1mlToAscsvao34SyqsjD1F
   bfFlmRQjmSDu188/t9iXq/6iQtk8Zlv+mDlsCHrRzf8iArLL3+P8xiNen
   XodN2SvT+g18Xj5rO9Xxufww8VyN3SAJa7xmJXD9VFTXq5aujanviF5RQ
   8EHK4jo8eUoyjxqKBIGZQr1R2MJIxGM+agsWwWrFo4ftkRN0D9OX5Q7F+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557195"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557195"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671062"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671062"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:27 -0700
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack description
Date:   Mon, 12 Jun 2023 17:10:49 -0700
Message-Id: <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce a new document on Control-flow Enforcement Technology (CET).

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
 Documentation/arch/x86/index.rst |   1 +
 Documentation/arch/x86/shstk.rst | 169 +++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 Documentation/arch/x86/shstk.rst

diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
index c73d133fd37c..8ac64d7de4dc 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -22,6 +22,7 @@ x86-specific Documentation
    mtrr
    pat
    intel-hfi
+   shstk
    iommu
    intel_txt
    amd-memory-encryption
diff --git a/Documentation/arch/x86/shstk.rst b/Documentation/arch/x86/shstk.rst
new file mode 100644
index 000000000000..f09afa504ec0
--- /dev/null
+++ b/Documentation/arch/x86/shstk.rst
@@ -0,0 +1,169 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================
+Control-flow Enforcement Technology (CET) Shadow Stack
+======================================================
+
+CET Background
+==============
+
+Control-flow Enforcement Technology (CET) covers several related x86 processor
+features that provide protection against control flow hijacking attacks. CET
+can protect both applications and the kernel.
+
+CET introduces shadow stack and indirect branch tracking (IBT). A shadow stack
+is a secondary stack allocated from memory which cannot be directly modified by
+applications. When executing a CALL instruction, the processor pushes the
+return address to both the normal stack and the shadow stack. Upon
+function return, the processor pops the shadow stack copy and compares it
+to the normal stack copy. If the two differ, the processor raises a
+control-protection fault. IBT verifies indirect CALL/JMP targets are intended
+as marked by the compiler with 'ENDBR' opcodes. Not all CPU's have both Shadow
+Stack and Indirect Branch Tracking. Today in the 64-bit kernel, only userspace
+shadow stack and kernel IBT are supported.
+
+Requirements to use Shadow Stack
+================================
+
+To use userspace shadow stack you need HW that supports it, a kernel
+configured with it and userspace libraries compiled with it.
+
+The kernel Kconfig option is X86_USER_SHADOW_STACK.  When compiled in, shadow
+stacks can be disabled at runtime with the kernel parameter: nousershstk.
+
+To build a user shadow stack enabled kernel, Binutils v2.29 or LLVM v6 or later
+are required.
+
+At run time, /proc/cpuinfo shows CET features if the processor supports
+CET. "user_shstk" means that userspace shadow stack is supported on the current
+kernel and HW.
+
+Application Enabling
+====================
+
+An application's CET capability is marked in its ELF note and can be verified
+from readelf/llvm-readelf output::
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
+are only supported in 64 bit user applications. These operate on the features
+on a per-thread basis. The enablement status is inherited on clone, so if the
+feature is enabled on the first thread, it will propagate to all the thread's
+in an app.
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
+The return values are as follows. On success, return 0. On error, errno can
+be::
+
+        -EPERM if any of the passed feature are locked.
+        -ENOTSUPP if the feature is not supported by the hardware or
+         kernel.
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
+the maximum size of the normal stack, but capped to 4 GB. In the case
+of the clone3 syscall, there is a stack size passed in and shadow stack
+uses this instead of the rlimit.
+
+Signal
+------
+
+The main program and its signal handlers use the same shadow stack. Because
+the shadow stack stores only return addresses, a large shadow stack covers
+the condition that both the program stack and the signal alternate stack run
+out.
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
+32 bit execution while shadow stack is enabled by the allocating shadow stacks
+outside of the 32 bit address space. When execution enters 32 bit mode, either
+via far call or returning to userspace, a #GP is generated by the hardware
+which, will be delivered to the process as a segfault. When transitioning to
+userspace the register's state will be as if the userspace ip being returned to
+caused the segfault.
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
+for the new thread. New shadow stack creation behaves like mmap() with respect
+to ASLR behavior. Similarly, on thread exit the thread's shadow stack is
+disabled.
+
+Exec
+----
+
+On exec, shadow stack features are disabled by the kernel. At which point,
+userspace can choose to re-enable, or lock them.
-- 
2.34.1

