Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35E125079C
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgHXS3V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgHXS3K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 14:29:10 -0400
Received: from localhost.localdomain (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2E6206BE;
        Mon, 24 Aug 2020 18:29:06 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        libc-alpha@sourceware.org
Subject: [PATCH v8 28/28] arm64: mte: Add Memory Tagging Extension documentation
Date:   Mon, 24 Aug 2020 19:27:58 +0100
Message-Id: <20200824182758.27267-29-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824182758.27267-1-catalin.marinas@arm.com>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Memory Tagging Extension (part of the ARMv8.5 Extensions) provides
a mechanism to detect the sources of memory related errors which
may be vulnerable to exploitation, including bounds violations,
use-after-free, use-after-return, use-out-of-scope and use before
initialization errors.

Add Memory Tagging Extension documentation for the arm64 linux
kernel support.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v7:
    - Add information on ptrace() regset access (NT_ARM_TAGGED_ADDR_CTRL).
    
    v4:
    - Document behaviour of madvise(MADV_DONTNEED/MADV_FREE).
    - Document the initial process state on fork/execve.
    - Clarify when the kernel uaccess checks the tags.
    - Minor updates to the example code.
    - A few other minor clean-ups following review.
    
    v3:
    - Modify the uaccess checking conditions: only when the sync mode is
      selected by the user. In async mode, the kernel uaccesses are not
      checked.
    - Clarify that an include mask of 0 (exclude mask 0xffff) results in
      always generating tag 0.
    - Document the ptrace() interface.
    
    v2:
    - Documented the uaccess kernel tag checking mode.
    - Removed the BTI definitions from cpu-feature-registers.rst.
    - Removed the paragraph stating that MTE depends on the tagged address
      ABI (while the Kconfig entry does, there is no requirement for the
      user to enable both).
    - Changed the GCR_EL1.Exclude handling description following the change
      in the prctl() interface (include vs exclude mask).
    - Updated the example code.

 Documentation/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arm64/elf_hwcaps.rst            |   4 +
 Documentation/arm64/index.rst                 |   1 +
 .../arm64/memory-tagging-extension.rst        | 305 ++++++++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 Documentation/arm64/memory-tagging-extension.rst

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index f28853f80089..328e0c454fbd 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -175,6 +175,8 @@ infrastructure:
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
+     | MTE                          | [11-8]  |    y    |
+     +------------------------------+---------+---------+
      | SSBS                         | [7-4]   |    y    |
      +------------------------------+---------+---------+
      | BT                           | [3-0]   |    y    |
diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 84a9fd2d41b4..bbd9cf54db6c 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -240,6 +240,10 @@ HWCAP2_BTI
 
     Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.
 
+HWCAP2_MTE
+
+    Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
+    by Documentation/arm64/memory-tagging-extension.rst.
 
 4. Unused AT_HWCAP bits
 -----------------------
diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index d9665d83c53a..43b0939d384e 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -14,6 +14,7 @@ ARM64 Architecture
     hugetlbpage
     legacy_instructions
     memory
+    memory-tagging-extension
     perf
     pointer-authentication
     silicon-errata
diff --git a/Documentation/arm64/memory-tagging-extension.rst b/Documentation/arm64/memory-tagging-extension.rst
new file mode 100644
index 000000000000..e3709b536b89
--- /dev/null
+++ b/Documentation/arm64/memory-tagging-extension.rst
@@ -0,0 +1,305 @@
+===============================================
+Memory Tagging Extension (MTE) in AArch64 Linux
+===============================================
+
+Authors: Vincenzo Frascino <vincenzo.frascino@arm.com>
+         Catalin Marinas <catalin.marinas@arm.com>
+
+Date: 2020-02-25
+
+This document describes the provision of the Memory Tagging Extension
+functionality in AArch64 Linux.
+
+Introduction
+============
+
+ARMv8.5 based processors introduce the Memory Tagging Extension (MTE)
+feature. MTE is built on top of the ARMv8.0 virtual address tagging TBI
+(Top Byte Ignore) feature and allows software to access a 4-bit
+allocation tag for each 16-byte granule in the physical address space.
+Such memory range must be mapped with the Normal-Tagged memory
+attribute. A logical tag is derived from bits 59-56 of the virtual
+address used for the memory access. A CPU with MTE enabled will compare
+the logical tag against the allocation tag and potentially raise an
+exception on mismatch, subject to system registers configuration.
+
+Userspace Support
+=================
+
+When ``CONFIG_ARM64_MTE`` is selected and Memory Tagging Extension is
+supported by the hardware, the kernel advertises the feature to
+userspace via ``HWCAP2_MTE``.
+
+PROT_MTE
+--------
+
+To access the allocation tags, a user process must enable the Tagged
+memory attribute on an address range using a new ``prot`` flag for
+``mmap()`` and ``mprotect()``:
+
+``PROT_MTE`` - Pages allow access to the MTE allocation tags.
+
+The allocation tag is set to 0 when such pages are first mapped in the
+user address space and preserved on copy-on-write. ``MAP_SHARED`` is
+supported and the allocation tags can be shared between processes.
+
+**Note**: ``PROT_MTE`` is only supported on ``MAP_ANONYMOUS`` and
+RAM-based file mappings (``tmpfs``, ``memfd``). Passing it to other
+types of mapping will result in ``-EINVAL`` returned by these system
+calls.
+
+**Note**: The ``PROT_MTE`` flag (and corresponding memory type) cannot
+be cleared by ``mprotect()``.
+
+**Note**: ``madvise()`` memory ranges with ``MADV_DONTNEED`` and
+``MADV_FREE`` may have the allocation tags cleared (set to 0) at any
+point after the system call.
+
+Tag Check Faults
+----------------
+
+When ``PROT_MTE`` is enabled on an address range and a mismatch between
+the logical and allocation tags occurs on access, there are three
+configurable behaviours:
+
+- *Ignore* - This is the default mode. The CPU (and kernel) ignores the
+  tag check fault.
+
+- *Synchronous* - The kernel raises a ``SIGSEGV`` synchronously, with
+  ``.si_code = SEGV_MTESERR`` and ``.si_addr = <fault-address>``. The
+  memory access is not performed. If ``SIGSEGV`` is ignored or blocked
+  by the offending thread, the containing process is terminated with a
+  ``coredump``.
+
+- *Asynchronous* - The kernel raises a ``SIGSEGV``, in the offending
+  thread, asynchronously following one or multiple tag check faults,
+  with ``.si_code = SEGV_MTEAERR`` and ``.si_addr = 0`` (the faulting
+  address is unknown).
+
+The user can select the above modes, per thread, using the
+``prctl(PR_SET_TAGGED_ADDR_CTRL, flags, 0, 0, 0)`` system call where
+``flags`` contain one of the following values in the ``PR_MTE_TCF_MASK``
+bit-field:
+
+- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults
+- ``PR_MTE_TCF_SYNC``  - *Synchronous* tag check fault mode
+- ``PR_MTE_TCF_ASYNC`` - *Asynchronous* tag check fault mode
+
+The current tag check fault mode can be read using the
+``prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0)`` system call.
+
+Tag checking can also be disabled for a user thread by setting the
+``PSTATE.TCO`` bit with ``MSR TCO, #1``.
+
+**Note**: Signal handlers are always invoked with ``PSTATE.TCO = 0``,
+irrespective of the interrupted context. ``PSTATE.TCO`` is restored on
+``sigreturn()``.
+
+**Note**: There are no *match-all* logical tags available for user
+applications.
+
+**Note**: Kernel accesses to the user address space (e.g. ``read()``
+system call) are not checked if the user thread tag checking mode is
+``PR_MTE_TCF_NONE`` or ``PR_MTE_TCF_ASYNC``. If the tag checking mode is
+``PR_MTE_TCF_SYNC``, the kernel makes a best effort to check its user
+address accesses, however it cannot always guarantee it.
+
+Excluding Tags in the ``IRG``, ``ADDG`` and ``SUBG`` instructions
+-----------------------------------------------------------------
+
+The architecture allows excluding certain tags to be randomly generated
+via the ``GCR_EL1.Exclude`` register bit-field. By default, Linux
+excludes all tags other than 0. A user thread can enable specific tags
+in the randomly generated set using the ``prctl(PR_SET_TAGGED_ADDR_CTRL,
+flags, 0, 0, 0)`` system call where ``flags`` contains the tags bitmap
+in the ``PR_MTE_TAG_MASK`` bit-field.
+
+**Note**: The hardware uses an exclude mask but the ``prctl()``
+interface provides an include mask. An include mask of ``0`` (exclusion
+mask ``0xffff``) results in the CPU always generating tag ``0``.
+
+Initial process state
+---------------------
+
+On ``execve()``, the new process has the following configuration:
+
+- ``PR_TAGGED_ADDR_ENABLE`` set to 0 (disabled)
+- Tag checking mode set to ``PR_MTE_TCF_NONE``
+- ``PR_MTE_TAG_MASK`` set to 0 (all tags excluded)
+- ``PSTATE.TCO`` set to 0
+- ``PROT_MTE`` not set on any of the initial memory maps
+
+On ``fork()``, the new process inherits the parent's configuration and
+memory map attributes with the exception of the ``madvise()`` ranges
+with ``MADV_WIPEONFORK`` which will have the data and tags cleared (set
+to 0).
+
+The ``ptrace()`` interface
+--------------------------
+
+``PTRACE_PEEKMTETAGS`` and ``PTRACE_POKEMTETAGS`` allow a tracer to read
+the tags from or set the tags to a tracee's address space. The
+``ptrace()`` system call is invoked as ``ptrace(request, pid, addr,
+data)`` where:
+
+- ``request`` - one of ``PTRACE_PEEKMTETAGS`` or ``PTRACE_PEEKMTETAGS``.
+- ``pid`` - the tracee's PID.
+- ``addr`` - address in the tracee's address space.
+- ``data`` - pointer to a ``struct iovec`` where ``iov_base`` points to
+  a buffer of ``iov_len`` length in the tracer's address space.
+
+The tags in the tracer's ``iov_base`` buffer are represented as one
+4-bit tag per byte and correspond to a 16-byte MTE tag granule in the
+tracee's address space.
+
+**Note**: If ``addr`` is not aligned to a 16-byte granule, the kernel
+will use the corresponding aligned address.
+
+``ptrace()`` return value:
+
+- 0 - tags were copied, the tracer's ``iov_len`` was updated to the
+  number of tags transferred. This may be smaller than the requested
+  ``iov_len`` if the requested address range in the tracee's or the
+  tracer's space cannot be accessed or does not have valid tags.
+- ``-EPERM`` - the specified process cannot be traced.
+- ``-EIO`` - the tracee's address range cannot be accessed (e.g. invalid
+  address) and no tags copied. ``iov_len`` not updated.
+- ``-EFAULT`` - fault on accessing the tracer's memory (``struct iovec``
+  or ``iov_base`` buffer) and no tags copied. ``iov_len`` not updated.
+- ``-EOPNOTSUPP`` - the tracee's address does not have valid tags (never
+  mapped with the ``PROT_MTE`` flag). ``iov_len`` not updated.
+
+**Note**: There are no transient errors for the requests above, so user
+programs should not retry in case of a non-zero system call return.
+
+``PTRACE_GETREGSET`` and ``PTRACE_SETREGSET`` with ``addr ==
+``NT_ARM_TAGGED_ADDR_CTRL`` allow ``ptrace()`` access to the tagged
+address ABI control and MTE configuration of a process as per the
+``prctl()`` options described in
+Documentation/arm64/tagged-address-abi.rst and above. The corresponding
+``regset`` is 1 element of 8 bytes (``sizeof(long))``).
+
+Example of correct usage
+========================
+
+*MTE Example code*
+
+.. code-block:: c
+
+    /*
+     * To be compiled with -march=armv8.5-a+memtag
+     */
+    #include <errno.h>
+    #include <stdint.h>
+    #include <stdio.h>
+    #include <stdlib.h>
+    #include <unistd.h>
+    #include <sys/auxv.h>
+    #include <sys/mman.h>
+    #include <sys/prctl.h>
+
+    /*
+     * From arch/arm64/include/uapi/asm/hwcap.h
+     */
+    #define HWCAP2_MTE              (1 << 18)
+
+    /*
+     * From arch/arm64/include/uapi/asm/mman.h
+     */
+    #define PROT_MTE                 0x20
+
+    /*
+     * From include/uapi/linux/prctl.h
+     */
+    #define PR_SET_TAGGED_ADDR_CTRL 55
+    #define PR_GET_TAGGED_ADDR_CTRL 56
+    # define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
+    # define PR_MTE_TCF_SHIFT       1
+    # define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
+    # define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
+    # define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
+    # define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
+    # define PR_MTE_TAG_SHIFT       3
+    # define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
+
+    /*
+     * Insert a random logical tag into the given pointer.
+     */
+    #define insert_random_tag(ptr) ({                       \
+            uint64_t __val;                                 \
+            asm("irg %0, %1" : "=r" (__val) : "r" (ptr));   \
+            __val;                                          \
+    })
+
+    /*
+     * Set the allocation tag on the destination address.
+     */
+    #define set_tag(tagged_addr) do {                                      \
+            asm volatile("stg %0, [%0]" : : "r" (tagged_addr) : "memory"); \
+    } while (0)
+
+    int main()
+    {
+            unsigned char *a;
+            unsigned long page_sz = sysconf(_SC_PAGESIZE);
+            unsigned long hwcap2 = getauxval(AT_HWCAP2);
+
+            /* check if MTE is present */
+            if (!(hwcap2 & HWCAP2_MTE))
+                    return EXIT_FAILURE;
+
+            /*
+             * Enable the tagged address ABI, synchronous MTE tag check faults and
+             * allow all non-zero tags in the randomly generated set.
+             */
+            if (prctl(PR_SET_TAGGED_ADDR_CTRL,
+                      PR_TAGGED_ADDR_ENABLE | PR_MTE_TCF_SYNC | (0xfffe << PR_MTE_TAG_SHIFT),
+                      0, 0, 0)) {
+                    perror("prctl() failed");
+                    return EXIT_FAILURE;
+            }
+
+            a = mmap(0, page_sz, PROT_READ | PROT_WRITE,
+                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+            if (a == MAP_FAILED) {
+                    perror("mmap() failed");
+                    return EXIT_FAILURE;
+            }
+
+            /*
+             * Enable MTE on the above anonymous mmap. The flag could be passed
+             * directly to mmap() and skip this step.
+             */
+            if (mprotect(a, page_sz, PROT_READ | PROT_WRITE | PROT_MTE)) {
+                    perror("mprotect() failed");
+                    return EXIT_FAILURE;
+            }
+
+            /* access with the default tag (0) */
+            a[0] = 1;
+            a[1] = 2;
+
+            printf("a[0] = %hhu a[1] = %hhu\n", a[0], a[1]);
+
+            /* set the logical and allocation tags */
+            a = (unsigned char *)insert_random_tag(a);
+            set_tag(a);
+
+            printf("%p\n", a);
+
+            /* non-zero tag access */
+            a[0] = 3;
+            printf("a[0] = %hhu a[1] = %hhu\n", a[0], a[1]);
+
+            /*
+             * If MTE is enabled correctly the next instruction will generate an
+             * exception.
+             */
+            printf("Expecting SIGSEGV...\n");
+            a[16] = 0xdd;
+
+            /* this should not be printed in the PR_MTE_TCF_SYNC mode */
+            printf("...haven't got one\n");
+
+            return EXIT_FAILURE;
+    }
