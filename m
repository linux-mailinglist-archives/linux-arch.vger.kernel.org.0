Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7431251DE6B
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444238AbiEFRp6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiEFRp6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 13:45:58 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E155373B
        for <linux-arch@vger.kernel.org>; Fri,  6 May 2022 10:42:14 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y2so14086985ybi.7
        for <linux-arch@vger.kernel.org>; Fri, 06 May 2022 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKfnJFHuOviCdMg0UB5UffT9B/WVcObEOxiRN5y2Kug=;
        b=emmUN3k1bPN4J6n6aBe2FemprgUT+FF6VAYxV6ekMwnHvd4yMg9T5KGYmUYmFa9oAe
         l8wgj8tdCP2FJPIShfAg2Fk/rOBVcSKoqvKeqjnUKen1LIajvaEdZt/TPfqzH6t/XrSo
         syM1kjCv3gSDfacEuEc3EgG0lwGjeC2hWNg5U2El7kqEz+o0tsjk8MjpqNijR6o+XqPs
         q3onvlApQgHZ5xOXxhHzjSgk18UOnvT+GgtT76x6XFC/llE4jgVQddy0F0CFkFJAkHTB
         0S9hvZkV7X0lPAIZLLytf/7qjnZXN3mz9RqswI5f966807Geg/q/71UbscP2MlkhGUSo
         7bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKfnJFHuOviCdMg0UB5UffT9B/WVcObEOxiRN5y2Kug=;
        b=0s+/KqsAlTmSaTtTmX29Kx2aVER688asdQMViRLLXVPnATp77GTWtxywX4bJt9Wxg+
         /a46DAaF/XeEjUw15jDKWly5C5Iw0AAGMWBdTmBm7V7QwxaRvrK1dOSJhXoUL/UQ6CJu
         AQmJsGKV/CYyt/9EvhnN+LGmrpgVP0/PyxuVGpRBwE/cLzfv2PML1B1RD5bzXNyU8lCX
         SMt3n+ePh7BdW4h6oc9aDHHjvSRwdOM/OLw+QW0W8tNWBbsgJ2ZSw2TNZRqxOYP6J2NS
         pYSCMVPug6107XB4N0vTVSJKcG0nPc1F+S84e2J9SuS+1AGEGh8jHm5mI53GvJkuk6PH
         Dfpg==
X-Gm-Message-State: AOAM532/2qm9N0JS13bOqCeiiTEaZqmYdboF+Q3qpan+gfrBi6TERWYw
        qQcr5+bE9WuX2JkKst4h+yqbeFBgIbTTLL0GSb/Acw==
X-Google-Smtp-Source: ABdhPJws5njwDWJ9xDpRYMne8cwuzMbwVAp2MzFRAKHvjVIKPSom5y1drK/dJlbHrWExYpCexhrZLlT5LtJ6/fdqUbo=
X-Received: by 2002:a25:bb0f:0:b0:61d:60f9:aaf9 with SMTP id
 z15-20020a25bb0f000000b0061d60f9aaf9mr3038082ybg.199.1651858933696; Fri, 06
 May 2022 10:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-29-glider@google.com>
 <87a6c6y7mg.ffs@tglx> <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx> <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
 <878rrfiqyr.ffs@tglx> <CAG_fn=XVchXCcOhFt+rP=vinRhkyrXJSP46cyvcZeHJWaDquGg@mail.gmail.com>
 <87k0ayhc43.ffs@tglx>
In-Reply-To: <87k0ayhc43.ffs@tglx>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 6 May 2022 19:41:37 +0200
Message-ID: <CAG_fn=UpcXMqJiZvho6_G3rjvjQA-3Ax6X8ONVO0D+4Pttc9dA@mail.gmail.com>
Subject: Re: [PATCH v3 28/46] kmsan: entry: handle register passing from
 uninstrumented code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 6, 2022 at 6:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, May 06 2022 at 16:52, Alexander Potapenko wrote:
> > On Thu, May 5, 2022 at 11:56 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> @@ -452,6 +455,7 @@ irqentry_state_t noinstr irqentry_nmi_en
> >>         rcu_nmi_enter();
> >>
> >>         instrumentation_begin();
> >> +       unpoison(regs);
> >>         trace_hardirqs_off_finish();
> >>         ftrace_nmi_enter();
> >>         instrumentation_end();
> >>
> >> As I said: 4 places :)
> >
> > These four instances still do not look sufficient.
> > Right now I am seeing e.g. reports with the following stack trace:
> >
> > BUG: KMSAN: uninit-value in irqtime_account_process_tick+0x255/0x580
> > kernel/sched/cputime.c:382
> >  irqtime_account_process_tick+0x255/0x580 kernel/sched/cputime.c:382
> >  account_process_tick+0x98/0x450 kernel/sched/cputime.c:476
> >  update_process_times+0xe4/0x3e0 kernel/time/timer.c:1786
> >  tick_sched_handle kernel/time/tick-sched.c:243
> >  tick_sched_timer+0x83e/0x9e0 kernel/time/tick-sched.c:1473
> >  __run_hrtimer+0x518/0xe50 kernel/time/hrtimer.c:1685
> >  __hrtimer_run_queues kernel/time/hrtimer.c:1749
> >  hrtimer_interrupt+0x838/0x15a0 kernel/time/hrtimer.c:1811
> >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086
> >  __sysvec_apic_timer_interrupt+0x1ae/0x680 arch/x86/kernel/apic/apic.c:1103
> >  sysvec_apic_timer_interrupt+0x95/0xc0 arch/x86/kernel/apic/apic.c:1097
> > ...
> > (uninit creation stack trace is irrelevant here, because it is some
> > random value from the stack)
> >
> > sysvec_apic_timer_interrupt() receives struct pt_regs from
> > uninstrumented code, so regs can be partially uninitialized.
> > They are not passed down the call stack directly, but are instead
> > saved by set_irq_regs() in sysvec_apic_timer_interrupt() and loaded by
> > get_irq_regs() in tick_sched_timer().
>
> sysvec_apic_timer_interrupt() invokes irqentry_enter() _before_
> set_irq_regs() and irqentry_enter() unpoisons @reg.
>
> Confused...

As far as I can tell in this case sysvect_apic_timer_interrupt() is
called by the following code in arch/x86/kernel/idt.c:

  INTG(LOCAL_TIMER_VECTOR,                asm_sysvec_apic_timer_interrupt),

, which does not use IDTENTRY_SYSVEC framework and thus does not call
irqentry_enter().

I guess handling those will require wrapping every interrupt gate into
a function that performs register unpoisoning?

By the way, if it helps, I think we don't necessarily have to call
kmsan_unpoison_memory() from within the
instrumentation_begin()/instrumentation_end() region?
We could move the call to the beginning of irqentry_enter(), removing
unnecessary duplication.
