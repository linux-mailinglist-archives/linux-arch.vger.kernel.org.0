Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7C285037
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 18:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJFQz3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 12:55:29 -0400
Received: from foss.arm.com ([217.140.110.172]:52230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgJFQz1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Oct 2020 12:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42096D6E;
        Tue,  6 Oct 2020 09:55:25 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 453E53F66B;
        Tue,  6 Oct 2020 09:55:23 -0700 (PDT)
Date:   Tue, 6 Oct 2020 17:55:20 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] x86: Improve Minimum Alternate Stack Size
Message-ID: <20201006165520.GA6642@arm.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
 <20201005134534.GT6642@arm.com>
 <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
 <20201006092532.GU6642@arm.com>
 <CAMe9rOq_nKa6xjHju3kVZephTiO+jEW3PqxgAhU9+RdLTo-jgg@mail.gmail.com>
 <20201006152553.GY6642@arm.com>
 <CAMe9rOpQiPUZMjysPqtyFfmGDtfRapUvzfMOk7X14xZFSQ66Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOpQiPUZMjysPqtyFfmGDtfRapUvzfMOk7X14xZFSQ66Aw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 06, 2020 at 08:34:06AM -0700, H.J. Lu wrote:
> On Tue, Oct 6, 2020 at 8:25 AM Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Tue, Oct 06, 2020 at 05:12:29AM -0700, H.J. Lu wrote:
> > > On Tue, Oct 6, 2020 at 2:25 AM Dave Martin <Dave.Martin@arm.com> wrote:
> > > >
> > > > On Mon, Oct 05, 2020 at 10:17:06PM +0100, H.J. Lu wrote:
> > > > > On Mon, Oct 5, 2020 at 6:45 AM Dave Martin <Dave.Martin@arm.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 29, 2020 at 01:57:42PM -0700, Chang S. Bae wrote:
> > > > > > > During signal entry, the kernel pushes data onto the normal userspace
> > > > > > > stack. On x86, the data pushed onto the user stack includes XSAVE state,
> > > > > > > which has grown over time as new features and larger registers have been
> > > > > > > added to the architecture.
> > > > > > >
> > > > > > > MINSIGSTKSZ is a constant provided in the kernel signal.h headers and
> > > > > > > typically distributed in lib-dev(el) packages, e.g. [1]. Its value is
> > > > > > > compiled into programs and is part of the user/kernel ABI. The MINSIGSTKSZ
> > > > > > > constant indicates to userspace how much data the kernel expects to push on
> > > > > > > the user stack, [2][3].
> > > > > > >
> > > > > > > However, this constant is much too small and does not reflect recent
> > > > > > > additions to the architecture. For instance, when AVX-512 states are in
> > > > > > > use, the signal frame size can be 3.5KB while MINSIGSTKSZ remains 2KB.
> > > > > > >
> > > > > > > The bug report [4] explains this as an ABI issue. The small MINSIGSTKSZ can
> > > > > > > cause user stack overflow when delivering a signal.
> > > > > > >
> > > > > > > In this series, we suggest a couple of things:
> > > > > > > 1. Provide a variable minimum stack size to userspace, as a similar
> > > > > > >    approach to [5]
> > > > > > > 2. Avoid using a too-small alternate stack
> > > > > >
> > > > > > I can't comment on the x86 specifics, but the approach followed in this
> > > > > > series does seem consistent with the way arm64 populates
> > > > > > AT_MINSIGSTKSZ.
> > > > > >
> > > > > > I need to dig up my glibc hacks for providing a sysconf interface to
> > > > > > this...
> > > > >
> > > > > Here is my proposal for glibc:
> > > > >
> > > > > https://sourceware.org/pipermail/libc-alpha/2020-September/118098.html
> > > >
> > > > Thanks for the link.
> > > >
> > > > Are there patches yet?  I already had some hacks in the works, but I can
> > > > drop them if there's something already out there.
> > >
> > > I am working on it.
> >
> > OK.  I may post something for discussion, but I'm happy for it to be
> > superseded by someone (i.e., other than me) who actually knows what
> > they're doing...
> 
> Please see my previous email for my glibc patch:
> 
> https://gitlab.com/x86-glibc/glibc/-/commits/users/hjl/AT_MINSIGSTKSZ
> 
> > > >
> > > > > 1. Define SIGSTKSZ and MINSIGSTKSZ to 64KB.
> > > >
> > > > Can we do this?  IIUC, this is an ABI break and carries the risk of
> > > > buffer overruns.
> > > >
> > > > The reason for not simply increasing the kernel's MINSIGSTKSZ #define
> > > > (apart from the fact that it is rarely used, due to glibc's shadowing
> > > > definitions) was that userspace binaries will have baked in the old
> > > > value of the constant and may be making assumptions about it.
> > > >
> > > > For example, the type (char [MINSIGSTKSZ]) changes if this #define
> > > > changes.  This could be a problem if an newly built library tries to
> > > > memcpy() or dump such an object defined by and old binary.
> > > > Bounds-checking and the stack sizes passed to things like sigaltstack()
> > > > and makecontext() could similarly go wrong.
> > >
> > > With my original proposal:
> > >
> > > https://sourceware.org/pipermail/libc-alpha/2020-September/118028.html
> > >
> > > char [MINSIGSTKSZ] won't compile.  The feedback is to increase the
> > > constants:
> > >
> > > https://sourceware.org/pipermail/libc-alpha/2020-September/118092.html
> >
> > Ah, I see.  But both still API and ABI breaks; moreover, declaraing an
> > array with size based on (MIN)SIGSTKSZ is not just reasonable, but the
> > obvious thing to do with this constant in many simple cases.  Such usage
> > is widespread, see:
> >
> >  * https://codesearch.debian.net/search?q=%5BSIGSTKSZ%5D&literal=1
> >
> >
> > Your two approaches seem to trade off two different sources of buffer
> > overruns: undersized stacks versus ABI breaks across library boundaries.
> 
> We can't get everything we want.
> 
> > Since undersized stack is by far the more familiar problem and we at
> > least have guard regions to help detect overruns, I'd vote to keep
> > MINSIGSTKSZ and SIGSTKSZ as-is, at least for now.
> 
> Agree.
> 
> > Or are people reporting real stack overruns on x86 today?
> 
> I hope so.
> 
> >
> > For arm64, we made large vectors on SVE opt-in, so that oversized signal
> > frames are not seen by default.  Would somethine similar be feasible on
> > x86?
> >
> >
> > > > > 2. Add _SC_RSVD_SIG_STACK_SIZE for signal stack size reserved by the kernel.
> > > >
> > > > How about "_SC_MINSIGSTKSZ"?  This was my initial choice since only the
> > > > discovery method is changing.  The meaning of the value is exactly the
> > > > same as before.
> > > >
> > > > If we are going to rename it though, it could make sense to go for
> > > > something more directly descriptive, say, "_SC_SIGNAL_FRAME_SIZE".
> > > >
> > > > The trouble with including "STKSZ" is that is sounds like a
> > > > recommendation for your stack size.  While the signal frame size is
> > > > relevant to picking a stack size, it's not the only thing to
> > > > consider.
> > >
> > > The problem is that AT_MINSIGSTKSZ is the signal frame size used by
> > > kernel.   The minimum stack size for a signal handler is more likely
> > > AT_MINSIGSTKSZ + 1.5KB unless AT_MINSIGSTKSZ returns the signal
> > > frame size used by kernel + 6KB for user application.
> >
> > Ack; to be correct, you also need to take into account which signals may
> > be unmasked while running on this stack, and the stack requirements of
> > all their handlers.  Unfortunately, that's hard :(
> >
> > What's your view on my naming suggesions?
> 
> I used _SC_MINSIGSTKSZ:
> 
> https://gitlab.com/x86-glibc/glibc/-/commit/73ca53bfbc1c105bc579f55f15af011a07fcded9

Apologies, I missed that.

Otherwise, the changes look much as I would expect, except for the
"6K for user program" thing.  This is strictly not included in the
legacy MINSIGSTKSZ.

> 
> >
> > > > Also, do we need a _SC_SIGSTKSZ constant, or should the entire concept
> > > > of a "recommended stack size" be abandoned?  glibc can at least make a
> > > > slightly more informed guess about suitable stack sizes than the kernel
> > > > (and glibc already has to guess anyway, in order to determine the
> > > > default thread stack size).
> > >
> > > Glibc should try to deduct signal frame size if AT_MINSIGSTKSZ isn't
> > > available.
> >
> > In my code, I generate _SC_SIGSTKSZ as the equivalent of
> >
> >         max(sysconf(_SC_MINSIGSTKSZ) * 4, SIGSTKSZ)
> >
> > which is >= the legacy value, and broadly reperesentative of the
> > relationship between MINSIGSTKSZ and SIGSTKSZ on most arches.
> >
> >
> > What do you think?
> 
> sysconf(_SC_MINSIGSTKSZ) should be usable ASIS for most cases.

Why, though?

MINSIGSTKSZ is not specified to be usable as-is for any case whatsoever.


Software that calculates its own needs to know the actual system values,
not estimates based on guesses about how much stack a typical program
might need if it were recompiled for x86.

This doesn't mean we can't have a generic suggested value that's suitable
for common scenarios (like SIGSTKSZ), but if we do then I think it
should be a separate constant.


> > > > > 3. Deprecate SIGSTKSZ and MINSIGSTKSZ if _SC_RSVD_SIG_STACK_SIZE
> > > > > is in use.
> > > >
> > > > Great if we can do it.  I was concerned that this might be
> > > > controversial.
> > > >
> > > > Would this just be a recommendation, or can we enforce it somehow?
> > >
> > > It is just an idea.  We need to move away from constant SIGSTKSZ and
> > > MINSIGSTKSZ.
> >
> > Totally agree with that.
> >
> 
> With my glibc patch, -D_SC_MINSIGSTKSZ_SOURCE will fail to compile
> if the source assumes constant SIGSTKSZ or MINSIGSTKSZ.

Ah yes, I see.  That's a sensible precaution.

Is it accepted in general that defining different feature test macros
can lead to ABI incompatibilities?

I have thought that building a shared library with _GNU_SOURCE (say)
doesn't mean that a program that loads that library must also be built
with _GNU_SOURCE.  For one thing, that's hard to police.


However, there are already combinations that could break, e.g., mixing
-D_FILE_OFFSET_BITS=64 with -D_FILE_OFFSET_BITS=32 would be broken if
this define changes off_t.


So, maybe having _SC_MINSIGSTKSZ_SOURCE break things in this way is an
acceptable compromise.  Interfaces that depend on the value of
MINSIGSTKSZ or SIGSTKSZ are possible, but probably rare in practice --
I don't know of a specific example.

Cheers
---Dave
