Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A10E284B78
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 14:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgJFMNG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 08:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgJFMNF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 08:13:05 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE103C061755;
        Tue,  6 Oct 2020 05:13:05 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a2so12024519otr.11;
        Tue, 06 Oct 2020 05:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWRcIl4H7NR5wjNYHStWtcM865vMj76wc7Y4EJHzHWk=;
        b=j5h77Rg+bo8N17QG5m2Osa23XPWOy513mVqvsiAeGawdiKxyfR2h+pt1FC7xBOZfvB
         bBeH98WXUFpJPjfwjf1NS/+a402MQo15R893F8B8VYWt87BYnmsEEN4FikHbFK+tHwWw
         LmVbOLvMxQkUjRhS1OXw8gkCXStNqBBT2iVsr3GOVq6WgCr4GGJ08JAt+M2d4O8QhVvp
         wUQW+KwKutgy57+Fp/oAjAj6oeBtkorLUeASyvLzJ50duvae3P84Zw3Bw7ZBxa1LqAlu
         JXhiHNqwGJ8LoRG/lugNFm/VaAHlb2nGlTvdXZv/V5PfRbSlFcdQ0ciT3Jbn8MIzOYB4
         xKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWRcIl4H7NR5wjNYHStWtcM865vMj76wc7Y4EJHzHWk=;
        b=Mtla4oH3nLJdZLsrENKV1807wHDWySz12+/aRv085bT+VrqgNgEb+H0KpH4bphj/nb
         yVdBmnN9vRIAOKAb9cYNpbDywv05Gggl14j9je6P3zgKEqgbfcfp0NbjyFhILhZyCbA8
         tvK0jdhAYlAEkCHGnajoprR84h/KY0YqPl1FEce5pnXCXhdJ/E2WUWGL2L86TlvwzVhy
         /lm1p2mltyGIgzo9qBYROE1pUcxw8tzRlir1HxsAvJ1z4pKvFLvH9TqHSNYI75nExrgw
         4pLAMGbE2E6OwPYbtb1upEa+IEMWukknOVpxBtaJUOmwHGoPecI1QxSdYw8J3PQmh7F1
         nLOA==
X-Gm-Message-State: AOAM533lrVXRaWwzqSvDt2Pw+XNZCnp2RUueUmE9U/iMPutbJd6XTSWJ
        9yW5vNVKxqRckU58MwbowzA8USq1btuQwgd1ZIY=
X-Google-Smtp-Source: ABdhPJwjE+8Vth572W+dNh6A8WM0UhDVuIqFRfy1nr1NrlLlFhSLdMEmG9Fhy30SKKlKIoIyIuRGQqzFANhVi6gsMbc=
X-Received: by 2002:a9d:6498:: with SMTP id g24mr2742514otl.179.1601986385044;
 Tue, 06 Oct 2020 05:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
 <20201005134534.GT6642@arm.com> <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
 <20201006092532.GU6642@arm.com>
In-Reply-To: <20201006092532.GU6642@arm.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 6 Oct 2020 05:12:29 -0700
Message-ID: <CAMe9rOq_nKa6xjHju3kVZephTiO+jEW3PqxgAhU9+RdLTo-jgg@mail.gmail.com>
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

On Tue, Oct 6, 2020 at 2:25 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, Oct 05, 2020 at 10:17:06PM +0100, H.J. Lu wrote:
> > On Mon, Oct 5, 2020 at 6:45 AM Dave Martin <Dave.Martin@arm.com> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 01:57:42PM -0700, Chang S. Bae wrote:
> > > > During signal entry, the kernel pushes data onto the normal userspace
> > > > stack. On x86, the data pushed onto the user stack includes XSAVE state,
> > > > which has grown over time as new features and larger registers have been
> > > > added to the architecture.
> > > >
> > > > MINSIGSTKSZ is a constant provided in the kernel signal.h headers and
> > > > typically distributed in lib-dev(el) packages, e.g. [1]. Its value is
> > > > compiled into programs and is part of the user/kernel ABI. The MINSIGSTKSZ
> > > > constant indicates to userspace how much data the kernel expects to push on
> > > > the user stack, [2][3].
> > > >
> > > > However, this constant is much too small and does not reflect recent
> > > > additions to the architecture. For instance, when AVX-512 states are in
> > > > use, the signal frame size can be 3.5KB while MINSIGSTKSZ remains 2KB.
> > > >
> > > > The bug report [4] explains this as an ABI issue. The small MINSIGSTKSZ can
> > > > cause user stack overflow when delivering a signal.
> > > >
> > > > In this series, we suggest a couple of things:
> > > > 1. Provide a variable minimum stack size to userspace, as a similar
> > > >    approach to [5]
> > > > 2. Avoid using a too-small alternate stack
> > >
> > > I can't comment on the x86 specifics, but the approach followed in this
> > > series does seem consistent with the way arm64 populates
> > > AT_MINSIGSTKSZ.
> > >
> > > I need to dig up my glibc hacks for providing a sysconf interface to
> > > this...
> >
> > Here is my proposal for glibc:
> >
> > https://sourceware.org/pipermail/libc-alpha/2020-September/118098.html
>
> Thanks for the link.
>
> Are there patches yet?  I already had some hacks in the works, but I can
> drop them if there's something already out there.

I am working on it.

>
> > 1. Define SIGSTKSZ and MINSIGSTKSZ to 64KB.
>
> Can we do this?  IIUC, this is an ABI break and carries the risk of
> buffer overruns.
>
> The reason for not simply increasing the kernel's MINSIGSTKSZ #define
> (apart from the fact that it is rarely used, due to glibc's shadowing
> definitions) was that userspace binaries will have baked in the old
> value of the constant and may be making assumptions about it.
>
> For example, the type (char [MINSIGSTKSZ]) changes if this #define
> changes.  This could be a problem if an newly built library tries to
> memcpy() or dump such an object defined by and old binary.
> Bounds-checking and the stack sizes passed to things like sigaltstack()
> and makecontext() could similarly go wrong.

With my original proposal:

https://sourceware.org/pipermail/libc-alpha/2020-September/118028.html

char [MINSIGSTKSZ] won't compile.  The feedback is to increase the
constants:

https://sourceware.org/pipermail/libc-alpha/2020-September/118092.html

>
> > 2. Add _SC_RSVD_SIG_STACK_SIZE for signal stack size reserved by the kernel.
>
> How about "_SC_MINSIGSTKSZ"?  This was my initial choice since only the
> discovery method is changing.  The meaning of the value is exactly the
> same as before.
>
> If we are going to rename it though, it could make sense to go for
> something more directly descriptive, say, "_SC_SIGNAL_FRAME_SIZE".
>
> The trouble with including "STKSZ" is that is sounds like a
> recommendation for your stack size.  While the signal frame size is
> relevant to picking a stack size, it's not the only thing to
> consider.

The problem is that AT_MINSIGSTKSZ is the signal frame size used by
kernel.   The minimum stack size for a signal handler is more likely
AT_MINSIGSTKSZ + 1.5KB unless AT_MINSIGSTKSZ returns the signal
frame size used by kernel + 6KB for user application.

>
> Also, do we need a _SC_SIGSTKSZ constant, or should the entire concept
> of a "recommended stack size" be abandoned?  glibc can at least make a
> slightly more informed guess about suitable stack sizes than the kernel
> (and glibc already has to guess anyway, in order to determine the
> default thread stack size).

Glibc should try to deduct signal frame size if AT_MINSIGSTKSZ isn't
available.

>
> > 3. Deprecate SIGSTKSZ and MINSIGSTKSZ if _SC_RSVD_SIG_STACK_SIZE
> > is in use.
>
> Great if we can do it.  I was concerned that this might be
> controversial.
>
> Would this just be a recommendation, or can we enforce it somehow?

It is just an idea.  We need to move away from constant SIGSTKSZ and
MINSIGSTKSZ.

-- 
H.J.
