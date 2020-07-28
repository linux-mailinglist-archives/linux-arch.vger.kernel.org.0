Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD6B230864
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgG1LIY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 07:08:24 -0400
Received: from foss.arm.com ([217.140.110.172]:32870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgG1LIY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 07:08:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 928591FB;
        Tue, 28 Jul 2020 04:08:23 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25A383F66E;
        Tue, 28 Jul 2020 04:08:22 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:08:12 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200728110758.GA21941@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727163634.GO7127@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 27, 2020 at 05:36:35PM +0100, Szabolcs Nagy wrote:
> The 07/15/2020 18:08, Catalin Marinas wrote:
> > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > 
> > Memory Tagging Extension (part of the ARMv8.5 Extensions) provides
> > a mechanism to detect the sources of memory related errors which
> > may be vulnerable to exploitation, including bounds violations,
> > use-after-free, use-after-return, use-out-of-scope and use before
> > initialization errors.
> > 
> > Add Memory Tagging Extension documentation for the arm64 linux
> > kernel support.
> > 
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> > 
> > Notes:
> >     v7:
> >     - Add information on ptrace() regset access (NT_ARM_TAGGED_ADDR_CTRL).
> >     
> >     v4:
> >     - Document behaviour of madvise(MADV_DONTNEED/MADV_FREE).
> >     - Document the initial process state on fork/execve.
> >     - Clarify when the kernel uaccess checks the tags.
> >     - Minor updates to the example code.
> >     - A few other minor clean-ups following review.
> >     
> >     v3:
> >     - Modify the uaccess checking conditions: only when the sync mode is
> >       selected by the user. In async mode, the kernel uaccesses are not
> >       checked.
> >     - Clarify that an include mask of 0 (exclude mask 0xffff) results in
> >       always generating tag 0.
> >     - Document the ptrace() interface.
> >     
> >     v2:
> >     - Documented the uaccess kernel tag checking mode.
> >     - Removed the BTI definitions from cpu-feature-registers.rst.
> >     - Removed the paragraph stating that MTE depends on the tagged address
> >       ABI (while the Kconfig entry does, there is no requirement for the
> >       user to enable both).
> >     - Changed the GCR_EL1.Exclude handling description following the change
> >       in the prctl() interface (include vs exclude mask).
> >     - Updated the example code.
> > 
> >  Documentation/arm64/cpu-feature-registers.rst |   2 +
> >  Documentation/arm64/elf_hwcaps.rst            |   4 +
> >  Documentation/arm64/index.rst                 |   1 +
> >  .../arm64/memory-tagging-extension.rst        | 305 ++++++++++++++++++
> >  4 files changed, 312 insertions(+)
> >  create mode 100644 Documentation/arm64/memory-tagging-extension.rst
> > 
> > diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> ...
> > +Tag Check Faults
> > +----------------
> > +
> > +When ``PROT_MTE`` is enabled on an address range and a mismatch between
> > +the logical and allocation tags occurs on access, there are three
> > +configurable behaviours:
> > +
> > +- *Ignore* - This is the default mode. The CPU (and kernel) ignores the
> > +  tag check fault.
> > +
> > +- *Synchronous* - The kernel raises a ``SIGSEGV`` synchronously, with
> > +  ``.si_code = SEGV_MTESERR`` and ``.si_addr = <fault-address>``. The
> > +  memory access is not performed. If ``SIGSEGV`` is ignored or blocked
> > +  by the offending thread, the containing process is terminated with a
> > +  ``coredump``.
> > +
> > +- *Asynchronous* - The kernel raises a ``SIGSEGV``, in the offending
> > +  thread, asynchronously following one or multiple tag check faults,
> > +  with ``.si_code = SEGV_MTEAERR`` and ``.si_addr = 0`` (the faulting
> > +  address is unknown).
> > +
> > +The user can select the above modes, per thread, using the
> > +``prctl(PR_SET_TAGGED_ADDR_CTRL, flags, 0, 0, 0)`` system call where
> > +``flags`` contain one of the following values in the ``PR_MTE_TCF_MASK``
> > +bit-field:
> > +
> > +- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults
> > +- ``PR_MTE_TCF_SYNC``  - *Synchronous* tag check fault mode
> > +- ``PR_MTE_TCF_ASYNC`` - *Asynchronous* tag check fault mode
> > +
> > +The current tag check fault mode can be read using the
> > +``prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0)`` system call.
> 
> we discussed the need for per process prctl off list, i will
> try to summarize the requirement here:
> 
> - it cannot be guaranteed in general that a library initializer
> or first call into a library happens when the process is still
> single threaded.
> 
> - user code currently has no way to call prctl in all threads of
> a process and even within the c runtime doing so is problematic
> (it has to signal all threads, which requires a reserved signal
> and dealing with exiting threads and signal masks, such mechanism
> can break qemu user and various other userspace tooling).

When working on the SVE support, I came to the conclusion that this
kind of thing would normally either be done by the runtime itself, or in
close cooperation with the runtime.  However, for SVE it never makes
sense for one thread to asynchronously change the vector length of
another thread -- that's different from the MTE situation.

> - we don't yet have defined contract in userspace about how user
> code may enable mte (i.e. use the prctl call), but it seems that
> there will be use cases for it: LD_PRELOADing malloc for heap
> tagging is one such case, but any library or custom allocator
> that wants to use mte will have this issue: when it enables mte
> it wants to enable it for all threads in the process. (or at
> least all threads managed by the c runtime).

What are the situations where we anticipate a need to twiddle MTE in
multiple threads simultaneously, other than during process startup?

> - even if user code is not allowed to call the prctl directly,
> i.e. the prctl settings are owned by the libc, there will be
> cases when the settings have to be changed in a multithreaded
> process (e.g. dlopening a library that requires a particular
> mte state).

Could be avoided by refusing to dlopen a library that is incompatible
with the current process.

dlopen()ing a library that doesn't support tagged addresses, in a
process that does use tagged addresses, seems undesirable even if tag
checking is currently turned off.


> a solution is to introduce a flag like SECCOMP_FILTER_FLAG_TSYNC
> that means the prctl is for all threads in the process not just
> for the current one. however the exact semantics is not obvious
> if there are inconsistent settings in different threads or user
> code tries to use the prctl concurrently: first checking then
> setting the mte state via separate prctl calls is racy. but if
> the userspace contract for enabling mte limits who and when can
> call the prctl then i think the simple sync flag approach works.
> 
> (the sync flag should apply to all prctl settings: tagged addr
> syscall abi, mte check fault mode, irg tag excludes. ideally it
> would work for getting the process wide state and it would fail
> in case of inconsistent settings.)

If going down this route, perhaps we could have sets of settings:
so for each setting we have a process-wide value and a per-thread
value, with defines rules about how they combine.

Since MTE is a debugging feature, we might be able to be less aggressive
about synchronisation than in the SECCOMP case.

> we may need to document some memory ordering details when
> memory accesses in other threads are affected, but i think
> that can be something simple that leaves it unspecified
> what happens with memory accesses that are not synchrnized
> with the prctl call.

Hmmm...

Cheers
---Dave
