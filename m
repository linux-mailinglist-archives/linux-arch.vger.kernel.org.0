Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927602736C5
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 01:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgIUXsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 19:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgIUXsj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Sep 2020 19:48:39 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EDD523A77
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2020 23:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600732118;
        bh=N8vHQdEHpTHWvUHKpDbNH8Yi1jVK5l/yl5V+P+NE0OA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=goDxIMoDoxVa3C64VsVsoO1jj5SNv4S6MzZHZ98rF+dlRwaM2zylky7OMs58V0cIt
         0k34+7+qqV1O1on10uR7KTin37l5HHeADO5pXJZJTKNV4jiznZr/kCqEdpy6SoWJMv
         J+loS6sIAobeIhC7PKoJMovzXnqu/F07k7RzKvZA=
Received: by mail-wr1-f53.google.com with SMTP id c18so15004373wrm.9
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2020 16:48:38 -0700 (PDT)
X-Gm-Message-State: AOAM531KmVEymDs/3GNv9swF+9GbDmw8lz6qSMzo9hNkCE8j2qPinfmU
        0hqbhEHkNK5ehSSNILGAGRab0QNyNv9FBBvk+DIRoA==
X-Google-Smtp-Source: ABdhPJzngS+LJRRhcziEyC3Eee4FojJ0Xz7OhABh4eqwGzQo/447WGnYoKx4dZhgKZSGTGYlukUJFQ1u+OQ1i1Jxyaw=
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr2138226wrw.75.1600732116993;
 Mon, 21 Sep 2020 16:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200918192312.25978-1-yu-cheng.yu@intel.com> <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
 <c96c98ec-d72a-81a3-06e2-2040f3ece33a@intel.com> <24718de58ab7bc6d7288c58d3567ad802eeb6542.camel@intel.com>
In-Reply-To: <24718de58ab7bc6d7288c58d3567ad802eeb6542.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 21 Sep 2020 16:48:25 -0700
X-Gmail-Original-Message-ID: <CALCETrWssUxxfhPPJZgPOmpaQcf4o9qCe1j-P7yiPyZVV+O8ZQ@mail.gmail.com>
Message-ID: <CALCETrWssUxxfhPPJZgPOmpaQcf4o9qCe1j-P7yiPyZVV+O8ZQ@mail.gmail.com>
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is enabled
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
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

On Mon, Sep 21, 2020 at 3:37 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Mon, 2020-09-21 at 09:22 -0700, Yu, Yu-cheng wrote:
> > On 9/18/2020 5:11 PM, Andy Lutomirski wrote:
> > > On Fri, Sep 18, 2020 at 12:23 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > > > Emulation of the legacy vsyscall page is required by some programs
> > > > built before 2013.  Newer programs after 2013 don't use it.
> > > > Disable vsyscall emulation when Control-flow Enforcement (CET) is
> > > > enabled to enhance security.
> > > >
> > > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> [...]
> > >
> > > Nope, try again.  Having IBT on does *not* mean that every library in
> > > the process knows that we have indirect branch tracking.  The legacy
> > > bitmap exists for a reason.  Also, I want a way to flag programs as
> > > not using the vsyscall page, but that flag should not be called CET.
> > > And a process with vsyscalls off should not be able to read the
> > > vsyscall page, and /proc/self/maps should be correct.
> > >
> > > So you have some choices:
> > >
> > > 1. Drop this patch and make it work.
> > >
> > > 2. Add a real per-process vsyscall control.  Either make it depend on
> > > vsyscall=xonly and wire it up correctly or actually make it work
> > > correctly with vsyscall=emulate.
> > >
> > > NAK to any hacks in this space.  Do it right or don't do it at all.
> > >
> >
> > We can drop this patch, and bring back the previous patch that fixes up
> > shadow stack and ibt.  That makes vsyscall emulation work correctly, and
> > does not force the application to do anything different from what is
> > working now.  I will post the previous patch as a reply to this thread
> > so that people can make comments on it.
> >
> > Yu-cheng
>
> Here is the patch:
>
> ------
>
> From dfdee39c795ee5dcee2c77f6ba344a61f4d8124b Mon Sep 17 00:00:00 2001
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Date: Thu, 29 Nov 2018 14:15:38 -0800
> Subject: [PATCH 34/43] x86/vsyscall/64: Fixup Shadow Stack and Indirect Branch
>  Tracking for vsyscall emulation
>
> Vsyscall entry points are effectively branch targets.  Mark them with
> ENDBR64 opcodes.  When emulating the RET instruction, unwind the shadow
> stack and reset IBT state machine.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/entry/vsyscall/vsyscall_64.c     | 29 +++++++++++++++++++++++
>  arch/x86/entry/vsyscall/vsyscall_emu_64.S |  9 +++++++
>  arch/x86/entry/vsyscall/vsyscall_trace.h  |  1 +
>  3 files changed, 39 insertions(+)
>
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
> b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 44c33103a955..0131c9f7f9c5 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -38,6 +38,9 @@
>  #include <asm/fixmap.h>
>  #include <asm/traps.h>
>  #include <asm/paravirt.h>
> +#include <asm/fpu/xstate.h>
> +#include <asm/fpu/types.h>
> +#include <asm/fpu/internal.h>
>
>  #define CREATE_TRACE_POINTS
>  #include "vsyscall_trace.h"
> @@ -286,6 +289,32 @@ bool emulate_vsyscall(unsigned long error_code,
>         /* Emulate a ret instruction. */
>         regs->ip = caller;
>         regs->sp += 8;
> +
> +       if (current->thread.cet.shstk_size ||
> +           current->thread.cet.ibt_enabled) {
> +               u64 r;
> +
> +               fpregs_lock();
> +               if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +                       __fpregs_load_activate();

Wouldn't this be nicer if you operated on the memory image, not the registers?

> +
> +#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
> +               /* Fixup branch tracking */
> +               if (current->thread.cet.ibt_enabled) {
> +                       rdmsrl(MSR_IA32_U_CET, r);
> +                       wrmsrl(MSR_IA32_U_CET, r & ~CET_WAIT_ENDBR);
> +               }
> +#endif

Seems reasonable on first glance.

> +
> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +               /* Unwind shadow stack. */
> +               if (current->thread.cet.shstk_size) {
> +                       rdmsrl(MSR_IA32_PL3_SSP, r);
> +                       wrmsrl(MSR_IA32_PL3_SSP, r + 8);
> +               }
> +#endif

What happens if the result is noncanonical?  A quick skim of the SDM
didn't find anything.  This latter issue goes away if you operate on
the memory image, though -- writing a bogus value is just fine, since
the FP restore will handle it.
