Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B5D20B40A
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 16:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgFZOyr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 10:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFZOyr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Jun 2020 10:54:47 -0400
Received: from gaia (unknown [2.26.170.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB3C20775;
        Fri, 26 Jun 2020 14:54:43 +0000 (UTC)
Date:   Fri, 26 Jun 2020 15:54:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Earnshaw <rearnsha@arm.com>, libc-alpha@sourceware.org,
        nd@arm.com
Subject: Re: [PATCH v5 25/25] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200626145439.GB25805@gaia>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-26-catalin.marinas@arm.com>
 <20200625122216.GJ16726@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625122216.GJ16726@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Szabolcs,

On Thu, Jun 25, 2020 at 01:22:17PM +0100, Szabolcs Nagy wrote:
> The 06/24/2020 18:52, Catalin Marinas wrote:
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
> > Cc: Will Deacon <will@kernel.org>
> 
> there are are still libc side discussions, but the
> linux abi looks ok to me from user space pov.
> i'm adding libc-alpha on cc, the patch set is e.g. at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2020-June/579787.html
> 
> Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>

Thanks for the review. If there are any ABI changes required as a result
of the libc-alpha discussions, please let me know.

> > +PROT_MTE
> > +--------
> > +
> > +To access the allocation tags, a user process must enable the Tagged
> > +memory attribute on an address range using a new ``prot`` flag for
> > +``mmap()`` and ``mprotect()``:
> > +
> > +``PROT_MTE`` - Pages allow access to the MTE allocation tags.
> > +
> > +The allocation tag is set to 0 when such pages are first mapped in the
> > +user address space and preserved on copy-on-write. ``MAP_SHARED`` is
> > +supported and the allocation tags can be shared between processes.
> > +
> > +**Note**: ``PROT_MTE`` is only supported on ``MAP_ANONYMOUS`` and
> > +RAM-based file mappings (``tmpfs``, ``memfd``). Passing it to other
> > +types of mapping will result in ``-EINVAL`` returned by these system
> > +calls.
> > +
> > +**Note**: The ``PROT_MTE`` flag (and corresponding memory type) cannot
> > +be cleared by ``mprotect()``.
> > +
> > +**Note**: ``madvise()`` memory ranges with ``MADV_DONTNEED`` and
> > +``MADV_FREE`` may have the allocation tags cleared (set to 0) at any
> > +point after the system call.
> 
> OK.
> 
> I expect in the future to have a way to query the
> PROT_MTE status of mappings (e.g. via /proc/self).

Currently you can do this via /proc/<pid>/smaps.

> The MAP_SHARED behaviour is not entirely clear here
> but i guess it's possible to have PROT_MTE in one
> process and no PROT_MTE in others on the same mapping.

Yes, it is.

> then allocation tags only affect the process where
> PROT_MTE was used, later on another process may set
> PROT_MTE and then the shared allocation tags affect
> that process too.

Yes. Since PROT_MTE allows access to the allocation tags, each process
can control it independently.

> The madvise behaviour looks a bit risky from user
> space pov since now it's not just the memory content
> that can disappear after a MADV_DONTNEED, but pointer
> to that memory can become invalid too. but i think
> this is OK: in libc we will have to say that madvise
> on memory returned by malloc is not valid.

From a kernel perspective, it never returned a tagged pointer on mmap(),
so reverting the allocation tag to 0 is fine. I don't really have a
better solution here other than not calling madvise() on malloc'ed
memory.

A more invasive option may be to return tagged pointers on mmap() and
guarantee that the libc will not change them. A subsequent access on
DONTNEED memory would restore the original colour.

> As noted before, this design is not ideal for stack
> tagging (mprotecting the initial stack with PROT_MTE
> may be problematic if we don't know the bounds),

I don't think you need the bounds (with PROT_GROWSDOWN). Maybe the upper
one but functions up the call chain should not use stack tagging anyway.

> but
> the expectation is to introduce some ELF marking and
> then linux can just start the process with PROT_MTE
> stack if the dynamic linker has the marking. Same for
> the brk area (default PROT_MTE based on ELF marking).

This should work. Since stack tagging cannot use instructions in the NOP
space anyway and the program needs recompiling, having an ELF marking
would help (for heap tagging, you only need to change the libc and
dynamic loader). I think we do similar checks for BTI.

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
> > +
> > +Tag checking can also be disabled for a user thread by setting the
> > +``PSTATE.TCO`` bit with ``MSR TCO, #1``.
> > +
> > +**Note**: Signal handlers are always invoked with ``PSTATE.TCO = 0``,
> > +irrespective of the interrupted context. ``PSTATE.TCO`` is restored on
> > +``sigreturn()``.
> > +
> > +**Note**: There are no *match-all* logical tags available for user
> > +applications.
> > +
> > +**Note**: Kernel accesses to the user address space (e.g. ``read()``
> > +system call) are not checked if the user thread tag checking mode is
> > +``PR_MTE_TCF_NONE`` or ``PR_MTE_TCF_ASYNC``. If the tag checking mode is
> > +``PR_MTE_TCF_SYNC``, the kernel makes a best effort to check its user
> > +address accesses, however it cannot always guarantee it.
> 
> OK.
> 
> i know the kernel likes to operate on os-threads,
> but in userspace this causes the slight wart that if
> somebody wants to use heap tagging with LD_PRELOADed
> malloc and the first malloc is called after a thread
> is already created then the malloc implementation
> cannot set up the prctl right for all threads in the
> process.

Ah, so you can't have a constructor called with LD_PRELOAD.

> (for userspace i think it is only useful to
> allow threads with different MTE settings if there
> are some threads in a process that are not managed by
> the c runtime and don't call into libc, so as far as
> normal c code is concerned a per process setting
> would be nicer).

My assumption was that the c runtime would set this up and all threads
inherit the initial configuration. How important is the LD_PRELOAD
use-case?

The slight trouble with having this setting global is synchronising all
the threads. Maybe if we only allow single global configuration (rather
than having the option of per-thread and global), user-space could force
the synchronisation with something like membarrier().

> for interposers the workaround is
> to interpose thread creating libc apis, which is not
> perfect (libc internally may create threads in not
> interposable ways e.g. for implementing aio and then
> use heap memory in such threads), but i think early
> threads before an LD_PRELOAD initializer may run is
> not a common scenario and this type of MTE usage is
> for debugging, i.e. does not have to be perfect.

Feedback welcome, both from the glibc and the bionic/Android camps.

> as noted before (i think by Kevin) it would be nice
> to query the tag check status of other threads e.g.
> via a /proc/ thing (but i don't see an immediate need
> for this other than debugging MTE faults).

I have a plan to add some information in /proc/<pid>/status at some
point.

-- 
Catalin
