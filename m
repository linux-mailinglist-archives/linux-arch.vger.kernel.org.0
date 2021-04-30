Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5F36FFE9
	for <lists+linux-arch@lfdr.de>; Fri, 30 Apr 2021 19:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhD3Rsa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 13:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhD3RsW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Apr 2021 13:48:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66AE661466
        for <linux-arch@vger.kernel.org>; Fri, 30 Apr 2021 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619804853;
        bh=0ko+ih9vB2EkIJYcPJvGTrOw7LReSx1K4pbFb4KglZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u0OQNfD/tdO78n8gFDTR/vXtatEd8FiKKcWK6Izb1ZJ5d/mRNkZGyax+blhxsVZxL
         qrNczschLXVXwBz2co31C4/VWkDmVNscJriy1FGUg4z3nmtx6n/FrybqnMbKiaZxFx
         3CCgyVZAprEa0r8R31Tid1tDMFdzAtVnGsbcEzdKWJOyp85wPbFDKmpx+0KQ5tUsSI
         Qndead/XCaXW2abYdezizkxHBaYCpcyczwKncaHupSzCAVoWQvqTEel1fweBmTixs/
         yX4qsNwDFU7zINmAjkh3mahfLNwJCwpsfgn2GfBvI/Tc2C3fkUOKMZ8nkeRQaN0Awu
         zXmjdp7YW5W6g==
Received: by mail-ej1-f43.google.com with SMTP id gx5so14388312ejb.11
        for <linux-arch@vger.kernel.org>; Fri, 30 Apr 2021 10:47:33 -0700 (PDT)
X-Gm-Message-State: AOAM530nIoqoZf6QCdQn4jmpx+rrC85HlkiitnRCGIB/U0diXZGepjx2
        VJphz+alBDNELISEvrRaQv1uZX7a9hU96ujjECd5Qg==
X-Google-Smtp-Source: ABdhPJyJzN7XxMwwKKuZTcr2REAqArJDgZ4GoNgkwt77+CR2AQjbuqYhdzSwvJvyRGHpZ3DAmy/UXg3207t6lMFw9E4=
X-Received: by 2002:a17:906:270a:: with SMTP id z10mr5586253ejc.204.1619804851823;
 Fri, 30 Apr 2021 10:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210427204315.24153-1-yu-cheng.yu@intel.com> <20210427204315.24153-26-yu-cheng.yu@intel.com>
 <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com> <8fd86049-930d-c9b7-379c-56c02a12cd77@intel.com>
In-Reply-To: <8fd86049-930d-c9b7-379c-56c02a12cd77@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 30 Apr 2021 10:47:20 -0700
X-Gmail-Original-Message-ID: <CALCETrX9z-73wpy-SCy8NE1XfQgXAN0mCmjv0jXDDomMyS7TKg@mail.gmail.com>
Message-ID: <CALCETrX9z-73wpy-SCy8NE1XfQgXAN0mCmjv0jXDDomMyS7TKg@mail.gmail.com>
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle
 signals for shadow stack)
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 30, 2021 at 10:00 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 4/28/2021 4:03 PM, Andy Lutomirski wrote:
> > On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >>
> >> When shadow stack is enabled, a task's shadow stack states must be saved
> >> along with the signal context and later restored in sigreturn.  However,
> >> currently there is no systematic facility for extending a signal context.
> >> There is some space left in the ucontext, but changing ucontext is likely
> >> to create compatibility issues and there is not enough space for further
> >> extensions.
> >>
> >> Introduce a signal context extension struct 'sc_ext', which is used to save
> >> shadow stack restore token address.  The extension is located above the fpu
> >> states, plus alignment.  The struct can be extended (such as the ibt's
> >> wait_endbr status to be introduced later), and sc_ext.total_size field
> >> keeps track of total size.
> >
> > I still don't like this.
> >
> > Here's how the signal layout works, for better or for worse:
> >
> > The kernel has:
> >
> > struct rt_sigframe {
> >      char __user *pretcode;
> >      struct ucontext uc;
> >      struct siginfo info;
> >      /* fp state follows here */
> > };
> >
> > This is roughly the actual signal frame.  But userspace does not have
> > this struct declared, and user code does not know the sizes of the
> > fields.  So it's accessed in a nonsensical way.  The signal handler
> > function is passed a pointer to the whole sigframe implicitly in RSP,
> > a pointer to &frame->info in RSI, anda pointer to &frame->uc in RDX.
> > User code can *find* the fp state by following a pointer from
> > mcontext, which is, in turn, found via uc:
> >
> > struct ucontext {
> >      unsigned long      uc_flags;
> >      struct ucontext  *uc_link;
> >      stack_t          uc_stack;
> >      struct sigcontext uc_mcontext;  <-- fp pointer is in here
> >      sigset_t      uc_sigmask;    /* mask last for extensibility */
> > };
> >
> > The kernel, in sigreturn, works a bit differently.  The sigreturn
> > variants know the base address of the frame but don't have the benefit
> > of receiving pointers to the fields.  So instead the kernel takes
> > advantage of the fact that it knows the offset to uc and parses uc
> > accordingly.  And the kernel follows the pointer in mcontext to find
> > the fp state.  The latter bit is quite important later.  The kernel
> > does not parse info at all.
> >
> > The fp state is its own mess.  When XSAVE happened, Intel kindly (?)
> > gave us a software defined area between the "legacy" x87 region and
> > the modern supposedly extensible part.  Linux sticks the following
> > structure in that hole:
> >
> > struct _fpx_sw_bytes {
> >      /*
> >       * If set to FP_XSTATE_MAGIC1 then this is an xstate context.
> >       * 0 if a legacy frame.
> >       */
> >      __u32                magic1;
> >
> >      /*
> >       * Total size of the fpstate area:
> >       *
> >       *  - if magic1 == 0 then it's sizeof(struct _fpstate)
> >       *  - if magic1 == FP_XSTATE_MAGIC1 then it's sizeof(struct _xstate)
> >       *    plus extensions (if any)
> >       */
> >      __u32                extended_size;
> >
> >      /*
> >       * Feature bit mask (including FP/SSE/extended state) that is present
> >       * in the memory layout:
> >       */
> >      __u64                xfeatures;
> >
> >      /*
> >       * Actual XSAVE state size, based on the xfeatures saved in the layout.
> >       * 'extended_size' is greater than 'xstate_size':
> >       */
> >      __u32                xstate_size;
> >
> >      /* For future use: */
> >      __u32                padding[7];
> > };
> >
> >
> > That's where we are right now upstream.  The kernel has a parser for
> > the FPU state that is bugs piled upon bugs and is going to have to be
> > rewritten sometime soon.  On top of all this, we have two upcoming
> > features, both of which require different kinds of extensions:
> >
> > 1. AVX-512.  (Yeah, you thought this story was over a few years ago,
> > but no.  And AMX makes it worse.)  To make a long story short, we
> > promised user code many years ago that a signal frame fit in 2048
> > bytes with some room to spare.  With AVX-512 this is false.  With AMX
> > it's so wrong it's not even funny.  The only way out of the mess
> > anyone has come up with involves making the length of the FPU state
> > vary depending on which features are INIT, i.e. making it more compact
> > than "compact" mode is.  This has a side effect: it's no longer
> > possible to modify the state in place, because enabling a feature with
> > no space allocated will make the structure bigger, and the stack won't
> > have room.  Fortunately, one can relocate the entire FPU state, update
> > the pointer in mcontext, and the kernel will happily follow the
> > pointer.  So new code on a new kernel using a super-compact state
> > could expand the state by allocating new memory (on the heap? very
> > awkwardly on the stack?) and changing the pointer.  For all we know,
> > some code already fiddles with the pointer.  This is great, except
> > that your patch sticks more data at the end of the FPU block that no
> > one is expecting, and your sigreturn code follows that pointer, and
> > will read off into lala land.
> >
>
> Then, what about we don't do that at all.  Is it possible from now on we
> don't stick more data at the end, and take the relocating-fpu approach?
>
> > 2. CET.  CET wants us to find a few more bytes somewhere, and those
> > bytes logically belong in ucontext, and here we are.
> >
>
> Fortunately, we can spare CET the need of ucontext extension.  When the
> kernel handles sigreturn, the user-mode shadow stack pointer is right at
> the restore token.  There is no need to put that in ucontext.

That seems entirely reasonable.  This might also avoid needing to
teach CRIU about CET at all.

>
> However, the WAIT_ENDBR status needs to be saved/restored for signals.
> Since IBT is now dependent on shadow stack, we can use a spare bit of
> the shadow stack restore token for that.

That seems like unnecessary ABI coupling.  We have plenty of bits in
uc_flags, and we have an entire reserved word in sigcontext.  How
about just sticking this bit in one of those places?

--Andy
