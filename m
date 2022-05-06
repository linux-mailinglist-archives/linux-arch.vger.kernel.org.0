Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391CE51DB30
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442486AbiEFO4y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 10:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442485AbiEFO4y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 10:56:54 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A530F6972C
        for <linux-arch@vger.kernel.org>; Fri,  6 May 2022 07:53:10 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f7c57ee6feso84228717b3.2
        for <linux-arch@vger.kernel.org>; Fri, 06 May 2022 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8x1ByB3JGKsEKA0yU+drp41tFZX/S/sAjt0JU8w8Oas=;
        b=Hx3cfMOxgqSoLe0fsErpWQSiRrByO8vc44yk837SHe03vklIhl8eWrGDUOUlw+p69q
         vmw8Jxql0io8n5hAV1ezTfvU7nnZIUvvc6obbMlTnkDBiB31i8hR51INscyHEtizxdTI
         2WMMybr8QaCcewUFkZc0Cu0AIMenlG+0A/vkeckzDBa3slyunHrDjEG7Syi6s6lpStMJ
         NLVFfVUogqjC9yEdt0ayVD9O7wEN1FxowV9ns1oG+BPbDQGg7PqSuEGGbcMjHkQBas8/
         D+0L6eoK8jP+O5/xJ2XBbEi89ZyKj2/9eS6b3u8MRUPWqruEVMjKzRRXk4F1Dj5q8scF
         hJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8x1ByB3JGKsEKA0yU+drp41tFZX/S/sAjt0JU8w8Oas=;
        b=tRfNVOZzctddFHAr2PcifmjehLVBi4Y7cMcW+lSg5KO/5qXX/RMpzOeHaRz5HTX3UA
         yRMWEsbzE5wEC6LTw5mlUM687QPtvVRsofaHeQNLhxe8XoQVyYEl0zfonCH1f8Xhfee3
         47wXof/61lZ4zwyQb3BGDs6+Wt2BcMWQ28Ht/e0PSwAU+lOCVDCs0HLOYLPOqEJDAPYm
         IVWegRFKe+T+yRHZQK4qx+RTpwtdeWJZyqQVXDsX43qqWJ7hPjUIe3WKAIAJTvUFJEoZ
         x5upTi9LudU/r0y6xqd6QQ6iOUHs9pmstrm1CKE1rs/U33KSXHS8fVJKgaaiNNw6LRS2
         WB1Q==
X-Gm-Message-State: AOAM532RjgwQBV7GhY6Up9vRWNxA72sBWvJdF2QBGBuoAYy9aNrO8kXi
        KYZiotBV1fzZM1pYwWaMhPM3ZXC9Yk/qCGiEHMrb7g==
X-Google-Smtp-Source: ABdhPJxKlsOV0ynPCCkwL4Y5Mf82DpFiTqXkmma8uCkly/j57cqXEb/p6HR+taiGyRcZf3rW5lGACwy5HDpUUiU1FrM=
X-Received: by 2002:a81:19d2:0:b0:2f8:ad73:1f33 with SMTP id
 201-20020a8119d2000000b002f8ad731f33mr2769528ywz.461.1651848789637; Fri, 06
 May 2022 07:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-29-glider@google.com>
 <87a6c6y7mg.ffs@tglx> <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx> <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
 <878rrfiqyr.ffs@tglx>
In-Reply-To: <878rrfiqyr.ffs@tglx>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 6 May 2022 16:52:33 +0200
Message-ID: <CAG_fn=XVchXCcOhFt+rP=vinRhkyrXJSP46cyvcZeHJWaDquGg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 5, 2022 at 11:56 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Alexander,
>
> On Thu, May 05 2022 at 20:04, Alexander Potapenko wrote:
> > On Tue, May 3, 2022 at 12:00 AM Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> >> > Regarding the regs, you are right. It should be enough to unpoison t=
he
> >> > regs at idtentry prologue instead.
> >> > I tried that initially, but IIRC it required patching each of the
> >> > DEFINE_IDTENTRY_XXX macros, which already use instrumentation_begin(=
).
> >>
> >> Exactly 4 instances :)
> >>
> >
> > Not really, I had to add a call to `kmsan_unpoison_memory(regs,
> > sizeof(*regs));` to the following places in
> > arch/x86/include/asm/idtentry.h:
> > - DEFINE_IDTENTRY()
> > - DEFINE_IDTENTRY_ERRORCODE()
> > - DEFINE_IDTENTRY_RAW()
> > - DEFINE_IDTENTRY_RAW_ERRORCODE()
> > - DEFINE_IDTENTRY_IRQ()
> > - DEFINE_IDTENTRY_SYSVEC()
> > - DEFINE_IDTENTRY_SYSVEC_SIMPLE()
> > - DEFINE_IDTENTRY_DF()
> >
> > , but even that wasn't enough. For some reason I also had to unpoison
> > pt_regs directly in
> > DEFINE_IDTENTRY_SYSVEC(sysvec_apic_timer_interrupt) and
> > DEFINE_IDTENTRY_IRQ(common_interrupt).
> > In the latter case, this could have been caused by
> > asm_common_interrupt being entered from irq_entries_start(), but I am
> > not sure what is so special about sysvec_apic_timer_interrupt().
> >
> > Ideally, it would be great to find that single point where pt_regs are
> > set up before being passed to all IDT entries.
> > I used to do that by inserting calls to kmsan_unpoison_memory right
> > into arch/x86/entry/entry_64.S
> > (https://github.com/google/kmsan/commit/3b0583f45f74f3a09f4c7e0e0588169=
cef918026),
> > but that required storing/restoring all GP registers. Maybe there's a
> > better way?
>
> Yes. Something like this should cover all exceptions and syscalls before
> anything instrumentable can touch @regs. Anything up to those points is
> either off-limit for instrumentation or does not deal with @regs.
>
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -24,6 +24,7 @@ static __always_inline void __enter_from
>         user_exit_irqoff();
>
>         instrumentation_begin();
> +       unpoison(regs);
>         trace_hardirqs_off_finish();
>         instrumentation_end();
>  }
> @@ -352,6 +353,7 @@ noinstr irqentry_state_t irqentry_enter(
>                 lockdep_hardirqs_off(CALLER_ADDR0);
>                 rcu_irq_enter();
>                 instrumentation_begin();
> +               unpoison(regs);
>                 trace_hardirqs_off_finish();
>                 instrumentation_end();
>
> @@ -367,6 +369,7 @@ noinstr irqentry_state_t irqentry_enter(
>          */
>         lockdep_hardirqs_off(CALLER_ADDR0);
>         instrumentation_begin();
> +       unpoison(regs);
>         rcu_irq_enter_check_tick();
>         trace_hardirqs_off_finish();
>         instrumentation_end();
> @@ -452,6 +455,7 @@ irqentry_state_t noinstr irqentry_nmi_en
>         rcu_nmi_enter();
>
>         instrumentation_begin();
> +       unpoison(regs);
>         trace_hardirqs_off_finish();
>         ftrace_nmi_enter();
>         instrumentation_end();
>
> As I said: 4 places :)

These four instances still do not look sufficient.
Right now I am seeing e.g. reports with the following stack trace:

BUG: KMSAN: uninit-value in irqtime_account_process_tick+0x255/0x580
kernel/sched/cputime.c:382
 irqtime_account_process_tick+0x255/0x580 kernel/sched/cputime.c:382
 account_process_tick+0x98/0x450 kernel/sched/cputime.c:476
 update_process_times+0xe4/0x3e0 kernel/time/timer.c:1786
 tick_sched_handle kernel/time/tick-sched.c:243
 tick_sched_timer+0x83e/0x9e0 kernel/time/tick-sched.c:1473
 __run_hrtimer+0x518/0xe50 kernel/time/hrtimer.c:1685
 __hrtimer_run_queues kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x838/0x15a0 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086
 __sysvec_apic_timer_interrupt+0x1ae/0x680 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x95/0xc0 arch/x86/kernel/apic/apic.c:1097
...
(uninit creation stack trace is irrelevant here, because it is some
random value from the stack)

sysvec_apic_timer_interrupt() receives struct pt_regs from
uninstrumented code, so regs can be partially uninitialized.
They are not passed down the call stack directly, but are instead
saved by set_irq_regs() in sysvec_apic_timer_interrupt() and loaded by
get_irq_regs() in tick_sched_timer().

The remaining false positives can be fixed by unpoisoning the
registers in set_irq_regs():

 static inline struct pt_regs *set_irq_regs(struct pt_regs *new_regs)
 {
        struct pt_regs *old_regs;
+       kmsan_unpoison_memory(new_regs, sizeof(*new_regs));

        old_regs =3D __this_cpu_read(__irq_regs);
        __this_cpu_write(__irq_regs, new_regs);

Does that sound viable? Is it correct to assume that set_irq_regs() is
always called for registers received from non-instrumented code?

(It seems that just unpoisoning registers in set_irq_regs() is not
enough, i.e. we still need to do what you suggest in
kernel/entry/common.c)
--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
