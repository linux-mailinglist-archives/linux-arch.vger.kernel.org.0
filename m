Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAAF3614AC
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 00:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhDOWP7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 18:15:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:22365 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236649AbhDOWP5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 18:15:57 -0400
IronPort-SDR: NL+RtR7oTdJZRJtXv/cBWCWJ/xI5IvuwDXSTSE/6R8xWR46iUVw4W/y3vTKDtg+eXVU0YNhuXa
 M2B9C48gm00A==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194513316"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194513316"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:33 -0700
IronPort-SDR: GQHn+ysxooCYnrwHldu33KeZx6Gbm7Rnx89fXv9IXXtLbuAAIRAbGybDpnfIdzbfzZkAKS8c8s
 F3KziKDT0YPg==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="451270859"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:33 -0700
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
Subject: [PATCH v25 01/30] Documentation/x86: Add CET description
Date:   Thu, 15 Apr 2021 15:13:50 -0700
Message-Id: <20210415221419.31835-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210415221419.31835-1-yu-cheng.yu@intel.com>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Explain no_user_shstk/no_user_ibt kernel parameters, and introduce a new
document on Control-flow Enforcement Technology (CET).

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v24:
- Update for Kconfig changes from X86_CET to X86_SHADOW_STACK, X86_IBT.
- Update for the change of VM_SHSTK to VM_SHADOW_STACK.

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/intel_cet.rst               | 136 ++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 Documentation/x86/intel_cet.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..bc79e54be91e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3220,6 +3220,12 @@
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
+	no_user_shstk	[X86-64] Disable Shadow Stack for user-mode
+			applications
+
+	no_user_ibt	[X86-64] Disable Indirect Branch Tracking for user-mode
+			applications
+
 	nosmap		[X86,PPC]
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 4693e192b447..cf5250a3cc70 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -21,6 +21,7 @@ x86-specific Documentation
    tlb
    mtrr
    pat
+   intel_cet
    intel-iommu
    intel_txt
    amd-memory-encryption
diff --git a/Documentation/x86/intel_cet.rst b/Documentation/x86/intel_cet.rst
new file mode 100644
index 000000000000..ae30c392994a
--- /dev/null
+++ b/Documentation/x86/intel_cet.rst
@@ -0,0 +1,136 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+Control-flow Enforcement Technology (CET)
+=========================================
+
+[1] Overview
+============
+
+Control-flow Enforcement Technology (CET) is an Intel processor feature
+that provides protection against return/jump-oriented programming (ROP)
+attacks.  It can be set up to protect both applications and the kernel.
+Only user-mode protection is implemented in the 64-bit kernel, including
+support for running legacy 32-bit applications.
+
+CET introduces Shadow Stack and Indirect Branch Tracking.  Shadow stack is
+a secondary stack allocated from memory and cannot be directly modified by
+applications.  When executing a CALL instruction, the processor pushes the
+return address to both the normal stack and the shadow stack.  Upon
+function return, the processor pops the shadow stack copy and compares it
+to the normal stack copy.  If the two differ, the processor raises a
+control-protection fault.  Indirect branch tracking verifies indirect
+CALL/JMP targets are intended as marked by the compiler with 'ENDBR'
+opcodes.
+
+There are two Kconfig options:
+
+    X86_SHADOW_STACK, and X86_IBT.
+
+To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or LLVM v10.0.1
+or later are required.  To build a CET-enabled application, GLIBC v2.28 or
+later is also required.
+
+There are two command-line options for disabling CET features::
+
+    no_user_shstk - disables user shadow stack, and
+    no_user_ibt   - disables user indirect branch tracking.
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
+        properties: x86 feature: IBT, SHSTK
+
+If an application supports CET and is statically linked, it will run with
+CET protection.  If the application needs any shared libraries, the loader
+checks all dependencies and enables CET when all requirements are met.
+
+[3] Backward Compatibility
+==========================
+
+GLIBC provides a few CET tunables via the GLIBC_TUNABLES environment
+variable:
+
+GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-IBT
+    Turn off SHSTK/IBT.
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
+Several arch_prctl()'s have been added for CET:
+
+arch_prctl(ARCH_X86_CET_STATUS, u64 *addr)
+    Return CET feature status.
+
+    The parameter 'addr' is a pointer to a user buffer.
+    On returning to the caller, the kernel fills the following
+    information::
+
+        *addr       = shadow stack/indirect branch tracking status
+        *(addr + 1) = shadow stack base address
+        *(addr + 2) = shadow stack size
+
+arch_prctl(ARCH_X86_CET_DISABLE, unsigned int features)
+    Disable shadow stack and/or indirect branch tracking as specified in
+    'features'.  Return -EPERM if CET is locked.
+
+arch_prctl(ARCH_X86_CET_LOCK)
+    Lock in all CET features.  They cannot be turned off afterwards.
+
+Note:
+  There is no CET-enabling arch_prctl function.  By design, CET is enabled
+  automatically if the binary and the system can support it.
+
+[5] The implementation of the Shadow Stack
+==========================================
+
+Shadow Stack size
+-----------------
+
+A task's shadow stack is allocated from memory to a fixed size of
+MIN(RLIMIT_STACK, 4 GB).  In other words, the shadow stack is allocated to
+the maximum size of the normal stack, but capped to 4 GB.  However,
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
+The kernel creates a restore token for the shadow stack restoring address
+and verifies that token when restoring from the signal handler.
+
+Fork
+----
+
+The shadow stack's vma has VM_SHADOW_STACK flag set; its PTEs are required
+to be read-only and dirty.  When a shadow stack PTE is not RO and dirty, a
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
-- 
2.21.0

