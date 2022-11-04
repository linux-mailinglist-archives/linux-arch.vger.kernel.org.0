Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC8E61A42C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiKDWj0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKDWjZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:39:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3D324961;
        Fri,  4 Nov 2022 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601564; x=1699137564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HzY88wRuFQaKqUeaRtvIS4XEASKTUtROHQ9F/zxMQKY=;
  b=Tq2qM6Ve5Kb3WBrUkGLfucPkVLCc0LPFyRFwbEy1IGpftSzFHICnf0Ly
   oy6pcgBoBuorXAHlFc9ZOQB+c7DDIeYLRLf2XtrVZiPfiTnPeqRKbUprB
   lhRpewJdlbU+FjKgooJ06CC/9RyX0UEMsC7zn5IOemInnSt8W5bmylAan
   p0sAnLPN+hj1LFXdlSFJRZKuvgOtp6PJjJLSNkT39F0NuakfYLLtem3ht
   h+hgXJOATqHONK817KRExbcavwbX7zROAY4RdgYczQsFv+nr7veCv4TV/
   lKj9J7Ur+1uwAa7gQ5nutu92nATbbut0Fp6AVh1a1iZV3SlIZW61dazfM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840473"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840473"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668513914"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668513914"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:21 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 01/37] Documentation/x86: Add CET description
Date:   Fri,  4 Nov 2022 15:35:28 -0700
Message-Id: <20221104223604.29615-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

 Documentation/x86/cet.rst   | 147 ++++++++++++++++++++++++++++++++++++
 Documentation/x86/index.rst |   1 +
 2 files changed, 148 insertions(+)
 create mode 100644 Documentation/x86/cet.rst

diff --git a/Documentation/x86/cet.rst b/Documentation/x86/cet.rst
new file mode 100644
index 000000000000..b56811566531
--- /dev/null
+++ b/Documentation/x86/cet.rst
@@ -0,0 +1,147 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+Control-flow Enforcement Technology (CET)
+=========================================
+
+Overview
+========
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
+Shadow Stack and kernel IBT is supported in the kernel.
+
+The Kconfig option is X86_USER_SHADOW_STACK, and it can be disabled with
+the kernel parameter clearcpuid, like this: "clearcpuid=user_shstk".
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
+CET arch_prctl()'s
+==================
+
+Elf features should be enabled by the loader using the below arch_prctl's.
+
+arch_prctl(ARCH_CET_ENABLE, unsigned int feature)
+    Enable a single feature specified in 'feature'. Can only operate on
+    one feature at a time.
+
+arch_prctl(ARCH_CET_DISABLE, unsigned int feature)
+    Disable a single feature specified in 'feature'. Can only operate on
+    one feature at a time.
+
+arch_prctl(ARCH_CET_LOCK, unsigned int features)
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
+Currently shadow stack and WRSS are supported via this interface. WRSS
+can only be enabled with shadow stack, and is automatically disabled
+if shadow stack is disabled.
+
+Proc status
+===========
+To check if an application is actually running with shadow stack, the
+user can read the /proc/$PID/status. It will report "wrss" or "shstk"
+depending on what is enabled. The lines look like this::
+
+    x86_Thread_features: shstk wrss
+    x86_Thread_features_locked: shstk wrss
+
+The implementation of the Shadow Stack
+======================================
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
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c73d133fd37c..9ac03055c4b5 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -22,6 +22,7 @@ x86-specific Documentation
    mtrr
    pat
    intel-hfi
+   cet
    iommu
    intel_txt
    amd-memory-encryption
-- 
2.17.1

