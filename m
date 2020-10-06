Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86209285031
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgJFQxj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 12:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFQxg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 12:53:36 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C1C061755;
        Tue,  6 Oct 2020 09:53:36 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c13so13287556oiy.6;
        Tue, 06 Oct 2020 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHW6oLWR4zV2RPLim0JT1nYB7S0AFWcKslhQ0TQtlGc=;
        b=ATiZuw4DJezrEj4EfNgFc26tQN8g5I/hudFn1FRq6py9RgXrt6tf+OmMxHqqKpWPv9
         Lzo0MvRiTkZpZOHvtfKjiWyxjlN4Ay5Cg4UeKKq910YdxiOEPDv5qjxbEyv6enPL6OFa
         utvxVT3oybBMibkAY2CXe7FN9CLkx74i3Frd0gqyefHEb/NGH6A+CVIyiDc8GsXxfzsw
         p7cse5aO+Z5DVwYMayls8m+r91hXnV+CoGIdMKLF2+YTRiQVnukJcRHY0u1F+1GaxYau
         XeBNJTbd1HBxHWJy+4NQwJ20KOHcXoi2mMZG4iRyrmNKs9Hemq9pBzZxHG3zg7T4tBIQ
         9oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHW6oLWR4zV2RPLim0JT1nYB7S0AFWcKslhQ0TQtlGc=;
        b=HA7FFCm3mjI8V6/KeVN4Q20tkHHpoAyniynHPhNvThol9RVaBKFHeCjqgDgbnzghyb
         YMZGGwcd5CgH36zlKLNrbuxU2vdT+2KqRMg1lT1g0RiccQ6P6hRuinnHpWtvMU/htswA
         3b0FfCCMgEOSn+h4UXl4iX1pv2vzTC6D9Rn9XOTFHjAydJNdf2w+emfrs6ZBKqrUG/zQ
         zPvSwXQw9B/I5cxFjCiDA51yaYOHc59IzT4Y2IdhI43xkN/8Kdjy9BiG6aRFQiBR2Kvc
         hg0cOdZG02nubEYOV1wcylzYDg+xfu38vx6M3bkm42ljnwagI9h/tVqfXVrioRO4NymJ
         JXTA==
X-Gm-Message-State: AOAM530JkhIXM/+M/33OrDTmObrtJgWsdUtAjKCh4OpiVIVArR8AEnID
        788p5/mH3WwHvXW+hzDthQKdh2MPDgBKUwNmAx4=
X-Google-Smtp-Source: ABdhPJxPg9b7k/RnjI7Q2GXXTovuaFaBN1W+A8IWMiTCjI2QCQ8PaE9HMz2ChiMypyt1zCYAn3k0eQtx3OCeo4avOiA=
X-Received: by 2002:aca:4c7:: with SMTP id 190mr3426813oie.58.1602003215820;
 Tue, 06 Oct 2020 09:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
 <20201005134534.GT6642@arm.com> <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
 <20201006092532.GU6642@arm.com> <CAMe9rOq_nKa6xjHju3kVZephTiO+jEW3PqxgAhU9+RdLTo-jgg@mail.gmail.com>
 <CAMe9rOreJzDZxh8HDDRBvOVZ0Zp_UuoZsenhynh1jjxNNsgTKw@mail.gmail.com> <20201006154353.GZ6642@arm.com>
In-Reply-To: <20201006154353.GZ6642@arm.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 6 Oct 2020 09:52:59 -0700
Message-ID: <CAMe9rOrDmuiymt8jym-bH0JSzmaDAGGreUJsoZKdsZ=ETSYzBg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86: Improve Minimum Alternate Stack Size
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 6, 2020 at 8:43 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Tue, Oct 06, 2020 at 08:18:03AM -0700, H.J. Lu wrote:
> > On Tue, Oct 6, 2020 at 5:12 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> > >
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
> > >
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
> > >
> > > >
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
> > >
> > > >
> > > > Also, do we need a _SC_SIGSTKSZ constant, or should the entire concept
> > > > of a "recommended stack size" be abandoned?  glibc can at least make a
> > > > slightly more informed guess about suitable stack sizes than the kernel
> > > > (and glibc already has to guess anyway, in order to determine the
> > > > default thread stack size).
> > >
> > > Glibc should try to deduct signal frame size if AT_MINSIGSTKSZ isn't
> > > available.
> > >
> > > >
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
> > >
> >
> > Here is the glibc patch:
> >
> > https://gitlab.com/x86-glibc/glibc/-/commits/users/hjl/AT_MINSIGSTKSZ
> >
> > AT_MINSIGSTKSZ should return the signal frame size used by kernel + 6KB
> > for user application.
>
> I'm not sure about the 6K here.

6KB is something I made up.

> We a few fundamental parameters:
>
>  * the actual maximum size of the kernel-allocated signal frame (which
>    we'll report via AT_MINSIGSTKSZ);

Agree.

>  * the size of additional userspace stack frame required to execute the
>    minimal (i.e., empty) signal handler.  (On AArch64, this is 0.  In

It is also 0 for x86.

>    environments where the C lirbrary calls signal handlers through some
>    sort of wrapper, this would need to include the wrapper's stack
>    needs also);

>  * additional userspace stack needs for the actual signal handler code.
>    This is completely unknown.

That is 6KB I made up.

>
> _SC_MINSIGSTKSZ (however named) should certainly include the first two,
> but I'm not sure about the third.  It will at least be architecture-
> dependent.
>
>
> This is one reason why I still favor having more than one constant here:
> the fundamental system properties should be discoverable for software
> that knows how to calculate its own stack needs accurately.
>
> Since calculating stack needs is hard and most software doesn't bother
> to do it, we could also give a "recommended" stack size which
> incorporates a guess of typical handler stack needs (similarly to the
> legacy SIGSTKSZ constant), but I think that should be a separate
> parameter.

Sounds reasonable.  We can have _SC_MINSIGSTKSZ and
_SC_SIGSTKSZ which is _SC_MINSIGSTKSZ + 6KB (or some
other value).

-- 
H.J.
