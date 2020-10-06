Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6260284950
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgJFJZk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:25:40 -0400
Received: from foss.arm.com ([217.140.110.172]:42816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJFJZk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Oct 2020 05:25:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A53D7113E;
        Tue,  6 Oct 2020 02:25:39 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89A23F71F;
        Tue,  6 Oct 2020 02:25:37 -0700 (PDT)
Date:   Tue, 6 Oct 2020 10:25:34 +0100
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
Message-ID: <20201006092532.GU6642@arm.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
 <20201005134534.GT6642@arm.com>
 <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 10:17:06PM +0100, H.J. Lu wrote:
> On Mon, Oct 5, 2020 at 6:45 AM Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 01:57:42PM -0700, Chang S. Bae wrote:
> > > During signal entry, the kernel pushes data onto the normal userspace
> > > stack. On x86, the data pushed onto the user stack includes XSAVE state,
> > > which has grown over time as new features and larger registers have been
> > > added to the architecture.
> > >
> > > MINSIGSTKSZ is a constant provided in the kernel signal.h headers and
> > > typically distributed in lib-dev(el) packages, e.g. [1]. Its value is
> > > compiled into programs and is part of the user/kernel ABI. The MINSIGSTKSZ
> > > constant indicates to userspace how much data the kernel expects to push on
> > > the user stack, [2][3].
> > >
> > > However, this constant is much too small and does not reflect recent
> > > additions to the architecture. For instance, when AVX-512 states are in
> > > use, the signal frame size can be 3.5KB while MINSIGSTKSZ remains 2KB.
> > >
> > > The bug report [4] explains this as an ABI issue. The small MINSIGSTKSZ can
> > > cause user stack overflow when delivering a signal.
> > >
> > > In this series, we suggest a couple of things:
> > > 1. Provide a variable minimum stack size to userspace, as a similar
> > >    approach to [5]
> > > 2. Avoid using a too-small alternate stack
> >
> > I can't comment on the x86 specifics, but the approach followed in this
> > series does seem consistent with the way arm64 populates
> > AT_MINSIGSTKSZ.
> >
> > I need to dig up my glibc hacks for providing a sysconf interface to
> > this...
> 
> Here is my proposal for glibc:
> 
> https://sourceware.org/pipermail/libc-alpha/2020-September/118098.html

Thanks for the link.

Are there patches yet?  I already had some hacks in the works, but I can
drop them if there's something already out there.


> 1. Define SIGSTKSZ and MINSIGSTKSZ to 64KB.

Can we do this?  IIUC, this is an ABI break and carries the risk of
buffer overruns.

The reason for not simply increasing the kernel's MINSIGSTKSZ #define
(apart from the fact that it is rarely used, due to glibc's shadowing
definitions) was that userspace binaries will have baked in the old
value of the constant and may be making assumptions about it.

For example, the type (char [MINSIGSTKSZ]) changes if this #define
changes.  This could be a problem if an newly built library tries to
memcpy() or dump such an object defined by and old binary.
Bounds-checking and the stack sizes passed to things like sigaltstack()
and makecontext() could similarly go wrong.


> 2. Add _SC_RSVD_SIG_STACK_SIZE for signal stack size reserved by the kernel.

How about "_SC_MINSIGSTKSZ"?  This was my initial choice since only the
discovery method is changing.  The meaning of the value is exactly the
same as before.

If we are going to rename it though, it could make sense to go for
something more directly descriptive, say, "_SC_SIGNAL_FRAME_SIZE".

The trouble with including "STKSZ" is that is sounds like a
recommendation for your stack size.  While the signal frame size is
relevant to picking a stack size, it's not the only thing to
consider.


Also, do we need a _SC_SIGSTKSZ constant, or should the entire concept
of a "recommended stack size" be abandoned?  glibc can at least make a
slightly more informed guess about suitable stack sizes than the kernel
(and glibc already has to guess anyway, in order to determine the
default thread stack size).


> 3. Deprecate SIGSTKSZ and MINSIGSTKSZ if _SC_RSVD_SIG_STACK_SIZE
> is in use.

Great if we can do it.  I was concerned that this might be
controversial.

Would this just be a recommendation, or can we enforce it somehow?

Cheers
---Dave
