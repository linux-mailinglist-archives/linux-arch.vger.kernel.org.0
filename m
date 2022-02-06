Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1946F4AAF93
	for <lists+linux-arch@lfdr.de>; Sun,  6 Feb 2022 14:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbiBFN4C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Feb 2022 08:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbiBFN4C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Feb 2022 08:56:02 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2A6C06173B;
        Sun,  6 Feb 2022 05:56:00 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id p125so9319727pga.2;
        Sun, 06 Feb 2022 05:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MVGrK19E00WWSz2xPXsV4Xp+Zqzss5NIyuH9iJU5vD8=;
        b=ldAyo+nvz7JEjtwsPQzFtrf8tgNEzMeI1EpU7z2uQe8Ou7qfBtUlTb8zWFKXWfJVNO
         IgTsIfh2TOWT2fdCQHL1wx1NztHRnKkuScEkZkkb06O5pFdc2Nw0zK0D2AtffuIzV2hP
         3oD1taMD9HfEKyGDkbKSt6prPDtIyaZx2H19J74Ro0wvaI8FaPgcZhWHOR7cPR2pREcX
         den0kzpHQl7VrK1dNoE2gg5Fe2Ny53z5NKeuZgOmWCIKuss/13XJiMzFKuYS4sT5EMz4
         tiED6lO5CYEHathDk3HHEYY1c3oaELn76rwqMOGEwpHP+YP4cwDNM4RWLOSKP028DO0o
         V9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MVGrK19E00WWSz2xPXsV4Xp+Zqzss5NIyuH9iJU5vD8=;
        b=r4Fi3etWF3BhcJ50PcQxnHvR4yCqp2lXsbZQefJ3BN9KjmgZ26DzPDQ2cBZySp0oxA
         pmfih7GH3i9uhJJ8iNzeroDRNTqmqtRRacDMcaBfHoW/TU2hmheZwhQaXNbO9dGt88PC
         NIJ7Lo1ihw2PjOW+xqUPpsqv8SOo+ggw51JKaPyV7KTLKVq9oRptZh69bk19tYEHxcC+
         gn5ZK3KYfIMMNGeNWsd+vQEZx9xe78KoQ8w+h9RZ8q/w40M5xYq+wKU/JOCVTjgOSYbp
         xf3uIwHyYXlx2ixmPdiL+j4eSl9Yoma7SFYRDS5MJa1na5OPY8VMx1FpbzHpueCQIhSz
         XaJg==
X-Gm-Message-State: AOAM533w7N2qdbxvd+1MphaBKB02yhbUgC9oWExyD7illFWB2sEz8z1m
        wjsydMcw0+VpPi11kSOlJuWa/O07yTIOhxV0gNY=
X-Google-Smtp-Source: ABdhPJx0HBjkPWB7u5rUo6zw67cBZFkL7uxuqdb41P/l+hmcppImyJXTZMvU6fhEDX6A3eULvwe0URSGe9Pfhaofkjk=
X-Received: by 2002:a65:414a:: with SMTP id x10mr5913538pgp.125.1644155759850;
 Sun, 06 Feb 2022 05:55:59 -0800 (PST)
MIME-Version: 1.0
References: <87fsozek0j.ffs@tglx> <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
 <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com> <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
 <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com> <782f27dbe6fc419a8946eeb426253e28@AcuMS.aculab.com>
In-Reply-To: <782f27dbe6fc419a8946eeb426253e28@AcuMS.aculab.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Sun, 6 Feb 2022 05:55:24 -0800
Message-ID: <CAMe9rOoyrWXe9Zuxoat74kPW=kdjWXvbcQY=5RFu2nJACDvnOQ@mail.gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
To:     David Laight <David.Laight@aculab.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 6, 2022 at 5:42 AM David Laight <David.Laight@aculab.com> wrote=
:
>
> From: Edgecombe, Rick P
> > Sent: 05 February 2022 20:15
> >
> > On Sat, 2022-02-05 at 05:29 -0800, H.J. Lu wrote:
> > > On Sat, Feb 5, 2022 at 5:27 AM David Laight <David.Laight@aculab.com>
> > > wrote:
> > > >
> > > > From: Edgecombe, Rick P
> > > > > Sent: 04 February 2022 01:08
> > > > > Hi Thomas,
> > > > >
> > > > > Thanks for feedback on the plan.
> > > > >
> > > > > On Thu, 2022-02-03 at 22:07 +0100, Thomas Gleixner wrote:
> > > > > > > Until now, the enabling effort was trying to support both
> > > > > > > Shadow
> > > > > > > Stack and IBT.
> > > > > > > This history will focus on a few areas of the shadow stack
> > > > > > > development history
> > > > > > > that I thought stood out.
> > > > > > >
> > > > > > >        Signals
> > > > > > >        -------
> > > > > > >        Originally signals placed the location of the shadow
> > > > > > > stack
> > > > > > > restore
> > > > > > >        token inside the saved state on the stack. This was
> > > > > > > problematic from a
> > > > > > >        past ABI promises perspective. So the restore location
> > > > > > > was
> > > > > > > instead just
> > > > > > >        assumed from the shadow stack pointer. This works
> > > > > > > because in
> > > > > > > normal
> > > > > > >        allowed cases of calling sigreturn, the shadow stack
> > > > > > > pointer
> > > > > > > should be
> > > > > > >        right at the restore token at that time. There is no
> > > > > > > alternate shadow
> > > > > > >        stack support. If an alt shadow stack is added later
> > > > > > > we
> > > > > > > would
> > > > > > >        need to
> > > > > >
> > > > > > So how is that going to work? altstack is not an esoteric
> > > > > > corner
> > > > > > case.
> > > > >
> > > > > My understanding is that the main usages for the signal stack
> > > > > were
> > > > > handling stack overflows and corruption. Since the shadow stack
> > > > > only
> > > > > contains return addresses rather than large stack allocations,
> > > > > and is
> > > > > not generally writable or pivotable, I thought there was a good
> > > > > possibility an alt shadow stack would not end up being especially
> > > > > useful. Does it seem like reasonable guesswork?
> > > >
> > > > The other 'problem' is that it is valid to longjump out of a signal
> > > > handler.
> > > > These days you have to use siglongjmp() not longjmp() but it is
> > > > still used.
> > > >
> > > > It is probably also valid to use siglongjmp() to jump from a nested
> > > > signal handler into the outer handler.
> > > > Given both signal handlers can have their own stack, there can be
> > > > three
> > > > stacks involved.
> >
> > So the scenario is?
> >
> > 1. Handle signal 1
> > 2. sigsetjmp()
> > 3. signalstack()
> > 4. Handle signal 2 on alt stack
> > 5. siglongjmp()
> >
> > I'll check that it is covered by the tests, but I think it should work
> > in this series that has no alt shadow stack. I have only done a high
> > level overview of how the shadow stack stuff, that doesn't involve the
> > kernel, works in glibc. Sounds like I'll need to do a deeper dive.
>
> The posix/xopen definition for setjmp/longjmp doesn't require such
> longjmp requests to work.
>
> Although they still have to do something that doesn't break badly.
> Aborting the process is probably fine!
>
> > > > I think the shadow stack pointer has to be in ucontext - which also
> > > > means the application can change it before returning from a signal.
> >
> > Yes we might need to change it to support alt shadow stacks. Can you
> > elaborate why you think it has to be in ucontext? I was thinking of
> > looking at three options for storing the ssp:
> >  - Stored in the shadow stack like a token using WRUSS from the kernel.
> >  - Stored on the kernel side using a hashmap that maps ucontext or
> >    sigframe userspace address to ssp (this is of course similar to
> >    storing in ucontext, except that the user can=E2=80=99t change the s=
sp).
> >  - Stored writable in userspace in ucontext.
> >
> > But in this version, without alt shadow stacks, the shadow stack
> > pointer is not stored in ucontext. This causes the limitation that
> > userspace can only call sigreturn when it has returned back to a point
> > where there is a restore token on the shadow stack (which was placed
> > there by the kernel). This doesn=E2=80=99t mean it can=E2=80=99t switch=
 to a different
> > shadow stack or handle a nested signal, but it limits the possibility
> > for calling sigreturn with a totally different sigframe (like CRIU and
> > SROP attacks do). It should hopefully be a helpful, protective
> > limitation for most apps and I'm hoping CRIU can be fixed without
> > removing it.
> >
> > I am not aware of other limitations to signals (besides normal shadow
> > stack enforcement), but I could be missing it. And people's skepticism
> > is making me want to go back over it with more scrutiny.
> >
> > > > In much the same way as all the segment registers can be changed
> > > > leading to all the nasty bugs when the final 'return to user' code
> > > > traps in kernel when loading invalid segment registers or executing
> > > > iret.
> >
> > I don't think this is as difficult to avoid because userspace ssp has
> > its own register that should not be accessed at that point, but I have
> > not given this aspect enough analysis. Thanks for bringing it up.
>
> So the user ssp isn't saved (or restored) by the trap entry/exit.
> So it needs to be saved by the context switch code?
> Much like the user segment registers?
> So you are likely to get the same problems if restoring it can fault
> in kernel (eg for a non-canonical address).
>
> > > > Hmmm... do shadow stacks mean that longjmp() has to be a system
> > > > call?
> > >
> > > No.  setjmp/longjmp save and restore shadow stack pointer.
>
> Ok, I was thinking that direct access to the user ssp would be
> a privileged operation.

User space can only pop shadow stack.  longjmp does

#ifdef SHADOW_STACK_POINTER_OFFSET
# if IS_IN (libc) && defined SHARED && defined FEATURE_1_OFFSET
/* Check if Shadow Stack is enabled.  */
testl $X86_FEATURE_1_SHSTK, %fs:FEATURE_1_OFFSET
jz L(skip_ssp)
# else
xorl %eax, %eax
# endif
/* Check and adjust the Shadow-Stack-Pointer.  */
/* Get the current ssp.  */
rdsspq %rax
/* And compare it with the saved ssp value.  */
subq SHADOW_STACK_POINTER_OFFSET(%rdi), %rax
je L(skip_ssp)
/* Count the number of frames to adjust and adjust it
   with incssp instruction.  The instruction can adjust
   the ssp by [0..255] value only thus use a loop if
   the number of frames is bigger than 255.  */
negq %rax
shrq $3, %rax
/* NB: We saved Shadow-Stack-Pointer of setjmp.  Since we are
       restoring Shadow-Stack-Pointer of setjmp's caller, we
       need to unwind shadow stack by one more frame.  */
addq $1, %rax

movl $255, %ebx
L(loop):
cmpq %rbx, %rax
cmovb %rax, %rbx
incsspq %rbx
subq %rbx, %rax
ja L(loop)

L(skip_ssp):
#endif

> If it can be written you don't really have to worry about what code
> is trying to do - it can actually do what it likes.
> It just catches unintentional operations (like buffer overflows).
>
> Was there any 'spare' space in struct jmpbuf ?

By pure luck, we have ONE spare space in sigjmp_buf.

> Otherwise you can only enable shadow stacks if everything has been
> recompiled - including any shared libraries the might be dlopen()ed.
> (or does the compiler invent an alloca() call somehow for a
> size that comes back from glibc?)
>
> I've never really considered how setjmp/longjmp handle callee saved
> register variables (apart from it being hard).
> The original pdp11 implementation probably only needed to save r6 and r7.
>
> What does happen to all the 'extended state' that XSAVE handles?
> IIRC all the AVX registers are caller saved (so should probably
> be zerod), but some of the SSE ones are callee saved, and one or
> two of the fpu flags are sticky and annoying enough the save/restore
> at the best of times.
>
> > It sounds like it would help to write up in a lot more detail exactly
> > how all the signal and specialer stack manipulation scenarios work in
> > glibc.
>
> Some cross references might have made people notice that the ucontext
> extensions for AVX512 (if not earlier ones) broke the minimal/default
> signal stack size.
>
>         David
>

--=20
H.J.
