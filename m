Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C73286272
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgJGPqG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 11:46:06 -0400
Received: from foss.arm.com ([217.140.110.172]:45786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgJGPqF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Oct 2020 11:46:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C43F5106F;
        Wed,  7 Oct 2020 08:46:04 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C53A73F66B;
        Wed,  7 Oct 2020 08:46:02 -0700 (PDT)
Date:   Wed, 7 Oct 2020 16:45:59 +0100
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
Message-ID: <20201007154559.GI6642@arm.com>
References: <20201005134534.GT6642@arm.com>
 <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
 <20201006092532.GU6642@arm.com>
 <CAMe9rOq_nKa6xjHju3kVZephTiO+jEW3PqxgAhU9+RdLTo-jgg@mail.gmail.com>
 <20201006152553.GY6642@arm.com>
 <CAMe9rOpQiPUZMjysPqtyFfmGDtfRapUvzfMOk7X14xZFSQ66Aw@mail.gmail.com>
 <20201006165520.GA6642@arm.com>
 <CAMe9rOoY5T61uYCXMcEaKxL7NURDpACJ+0rF47HFmosYOvA2aA@mail.gmail.com>
 <20201007104720.GH6642@arm.com>
 <CAMe9rOq7yoAwT=+JR4nk4yWMGeXza9490YgJYNp4FKfkJRJxtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOq7yoAwT=+JR4nk4yWMGeXza9490YgJYNp4FKfkJRJxtQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 07, 2020 at 06:30:03AM -0700, H.J. Lu wrote:
> On Wed, Oct 7, 2020 at 3:47 AM Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Tue, Oct 06, 2020 at 10:44:14AM -0700, H.J. Lu wrote:

[...]

> > > I updated my glibc patch to add both _SC_MINSIGSTKSZ and _SC_SIGSTKSZ.
> > > _SC_MINSIGSTKSZ is  the minimum signal stack size from AT_MINSIGSTKSZ,
> > > which is the signal frame size used by kernel, and _SC_SIGSTKSZ is the value
> > > of sysconf (_SC_MINSIGSTKSZ) + 6KB for user application.
> >
> > Can I suggest sysconf (_SC_MINSIGSTKSZ) * 4 instead?
> 
> Done.

OK.  I was prepared to have to argue my case a bit more, but if you
think this is OK then I will stop arguing ;)


> > If the arch has more or bigger registers to save in the signal frame,
> > the chances are that they're going to get saved in some userspace stack
> > frames too.  So I suspect that the user signal handler stack usage may
> > scale up to some extent rather than being a constant.
> >
> >
> > To help people migrate without unpleasant surprises, I also figured it
> > would be a good idea to make sure that sysconf (_SC_MINSIGSTKSZ) >=
> > legacy MINSIGSTKSZ, and sysconf (_SC_SIGSTKSZ) >= legacy SIGSTKSZ.
> > This should makes it safer to use sysconf (_SC_MINSIGSTKSZ) as a
> > drop-in replacement for MINSIGSTKSZ, etc.
> >
> > (To explain: AT_MINSIGSTKSZ may actually be < MINSIGSTKSZ on AArch64.
> > My idea was that sysconf () should hide this surprise, but people who
> > really want to know the kernel value would tolerate some
> > nonportability and read AT_MINSIGSTKSZ directly.)
> >
> >
> > So then:
> >
> >         kernel_minsigstksz = getauxval(AT_MINSIGSTKSZ);
> >         minsigstksz = LEGACY_MINSIGSTKSZ;
> >         if (kernel_minsigstksz > minsigstksz)
> >                 minsistksz = kernel_minsigstksz;
> >
> >         sigstksz = LEGACY_SIGSTKSZ;
> >         if (minsigstksz * 4 > sigstksz)
> >                 sigstksz = minsigstksz * 4;
> 
> I updated users/hjl/AT_MINSIGSTKSZ branch with
> 
> +@item _SC_MINSIGSTKSZ
> +@standards{GNU, unistd.h}

Can we specify these more agressively now?

> +Inquire about the signal stack size used by the kernel.

I think we've already concluded that this should included all mandatory
overheads, including those imposed by the compiler and glibc?

e.g.:

--8<--

The returned value is the minimum number of bytes of free stack space
required in order to gurantee successful, non-nested handling of a
single signal whose handler is an empty function.

-->8--

> +
> +@item _SC_SIGSTKSZ
> +@standards{GNU, unistd.h}
> +Inquire about the default signal stack size for a signal handler.

Similarly:

--8<--

The returned value is the suggested minimum number of bytes of stack
space required for a signal stack.

This is not guaranteed to be enough for any specific purpose other than
the invocation of a single, non-nested, empty handler, but nonetheless
should be enough for basic scenarios involving simple signal handlers
and very low levels of signal nesting (say, 2 or 3 levels at the very
most).

This value is provided for developer convenience and to ease migration
from the legacy SIGSTKSZ constant.  Programs requiring stronger
guarantees should avoid using it if at all possible.

-->8--


If these descriptions are too wordy, we might want to move some of it
out to signal.texi, though.

> 
>     case _SC_MINSIGSTKSZ:
>       assert (GLRO(dl_minsigstacksize) != 0);
>       return GLRO(dl_minsigstacksize);
> 
>     case _SC_SIGSTKSZ:
>       {
>         /* Return MAX (MINSIGSTKSZ, sysconf (_SC_MINSIGSTKSZ)) * 4.  */
>         long int minsigstacksize = GLRO(dl_minsigstacksize);
>         _Static_assert (__builtin_constant_p (MINSIGSTKSZ),
>                         "MINSIGSTKSZ is constant");
>         if (minsigstacksize < MINSIGSTKSZ)
>           minsigstacksize = MINSIGSTKSZ;
>         return minsigstacksize * 4;
>       }
> 
> >
> > (Or something like that, unless the architecture provides its own
> > definitions.  ia64's MINSIGSTKSZ is enormous, so it probably doesn't
> > want this.)
> >
> >
> > Also: should all these values be rounded up to a multiple of the
> > architecture's preferred stack alignment?
> 
> Kernel should provide a properly aligned AT_MINSIGSTKSZ.

OK.  Can you comment on Chang S. Bae's series?  I wasn't sure that the
proposal produces an aligned value for AT_MINSIGSTKSZ on x86, but maybe
I just worked it out wrong.


> > Should the preferred stack alignment also be exposed through sysconf?
> > Portable code otherwise has no way to know this, though if the
> > preferred alignment is <= the minimum malloc()/alloca() alignment then
> > this is generally not an issue.)
> 
> Good question.  But it is orthogonal to the signal stack size issue.

Ack.

There are various other brokennesses around this area, such as the fact
that the register data may now run off the end of the mcontext_t object
that is supposed to contain it.  Ideally we should fork ucontext_t or
mcontext_t into two types, one for the ucontext API and one for the
signal API (which are anyway highly incompatible with each other).

If this stuff is addressed, I guess we could bundle it under a more
general feature test macro.  But it's probably best to nail down this
series in something like its current form first.


I'll follow up on libc-alpha with a wishlist, but that will be a
separate conversation...

[...]

Cheers
---Dave
