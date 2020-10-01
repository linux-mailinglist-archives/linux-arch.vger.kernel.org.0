Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508D627F705
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 03:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgJABKf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 21:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729617AbgJABKf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Sep 2020 21:10:35 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26CBA221EF
        for <linux-arch@vger.kernel.org>; Thu,  1 Oct 2020 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601514633;
        bh=pHq5pJpYKrfc4SrVwINHvkk5fdj4v2c/IBE6vUVBA24=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zm5aCTk/sVr/pU9rDMBUrGBdeas9sD/FX7/wNUHtwE0BtXBPIMr772YAGiG2WmRTk
         J0GTzBvmn3y/QcHtwU2O25ymPjuztFw00NZO0bT0edAkDMJIsctPxgu+mvcWH2TfUZ
         9dZQbU7hFRksEJFtFN9zyU70wFrR4YUpV6QEeCA8=
Received: by mail-wr1-f42.google.com with SMTP id o5so3716830wrn.13
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 18:10:33 -0700 (PDT)
X-Gm-Message-State: AOAM530bE+9DFKve0W0X2iwJmBGMpreqJC00v2KdwOaX9dg+WgbqMskJ
        6pkiaNL9u4i0qdx1bZqD4kFZcxbrVs0feUcm8oB2nw==
X-Google-Smtp-Source: ABdhPJyeedVaH1YrWPzgVb/YjwYsrQOcnOiupnFz5QIxyB3dlHWAkhKAMveGNrJuREIyuBmXMaID9uNeO3rW5PCMqpA=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr5793346wrv.184.1601514631554;
 Wed, 30 Sep 2020 18:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <d0e4077e-129f-6823-dcea-a101ef626e8c@intel.com>
 <99B32E59-CFF2-4756-89BD-AEA0021F355F@amacapital.net> <d9099183dadde8fe675e1b10e589d13b0d46831f.camel@intel.com>
 <CALCETrWuhPE3A7eWC=ERJa7i7jLtsXnfu04PKUFJ-Gybro+p=Q@mail.gmail.com>
 <b8797fcd-9d70-5749-2277-ef61f2e1be1f@intel.com> <CALCETrWvWAxEuyteLaPmmu-r5LcWdh_DuW4JAOh3pVD4skWoBQ@mail.gmail.com>
 <CALCETrVvob1dbdWSvaB0ZK1kJ19o9ZKy=U3tFifwOR++_xk=zA@mail.gmail.com>
 <dd4310bd-a76b-cf19-4f12-0b52d7bc483d@intel.com> <CALCETrXgde6yHTKw1Njnxp9cANp6Ee8bmG9C2X4e-Fz0ZZCuBw@mail.gmail.com>
 <CAMe9rOonjX-b46sJ3AYSJZV84d=oU6-KhScnk5vksVqoLgQ90A@mail.gmail.com>
In-Reply-To: <CAMe9rOonjX-b46sJ3AYSJZV84d=oU6-KhScnk5vksVqoLgQ90A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 30 Sep 2020 18:10:19 -0700
X-Gmail-Original-Message-ID: <CALCETrWoGXDDEvy10LoYVY6c_tkpMVABhCy+8pse9Rw8L9L=5A@mail.gmail.com>
Message-ID: <CALCETrWoGXDDEvy10LoYVY6c_tkpMVABhCy+8pse9Rw8L9L=5A@mail.gmail.com>
Subject: Re: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect
 Branch Tracking for vsyscall emulation
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 30, 2020 at 6:01 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Wed, Sep 30, 2020 at 4:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Sep 30, 2020 at 3:33 PM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
> > >
> > > On 9/29/2020 1:00 PM, Andy Lutomirski wrote:
> > > > On Tue, Sep 29, 2020 at 12:57 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > >>
> > > >> On Tue, Sep 29, 2020 at 11:37 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
> > > >>>
> > > >>> On 9/28/2020 10:37 AM, Andy Lutomirski wrote:
> > > >>>> On Mon, Sep 28, 2020 at 9:59 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > > >>>>>
> > > >>>>> On Fri, 2020-09-25 at 09:51 -0700, Andy Lutomirski wrote:
> > > >>>>>>> On Sep 25, 2020, at 9:48 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
> > > >>>>> +
> > > >>>>> +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> > > >>>>> +               if (!cet) {
> > > >>>>> +                       /*
> > > >>>>> +                        * This is an unlikely case where the task is
> > > >>>>> +                        * CET-enabled, but CET xstate is in INIT.
> > > >>>>> +                        */
> > > >>>>> +                       WARN_ONCE(1, "CET is enabled, but no xstates");
> > > >>>>
> > > >>>> "unlikely" doesn't really cover this.
> > > >>>>
> > > >>>>> +                       fpregs_unlock();
> > > >>>>> +                       goto sigsegv;
> > > >>>>> +               }
> > > >>>>> +
> > > >>>>> +               if (cet->user_ssp && ((cet->user_ssp + 8) < TASK_SIZE_MAX))
> > > >>>>> +                       cet->user_ssp += 8;
> > > >>>>
> > > >>>> This looks buggy.  The condition should be "if SHSTK is on, then add 8
> > > >>>> to user_ssp".  If the result is noncanonical, then some appropriate
> > > >>>> exception should be generated, probably by the FPU restore code -- see
> > > >>>> below.  You should be checking the SHSTK_EN bit, not SSP.
> > > >>>
> > > >>> Updated.  Is this OK?  I will resend the whole series later.
> > > >>>
> > > >>> Thanks,
> > > >>> Yu-cheng
> > > >>>
> > > >>> ======
> > > >>>
> > > >>>   From 09803e66dca38d7784e32687d0693550948199ed Mon Sep 17 00:00:00 2001
> > > >>> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > >>> Date: Thu, 29 Nov 2018 14:15:38 -0800
> > > >>> Subject: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and
> > > >>> Indirect Branch
> > > >>>    Tracking for vsyscall emulation
> > > >>>
> > > >>> Vsyscall entry points are effectively branch targets.  Mark them with
> > > >>> ENDBR64 opcodes.  When emulating the RET instruction, unwind shadow stack
> > > >>> and reset IBT state machine.
> > > >>>
> > > >>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > >>> ---
> > > >>> v13:
> > > >>> - Check shadow stack address is canonical.
> > > >>> - Change from writing to MSRs to writing to CET xstate.
> > > >>>
> > > >>>    arch/x86/entry/vsyscall/vsyscall_64.c     | 34 +++++++++++++++++++++++
> > > >>>    arch/x86/entry/vsyscall/vsyscall_emu_64.S |  9 ++++++
> > > >>>    arch/x86/entry/vsyscall/vsyscall_trace.h  |  1 +
> > > >>>    3 files changed, 44 insertions(+)
> > > >>>
> > > >>> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
> > > >>> b/arch/x86/entry/vsyscall/vsyscall_64.c
> > > >>> index 44c33103a955..30b166091d46 100644
> > > >>> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > > >>> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > > >>> @@ -38,6 +38,9 @@
> > > >>>    #include <asm/fixmap.h>
> > > >>>    #include <asm/traps.h>
> > > >>>    #include <asm/paravirt.h>
> > > >>> +#include <asm/fpu/xstate.h>
> > > >>> +#include <asm/fpu/types.h>
> > > >>> +#include <asm/fpu/internal.h>
> > > >>>
> > > >>>    #define CREATE_TRACE_POINTS
> > > >>>    #include "vsyscall_trace.h"
> > > >>> @@ -286,6 +289,44 @@ bool emulate_vsyscall(unsigned long error_code,
> > > >>>          /* Emulate a ret instruction. */
> > > >>>          regs->ip = caller;
> > > >>>          regs->sp += 8;
> > > >>> +
> > > >>> +#ifdef CONFIG_X86_CET
> > > >>> +       if (tsk->thread.cet.shstk_size || tsk->thread.cet.ibt_enabled) {
> > > >>> +               struct cet_user_state *cet;
> > > >>> +               struct fpu *fpu;
> > > >>> +
> > > >>> +               fpu = &tsk->thread.fpu;
> > > >>> +               fpregs_lock();
> > > >>> +
> > > >>> +               if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> > > >>> +                       copy_fpregs_to_fpstate(fpu);
> > > >>> +                       set_thread_flag(TIF_NEED_FPU_LOAD);
> > > >>> +               }
> > > >>> +
> > > >>> +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> > > >>> +               if (!cet) {
> > > >>> +                       /*
> > > >>> +                        * This should not happen.  The task is
> > > >>> +                        * CET-enabled, but CET xstate is in INIT.
> > > >>> +                        */
> > > >>
> > > >> Can the comment explain better, please?  I would say something like:
> > > >>
> > > >> If the kernel thinks this task has CET enabled (because
> > > >> tsk->thread.cet has one of the features enabled), then the
> > > >> corresponding bits must also be set in the CET XSAVES region.  If the
> > > >> CET XSAVES region is in the INIT state, then the kernel's concept of
> > > >> the task's CET state is corrupt.
> > > >>
> > > >>> +                       WARN_ONCE(1, "CET is enabled, but no xstates");
> > > >>> +                       fpregs_unlock();
> > > >>> +                       goto sigsegv;
> > > >>> +               }
> > > >>> +
> > > >>> +               if (cet->user_cet & CET_SHSTK_EN) {
> > > >>> +                       if (cet->user_ssp && (cet->user_ssp + 8 < TASK_SIZE_MAX))
> > > >>> +                               cet->user_ssp += 8;
> > > >>> +               }
> > > >>
> > > >> This makes so sense to me.  Also, the vsyscall emulation code is
> > > >> intended to be as rigid as possible to minimize the chance that it
> > > >> gets used as an exploit gadget.  So we should not silently corrupt
> > > >> anything.  Moreover, this code seems quite dangerous -- you've created
> > > >> a gadget that does RET without actually verifying the SHSTK token.  If
> > > >> SHSTK and some form of strong indirect branch/call CFI is in use, then
> > > >> the existance of a CFI-bypassing return primitive at a fixed address
> > > >> seems quite problematic.
> > > >>
> > > >> So I think you need to write a function that reasonably accurately
> > > >> emulates a usermode RET.
> > > >>
> > > >
> > > > For what it's worth, I think there is an alternative.  If you all
> > > > (userspace people, etc) can come up with a credible way for a user
> > > > program to statically declare that it doesn't need vsyscalls, then we
> > > > could make SHSTK depend on *that*, and we could avoid this mess.  This
> > > > breaks orthogonality, but it's probably a decent outcome.
> > > >
> > >
> > > Would an arch_prctl(DISABLE_VSYSCALL) work?  The kernel then sets a
> > > thread flag, and in emulate_vsyscall(), checks the flag.
> > >
> > > When CET is enabled, ld-linux will do DISABLE_VSYSCALL.
> > >
> > > How is that?
> >
> > Backwards, no?  Presumably vsyscall needs to be disabled before or
> > concurrently with CET being enabled, not after.
> >
> > I think the solution of making vsyscall emulation work correctly with
> > CET is going to be better and possibly more straightforward.
> >
>
> We can do
>
> 1. Add ARCH_X86_DISABLE_VSYSCALL to disable the vsyscall page.
> 2. If CPU supports CET and the program is CET enabled:
>     a. Disable the vsyscall page.
>     b. Pass control to user.
>     c. Enable the vsyscall page when ARCH_X86_CET_DISABLE is called.
>
> So when control is passed from kernel to user, the vsyscall page is
> disabled if the program
> is CET enabled.

Let me say this one more time:

If we have a per-process vsyscall disable control and a per-process
CET control, we are going to keep those settings orthogonal.  I'm
willing to entertain an option in which enabling SHSTK without also
disabling vsyscalls is disallowed, We are *not* going to have any CET
flags magically disable vsyscalls, though, and we are not going to
have a situation where disabling vsyscalls on process startup requires
enabling SHSTK.

Any possible static vsyscall controls (and CET controls, for that
matter) also need to come with some explanation of whether they are
properties set on the ELF loader, the ELF program being loaded, or
both.  And this explanation needs to cover what happens when old
binaries link against new libc versions and vice versa.  A new
CET-enabled binary linked against old libc running on a new kernel
that is expected to work on a non-CET CPU MUST work on a CET CPU, too.

Right now, literally the only thing preventing vsyscall emulation from
coexisting with SHSTK is that the implementation eeds work.

So your proposal is rejected.  Sorry.
