Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0171BE435
	for <lists+linux-arch@lfdr.de>; Wed, 29 Apr 2020 18:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD2QrL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Apr 2020 12:47:11 -0400
Received: from foss.arm.com ([217.140.110.172]:42096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2QrK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Apr 2020 12:47:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 573041045;
        Wed, 29 Apr 2020 09:47:09 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C83D13F73D;
        Wed, 29 Apr 2020 09:47:07 -0700 (PDT)
Date:   Wed, 29 Apr 2020 17:47:05 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 23/23] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200429164705.GF30377@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-24-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421142603.3894-24-catalin.marinas@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 03:26:03PM +0100, Catalin Marinas wrote:
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
> Cc: Will Deacon <will@kernel.org>
> ---
> 
> Notes:
>     v3:
>     - Modify the uaccess checking conditions: only when the sync mode is
>       selected by the user. In async mode, the kernel uaccesses are not
>       checked.
>     - Clarify that an include mask of 0 (exclude mask 0xffff) results in
>       always generating tag 0.
>     - Document the ptrace() interface.
>     
>     v2:
>     - Documented the uaccess kernel tag checking mode.
>     - Removed the BTI definitions from cpu-feature-registers.rst.
>     - Removed the paragraph stating that MTE depends on the tagged address
>       ABI (while the Kconfig entry does, there is no requirement for the
>       user to enable both).
>     - Changed the GCR_EL1.Exclude handling description following the change
>       in the prctl() interface (include vs exclude mask).
>     - Updated the example code.
> 
>  Documentation/arm64/cpu-feature-registers.rst |   2 +
>  Documentation/arm64/elf_hwcaps.rst            |   5 +
>  Documentation/arm64/index.rst                 |   1 +
>  .../arm64/memory-tagging-extension.rst        | 260 ++++++++++++++++++
>  4 files changed, 268 insertions(+)
>  create mode 100644 Documentation/arm64/memory-tagging-extension.rst
> 
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> index 41937a8091aa..b5679fa85ad9 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -174,6 +174,8 @@ infrastructure:
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
>       +------------------------------+---------+---------+
> +     | MTE                          | [11-8]  |    y    |
> +     +------------------------------+---------+---------+
>       | SSBS                         | [7-4]   |    y    |
>       +------------------------------+---------+---------+
>  
> diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> index 7dfb97dfe416..ca7f90e99e3a 100644
> --- a/Documentation/arm64/elf_hwcaps.rst
> +++ b/Documentation/arm64/elf_hwcaps.rst
> @@ -236,6 +236,11 @@ HWCAP2_RNG
>  
>      Functionality implied by ID_AA64ISAR0_EL1.RNDR == 0b0001.
>  
> +HWCAP2_MTE
> +
> +    Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
> +    by Documentation/arm64/memory-tagging-extension.rst.
> +
>  4. Unused AT_HWCAP bits
>  -----------------------
>  
> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> index 09cbb4ed2237..4cd0e696f064 100644
> --- a/Documentation/arm64/index.rst
> +++ b/Documentation/arm64/index.rst
> @@ -14,6 +14,7 @@ ARM64 Architecture
>      hugetlbpage
>      legacy_instructions
>      memory
> +    memory-tagging-extension
>      pointer-authentication
>      silicon-errata
>      sve
> diff --git a/Documentation/arm64/memory-tagging-extension.rst b/Documentation/arm64/memory-tagging-extension.rst
> new file mode 100644
> index 000000000000..f82dfbd70061
> --- /dev/null
> +++ b/Documentation/arm64/memory-tagging-extension.rst
> @@ -0,0 +1,260 @@
> +===============================================
> +Memory Tagging Extension (MTE) in AArch64 Linux
> +===============================================
> +
> +Authors: Vincenzo Frascino <vincenzo.frascino@arm.com>
> +         Catalin Marinas <catalin.marinas@arm.com>
> +
> +Date: 2020-02-25
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
> +be cleared by ``mprotect()``.

What enforces this?  I don't have my head fully around the code yet.

I'm wondering whether attempting to clear PROT_MTE should be reported as
an error.  Is there any rationale for not doing so?


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

Also say that if in this case, if SIGSEGV is ignored or blocked by the
offending thread then containing processes is terminated with a coredump
(at least, that's what ought to happen).

> +
> +- *Asynchronous* - The kernel raises a ``SIGSEGV``, in the current
> +  thread, asynchronously following one or multiple tag check faults,
> +  with ``.si_code = SEGV_MTEAERR`` and ``.si_addr = 0``.

For "current thread": that's a kernel concept.  For user-facing
documentation, can we say "the offending thread" or similar?

For clarity, it's worth saying that the faulting address is not
reported.  Or, we could be optimistic that someday this information will
be available and say that si_addr is the faulting address if available,
with 0 meaning the address is not available.

Maybe (void *)-1 would be better duff address, but I can't see it
mattering much.  If there's already precedent for si_addr==0 elsewhere,
it makes sense to follow it.

> +
> +**Note**: There are no *match-all* logical tags available for user
> +applications.

This note seems misplaced.

> +
> +The user can select the above modes, per thread, using the
> +``prctl(PR_SET_TAGGED_ADDR_CTRL, flags, 0, 0, 0)`` system call where

PR_GET_TAGGED_ADDR_CTRL seems to be missing here.

> +``flags`` contain one of the following values in the ``PR_MTE_TCF_MASK``
> +bit-field:
> +
> +- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults
> +- ``PR_MTE_TCF_SYNC``  - *Synchronous* tag check fault mode
> +- ``PR_MTE_TCF_ASYNC`` - *Asynchronous* tag check fault mode

Done naively, this will destroy the PR_MTE_TAG_MASK field.  Is there a
preferred way to change only parts of this control word?  If the answer
is "cache the value in userspace if you care about performance, or
otherwise use PR_GET_TAGGED_ADDR_CTRL as part of a read-modify-write,"
so be it.

If we think this might be an issue for software, it might be worth
splitting out separate prctls for each field.)

> +
> +Tag checking can also be disabled for a user thread by setting the
> +``PSTATE.TCO`` bit with ``MSR TCO, #1``.

Users should probably not touch this unless they know what they're
doing -- should this flag ever be left set across function boundaries
etc.?

What's it for?  Temporarily masking MTE faults in critical sections?
Is this self-synchronising... what happens to pending asynchronous
faults?  Are faults occurring while the flag is set pended or discarded?

(Deliberately not reading the spec here -- if the explanation is not
straightforward, then it may be sufficient to tell people to go read
it.)

> +
> +**Note**: Signal handlers are always invoked with ``PSTATE.TCO = 0``,
> +irrespective of the interrupted context.

Rationale?  Do we have advice on what signal handlers should do?

Is PSTATE.TC0 restored by sigreturn?

> +
> +**Note**: Kernel accesses to user memory (e.g. ``read()`` system call)
> +are only checked if the current thread tag checking mode is
> +PR_MTE_TCF_SYNC.

Vague?  Can we make a precise statement about when the kernel will and
won't check such accesses?  And aren't there limitations (like use of
get_user_pages() etc.)?

> +
> +Excluding Tags in the ``IRG``, ``ADDG`` and ``SUBG`` instructions
> +-----------------------------------------------------------------
> +
> +The architecture allows excluding certain tags to be randomly generated
> +via the ``GCR_EL1.Exclude`` register bit-field. By default, Linux

Can we have a separate section on what execve() and fork()/clone() do
to the MTE controls and PSTATE.TCO?  "By default" could mean a variety
of things, and I'm not sure we cover everything.

Is PROT_MTE ever set on the initial pages mapped by execve()?

> +excludes all tags other than 0. A user thread can enable specific tags
> +in the randomly generated set using the ``prctl(PR_SET_TAGGED_ADDR_CTRL,
> +flags, 0, 0, 0)`` system call where ``flags`` contains the tags bitmap
> +in the ``PR_MTE_TAG_MASK`` bit-field.
> +
> +**Note**: The hardware uses an exclude mask but the ``prctl()``
> +interface provides an include mask. An include mask of ``0`` (exclusion
> +mask ``0xffff``) results in the CPU always generating tag ``0``.

Is there no way to make this default to 1 rather than having a magic
meaning for 0?

> +
> +The ``ptrace()`` interface
> +--------------------------
> +
> +``PTRACE_PEEKMTETAGS`` and ``PTRACE_POKEMTETAGS`` allow a tracer to read
> +the tags from or set the tags to a tracee's address space. The
> +``ptrace()`` syscall is invoked as ``ptrace(request, pid, addr, data)``
> +where:
> +
> +- ``request`` - one of ``PTRACE_PEEKMTETAGS`` or ``PTRACE_PEEKMTETAGS``.
> +- ``pid`` - the tracee's PID.
> +- ``addr`` - address in the tracee's address space.

What if addr is not 16-byte aligned?  Is this considered valid use?

> +- ``data`` - pointer to a ``struct iovec`` where ``iov_base`` points to
> +  a buffer of ``iov_len`` length in the tracer's address space.

What's the data format for the copied tags?

> +
> +The tags in the tracer's ``iov_base`` buffer are represented as one tag
> +per byte and correspond to a 16-byte MTE tag granule in the tracee's
> +address space.

We could say that the whole operation accesses the tags for 16 * iov_len
bytes of the tracee's address space.  Maybe superfluous though.

> +
> +``ptrace()`` return value:
> +
> +- 0 - success, the tracer's ``iov_len`` was updated to the number of
> +  tags copied (it may be smaller than the requested ``iov_len`` if the
> +  requested address range in the tracee's or the tracer's space cannot
> +  be fully accessed).

I'd replace "success" with something like "some tags were copied:
``iov_len`` is updated to indicate the actual number of tags
transferred.  This may be fewer than requested: [...]"

Can we get a short PEEKTAGS/POKETAGS for transient reasons (like minor
page faults)?  i.e., should the caller attempt to retry, or is that a
a stupid thing to do?

> +- ``-EPERM`` - the specified process cannot be traced.
> +- ``-EIO`` - the tracee's address range cannot be accessed (e.g. invalid
> +  address) and no tags copied. ``iov_len`` not updated.
> +- ``-EFAULT`` - fault on accessing the tracer's memory (``struct iovec``
> +  or ``iov_base`` buffer) and no tags copied. ``iov_len`` not updated.
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
> +    #define HWCAP2_MTE              (1 << 18)
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
> +    # define PR_MTE_TAG_SHIFT       3
> +    # define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
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
> +    #define set_tag(tagged_addr) do {                                      \
> +            asm volatile("stg %0, [%0]" : : "r" (tagged_addr) : "memory"); \
> +    } while (0)
> +
> +    int main()
> +    {
> +            unsigned long *a;
> +            unsigned long page_sz = getpagesize();

Nit: obsolete in POSIX.  Prefer sysconf(_SC_PAGESIZE).

> +            unsigned long hwcap2 = getauxval(AT_HWCAP2);
> +
> +            /* check if MTE is present */
> +            if (!(hwcap2 & HWCAP2_MTE))
> +                    return -1;

Nit: -1 isn't a valid exit code, so it's preferable to return 1 or
EXIT_FAILURE.

> +
> +            /*
> +             * Enable the tagged address ABI, synchronous MTE tag check faults and
> +             * allow all non-zero tags in the randomly generated set.
> +             */
> +            if (prctl(PR_SET_TAGGED_ADDR_CTRL,
> +                      PR_TAGGED_ADDR_ENABLE | PR_MTE_TCF_SYNC | (0xfffe << PR_MTE_TAG_SHIFT),
> +                      0, 0, 0)) {
> +                    perror("prctl() failed");
> +                    return -1;
> +            }
> +
> +            a = mmap(0, page_sz, PROT_READ | PROT_WRITE,
> +                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

Is this a vaild assignment?

I can't remember whether C's "pointer values must be correctly aligned"
rule applies only to dereferences, or whether it applies to conversions
too.  From memory I have a feeling that it does.

If so, the compiler could legimitately optimise the failure check away,
since MAP_FAILED is not correctly aligned for unsigned long.

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
> +            set_tag(a);
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

Since this shouldn't happen, can we print an error and return nonzero?

[...]

Cheers
---Dave
