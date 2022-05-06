Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431F251DD61
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbiEFQSX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 12:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbiEFQSW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 12:18:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D50FE0AC;
        Fri,  6 May 2022 09:14:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651853677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGIaI6FR4z9ZKAajKHVzAuOrHeyDOTq0yBE9J83Z0DM=;
        b=BP8TefPhONS8kML5NOLtpqXmzambUy0GK8jRF4v5uGIa0Q+/JF67dmyIKUFDZXdtkdgEH3
        gAIhBHABcrOC2He1B7b5Y7v73xCxBS1QCOPiUZhjc5BsFx/1mQksKoyoU4EwvNH7+h4aoz
        Bdq07PrVDHsH6ZEYlsN/pWktW+cUEYejiG3BdFq0bzOTbDXcFeG37Hs5/mJ034JuqT7+PV
        3VKnqbSUd17z9NG8jDKj3nc5kv+pcwotIX+kChEH2NIVF828gwNWslAaUqeIUokFPXDJ5d
        GbN2LPaEKfDIabQrU9y03/pgCGy8JVUc125APHZoRU6jo7tzc4Oq+ThteyikYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651853677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGIaI6FR4z9ZKAajKHVzAuOrHeyDOTq0yBE9J83Z0DM=;
        b=pcMuIo9aq1DOq5bWbaoANP7IgoaUD36hkEleH8xagaT73ZawBHhxDCvKJEKK5auc97xb+k
        alDKkQkLUmqNSHAQ==
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
In-Reply-To: <CAG_fn=XVchXCcOhFt+rP=vinRhkyrXJSP46cyvcZeHJWaDquGg@mail.gmail.com>
References: <20220426164315.625149-1-glider@google.com>
 <20220426164315.625149-29-glider@google.com> <87a6c6y7mg.ffs@tglx>
 <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx>
 <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
 <878rrfiqyr.ffs@tglx>
 <CAG_fn=XVchXCcOhFt+rP=vinRhkyrXJSP46cyvcZeHJWaDquGg@mail.gmail.com>
Date:   Fri, 06 May 2022 18:14:36 +0200
Message-ID: <87k0ayhc43.ffs@tglx>
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

On Fri, May 06 2022 at 16:52, Alexander Potapenko wrote:
> On Thu, May 5, 2022 at 11:56 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> @@ -452,6 +455,7 @@ irqentry_state_t noinstr irqentry_nmi_en
>>         rcu_nmi_enter();
>>
>>         instrumentation_begin();
>> +       unpoison(regs);
>>         trace_hardirqs_off_finish();
>>         ftrace_nmi_enter();
>>         instrumentation_end();
>>
>> As I said: 4 places :)
>
> These four instances still do not look sufficient.
> Right now I am seeing e.g. reports with the following stack trace:
>
> BUG: KMSAN: uninit-value in irqtime_account_process_tick+0x255/0x580
> kernel/sched/cputime.c:382
>  irqtime_account_process_tick+0x255/0x580 kernel/sched/cputime.c:382
>  account_process_tick+0x98/0x450 kernel/sched/cputime.c:476
>  update_process_times+0xe4/0x3e0 kernel/time/timer.c:1786
>  tick_sched_handle kernel/time/tick-sched.c:243
>  tick_sched_timer+0x83e/0x9e0 kernel/time/tick-sched.c:1473
>  __run_hrtimer+0x518/0xe50 kernel/time/hrtimer.c:1685
>  __hrtimer_run_queues kernel/time/hrtimer.c:1749
>  hrtimer_interrupt+0x838/0x15a0 kernel/time/hrtimer.c:1811
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086
>  __sysvec_apic_timer_interrupt+0x1ae/0x680 arch/x86/kernel/apic/apic.c:1103
>  sysvec_apic_timer_interrupt+0x95/0xc0 arch/x86/kernel/apic/apic.c:1097
> ...
> (uninit creation stack trace is irrelevant here, because it is some
> random value from the stack)
>
> sysvec_apic_timer_interrupt() receives struct pt_regs from
> uninstrumented code, so regs can be partially uninitialized.
> They are not passed down the call stack directly, but are instead
> saved by set_irq_regs() in sysvec_apic_timer_interrupt() and loaded by
> get_irq_regs() in tick_sched_timer().

sysvec_apic_timer_interrupt() invokes irqentry_enter() _before_
set_irq_regs() and irqentry_enter() unpoisons @reg.

Confused...




