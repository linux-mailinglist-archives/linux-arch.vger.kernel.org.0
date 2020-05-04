Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95D91C4065
	for <lists+linux-arch@lfdr.de>; Mon,  4 May 2020 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgEDQqX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 May 2020 12:46:23 -0400
Received: from foss.arm.com ([217.140.110.172]:49016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgEDQqW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 May 2020 12:46:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69197101E;
        Mon,  4 May 2020 09:46:21 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF2F3F68F;
        Mon,  4 May 2020 09:46:19 -0700 (PDT)
Date:   Mon, 4 May 2020 17:46:17 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 23/23] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200504164617.GK30377@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-24-catalin.marinas@arm.com>
 <20200429164705.GF30377@arm.com>
 <20200430162316.GJ2717@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430162316.GJ2717@gaia>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 30, 2020 at 05:23:17PM +0100, Catalin Marinas wrote:
> On Wed, Apr 29, 2020 at 05:47:05PM +0100, Dave P Martin wrote:
> > On Tue, Apr 21, 2020 at 03:26:03PM +0100, Catalin Marinas wrote:
> > > +Userspace Support
> > > +=================
> > > +
> > > +When ``CONFIG_ARM64_MTE`` is selected and Memory Tagging Extension is
> > > +supported by the hardware, the kernel advertises the feature to
> > > +userspace via ``HWCAP2_MTE``.
> > > +
> > > +PROT_MTE
> > > +--------
> > > +
> > > +To access the allocation tags, a user process must enable the Tagged
> > > +memory attribute on an address range using a new ``prot`` flag for
> > > +``mmap()`` and ``mprotect()``:
> > > +
> > > +``PROT_MTE`` - Pages allow access to the MTE allocation tags.
> > > +
> > > +The allocation tag is set to 0 when such pages are first mapped in the
> > > +user address space and preserved on copy-on-write. ``MAP_SHARED`` is
> > > +supported and the allocation tags can be shared between processes.
> > > +
> > > +**Note**: ``PROT_MTE`` is only supported on ``MAP_ANONYMOUS`` and
> > > +RAM-based file mappings (``tmpfs``, ``memfd``). Passing it to other
> > > +types of mapping will result in ``-EINVAL`` returned by these system
> > > +calls.
> > > +
> > > +**Note**: The ``PROT_MTE`` flag (and corresponding memory type) cannot
> > > +be cleared by ``mprotect()``.
> > 
> > What enforces this?  I don't have my head fully around the code yet.
> > 
> > I'm wondering whether attempting to clear PROT_MTE should be reported as
> > an error.  Is there any rationale for not doing so?
> 
> A use-case is a JIT compiler where the memory is allocated by some
> malloc() code with PROT_MTE set and passed down to a code generator
> library which may not be MTE aware (and doesn't need to be, only tagged
> ptr aware). Such library, once it generated the code, may do an
> mprotect(PROT_READ|PROT_EXEC) without PROT_MTE. We didn't want to
> inadvertently clear PROT_MTE, especially if the memory will be given
> back to the original allocator (free) at some point.
> 
> Basically mprotect() may be done outside the heap allocator but it
> should not interfere with allocator's decision to use MTE. For this
> reason, I wouldn't report an error but silently ignore the lack of
> PROT_MTE.
> 
> The way we handle this is by not including VM_MTE in VM_ARCH_CLEAR
> (VM_MPX isn't either, though VM_SPARC_ADI is but when they added it, the
> syscall ABI didn't even accept tagged pointers).

OK, I think this makes sense.

For BTI, I think mprotect() will clear PROT_BTI unless it's included in
prot, but that's a bit different: PROT_BTI relates to the memory
contents (i.e., it's BTI-aware code), where PROT_MTE is a property of
the memory itself.

> > > +Tag Check Faults
> > > +----------------
> > > +
> > > +When ``PROT_MTE`` is enabled on an address range and a mismatch between
> > > +the logical and allocation tags occurs on access, there are three
> > > +configurable behaviours:
> > > +
> > > +- *Ignore* - This is the default mode. The CPU (and kernel) ignores the
> > > +  tag check fault.
> > > +
> > > +- *Synchronous* - The kernel raises a ``SIGSEGV`` synchronously, with
> > > +  ``.si_code = SEGV_MTESERR`` and ``.si_addr = <fault-address>``. The
> > > +  memory access is not performed.
> > 
> > Also say that if in this case, if SIGSEGV is ignored or blocked by the
> > offending thread then containing processes is terminated with a coredump
> > (at least, that's what ought to happen).
> 
> Makes sense.
> 
> > > +
> > > +- *Asynchronous* - The kernel raises a ``SIGSEGV``, in the current
> > > +  thread, asynchronously following one or multiple tag check faults,
> > > +  with ``.si_code = SEGV_MTEAERR`` and ``.si_addr = 0``.
> > 
> > For "current thread": that's a kernel concept.  For user-facing
> > documentation, can we say "the offending thread" or similar?
> > 
> > For clarity, it's worth saying that the faulting address is not
> > reported.  Or, we could be optimistic that someday this information will
> > be available and say that si_addr is the faulting address if available,
> > with 0 meaning the address is not available.
> > 
> > Maybe (void *)-1 would be better duff address, but I can't see it
> > mattering much.  If there's already precedent for si_addr==0 elsewhere,
> > it makes sense to follow it.
> 
> At a quick grep, I can see a few instances on other architectures where
> si_addr==0. I'll add a comment here.

OK, cool

Except: what if we're in PR_MTE_TCF_ASYNC mode.  If the SIGSEGV handler
triggers an asynchronous MTE fault itself, we could then get into a
spin.  Hmm.

I take it we drain any pending MTE faults when crossing EL boundaries?
In that case, an asynchronous MTE fault pending at sigreturn must have
been caused by the signal handler.  We could make that particular case
of MTE_AERR a force_sig.

> If the hardware gives us something in the future, it will likely be in a
> separate register and we can present it as a new sigcontext structure.
> In the meantime I'll add a some text that the faulting address is
> unknown.

I guess we can decide that later.  I think that if we can put something
sensible in si_addr we should do so, but that doesn't stop us also
putting more detailed info somewhere else.

> 
> > > +**Note**: There are no *match-all* logical tags available for user
> > > +applications.
> > 
> > This note seems misplaced.
> 
> This was in the context of tag checking. I'll move it further down when
> talking about PSTATE.TCO.

OK

> > > +
> > > +The user can select the above modes, per thread, using the
> > > +``prctl(PR_SET_TAGGED_ADDR_CTRL, flags, 0, 0, 0)`` system call where
> > 
> > PR_GET_TAGGED_ADDR_CTRL seems to be missing here.
> 
> Added.
> 
> > > +``flags`` contain one of the following values in the ``PR_MTE_TCF_MASK``
> > > +bit-field:
> > > +
> > > +- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults
> > > +- ``PR_MTE_TCF_SYNC``  - *Synchronous* tag check fault mode
> > > +- ``PR_MTE_TCF_ASYNC`` - *Asynchronous* tag check fault mode
> > 
> > Done naively, this will destroy the PR_MTE_TAG_MASK field.  Is there a
> > preferred way to change only parts of this control word?  If the answer
> > is "cache the value in userspace if you care about performance, or
> > otherwise use PR_GET_TAGGED_ADDR_CTRL as part of a read-modify-write,"
> > so be it.
> > 
> > If we think this might be an issue for software, it might be worth
> > splitting out separate prctls for each field.)
> 
> We lack some feedback from user space people on how this prctl is going
> to be used. I worked on the assumption that it is a one-off event during
> libc setup, potentially driven by some environment variable (but that's
> user's problem).
> 
> There were some suggestions that on an async SIGSEGV, the handler may
> switch to synchronous mode. Since that's a rare event, a get/set
> approach would be fine.
> 
> Anyway, with an additional argument to prctl (we have 3 spare), we could
> do a set/clear mask approach. The current behaviour could be emulated
> as:
> 
>   prctl(PR_SET_TAGGED_ADDR_CTRL, PR_MTE_bits, -1UL, 0, 0);
> 
> where -1 is the clear mask. The mask can be 0 for the initial prctl() or
> we can say that if the mask is non-zero, only the bits in the mask will
> be set.
> 
> If you want to only set the TCF bits:
> 
>   prctl(PR_SET_TAGGED_ADDR_CTRL, PR_MTE_TCF_SYNC, PR_MTE_TCF_MASK, 0, 0);

If this isn't critical path, I guess it's not a big deal either way.

If we make that mask argument an mask of bits _not_ to change than we
can add it as a backwards compatible extension later on without having
to define it now.  As you suggest, it may never matter.

So, I don't object to this staying as-is.

> > > +Tag checking can also be disabled for a user thread by setting the
> > > +``PSTATE.TCO`` bit with ``MSR TCO, #1``.
> > 
> > Users should probably not touch this unless they know what they're
> > doing -- should this flag ever be left set across function boundaries
> > etc.?
> 
> We can't control function boundaries from the kernel anyway.
> 
> > What's it for?  Temporarily masking MTE faults in critical sections?
> > Is this self-synchronising... what happens to pending asynchronous
> > faults?  Are faults occurring while the flag is set pended or discarded?
> 
> Something like a garbage collector scanning the memory. Since we do not
> allow tag 0 as a match-all, it needs a cheaper option than prctl().
> 
> > > +**Note**: Signal handlers are always invoked with ``PSTATE.TCO = 0``,
> > > +irrespective of the interrupted context.
> > 
> > Rationale?  Do we have advice on what signal handlers should do?
> 
> Well, that's the default mode - tag check override = 0, it means that
> tag checking takes place.

Sort of implies that a SIGSEGV handler must be careful not to trigger
any more faults.  But I guess that's nothing new.

> 
> > Is PSTATE.TC0 restored by sigreturn?
> 
> s/TC0/TCO/
> 
> Yes, it is restored on sigreturn.

OK.  I think it's worth mentioning (does no harm, anyway).

> 
> > > +**Note**: Kernel accesses to user memory (e.g. ``read()`` system call)
> > > +are only checked if the current thread tag checking mode is
> > > +PR_MTE_TCF_SYNC.
> > 
> > Vague?  Can we make a precise statement about when the kernel will and
> > won't check such accesses?  And aren't there limitations (like use of
> > get_user_pages() etc.)?
> 
> We could make it slightly clearer by say "kernel accesses to the user
> address space".

That's not the ambiguity.

My question is

1) Does the kernel guarantee not to check tags on kernel accesses to user memory without PR_MTE_TCF_SYNC?

2) Does the kernel guarantee to check tags on kernel accesses to user memory with PR_MTE_TCF_SYNC?


In practice, this note sounds to be more like a kernel implementation
detail rather than advice to userspace.

Would it make sense to say something like:

 * PR_MTE_TCF_NONE: the kernel does not check tags for kernel accesses
   to use memory done by syscalls in the thread.

 * PR_MTE_TCF_ASYNC: the kernel may check some tags for kernel accesses
   to user memory done by syscalls.  (Should we guarantee that such
   faults are reported synchronously on syscall exit?  In practice I
   think they are.  Should we use SEGV_MTESERR in this case?  Perhaps
   it's not worth making this a special case.)
   
 * PR_MTE_TCF_SYNC: the kernel makes best efforts to check tags for
   kernel accesses to user memory done by the syscalls, but does not
   guarantee to check everything (or does it?  I thought we can't really
   do that for some odd cases...)

> > > +Excluding Tags in the ``IRG``, ``ADDG`` and ``SUBG`` instructions
> > > +-----------------------------------------------------------------
> > > +
> > > +The architecture allows excluding certain tags to be randomly generated
> > > +via the ``GCR_EL1.Exclude`` register bit-field. By default, Linux
> > 
> > Can we have a separate section on what execve() and fork()/clone() do
> > to the MTE controls and PSTATE.TCO?  "By default" could mean a variety
> > of things, and I'm not sure we cover everything.
> 
> Good point. I'll add a note on initial state for processes and threads.
> 
> > Is PROT_MTE ever set on the initial pages mapped by execve()?
> 
> No. There were discussions about mapping the initial stack with PROT_MTE
> based on some ELF note but it can also be done in userspace with
> mprotect(). I think we concluded that the .data/.bss sections will be
> untagged.

Yes, I recall.  Sounds fine: probably worth mentioning here that
PROT_MTE is never set on the exec mappings for now.

> > > +excludes all tags other than 0. A user thread can enable specific tags
> > > +in the randomly generated set using the ``prctl(PR_SET_TAGGED_ADDR_CTRL,
> > > +flags, 0, 0, 0)`` system call where ``flags`` contains the tags bitmap
> > > +in the ``PR_MTE_TAG_MASK`` bit-field.
> > > +
> > > +**Note**: The hardware uses an exclude mask but the ``prctl()``
> > > +interface provides an include mask. An include mask of ``0`` (exclusion
> > > +mask ``0xffff``) results in the CPU always generating tag ``0``.
> > 
> > Is there no way to make this default to 1 rather than having a magic
> > meaning for 0?
> 
> We follow the hardware behaviour where 0xffff and 0xfffe give the same
> result.

Exposing this through a purely software interface seems a bit odd:
because the exclude mask is privileged-access-only, the architecture
could amend it to assign a different meaning to 0xffff, providing this
was an opt-in change.  Then we'd have to make a mess here.

Can't we just forbid the nonsense value 0 here, or are there other
reasons why that's problematic?

I presume the architecture defines a meaning for 0 to avoid making
it UNPREDICTABLE etc., not because this is deemed useful.

> > > +The ``ptrace()`` interface
> > > +--------------------------
> > > +
> > > +``PTRACE_PEEKMTETAGS`` and ``PTRACE_POKEMTETAGS`` allow a tracer to read
> > > +the tags from or set the tags to a tracee's address space. The
> > > +``ptrace()`` syscall is invoked as ``ptrace(request, pid, addr, data)``
> > > +where:
> > > +
> > > +- ``request`` - one of ``PTRACE_PEEKMTETAGS`` or ``PTRACE_PEEKMTETAGS``.
> > > +- ``pid`` - the tracee's PID.
> > > +- ``addr`` - address in the tracee's address space.
> > 
> > What if addr is not 16-byte aligned?  Is this considered valid use?
> 
> Yes, I don't think we should impose a restriction here. Each address in
> a 16-byte range has the same (shared) tag.

OK.  We might want to clarify what this means when addr is misaligned:
we do not colour the 16 bytes starting at addr, but the reader might
assume that's what happens.

> > > +- ``data`` - pointer to a ``struct iovec`` where ``iov_base`` points to
> > > +  a buffer of ``iov_len`` length in the tracer's address space.
> > 
> > What's the data format for the copied tags?
> 
> I could state that the tag are placed in the lower 4-bit of the byte
> with the upper 4-bit set to 0.

What if it's not?  I didn't find this in the architecture spec, but I
didn't look very hard so far...

> > > +The tags in the tracer's ``iov_base`` buffer are represented as one tag
> > > +per byte and correspond to a 16-byte MTE tag granule in the tracee's
> > > +address space.
> > 
> > We could say that the whole operation accesses the tags for 16 * iov_len
> > bytes of the tracee's address space.  Maybe superfluous though.
> > 
> > > +
> > > +``ptrace()`` return value:
> > > +
> > > +- 0 - success, the tracer's ``iov_len`` was updated to the number of
> > > +  tags copied (it may be smaller than the requested ``iov_len`` if the
> > > +  requested address range in the tracee's or the tracer's space cannot
> > > +  be fully accessed).
> > 
> > I'd replace "success" with something like "some tags were copied:
> > ``iov_len`` is updated to indicate the actual number of tags
> > transferred.  This may be fewer than requested: [...]"
> > 
> > Can we get a short PEEKTAGS/POKETAGS for transient reasons (like minor
> > page faults)?  i.e., should the caller attempt to retry, or is that a
> > a stupid thing to do?
> 
> I initially thought it should retry but managed to get the interface so
> that no retries are needed. If fewer tags were transferred, it's for a
> good reason (e.g. permission fault).

OK, we should mention that here then.  Software that retries things that
can't make progress can get stuck in a loop (or at least waste cycles).

> > > +            a = mmap(0, page_sz, PROT_READ | PROT_WRITE,
> > > +                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > 
> > Is this a vaild assignment?
> > 
> > I can't remember whether C's "pointer values must be correctly aligned"
> > rule applies only to dereferences, or whether it applies to conversions
> > too.  From memory I have a feeling that it does.
> > 
> > If so, the compiler could legimitately optimise the failure check away,
> > since MAP_FAILED is not correctly aligned for unsigned long.
> 
> I'm not going to dig into standards ;). I can change this to an unsigned
> char *.

Sure, I guess that solves the problem.

Something like

	void *p;
	unsigned long *a;

	p = mmap( ... );
	if (p == MAP_FAILED) {
		/* barf */
	}

	a = p;

might provide a clue that care is needed, but it's not essential.

> 
> > > +            printf("Expecting SIGSEGV...\n");
> > > +            a[2] = 0xdead;
> > > +
> > > +            /* this should not be printed in the PR_MTE_TCF_SYNC mode */
> > > +            printf("...done\n");
> > > +
> > > +            return 0;
> > > +    }
> > 
> > Since this shouldn't happen, can we print an error and return nonzero?
> 
> Fair enough. I also agree with the other points you raised but to which
> I haven't explicitly commented.
> 
> Thanks for the review, really useful.

Np

Cheers
---Dave
