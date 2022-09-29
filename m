Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2355D5F001B
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiI2W3y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI2W3w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:29:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49361B795;
        Thu, 29 Sep 2022 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490590; x=1696026590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dgoCV7vkgGcH+obhSo8r9k9vnopVaP/5/9bw1BHk+Fw=;
  b=UVm/hcuMvljZVYMjYd1NDI7HHTIQdrebdhKMC8JHleAaWWlLwl/c/J3L
   roxNmq5lN2KwIi/wbkKUpuEss30Lw5XeVrMATr3SgS3KU7bq1Mz20UcI7
   bsvRd9xwa48om+K5DMsflIuG4AijzquFnZVakZNFihQgOMFVu4QgMyV+2
   KXsq2CAkqQhNVN+GP6+LY9OcPyvH/ijVcu7FvCifPpg1A/eLZRnVy3Jgz
   ve2JJPkEsPi4D7xTns4yVzmhxV1PhoZnFhZA54htn9hgTuSKj+tOHXgWo
   WGmf3Pxd704tkhngB5NeMa69ZsyiAEl3KpjDJBCKJMa/+3qQ+lji2Y3Zn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303531317"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="303531317"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:29:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016062"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016062"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:29:47 -0700
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
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 01/39] Documentation/x86: Add CET description
Date:   Thu, 29 Sep 2022 15:28:58 -0700
Message-Id: <20220929222936.14584-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Introduce a new document on Control-flow Enforcement Technology (CET).

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---

v2:
 - Updated to new arch_prctl() API
 - Add bit about new proc status

v1:
 - Update and clarify the docs.
 - Moved kernel parameters documentation to other patch.

 Documentation/x86/cet.rst   | 140 ++++++++++++++++++++++++++++++++++++
 Documentation/x86/index.rst |   1 +
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/x86/cet.rst

diff --git a/Documentation/x86/cet.rst b/Documentation/x86/cet.rst
new file mode 100644
index 000000000000..4a0dfb6830f9
--- /dev/null
+++ b/Documentation/x86/cet.rst
@@ -0,0 +1,140 @@
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
+both applications and the kernel. Only user-mode protection is implemented
+in the 64-bit kernel.
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
+the kernel parameter clearcpuid, like this: "clearcpuid=shstk".
+
+To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or LLVM v10.0.1
+or later are required. To build a CET-enabled application, GLIBC v2.28 or
+later is also required.
+
+At run time, /proc/cpuinfo shows CET features if the processor supports
+CET.
+
+Application Enabling
+====================
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
+Backward Compatibility
+======================
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
+    Disable features specified in 'feature'. Can only operate on
+    one feature at a time.
+
+arch_prctl(ARCH_CET_LOCK, unsigned int features)
+    Lock in features at their current enabled or disabled status.
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
+user can read the /proc/$PID/arch_status. It will report "wrss" or
+"shstk" depending on what is enabled.
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

