Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CD7BBA61
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 19:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440153AbfIWRYU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 13:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393117AbfIWRYQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Sep 2019 13:24:16 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B375A2168B
        for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2019 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569259455;
        bh=DzycgKHCi19mMx4cgC/hY8TzO4MUiU13rQpq2YThoZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AgJtVR2zD2ID/COVmKJzNcv7L5FFBker86qUiq8xMUdR/grog+vdfoPdz1kl1i+2L
         3n8nUR6vNH6n2v3jWM0ceUb6UNpa3UdN0CZnhldbm2yHmP8a/ZloneXsUX2qePAseX
         7i/HLWr7tZbO8sx5lZGhoke2RMA9qDKtn6GgR5I4=
Received: by mail-wr1-f51.google.com with SMTP id i18so14846469wru.11
        for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2019 10:24:14 -0700 (PDT)
X-Gm-Message-State: APjAAAXcVVJLXfk0KYHSx1oIJAWQivMHXVtLvhDqFIjdu6PZ14379is2
        fHoDKMwhI485U4Y/QpyZkjXY2o820UTbMHQYdf4NIg==
X-Google-Smtp-Source: APXvYqzcNw/Fw315XYUmtYdbQHBHfab17/P4MaPRH38Ob6gFaeYiPSmAfE5s06olKUIUuopNukGDlqBjM+ujZLSvy+8=
X-Received: by 2002:adf:cc0a:: with SMTP id x10mr362155wrh.195.1569259453239;
 Mon, 23 Sep 2019 10:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190919150314.054351477@linutronix.de> <20190919150809.446771597@linutronix.de>
 <20190923084718.GG2349@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1909231227050.2003@nanos.tec.linutronix.de>
 <20190923114920.GF2332@hirez.programming.kicks-ass.net> <20190923115551.GZ2386@hirez.programming.kicks-ass.net>
 <20190923121001.GG2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190923121001.GG2332@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Sep 2019 10:24:01 -0700
X-Gmail-Original-Message-ID: <CALCETrW7T5KPCFO6vWUkExCYKdXVkv6mkfA53A542uxukP+eew@mail.gmail.com>
Message-ID: <CALCETrW7T5KPCFO6vWUkExCYKdXVkv6mkfA53A542uxukP+eew@mail.gmail.com>
Subject: Re: [RFC patch 10/15] x86/entry: Move irq tracing to C code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 23, 2019 at 5:10 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Sep 23, 2019 at 01:55:51PM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 23, 2019 at 01:49:20PM +0200, Peter Zijlstra wrote:
> > > While walking the kids to school I wondered WTH we need to call
> > > TRACE_IRQS_OFF in the first place. If this is the return from exception
> > > path, interrupts had better be disabled already (in exception enter).
> > >
> > > For entry_64.S we have:
> > >
> > >   - idtentry_part; which does TRACE_IRQS_OFF at the start and error_exit
> > >     at the end.
> > >
> > >   - xen_do_hypervisor_callback, xen_failsafe_callback -- which are
> > >     confusing.
> > >
> > > So in the normal case, it appears we can simply do:
> > >
> > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > > index b7c3ea4cb19d..e9cf59ac554e 100644
> > > --- a/arch/x86/entry/entry_64.S
> > > +++ b/arch/x86/entry/entry_64.S
> > > @@ -1368,8 +1368,6 @@ END(error_entry)
> > >
> > >  ENTRY(error_exit)
> > >     UNWIND_HINT_REGS
> > > -   DISABLE_INTERRUPTS(CLBR_ANY)
> > > -   TRACE_IRQS_OFF
> > >     testb   $3, CS(%rsp)
> > >     jz      retint_kernel
> > >     jmp     retint_user
> > >
> > > and all should be well. This leaves Xen...
> > >
> > > For entry_32.S it looks like nothing uses 'resume_userspace' so that
> > > ENTRY can go away. Which then leaves:
> > >
> > >  * ret_from_intr:
> > >   - common_spurious: TRACE_IRQS_OFF
> > >   - common_interrupt: TRACE_IRQS_OFF
> > >   - BUILD_INTERRUPT3: TRACE_IRQS_OFF
> > >   - xen_do_upcall: ...
> > >
> > >  * ret_from_exception:
> > >   - xen_failsafe_callback: ...
> > >   - common_exception_read_cr2: TRACE_IRQS_OFF
> > >   - common_exception: TRACE_IRQS_OFF
> > >   - int3: TRACE_IRQS_OFF
> > >
> > > Which again suggests:
> > >
> > > diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> > > index f83ca5aa8b77..7a19e7413a8e 100644
> > > --- a/arch/x86/entry/entry_32.S
> > > +++ b/arch/x86/entry/entry_32.S
> > > @@ -825,9 +825,6 @@ END(ret_from_fork)
> > >     cmpl    $USER_RPL, %eax
> > >     jb      restore_all_kernel              # not returning to v8086 or userspace
> > >
> > > -ENTRY(resume_userspace)
> > > -   DISABLE_INTERRUPTS(CLBR_ANY)
> > > -   TRACE_IRQS_OFF
> > >     movl    %esp, %eax
> > >     call    prepare_exit_to_usermode
> > >     jmp     restore_all
> > >
> > > with the notable exception (oh teh pun!) being Xen... _again_.
> > >
> > > With these patchlets on, we'd want prepare_exit_to_usermode() to
> > > validate the IRQ state, but AFAICT it _should_ all just 'work' (famous
> > > last words).
> > >
> > > Cc Juergen because Xen
> >
> > Arrgh.. faults!! they do local_irq_enable() but never disable them
> > again. Arguably those functions should be symmetric and restore IF when
> > they muck with it instead of relying on the exit path fixing things up.
>
> ---
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index f83ca5aa8b77..7a19e7413a8e 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -825,9 +825,6 @@ END(ret_from_fork)
>         cmpl    $USER_RPL, %eax
>         jb      restore_all_kernel              # not returning to v8086 or userspace

...

Yes, please, but can you add an assertion under CONFIG_DEBUG_ENTRY
that IRQs are actually off?
