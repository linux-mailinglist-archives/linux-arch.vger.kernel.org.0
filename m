Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F3D12A2A7
	for <lists+linux-arch@lfdr.de>; Tue, 24 Dec 2019 16:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfLXPDc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Dec 2019 10:03:32 -0500
Received: from foss.arm.com ([217.140.110.172]:52860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfLXPDc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Dec 2019 10:03:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44E841FB;
        Tue, 24 Dec 2019 07:03:29 -0800 (PST)
Received: from [10.1.195.17] (e123572-lin.cambridge.arm.com [10.1.195.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 802B13F6CF;
        Tue, 24 Dec 2019 07:03:25 -0800 (PST)
Subject: Re: [PATCH 22/22] arm64: mte: Add Memory Tagging Extension
 documentation
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-23-catalin.marinas@arm.com>
From:   Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <268ef441-0817-e97d-b752-826be24ca191@arm.com>
Date:   Tue, 24 Dec 2019 15:03:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191211184027.20130-23-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/12/2019 18:40, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Memory Tagging Extension (part of the ARMv8.5 Extensions) provides
> a mechanism to detect the sources of memory related errors which
> may be vulnerable to exploitation, including bounds violations,
> use-after-free, use-after-return, use-out-of-scope and use before
> initialization errors.
>
> Add Memory Tagging Extension documentation for the arm64 linux
> kernel support.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>   Documentation/arm64/cpu-feature-registers.rst |   4 +
>   Documentation/arm64/elf_hwcaps.rst            |   4 +
>   Documentation/arm64/index.rst                 |   1 +
>   .../arm64/memory-tagging-extension.rst        | 229 ++++++++++++++++++
>   4 files changed, 238 insertions(+)
>   create mode 100644 Documentation/arm64/memory-tagging-extension.rst
>
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> index b6e44884e3ad..67305a5f613a 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -172,8 +172,12 @@ infrastructure:
>        +------------------------------+---------+---------+
>        | Name                         |  bits   | visible |
>        +------------------------------+---------+---------+
> +     | MTE                          | [11-8]  |    y    |
> +     +------------------------------+---------+---------+
>        | SSBS                         | [7-4]   |    y    |
>        +------------------------------+---------+---------+
> +     | BT                           | [3-0]   |    n    |
> +     +------------------------------+---------+---------+

Not sure the BTI bits should be in this patch.

>     4) MIDR_EL1 - Main ID Register
> diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> index 7fa3d215ae6a..0f52d22c28af 100644
> --- a/Documentation/arm64/elf_hwcaps.rst
> +++ b/Documentation/arm64/elf_hwcaps.rst
> @@ -204,6 +204,10 @@ HWCAP2_FRINT
>   
>       Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.
>   
> +HWCAP2_MTE
> +
> +    Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010.
> +    Documentation/arm64/memory-tagging-extension.rst.

Nit: to be consistent with the PAC bits, the text should be something like "implied 
by ..., as described by Documentation/..."

>   4. Unused AT_HWCAP bits
>   -----------------------
> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> index 5c0c69dc58aa..82970c6d384f 100644
> --- a/Documentation/arm64/index.rst
> +++ b/Documentation/arm64/index.rst
> @@ -13,6 +13,7 @@ ARM64 Architecture
>       hugetlbpage
>       legacy_instructions
>       memory
> +    memory-tagging-extension
>       pointer-authentication
>       silicon-errata
>       sve
> diff --git a/Documentation/arm64/memory-tagging-extension.rst b/Documentation/arm64/memory-tagging-extension.rst
> new file mode 100644
> index 000000000000..ae02f0771971
> --- /dev/null
> +++ b/Documentation/arm64/memory-tagging-extension.rst
> @@ -0,0 +1,229 @@
> +===============================================
> +Memory Tagging Extension (MTE) in AArch64 Linux
> +===============================================
> +
> +Authors: Vincenzo Frascino <vincenzo.frascino@arm.com>
> +         Catalin Marinas <catalin.marinas@arm.com>
> +
> +Date: 2019-11-29
> +
> +This document describes the provision of the Memory Tagging Extension
> +functionality in AArch64 Linux.
> +
> +Introduction
> +============
> +
> +ARMv8.5 based processors introduce the Memory Tagging Extension (MTE)
> +feature. MTE is built on top of the ARMv8.0 virtual address tagging TBI
> +(Top Byte Ignore) feature and allows software to access a 4-bit
> +allocation tag for each 16-byte granule in the physical address space.
> +Such memory range must be mapped with the Normal-Tagged memory
> +attribute. A logical tag is derived from bits 59-56 of the virtual
> +address used for the memory access. A CPU with MTE enabled will compare
> +the logical tag against the allocation tag and potentially raise an
> +exception on mismatch, subject to system registers configuration.
> +
> +Userspace Support
> +=================
> +
> +Memory Tagging Extension Linux support depends on AArch64 Tagged Address
> +ABI being enabled in the kernel.

This is not very clear. Does it mean that the thread must have PR_TAGGED_ADDR_ENABLE 
set? In fact, as per patch 19, it is perfectly possible to enable tag checking 
without enabling the tagged address ABI, and this can work as long as no tagged 
pointer is passed to a syscall. Therefore enabling the tagged address ABI should be a 
recommendation and not a requirement.

>   For more details on AArch64 Tagged
> +Address ABI refer to Documentation/arm64/tagged-address-abi.rst.
> +
> +When ``CONFIG_ARM64_MTE`` is selected and Memory Tagging Extension is
> +supported by the hardware, the kernel advertises the feature to
> +userspace via ``HWCAP2_MTE``.
> +
> +PROT_MTE
> +--------
> +
> +To access the allocation tags, a user process must enable the Tagged
> +memory attribute on an address range using a new ``prot`` flag for
> +``mmap()`` and ``mprotect()``:
> +
> +``PROT_MTE`` - Pages allow access to the MTE allocation tags.
> +
> +The allocation tag is set to 0 when such pages are first mapped in the
> +user address space and preserved on copy-on-write. ``MAP_SHARED`` is
> +supported and the allocation tags can be shared between processes.
> +
> +**Note**: ``PROT_MTE`` is only supported on ``MAP_ANONYMOUS`` and
> +RAM-based file mappings (``tmpfs``, ``memfd``). Passing it to other
> +types of mapping will result in ``-EINVAL`` returned by these system
> +calls.
> +
> +**Note**: The ``PROT_MTE`` flag (and corresponding memory type) cannot
> +be cleared by ``mprotect()``. If this is desirable, ``munmap()``
> +(followed by ``mmap()``) must be used.

Or mmap(addr, ..., MAP_FIXED) to "overwrite" the mapping. Maybe it's better to just 
say that a new mapping must be created.

> +
> +Tag Check Faults
> +----------------
> +
> +When ``PROT_MTE`` is enabled on an address range and a mismatch between
> +the logical and allocation tags occurs on access, there are three
> +configurable behaviours:
> +
> +- *Ignore* - This is the default mode. The CPU (and kernel) ignores the
> +  tag check fault.
> +
> +- *Synchronous* - The kernel raises a ``SIGSEGV`` synchronously, with
> +  ``.si_code = SEGV_MTESERR`` and ``.si_addr = <fault-address>``. The
> +  memory access is not performed.
> +
> +- *Asynchronous* - The kernel raises a ``SIGSEGV``, in the current
> +  thread, asynchronously following one or multiple tag check faults,
> +  with ``.si_code = SEGV_MTEAERR`` and ``.si_addr = 0``.
> +
> +**Note**: There are no *match-all* logical tags available for user
> +applications.
> +
> +The user can select the above modes, per thread, using the
> +``prctl(PR_SET_TAGGED_ADDR_CTRL, flags, 0, 0, 0)`` system call where
> +``flags`` contain one of the following values in the ``PR_MTE_TCF_MASK``
> +bit-field:
> +
> +- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults
> +- ``PR_MTE_TCF_SYNC``  - *Synchronous* tag check fault mode
> +- ``PR_MTE_TCF_ASYNC`` - *Asynchronous* tag check fault mode
> +
> +Tag checking can also be disabled for a user thread by setting the
> +``PSTATE.TCO`` bit with ``MSR TCO, #1``.
> +
> +**Note**: Signal handlers are always invoked with ``PSTATE.TCO = 0``,
> +irrespective of the interrupted context.
> +
> +**Note**: Kernel accesses to user memory (e.g. ``read()`` system call)
> +do not generate a tag check fault.
> +
> +Excluding Tags in the ``IRG``, ``ADDG`` and ``SUBG`` instructions
> +-----------------------------------------------------------------
> +
> +The architecture allows excluding certain tags to be randomly generated
> +via the ``GCR_EL1.Exclude`` register bit-field. This can be configured,
> +per thread, using the ``prctl(PR_SET_TAGGED_ADDR_CTRL, flags, 0, 0, 0)``
> +system call where ``flags`` contains the exclusion bitmap in the
> +``PR_MTE_EXCL_MASK`` bit-field.
> +
> +Example of correct usage
> +========================
> +
> +*MTE Example code*
> +
> +.. code-block:: c
> +
> +    /*
> +     * To be compiled with -march=armv8.5-a+memtag
> +     */
> +    #include <errno.h>
> +    #include <stdio.h>
> +    #include <stdlib.h>
> +    #include <unistd.h>
> +    #include <sys/auxv.h>
> +    #include <sys/mman.h>
> +    #include <sys/prctl.h>
> +
> +    /*
> +     * From arch/arm64/include/uapi/asm/hwcap.h
> +     */
> +    #define HWCAP2_MTE              (1 << 10)
> +
> +    /*
> +     * From arch/arm64/include/uapi/asm/mman.h
> +     */
> +    #define PROT_MTE                 0x20
> +
> +    /*
> +     * From include/uapi/linux/prctl.h
> +     */
> +    #define PR_SET_TAGGED_ADDR_CTRL 55
> +    #define PR_GET_TAGGED_ADDR_CTRL 56
> +    # define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
> +    # define PR_MTE_TCF_SHIFT       1
> +    # define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_EXCL_SHIFT      3
> +    # define PR_MTE_EXCL_MASK       (0xffffUL << PR_MTE_EXCL_SHIFT)
> +
> +    /*
> +     * Insert a random logical tag into the given pointer.
> +     */
> +    #define insert_random_tag(ptr) ({                       \
> +            __u64 __val;                                    \
> +            asm("irg %0, %1" : "=r" (__val) : "r" (ptr));   \
> +            __val;                                          \
> +    })
> +
> +    /*
> +     * Set the allocation tag on the destination address.
> +     */
> +    #define set_tag(tag, addr) do {                                 \
> +            asm volatile("stg %0, [%1]" : : "r" (tag), "r" (addr)); \

Since STG modifies the memory, "memory" should be added to the clobber list. 
`volatile` makes no difference since there's no output operand.

To simplify the example for people less familiar with MTE, I would also suggest for 
this macro to only take one argument, and use it for both operands of STG. The 
two-operand form is a relatively recent addition to the architecture, and using 
different operands is very rarely needed (especially in userspace).

Otherwise the documentation and example look good to me.

Kevin

> +    } while (0)
> +
> +    int main()
> +    {
> +            unsigned long *a;
> +            unsigned long page_sz = getpagesize();
> +            unsigned long hwcap2 = getauxval(AT_HWCAP2);
> +
> +            /* check if MTE is present */
> +            if (!(hwcap2 & HWCAP2_MTE))
> +                    return -1;
> +
> +            /*
> +             * Enable the tagged address ABI, synchronous MTE tag check faults and
> +             * exclude tag 0 from the randomly generated set.
> +             */
> +            if (prctl(PR_SET_TAGGED_ADDR_CTRL,
> +                      PR_TAGGED_ADDR_ENABLE | PR_MTE_TCF_SYNC | (1 << PR_MTE_EXCL_SHIFT),
> +                      0, 0, 0)) {
> +                    perror("prctl() failed");
> +                    return -1;
> +            }
> +
> +            a = mmap(0, page_sz, PROT_READ | PROT_WRITE,
> +                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +            if (a == MAP_FAILED) {
> +                    perror("mmap() failed");
> +                    return -1;
> +            }
> +
> +            /*
> +             * Enable MTE on the above anonymous mmap. The flag could be passed
> +             * directly to mmap() and skip this step.
> +             */
> +            if (mprotect(a, page_sz, PROT_READ | PROT_WRITE | PROT_MTE)) {
> +                    perror("mprotect() failed");
> +                    return -1;
> +            }
> +
> +            /* access with the default tag (0) */
> +            a[0] = 1;
> +            a[1] = 2;
> +
> +            printf("a[0] = %lu a[1] = %lu\n", a[0], a[1]);
> +
> +            /* set the logical and allocation tags */
> +            a = (unsigned long *)insert_random_tag(a);
> +            set_tag(a, a);
> +
> +            printf("%p\n", a);
> +
> +            /* non-zero tag access */
> +            a[0] = 3;
> +            printf("a[0] = %lu a[1] = %lu\n", a[0], a[1]);
> +
> +            /*
> +             * If MTE is enabled correctly the next instruction will generate an
> +             * exception.
> +             */
> +            printf("Expecting SIGSEGV...\n");
> +            a[2] = 0xdead;
> +
> +            /* this should not be printed in the PR_MTE_TCF_SYNC mode */
> +            printf("...done\n");
> +
> +            return 0;
> +    }

