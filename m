Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4D71D5E02
	for <lists+linux-arch@lfdr.de>; Sat, 16 May 2020 04:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEPCw2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 22:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgEPCw1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 May 2020 22:52:27 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72727C061A0C;
        Fri, 15 May 2020 19:52:27 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l20so4486728ilj.10;
        Fri, 15 May 2020 19:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNfgiEathiSBxRi/+Bom/maZvv46VS2BCvZv4PPwQk8=;
        b=ivtMTS5yyQqcFApSplQIwwK5yS7OG/Tk6EPL5bx9xrhVBbpaLVp8fmsaYSuxLRkF3N
         O+6Rm1ESBExB8Zdbpw978FTJkj6F/B10CSUlJKMdWNB2q8xgKe/yDMvmdF313LgDLGTg
         KvnYmIZilB0OuwIr0DVZLKJteFzFlre+LpWZJbuwfElrGQQEJMQmHeGrCdHPd51ALUlU
         NW+8jJUBvqRvn7QYUMv3OKI4NmAQkK9GmVfJOArpw+C2H+qqrTmBzSK6gxuHmgOvrHQw
         AdoiYqsXgjqPO6W4LhT+1uMXnulrnLB+Zrnov8JsVwHzi4DE8ff6i+s0QuBX9XuCBUnt
         27lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNfgiEathiSBxRi/+Bom/maZvv46VS2BCvZv4PPwQk8=;
        b=mvUbqfkl2xwJyZJt9ePxSvZFlbMov8h7/V7W+9Ta1QeBgi8wb9gySUQayfI2zxRnLb
         1+mr+Kv64hJeHLTOXUEl5emzbrs7BaDbE7HZcLcWhCYQjnXds0TG4YCxf0Iy6nLwop9B
         TshWzjWjA0r3EdCUmXxqh5DK51/6LhqDY4ynHAOwhOP46Yoe4R5HY/VHTeHy8FXMrxOo
         ADa2SieuIpSXfbLMfIPXtW18I2bBbl9a1mtP/mgyxRqDpGFhLwhQTbhh53nA6QyTeZHK
         BgnkC2ktGKUNXQRniix1dZQbA+jCsyKnTHItBpp764Gn5J0QjH42oGHowz3tuWGK1E8q
         IqeQ==
X-Gm-Message-State: AOAM531uy14YESucDZmMxfFyjLyKZOtyHjaLlhrI8YZE3shWvZ/XT88f
        evQZF3p5r+UhcXKT8aht/C46mpPaKE2vBf//tFs=
X-Google-Smtp-Source: ABdhPJwsX7HUdwMla/9Y2i5H7ggisQsAUMqBXBK5pKw5P8RoByjVcL/nmflEX/eJfFoBSIKfrgXNPaK4xuYZeD7cZjU=
X-Received: by 2002:a92:d591:: with SMTP id a17mr6715599iln.13.1589597546218;
 Fri, 15 May 2020 19:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200429220732.31602-1-yu-cheng.yu@intel.com> <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com> <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com> <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com> <b09658f92eb66c1d1be509813939b9ed827f9cf0.camel@intel.com>
 <631f071c-c755-a818-6a97-b333eb1fe21c@intel.com>
In-Reply-To: <631f071c-c755-a818-6a97-b333eb1fe21c@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 15 May 2020 19:51:50 -0700
Message-ID: <CAMe9rOq_pCUz4wTQUyGCjyLpSkj4i3YO0XpZecADEp5cF=FhsQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 15, 2020 at 4:56 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/15/20 4:29 PM, Yu-cheng Yu wrote:
> > On Fri, 2020-05-15 at 15:43 -0700, Dave Hansen wrote:
> >> Basically, if there ends up being a bug in an app that violates the
> >> shadow stack rules, the app is broken, period.  The only recourse is to
> >> have the kernel disable CET and reboot.
> >>
> >> Is that right?
> >
> > You must be talking about init or any of the system daemons, right?
> > Assuming we let the app itself start CET with an arch_prctl(), why would that be
> > different from the current approach?
>
> You're getting ahead of me a bit here.
>
> I'm actually not asking directly about the prctls() or advocating for a
> different approach.  The MPX approach of _requiring the app to make a
> prctl() was actually pretty nasty because sometimes threads got created
> before the prctl() could get called.  Apps ended up inadvertently
> half-MPX-enabled.  Not fun.
>
> Let's say we have an app doing silly things like retpolines.  (Lots of
> app do lots of silly things).  It gets compiled in a distro but never
> runs on a system with CET.  The app gets run for the first time on a
> system with CET.  App goes boom.  Not init, just some random app, say
> /usr/bin/ldapsearch.

I designed and implemented CET toolchain and run-time in such a way
for it very difficult to happen.   Basically, CET won't be enabled on such
an app.

> What's my recourse as an end user?  I want to run my app and turn off
> CET for that app.  How can I do that?

The CET OS I designed turns CET off for you and you don't have to do
anything.

> >>>> Can a binary compiled without CET run CET-enabled code?
> >>>
> >>> Partially yes, but in reality somewhat difficult.
> >> ...
> >>> - If a not-CET application does fork(), and the child wants to turn on CET, it
> >>> would be difficult to manage the stack frames, unless the child knows what is is
> >>> doing.
> >>
> >> It might be hard to do, but it is possible with the patches you posted?
> >
> > It is possible to add an arch_prctl() to turn on CET.  That is simple from the
> > kernel's perspective, but difficult for the application.  Once the app enables
> > shadow stack, it has to take care not to return beyond the function call layers
> > before that point.  It can no longer do longjmp or ucontext swaps to anything
> > before that point.  It will also be complicated if the app enables shadow stack
> > in a signal handler.
>
> Yu-cheng, I'm having a very hard time getting direct answers to my
> questions.  Could you endeavor to give succinct, direct answers?  If you
> want to give a longer, conditioned answer, that's great.  But, I'd
> appreciate if you could please focus first on clearly answering the
> questions that I'm asking.
>
> Let me try again:
>
>         Is it possible with the patches in this series to run a single-
>         threaded binary which was has GNU_PROPERTY_X86_FEATURE_1_SHSTK
>         unset to run with shadow stack protection?

Yes, you can.  I added such capabilities for testing purpose.  But you
application
will crash as soon as there is a CET violation.  My CET software design is very
flexible.  It can accommodate different requirements.  We are working
with 2 OSVs
to enable CET in their OSes.  So far we haven't run into any
unexpected issues.

> I think the answer is an unambiguous: "No".  But I'd like to hear it
> from you.
>
> >>  I think you're saying that the CET-enabled binary would do
> >> arch_setup_elf_property() when it was first exec()'d.  Later, it could
> >> use the new prctl(ARCH_X86_CET_DISABLE) to disable its shadow stack,
> >> then fork() and the child would not be using CET.  Right?
> >>
> >> What is ARCH_X86_CET_DISABLE used for, anyway?
> >
> > Both the parent and the child can do ARCH_X86_CET_DISABLE, if CET is
> > not locked.
>
> Could you please describe a real-world example of why
> ARCH_X86_CET_DISABLE exists?  What kinds of apps will use it, or *are*
> using it?  Why was it created in the first place?
>
> >>> The JIT examples I mentioned previously run with CET enabled from the
> >>> beginning.  Do you have a reason to do this?  In other words, if the JIT code
> >>> needs CET, the app could have started with CET in the first place.
> >>
> >> Let's say I have a JIT'd sandbox.  I want the sandbox to be
> >> CET-protected, but the JIT engine itself not to be.
> >
> > I do not have any objections to this use case, but it needs some cautions as
> > stated above.  It will be much easier and cleaner if the sandbox is in a
> > separate exec'ed task with CET on.
>
> OK, great suggestion!  Could you do some research and look at the
> various sandboxing techniques?  Is imposing this requirement for a
> separate exec'd task reasonable?  Does it fit nicely with their existing
> models?  How about the Chrome browser and Firefox sandboxs?
>
> >>>> Does this *code* work?  Could you please indicate which JITs have been
> >>>> enabled to use the code in this series?  How much of the new ABI is in use?
> >>>
> >>> JIT does not necessarily use all of the ABI.  The JIT changes mainly fix stack
> >>> frames and insert ENDBRs.  I do not work on JIT.  What I found is LLVM JIT fixes
> >>> are tested and in the master branch.  Sljit fixes are in the release.
> >>
> >> Huh, so who is using the new prctl() ABIs?
> >
> > Any code can use the ABI, but JIT code CET-enabling part mostly do not use these
> > new prctl()'s, except, probably to get CET status.
>
> Which applications specifically are going to use the new prctl()s which
> this series adds?  How are they going to use them?
>
> "Any code can use them" is not a specific enough answer.
>
> >>>> Where are the selftests/ for this new ABI?  Were you planning on
> >>>> submitting any with this series?
> >>>
> >>> The ABI is more related to the application side, and therefore most suitable for
> >>> GLIBC unit tests.
> >>
> >> I was mostly concerned with the kernel selftests.  The things in
> >> tools/testing/selftests/x86 in the kernel tree.
> >
> > I have run them with CET enabled.  All of them pass, except for the following:
> > Sigreturn from 64-bit to 32-bit fails, because shadow stack is at a 64-bit
> > address.  This is understandable.
>
> That is not what I meant.  I'm going to be as explicit:
>
> I expect you to create a test case which you will submit with these
> patches and the test case will go into the tools/testing/selftests/x86
> directory in the kernel tree.  This test case will exercise the kernel
> functionality added in this series, especially the new prctl()s.
>
> One a separate topic: You ran the selftests and one failed.  This is a
> *MASSIVE* warning sign.  It should minimally be described in your cover
> letter, and accompanied by a fix to the test case.  It is absolutely
> unacceptable to introduce a kernel feature that causes a test to fail.
> You must either fix your kernel feature or you fix the test.
>
> This code can not be accepted until this selftests issue is rectified.
>
> >>> The more complicated areas such as pthreads, signals, ucontext,
> >>> fork() are all included there.  I have been constantly running these
> >>> tests without any problems.  I can provide more details if testing is
> >>> the concern.
> >>
> >> For something this complicated, with new kernel ABIs, we need an
> >> in-kernel sefltest.
> >>
> >> MPX was not that much different from this feature.  It required a
> >> boatload of compiler and linker changes to function.  Yet, there was a
> >> simple in-kernel test for it that didn't require *any* of that big pile
> >> of toolchain bits.
> >>
> >> Is there a reason we don't have one of those for CET?
> >
> > I have a quick test that checks shadow stack and ibt in both main program and in
> > signals.  Currently it is public on Github.  If that is desired, I can submit it
> > to the mailing list.
>
> Yes, that is desired.  It must accompany this submission.  It must also
> exercise all of the new ABIs.

Our CET smoke test is for quick validation of CET OS, not just kernel.
It requires
the complete CET implementation.   It does nothing if your OS isn't CET enabled.

-- 
H.J.
