Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B9A342432
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 19:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCSSNN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 14:13:13 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43968 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCSSNK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Mar 2021 14:13:10 -0400
Received: by mail-ed1-f45.google.com with SMTP id e7so11799118edu.10;
        Fri, 19 Mar 2021 11:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZal4QpX3Uqo0Jc5AuykWIm1WheHUMTD+qEfaje6yNM=;
        b=rsq2L2Qhp1OENj9eJfaw05d5M+w9/CXiDnzeVpUK4e7zL6g1H8fS1I34RdD1o+RxHs
         lHDUJu2bthr7sUEzmaXBAlfwpoyXdec5V52IvXkyvntaZHPhwxg/7+UWW3MgbsIIQSXR
         SStv5kIluXpEgpjFS+x6QjXlf/j5dbkVYCgl/GS8yfcZOHdzCYFlF1tAVdQZ18cUXkVG
         m37x+q5LPQuQ/26tWItwGNDo6ab1th4TZcfY7x0iRjtRlnnpa4dY0nW3AnmWbS7+jaqC
         Ow17Mqm4pIe24i2NNXCiXjX69RjgMY610wVhu90c0hvINXLvcn7DAsm45qTnD/B4vfQQ
         qpJA==
X-Gm-Message-State: AOAM530Eq4gujW9QadYjXjsx7M4YvWL5Skp/8vqthjYinAJCqx6/CqxN
        K4wPj0YkKJ5xKAJbfD+ZO+6kOLAgnzx8oZEw6W4=
X-Google-Smtp-Source: ABdhPJy66ov7mIzM8hYvrnVhsKVE1pzzMR9t4u/hAGekp6MYdhGc7rMxCmPkXnM2ZVFvTr51A+I/bFp/jtD3A317wlM=
X-Received: by 2002:aa7:d917:: with SMTP id a23mr11130226edr.122.1616177589508;
 Fri, 19 Mar 2021 11:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210317100640.GC1724119@gmail.com> <20210317104415.GA692070@gmail.com>
In-Reply-To: <20210317104415.GA692070@gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 19 Mar 2021 14:12:58 -0400
Message-ID: <CAJvTdKnpWL8y4N_BrCiK7fU0UXERwuuM8o84LUpp7Watxd8STw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] x86: Improve Minimum Alternate Stack Size
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, hjl.tools@gmail.com,
        Dave Martin <Dave.Martin@arm.com>, jannh@google.com,
        mpe@ellerman.id.au, carlos@redhat.com,
        "bothersome-borer for tony.luck@intel.com" <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 17, 2021 at 6:45 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> >
> > * Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >
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
> >
> > >   uapi: Define the aux vector AT_MINSIGSTKSZ
> > >   x86/signal: Introduce helpers to get the maximum signal frame size
> > >   x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
> > >   selftest/sigaltstack: Use the AT_MINSIGSTKSZ aux vector if available
> > >   x86/signal: Detect and prevent an alternate signal stack overflow
> > >   selftest/x86/signal: Include test cases for validating sigaltstack
> >
> > So this looks really complicated, is this justified?
> >
> > Why not just internally round up sigaltstack size if it's too small?
> > This would be more robust, as it would fix applications that use
> > MINSIGSTKSZ but don't use the new AT_MINSIGSTKSZ facility.
> >
> > I.e. does AT_MINSIGSTKSZ have any other uses than avoiding the
> > segfault if MINSIGSTKSZ is used to create a small signal stack?
>
> I.e. if the kernel sees a too small ->ss_size in sigaltstack() it
> would ignore ->ss_sp and mmap() a new sigaltstack instead and use that
> for the signal handler stack.
>
> This would automatically make MINSIGSTKSZ - and other too small sizes
> work today, and in the future.
>
> But the question is, is there user-space usage of sigaltstacks that
> relies on controlling or reading the contents of the stack?
>
> longjmp using programs perhaps?

For the legacy binary that requests a too-small sigaltstack, there are
several choices:

We could detect the too-small stack at sigaltstack(2) invocation and
return an error.
This results in two deal-killing problems:
First, some applications don't check the return value, so the check
would be fruitless.
Second, those that check and error-out may be programs that never
actually take the signal, and so we'd be causing a dusty binary to
exit, when it didn't exit on another system, or another kernel.

Or we could detect the too small stack at signal registration time.
This has the same two deal-killers as above.

Then there is the approach in this patch-set, which detects an
imminent stack overflow at run time.
It has neither of the two problems above, and the benefit that we now
prevent data corruption
that could have been happening on some systems already today.  The
down side is that the dusty binary
that does request the too-small stack can now die at run time.

So your idea of recognizing the problem and conjuring up a sufficient
stack is compelling,
since it would likely "just work", no matter how dumb the program.
But where would the
the sufficient stack come from -- is this a new kernel buffer, or is
there a way to abscond
some user memory?  I would expect a signal handler to look at the data
on its stack
and nobody else will look at that stack.  But this is already an
unreasonable program for
allocating a special signal stack in the first place :-/ So yes, one
could imagine the signal
handler could longjump instead of gracefully completing, and if this
specially allocated
signal stack isn't where the user planned, that could be trouble.

Another idea we discussed was to detect the potential overflow at run-time,
and instead of killing the process, just push the signal onto the
regular user stack.
this might actually work, but it is sort of devious; and it would not
work in the case
where the user overflowed their regular stack already, which may be
the most (only?)
compelling reason that they allocated and declared a special
sigaltstack in the first place...

-- 
Len Brown, Intel Open Source Technology Center
