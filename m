Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE521D2E7C
	for <lists+linux-arch@lfdr.de>; Thu, 14 May 2020 13:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgENLhc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 May 2020 07:37:32 -0400
Received: from foss.arm.com ([217.140.110.172]:34790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgENLhc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 May 2020 07:37:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FC171042;
        Thu, 14 May 2020 04:37:30 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1B483F305;
        Thu, 14 May 2020 04:37:28 -0700 (PDT)
Date:   Thu, 14 May 2020 12:37:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 23/23] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200514113722.GA1907@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-24-catalin.marinas@arm.com>
 <20200429164705.GF30377@arm.com>
 <20200430162316.GJ2717@gaia>
 <20200504164617.GK30377@arm.com>
 <20200511164018.GC19176@gaia>
 <20200513154845.GT21779@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513154845.GT21779@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 04:48:46PM +0100, Dave P Martin wrote:
> On Mon, May 11, 2020 at 05:40:19PM +0100, Catalin Marinas wrote:
> > On Mon, May 04, 2020 at 05:46:17PM +0100, Dave P Martin wrote:
> > > On Thu, Apr 30, 2020 at 05:23:17PM +0100, Catalin Marinas wrote:
> > > > On Wed, Apr 29, 2020 at 05:47:05PM +0100, Dave P Martin wrote:
> > > > > On Tue, Apr 21, 2020 at 03:26:03PM +0100, Catalin Marinas wrote:
> > > > > > +- *Asynchronous* - The kernel raises a ``SIGSEGV``, in the current
> > > > > > +  thread, asynchronously following one or multiple tag check faults,
> > > > > > +  with ``.si_code = SEGV_MTEAERR`` and ``.si_addr = 0``.
> > > > > 
> > > > > For "current thread": that's a kernel concept.  For user-facing
> > > > > documentation, can we say "the offending thread" or similar?
> > > > > 
> > > > > For clarity, it's worth saying that the faulting address is not
> > > > > reported.  Or, we could be optimistic that someday this information will
> > > > > be available and say that si_addr is the faulting address if available,
> > > > > with 0 meaning the address is not available.
> > > > > 
> > > > > Maybe (void *)-1 would be better duff address, but I can't see it
> > > > > mattering much.  If there's already precedent for si_addr==0 elsewhere,
> > > > > it makes sense to follow it.
> > > > 
> > > > At a quick grep, I can see a few instances on other architectures where
> > > > si_addr==0. I'll add a comment here.
> > > 
> > > OK, cool
> > > 
> > > Except: what if we're in PR_MTE_TCF_ASYNC mode.  If the SIGSEGV handler
> > > triggers an asynchronous MTE fault itself, we could then get into a
> > > spin.  Hmm.
[...]
> > > In that case, an asynchronous MTE fault pending at sigreturn must have
> > > been caused by the signal handler.  We could make that particular case
> > > of MTE_AERR a force_sig.
> > 
> > We clear the TIF flag when delivering the signal. I don't think there is
> > a way for the kernel to detect when it is running in a signal handler.
> > sigreturn() is not mandatory either.
> 
> I guess we can put up with this signal not being fatal then.
> 
> If you have a SEGV handler at all, you're supposed to code it carefully.
> 
> This brings us back to force_sig for SERR and a normal signal for AERR.
> That's probably OK.

I think we are in agreement now but please check the patches when I post
the v4.

> > > > > > +**Note**: Kernel accesses to user memory (e.g. ``read()`` system call)
> > > > > > +are only checked if the current thread tag checking mode is
> > > > > > +PR_MTE_TCF_SYNC.
> > > > > 
> > > > > Vague?  Can we make a precise statement about when the kernel will and
> > > > > won't check such accesses?  And aren't there limitations (like use of
> > > > > get_user_pages() etc.)?
> > > > 
> > > > We could make it slightly clearer by say "kernel accesses to the user
> > > > address space".
> > > 
> > > That's not the ambiguity.
> > > 
> > > My question is
> > > 
> > > 1) Does the kernel guarantee not to check tags on kernel accesses to
> > > user memory without PR_MTE_TCF_SYNC?
[...]
> > > 2) Does the kernel guarantee to check tags on kernel accesses to user
> > > memory with PR_MTE_TCF_SYNC?
[...]
> > > In practice, this note sounds to be more like a kernel implementation
> > > detail rather than advice to userspace.
> > > 
> > > Would it make sense to say something like:
> > > 
> > >  * PR_MTE_TCF_NONE: the kernel does not check tags for kernel accesses
> > >    to use memory done by syscalls in the thread.
> > > 
> > >  * PR_MTE_TCF_ASYNC: the kernel may check some tags for kernel accesses
> > >    to user memory done by syscalls.  (Should we guarantee that such
> > >    faults are reported synchronously on syscall exit?  In practice I
> > >    think they are.  Should we use SEGV_MTESERR in this case?  Perhaps
> > >    it's not worth making this a special case.)
> > 
> > Both NONE and ASYNC are now the same for kernel uaccess - not checked.
> >
> > For background information, I decided against ASYNC uaccess checking
> > since (1) there are some cases where the kernel overreads
> > (strncpy_from_user) and (2) we don't normally generate SIGSEGV on
> > uaccess but rather return -EFAULT. The latter is not possible to contain
> > since we only learn about the fault asynchronously, usually after the
> > transfer.
> 
> I may be missing something here.  Do we still rely on the hardware to
> detect tag mismatches in kernel accesses to user memory?  I was assuming
> we do some kind of explicit checking, but now I think that's nonsense
> (except for get_user_pages() etc.)

For synchronous tag checking, we expect the uaccess (via the user
address, e.g. copy_from_user()) to be checked by the hardware. If the
access happens via a kernel mapping (get_user_pages()), the access is
unchecked. There is no point in an explicit tag access+check from the
kernel since the get_user_pages() accesses are not expected to generate
faults anyway (once the pages have been returned). We also most likely
lost the actual user address at the point of access, so not easy to
infer the original tag.

> Since MTE is a new opt-in feature, I think we might have the option to
> report failures with SIGSEGV instead of -EFAULT.  This seems exactly to
> implement the concept of an asynchronous versus synchronous error. 

With synchronous checking, we return -EFAULT, smaller number of bytes
etc. since no/less data was copied. With async, the uaccess would
perform all the accesses, only that the user may get a SIGSEGV delivered
on return from the syscall.

> The kernel may not normally do this, but software usually doesn't use
> raw syscalls.  In reality "syscalls" can trigger a SIGSEGV in the libc
> wrapper anyway.  From the caller's point of view the whole thing is a
> black box.
> 
> Probably needs discussion with the bionic / glibc folks though (though
> likely this has been discussed already...)

The initial plan was to generate SIGSEGV on asynchronous faults for
uaccess (on syscall return). This changed when we noticed (in version 3
I think) that the kernel over-reads buffers in some cases
(strncpy_from_user(), copy_mount_options()) and triggers false
positives.

We could fix the above two cases, though in different ways:
strncpy_from_user() can align its source (user) address and would no
longer be expected to trigger a fault if the string is correctly tagged.
copy_mount_options(), OTOH, always reads 4K (not zero-terminated), so it
will trip over some tag mismatch. The workaround is to contain the async
tag check fault (with DSB before and after the access) and ignore it.

However, are these the only two cases where the kernel over-reads user
buffers? Without MTE, such faults on uaccess (page faults) were handled
by the kernel transparently. We may now start delivering SIGSEGV every
time some piece of uaccess kernel code changes and over-reads.

> My concern is that the spirit of asynchrous checking in the
> architecture is that accesses _are_ checked, and we seem to be
> breaking that principle here.

I agree with you on the principle but my concern is about the
practicality of chasing any future code changes and plugging potentially
fatal SIGSEGVs sent to the user.

Maybe we need a way to log this so that user (admin) can do something
about it like force synchronous. Or we could also toggle synchronous
uaccesses irrespective of the user mode or expose this option as a
prctl().

Also, do we want some big knob (sysctl) to force some of these modes for
all user processes: e.g. force-upgrade async to sync?

> > > > > > +excludes all tags other than 0. A user thread can enable specific tags
> > > > > > +in the randomly generated set using the ``prctl(PR_SET_TAGGED_ADDR_CTRL,
> > > > > > +flags, 0, 0, 0)`` system call where ``flags`` contains the tags bitmap
> > > > > > +in the ``PR_MTE_TAG_MASK`` bit-field.
> > > > > > +
> > > > > > +**Note**: The hardware uses an exclude mask but the ``prctl()``
> > > > > > +interface provides an include mask. An include mask of ``0`` (exclusion
> > > > > > +mask ``0xffff``) results in the CPU always generating tag ``0``.
> > > > > 
> > > > > Is there no way to make this default to 1 rather than having a magic
> > > > > meaning for 0?
> > > > 
> > > > We follow the hardware behaviour where 0xffff and 0xfffe give the same
> > > > result.
> > > 
> > > Exposing this through a purely software interface seems a bit odd:
> > > because the exclude mask is privileged-access-only, the architecture
> > > could amend it to assign a different meaning to 0xffff, providing this
> > > was an opt-in change.  Then we'd have to make a mess here.
> > 
> > You have a point. An include mask of 0 translates to an exclude mask of
> > 0xffff as per the current patches. If the hardware gains support for one
> > more bit (32 colours), old software running on new hardware may run into
> > unexpected results with an exclude mask of 0xffff.
> > 
> > > Can't we just forbid the nonsense value 0 here, or are there other
> > > reasons why that's problematic?
> > 
> > It was just easier to start with a default. I wonder whether we should
> > actually switch back to the exclude mask, as per the hardware
> > definition. This way 0 would mean all tags allowed. We can still
> > disallow 0xffff as an exclude mask.
[...]
> The only configuration that doesn't make sense is "no tags allowed", so
> I'd argue for explicity blocking that, even if the architeture aliases
> that encoding to something else.
> 
> If we prefer 0 as a default value so that init inherits the correct
> value from the kernel without any special acrobatics, then we make it an
> exclude mask, with the semantics that the hardware is allowed to
> generate any of these tags, but does not have to be capable of
> generating all of them.

That's more of a question to the libc people and their preference.
We have two options with suboptions:

1. prctl() gets an exclude mask with 0xffff illegal even though the
   hardware accepts it:
   a) default exclude mask 0, allowing all tags to be generated by IRG
   b) default exclude mask of 0xfffe so that only tag 0 is generated

2. prctl() gets an include mask with 0 illegal:
   a) default include mask is 0xffff, allowing all tags to be generated
   b) default include mask 0f 0x0001 so that only tag 0 is generated

We currently have (2) with mask 0 but could be changed to (2.b). If we
are to follow the hardware description (which makes more sense to me but
I don't write the C library), (1.a) is the most appropriate.

-- 
Catalin
