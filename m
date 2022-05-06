Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE951DF35
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 20:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354936AbiEFSox (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFSov (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 14:44:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F5450B37;
        Fri,  6 May 2022 11:41:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651862462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbruHfD7L5ui13yo40XACqjP4QTu0Yh5HyGtytqH9h0=;
        b=toC9h/bBwe9VN8u0hUjpXZdGLr+EKTd0NwPxoibysZHnQ+TBBXS2E0bhBMWj05jHILbNUK
        SvdtClNM77RiRFJ/LNGfReUgCpisxqP/hFYB+n+XxiUxV4WruMJEdzaAqLvW5MrL/ZhyCX
        If7RuFXFoPo3d0+qqtXuxRp7HKE+jCnpzh060a8MhUqh5WlTx73Na0uCiJG5IQ6bmgzVKr
        3io8ZEPWGWuAUxQB6j7nvde2mxp3AGn/uAP8x2DLvWSJBGR8itlEAg2KPbBFtHX0Wc0lpB
        fNaTb6o1nji7JWcAHXB9VmdptlPDMjp8g3bU377UrR3Lbjczd9mO3gzfIXyjRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651862462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbruHfD7L5ui13yo40XACqjP4QTu0Yh5HyGtytqH9h0=;
        b=8YaG10zQ5qm1FsH6PnUal8N/UCNILrym23WsmzAwEeH3cDqPKu9wU9s+9+YmXF8OHFEOcR
        it8ZOdn6PPQ+ZRDA==
To:     Alexander Potapenko <glider@google.com>
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
Subject: Re: [PATCH v3 28/46] kmsan: entry: handle register passing from
 uninstrumented code
In-Reply-To: <CAG_fn=UpcXMqJiZvho6_G3rjvjQA-3Ax6X8ONVO0D+4Pttc9dA@mail.gmail.com>
References: <20220426164315.625149-1-glider@google.com>
 <20220426164315.625149-29-glider@google.com> <87a6c6y7mg.ffs@tglx>
 <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx>
 <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
 <878rrfiqyr.ffs@tglx>
 <CAG_fn=XVchXCcOhFt+rP=vinRhkyrXJSP46cyvcZeHJWaDquGg@mail.gmail.com>
 <87k0ayhc43.ffs@tglx>
 <CAG_fn=UpcXMqJiZvho6_G3rjvjQA-3Ax6X8ONVO0D+4Pttc9dA@mail.gmail.com>
Date:   Fri, 06 May 2022 20:41:01 +0200
Message-ID: <87h762h5c2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 06 2022 at 19:41, Alexander Potapenko wrote:
> On Fri, May 6, 2022 at 6:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> sysvec_apic_timer_interrupt() invokes irqentry_enter() _before_
>> set_irq_regs() and irqentry_enter() unpoisons @reg.
>>
>> Confused...
>
> As far as I can tell in this case sysvect_apic_timer_interrupt() is
> called by the following code in arch/x86/kernel/idt.c:
>
>   INTG(LOCAL_TIMER_VECTOR,                asm_sysvec_apic_timer_interrupt),
>
> , which does not use IDTENTRY_SYSVEC framework and thus does not call
> irqentry_enter().

  asm_sysvec_apic_timer_interrupt != sysvec_apic_timer_interrupt

arch/x86/kernel/apic/apic.c:
DEFINE_IDTENTRY_SYSVEC(sysvec_apic_timer_interrupt)
{
        ....

#define DEFINE_IDTENTRY_SYSVEC(func)					\
static void __##func(struct pt_regs *regs);				\
									\
__visible noinstr void func(struct pt_regs *regs)			\
{									\
	irqentry_state_t state = irqentry_enter(regs);			\
        ....
	__##func (regs);						\
        ....
}                                                                       \
		                                                        \
static noinline void __##func(struct pt_regs *regs)

So it goes through that code path _before_ the actual implementation
which does set_irq_regs() is reached.

The callchain is:

  asm_sysvec_apic_timer_interrupt               <- ASM entry in gate
     sysvec_apic_timer_interrupt(regs)          <- noinstr C entry point
        irqentry_enter(regs)                    <- unpoisons @reg
        __sysvec_apic_timer_interrupt(regs)     <- the actual handler
           set_irq_regs(regs)                   <- stores regs
           local_apic_timer_interrupt()
             ...
             tick_handler()                     <- One of the 4 variants
                regs = get_irq_regs();          <- retrieves regs
                update_process_times(user_tick = user_mode(regs))
                   account_process_tick(user_tick)
                      irqtime_account_process_tick(user_tick)
line 382:                } else if { user_tick }   <- KMSAN complains

I'm even more confused now.

> I guess handling those will require wrapping every interrupt gate into
> a function that performs register unpoisoning?

No, guessing does not help here.

The gates point to the ASM entry point, which then invokes the C entry
point. All C entry points use a DEFINE_IDTENTRY variant.

Some of the DEFINE_IDTENTRY_* C entry points are not doing anything in
the macro, but the C function either invokes irqentry_enter() or
irqentry_nmi_enter() open coded _before_ invoking any instrumentable
function. So the unpoisoning of @regs in these functions should tell
KMSAN that @regs or something derived from @regs are not some random
uninitialized values.

There should be no difference between unpoisoning @regs in
irqentry_enter() or in set_irq_regs(), right?

If so, then the problem is definitely _not_ the idt entry code.

> By the way, if it helps, I think we don't necessarily have to call
> kmsan_unpoison_memory() from within the
> instrumentation_begin()/instrumentation_end() region?
> We could move the call to the beginning of irqentry_enter(), removing
> unnecessary duplication.

We could, but then you need to mark unpoison_memory() noinstr too and you
have to add the unpoison into the syscall code. No win and irrelevant to
the problem at hand.

Thanks,

        tglx


