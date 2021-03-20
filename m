Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB025342E9F
	for <lists+linux-arch@lfdr.de>; Sat, 20 Mar 2021 18:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCTRcu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Mar 2021 13:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTRcJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Mar 2021 13:32:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7EBC061574;
        Sat, 20 Mar 2021 10:32:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o19so14488556edc.3;
        Sat, 20 Mar 2021 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bFNu1Uz51KMfEW+ABnORMauFzs3e2ZaieyRLl3pCKvU=;
        b=QLEA1yh+KCAEYOOkPrpkm+SLlIPC5X02+U8st72y6fRRtiO5YF1lsPGA9gKHuVCc+S
         JeE+d8dy8xbFQkk6kYDug8s2j8rC8l4OE74223Q4NXPi879WjayWOvq7EtD4AzRL2Hbt
         fbQU1Rj2JHDwk1XxIIZnAPHI1PX7KBXQmZPWC0uFlwcpcyianWrpXcuVXccOJPqhGp15
         oCuZBRFEbJSdxvKXeM/KsSwTND95bhQ79jVoocZlmtgsg0YHkogJ8TYDyzAmM0xJ0haA
         7RDFnSyM3pD/mSj0l/+ID5lk7lPld/FEWCXJlc4LlQKt/WEDi3PdQQnl5p/+ntuWCHRe
         42fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bFNu1Uz51KMfEW+ABnORMauFzs3e2ZaieyRLl3pCKvU=;
        b=kV95/wvjBPQ9f9azuE3ZQuu+8WG3U6JVNqGEluHn5LuoLlkMjU0dKqM67JR9k+xcg0
         ouK9s22f+z0Bq7qoM1Rpi99/pm1cJonCa5DkIRRiKsH2g6XBNrejJjJG3HCgpqntcmuE
         bBGSj76jffwUS1wSHvN/tngDpgqXJ1ZArXQAU2iTmocpkirdiUT7buuXasE/y1gSban/
         secyTOEesROySmlCxtSRBu75uaQTSTpcVayoP9HsLKwQbe2u3UrlI1FD0SXew4t6G+Uz
         XTb0Lre5/AcF1DEk2W52aMsBRbD5o/6K+8RnkIWb7/OtigUeVmpIPvOIl5FDgmnlnEq4
         wbSw==
X-Gm-Message-State: AOAM530s8s8b61kjeCB6z/f4EX1AopgmQ6JCG4+lmWmL56w2RWegTt9X
        lRtbsJj/Atm5qBlpGvakIBs=
X-Google-Smtp-Source: ABdhPJzZpJENUP1BZIuAr/xSdl0PHrsU+bxCkZMDAjp/pvukOx+ljoJLGVaN5lMqGFsN1zqnFZ/nLw==
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr16635671edc.207.1616261523285;
        Sat, 20 Mar 2021 10:32:03 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id n2sm5707795ejl.1.2021.03.20.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 10:32:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 20 Mar 2021 18:32:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Len Brown <lenb@kernel.org>
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
Subject: Re: [PATCH v7 0/6] x86: Improve Minimum Alternate Stack Size
Message-ID: <20210320173200.GA4153106@gmail.com>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210317100640.GC1724119@gmail.com>
 <20210317104415.GA692070@gmail.com>
 <CAJvTdKnpWL8y4N_BrCiK7fU0UXERwuuM8o84LUpp7Watxd8STw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJvTdKnpWL8y4N_BrCiK7fU0UXERwuuM8o84LUpp7Watxd8STw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> On Wed, Mar 17, 2021 at 6:45 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> > >
> > > * Chang S. Bae <chang.seok.bae@intel.com> wrote:
> > >
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
> > >
> > > >   uapi: Define the aux vector AT_MINSIGSTKSZ
> > > >   x86/signal: Introduce helpers to get the maximum signal frame size
> > > >   x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
> > > >   selftest/sigaltstack: Use the AT_MINSIGSTKSZ aux vector if available
> > > >   x86/signal: Detect and prevent an alternate signal stack overflow
> > > >   selftest/x86/signal: Include test cases for validating sigaltstack
> > >
> > > So this looks really complicated, is this justified?
> > >
> > > Why not just internally round up sigaltstack size if it's too small?
> > > This would be more robust, as it would fix applications that use
> > > MINSIGSTKSZ but don't use the new AT_MINSIGSTKSZ facility.
> > >
> > > I.e. does AT_MINSIGSTKSZ have any other uses than avoiding the
> > > segfault if MINSIGSTKSZ is used to create a small signal stack?
> >
> > I.e. if the kernel sees a too small ->ss_size in sigaltstack() it
> > would ignore ->ss_sp and mmap() a new sigaltstack instead and use that
> > for the signal handler stack.
> >
> > This would automatically make MINSIGSTKSZ - and other too small sizes
> > work today, and in the future.
> >
> > But the question is, is there user-space usage of sigaltstacks that
> > relies on controlling or reading the contents of the stack?
> >
> > longjmp using programs perhaps?
> 
> For the legacy binary that requests a too-small sigaltstack, there are
> several choices:
> 
> We could detect the too-small stack at sigaltstack(2) invocation and
> return an error.
> This results in two deal-killing problems:
> First, some applications don't check the return value, so the check
> would be fruitless.
> Second, those that check and error-out may be programs that never
> actually take the signal, and so we'd be causing a dusty binary to
> exit, when it didn't exit on another system, or another kernel.
> 
> Or we could detect the too small stack at signal registration time.
> This has the same two deal-killers as above.
> 
> Then there is the approach in this patch-set, which detects an
> imminent stack overflow at run time.
> It has neither of the two problems above, and the benefit that we now
> prevent data corruption
> that could have been happening on some systems already today.  The
> down side is that the dusty binary
> that does request the too-small stack can now die at run time.
> 
> So your idea of recognizing the problem and conjuring up a 
> sufficient stack is compelling, since it would likely "just work", 
> no matter how dumb the program. But where would the the sufficient 
> stack come from -- is this a new kernel buffer, or is there a way to 
> abscond some user memory?  I would expect a signal handler to look 
> at the data on its stack and nobody else will look at that stack.  
> But this is already an unreasonable program for allocating a special 
> signal stack in the first place :-/ So yes, one could imagine the 
> signal handler could longjump instead of gracefully completing, and 
> if this specially allocated signal stack isn't where the user 
> planned, that could be trouble.

We could mmap() (implicitly) new anonymous memory - but I can see why 
this is probably more trouble than worth...

> Another idea we discussed was to detect the potential overflow at 
> run-time, and instead of killing the process, just push the signal 
> onto the regular user stack. this might actually work, but it is 
> sort of devious; and it would not work in the case where the user 
> overflowed their regular stack already, which may be the most 
> (only?) compelling reason that they allocated and declared a special 
> sigaltstack in the first place...

Yeah, this doesn't sound deterministic enough.

Ok, thanks for the detailed answers - I withdraw my objections, let's 
proceed with the approach you are proposing?

Thanks,

	Ingo
