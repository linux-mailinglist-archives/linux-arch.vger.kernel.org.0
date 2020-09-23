Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A34276335
	for <lists+linux-arch@lfdr.de>; Wed, 23 Sep 2020 23:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIWVe6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 17:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgIWVe6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Sep 2020 17:34:58 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54FB238E5
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2020 21:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600896897;
        bh=K3EiV2+i9l9fYhhP6vZIZ7TO6ZkrF/uEBL+okHQVlPQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ujf5QnyE9ozyeO63lNVfcHgSuZWq4kLYhNj8yCH/l/GxggbLRqaHjG3tfyGsNwkAs
         /3eDOzWcZTh8f3gCOD8zu+ZTETyzg7Pd20RNC1LvCr9fRAu1YUJpj1QQUzQkr4di7N
         BAI02qlhlOGufa1Q/1PBd0f89tJvj4m4oXfajmTs=
Received: by mail-wr1-f44.google.com with SMTP id w5so1535198wrp.8
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2020 14:34:56 -0700 (PDT)
X-Gm-Message-State: AOAM5325KjLNPTKrhFBZHgQaUZMLmhzMohAE47CpQnD6uCV5tu5EZnkU
        PkIutGCrCrQeX8LOYcwiHkKaoY7GHCfDrl8207xU+w==
X-Google-Smtp-Source: ABdhPJyfQsGZbyi4V01pz1OVEaeeFMqLVS6c+RfyIwko8Czk8CD8ZGTZnfdpdZtjBo1QLuIeZl5Z60Sb9PZVsHax7bU=
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr1646948wrb.70.1600896895213;
 Wed, 23 Sep 2020 14:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200918192312.25978-1-yu-cheng.yu@intel.com> <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
 <c96c98ec-d72a-81a3-06e2-2040f3ece33a@intel.com> <24718de58ab7bc6d7288c58d3567ad802eeb6542.camel@intel.com>
 <CALCETrWssUxxfhPPJZgPOmpaQcf4o9qCe1j-P7yiPyZVV+O8ZQ@mail.gmail.com> <b3defc91-1e8e-d0d5-2ac3-3861a7e3355c@intel.com>
In-Reply-To: <b3defc91-1e8e-d0d5-2ac3-3861a7e3355c@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Sep 2020 14:34:43 -0700
X-Gmail-Original-Message-ID: <CALCETrUVUqK6_bjFNSmOjnWVNscwfWmMa6Bt9fQrpFa5m3xNwA@mail.gmail.com>
Message-ID: <CALCETrUVUqK6_bjFNSmOjnWVNscwfWmMa6Bt9fQrpFa5m3xNwA@mail.gmail.com>
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is enabled
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
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
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 22, 2020 at 10:46 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 9/21/2020 4:48 PM, Andy Lutomirski wrote:
> > On Mon, Sep 21, 2020 at 3:37 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >>
> >> On Mon, 2020-09-21 at 09:22 -0700, Yu, Yu-cheng wrote:
>
> [...]
>
> >>
> >> Here is the patch:
> >>
> >> ------
> >>
> >>  From dfdee39c795ee5dcee2c77f6ba344a61f4d8124b Mon Sep 17 00:00:00 2001
> >> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> >> Date: Thu, 29 Nov 2018 14:15:38 -0800
> >> Subject: [PATCH 34/43] x86/vsyscall/64: Fixup Shadow Stack and Indirect Branch
> >>   Tracking for vsyscall emulation
> >>
> >> Vsyscall entry points are effectively branch targets.  Mark them with
> >> ENDBR64 opcodes.  When emulating the RET instruction, unwind the shadow
> >> stack and reset IBT state machine.
> >>
> >> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> >> ---
> >>   arch/x86/entry/vsyscall/vsyscall_64.c     | 29 +++++++++++++++++++++++
> >>   arch/x86/entry/vsyscall/vsyscall_emu_64.S |  9 +++++++
> >>   arch/x86/entry/vsyscall/vsyscall_trace.h  |  1 +
> >>   3 files changed, 39 insertions(+)
> >>
> >> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
> >> b/arch/x86/entry/vsyscall/vsyscall_64.c
> >> index 44c33103a955..0131c9f7f9c5 100644
> >> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> >> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> >> @@ -38,6 +38,9 @@
> >>   #include <asm/fixmap.h>
> >>   #include <asm/traps.h>
> >>   #include <asm/paravirt.h>
> >> +#include <asm/fpu/xstate.h>
> >> +#include <asm/fpu/types.h>
> >> +#include <asm/fpu/internal.h>
> >>
> >>   #define CREATE_TRACE_POINTS
> >>   #include "vsyscall_trace.h"
> >> @@ -286,6 +289,32 @@ bool emulate_vsyscall(unsigned long error_code,
> >>          /* Emulate a ret instruction. */
> >>          regs->ip = caller;
> >>          regs->sp += 8;
> >> +
> >> +       if (current->thread.cet.shstk_size ||
> >> +           current->thread.cet.ibt_enabled) {
> >> +               u64 r;
> >> +
> >> +               fpregs_lock();
> >> +               if (test_thread_flag(TIF_NEED_FPU_LOAD))
> >> +                       __fpregs_load_activate();
> >
> > Wouldn't this be nicer if you operated on the memory image, not the registers?
>
> Do you mean writing to the XSAVES area?

Yes.

>
> >
> >> +
> >> +#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
> >> +               /* Fixup branch tracking */
> >> +               if (current->thread.cet.ibt_enabled) {
> >> +                       rdmsrl(MSR_IA32_U_CET, r);
> >> +                       wrmsrl(MSR_IA32_U_CET, r & ~CET_WAIT_ENDBR);
> >> +               }
> >> +#endif
> >
> > Seems reasonable on first glance.
> >
> >> +
> >> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> >> +               /* Unwind shadow stack. */
> >> +               if (current->thread.cet.shstk_size) {
> >> +                       rdmsrl(MSR_IA32_PL3_SSP, r);
> >> +                       wrmsrl(MSR_IA32_PL3_SSP, r + 8);
> >> +               }
> >> +#endif
> >
> > What happens if the result is noncanonical?  A quick skim of the SDM
> > didn't find anything.  This latter issue goes away if you operate on
> > the memory image, though -- writing a bogus value is just fine, since
> > the FP restore will handle it.
> >
>
> At this point, the MSR's value can still be valid or is already saved to
> memory.  If we are going to write to memory, then the MSR must be saved
> first.  So I chose to do __fpregs_load_activate() and write the MSR.
>
> Maybe we can check the address before writing it to the MSR?

Performance is almost irrelevant here, and the writing-to-XSAVES-area
approach should have the benefit that the exception handling and
signaling happens for free.
