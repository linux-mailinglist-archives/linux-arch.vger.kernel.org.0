Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D7E85055
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2019 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbfHGPx3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Aug 2019 11:53:29 -0400
Received: from foss.arm.com ([217.140.110.172]:50670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388779AbfHGPx2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Aug 2019 11:53:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27BEC1570;
        Wed,  7 Aug 2019 08:53:28 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8DAA3F706;
        Wed,  7 Aug 2019 08:53:26 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v7 1/2] arm64: Define Documentation/arm64/tagged-address-abi.rst
Date:   Wed,  7 Aug 2019 16:53:20 +0100
Message-Id: <20190807155321.9648-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
In-Reply-To: <20190807155321.9648-1-catalin.marinas@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

On arm64 the TCR_EL1.TBI0 bit has been always enabled hence
the userspace (EL0) is allowed to set a non-zero value in the
top byte but the resulting pointers are not allowed at the
user-kernel syscall ABI boundary.

With the relaxed ABI proposed through this document, it is now possible
to pass tagged pointers to the syscalls, when these pointers are in
memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().

This change in the ABI requires a mechanism to requires the userspace
to opt-in to such an option.

Specify and document the way in which sysctl and prctl() can be used
in combination to allow the userspace to opt-in this feature.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
[catalin.marinas@arm.com: some rewording, dropped MAP_PRIVATE]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/arm64/tagged-address-abi.rst | 151 +++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/arm64/tagged-address-abi.rst

diff --git a/Documentation/arm64/tagged-address-abi.rst b/Documentation/arm64/tagged-address-abi.rst
new file mode 100644
index 000000000000..f91a5d2ac865
--- /dev/null
+++ b/Documentation/arm64/tagged-address-abi.rst
@@ -0,0 +1,151 @@
+==========================
+AArch64 TAGGED ADDRESS ABI
+==========================
+
+Author: Vincenzo Frascino <vincenzo.frascino@arm.com>
+
+Date: 25 July 2019
+
+This document describes the usage and semantics of the Tagged Address
+ABI on AArch64 Linux.
+
+1. Introduction
+---------------
+
+On AArch64 the TCR_EL1.TBI0 bit has always been enabled, allowing userspace
+(EL0) to perform memory accesses through 64-bit pointers with a non-zero
+top byte. Such tagged pointers, however, were not allowed at the
+user-kernel syscall ABI boundary.
+
+This document describes the relaxation of the syscall ABI that allows
+userspace to pass certain tagged pointers to kernel syscalls, as described
+in section 2.
+
+2. AArch64 Tagged Address ABI
+-----------------------------
+
+From the kernel syscall interface perspective and for the purposes of this
+document, a "valid tagged pointer" is a pointer with a potentially non-zero
+top-byte that references an address in the user process address space
+obtained in one of the following ways:
+
+- mmap() done by the process itself (or its parent), where either:
+
+  - flags have the **MAP_ANONYMOUS** bit set
+  - the file descriptor refers to a regular file (including those returned
+    by memfd_create()) or **/dev/zero**
+
+- brk() system call done by the process itself (i.e. the heap area between
+  the initial location of the program break at process creation and its
+  current location).
+
+- any memory mapped by the kernel in the address space of the process
+  during creation and with the same restrictions as for mmap() above (e.g.
+  data, bss, stack).
+
+The AArch64 Tagged Address ABI is an opt-in feature and an application can
+control it via **prctl()** as follows:
+
+- **PR_SET_TAGGED_ADDR_CTRL**: enable or disable the AArch64 Tagged Address
+  ABI for the calling process.
+
+  The (unsigned int) arg2 argument is a bit mask describing the control mode
+  used:
+
+  - **PR_TAGGED_ADDR_ENABLE**: enable AArch64 Tagged Address ABI. Default
+    status is disabled.
+
+  The arguments arg3, arg4, and arg5 are ignored.
+
+- **PR_GET_TAGGED_ADDR_CTRL**: get the status of the AArch64 Tagged Address
+  ABI for the calling process.
+
+  The arguments arg2, arg3, arg4, and arg5 are ignored.
+
+The prctl(PR_SET_TAGGED_ADDR_CTRL, ...) will return -EINVAL if the
+AArch64 Tagged Address ABI is not available
+(CONFIG_ARM64_TAGGED_ADDR_ABI disabled or sysctl abi.tagged_addr=0).
+
+The ABI properties set by the mechanism described above are inherited by
+threads of the same application and fork()'ed children but cleared by
+execve().
+
+Opting in (the prctl() option described above only) to or out of the
+AArch64 Tagged Address ABI can be disabled globally at runtime using the
+sysctl interface:
+
+- **abi.tagged_addr**: a new sysctl interface that can be used to prevent
+  applications from enabling or disabling the relaxed ABI. The sysctl
+  supports the following configuration options:
+
+  - **0**: disable the prctl(PR_SET_TAGGED_ADDR_CTRL) option to
+    enable/disable the AArch64 Tagged Address ABI globally
+
+  - **1** (Default): enable the prctl(PR_SET_TAGGED_ADDR_CTRL) option to
+    enable/disable the AArch64 Tagged Address ABI globally
+
+  Note that this sysctl does not affect the status of the AArch64 Tagged
+  Address ABI of the running processes.
+
+When a process has successfully enabled the new ABI by invoking
+prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE), the following
+behaviours are guaranteed:
+
+- Every currently available syscall, except the cases mentioned in section
+  3, can accept any valid tagged pointer. The same rule is applicable to
+  any syscall introduced in the future.
+
+- The syscall behaviour is undefined for non valid tagged pointers.
+
+- Every valid tagged pointer is expected to work as an untagged one.
+
+A definition of the meaning of tagged pointers on AArch64 can be found in:
+Documentation/arm64/tagged-pointers.txt.
+
+3. AArch64 Tagged Address ABI Exceptions
+-----------------------------------------
+
+The behaviour described in section 2, with particular reference to the
+acceptance by the syscalls of any valid tagged pointer, is not applicable
+to the following cases:
+
+- mmap() addr parameter.
+
+- mremap() new_address parameter.
+
+- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
+  PR_SET_MM_MAP_SIZE.
+
+- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.
+
+Any attempt to use non-zero tagged pointers will lead to undefined
+behaviour.
+
+4. Example of correct usage
+---------------------------
+.. code-block:: c
+
+   void main(void)
+   {
+           static int tbi_enabled = 0;
+           unsigned long tag = 0;
+
+           char *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+                            MAP_ANONYMOUS, -1, 0);
+
+           if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE,
+                     0, 0, 0) == 0)
+                   tbi_enabled = 1;
+
+           if (ptr == (void *)-1) /* MAP_FAILED */
+                   return -1;
+
+           if (tbi_enabled)
+                   tag = rand() & 0xff;
+
+           ptr = (char *)((unsigned long)ptr | (tag << TAG_SHIFT));
+
+           *ptr = 'a';
+
+           ...
+   }
