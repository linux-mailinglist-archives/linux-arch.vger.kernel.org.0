Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EE6525251
	for <lists+linux-arch@lfdr.de>; Thu, 12 May 2022 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbiELQRS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 May 2022 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356377AbiELQRP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 May 2022 12:17:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F3510B3CF;
        Thu, 12 May 2022 09:17:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652372231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3WA7a2LKBsvGjpHAfwHZrsdX5lPf+mXnzFb/W6CTG4=;
        b=M2SNi8xRlFNsaTf4EnM632IULRDzo8Lh9IAaPhgFV1fYK8RqrQDWoPkNTF2vcwphpIqR8c
        lM0WdyegTuvPqzbzdNjo6FXwZOVH8SYmYie3wSCTCbQt9OAVR7VhT7snHk7EZZ4HSMiVNh
        YB6rIykaXznfefVPXXp55XmG4NMpCtoasCHoeWXHQQc1U4QPsS6pDRFmQhfG47a2QFvPyf
        dI5VgqJPpF8of7FJfUD/7R0i2q2kDJXELWPTg4fefEI0EW2vgMFIuYLFfWOSCQR2pwVJdS
        dHD2sTWVhsHJlsB4lAPZZ1xHYuEFG+ILoVEz5I7pb4/IbxyTZsCtAjyIp12QpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652372231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3WA7a2LKBsvGjpHAfwHZrsdX5lPf+mXnzFb/W6CTG4=;
        b=W90ZtdXlwRF+/ciwbpXvb7TIXlmhwJBIcwThOHIJql1Ajmtg8N8/gWVkSg1avC7iab1Fs1
        rtsKmNIz8W8ezIAw==
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
In-Reply-To: <CAG_fn=VtQw1gL_UVONHi=OJakOuMa3wKfkzP0jWcuvGQEmV9Vw@mail.gmail.com>
References: <20220426164315.625149-1-glider@google.com>
 <20220426164315.625149-29-glider@google.com> <87a6c6y7mg.ffs@tglx>
 <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx>
 <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
 <878rrfiqyr.ffs@tglx>
 <CAG_fn=XVchXCcOhFt+rP=vinRhkyrXJSP46cyvcZeHJWaDquGg@mail.gmail.com>
 <87k0ayhc43.ffs@tglx>
 <CAG_fn=UpcXMqJiZvho6_G3rjvjQA-3Ax6X8ONVO0D+4Pttc9dA@mail.gmail.com>
 <87h762h5c2.ffs@tglx>
 <CAG_fn=UroTgp0jt77X_E-b1DPJ+32Cye6dRL4DOZ8MRf+XSokg@mail.gmail.com>
 <871qx2r09k.ffs@tglx>
 <CAG_fn=VtQw1gL_UVONHi=OJakOuMa3wKfkzP0jWcuvGQEmV9Vw@mail.gmail.com>
Date:   Thu, 12 May 2022 18:17:11 +0200
Message-ID: <87h75uvi7s.ffs@tglx>
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

On Thu, May 12 2022 at 14:24, Alexander Potapenko wrote:
> On Mon, May 9, 2022 at 9:09 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > So in the case when `hardirq_count()>>HARDIRQ_SHIFT` is greater than
>> > 1, kmsan_in_runtime() becomes a no-op, which leads to false positives.
>>
>> But, that'd only > 1 when there is a nested interrupt, which is not the
>> case. Interrupt handlers keep interrupts disabled. The last exception from
>> that rule was some legacy IDE driver which is gone by now.
>
> That's good to know, then we probably don't need this hardirq_count()
> check anymore.
>
>> So no, not a good explanation either.
>
> After looking deeper I see that unpoisoning was indeed skipped because
> kmsan_in_runtime() returned true, but I was wrong about the root
> cause.
> The problem was not caused by a nested hardirq, but rather by the fact
> that the KMSAN hook in irqentry_enter() was called with in_task()==1.

Argh, the preempt counter increment happens _after_ irqentry_enter().

> I think the best that can be done here is (as suggested above) to
> provide some kmsan_unpoison_pt_regs() function that will only be
> called from the entry points and won't be doing reentrancy checks.
> It should be safe, because unpoisoning boils down to calculating
> shadow/origin addresses and calling memset() on them, no instrumented
> code will be involved.

If you keep them where I placed them, then there is no need for a
noinstr function. It's already instrumentable.

> We could try to figure out the places in idtentry code where normal
> kmsan_unpoison_memory() can be called in IRQ context, but as far as I
> can see it will depend on the type of the entry point.

NMI is covered as it increments before it invokes the unpoison().

Let me figure out why we increment the preempt count late for
interrupts. IIRC it's for symmetry reasons related to softirq processing
on return, but let me double check.

> Another way to deal with the problem is to not rely on in_task(), but
> rather use some per-cpu counter in irqentry_enter()/irqentry_exit() to
> figure out whether we are in IRQ code already.

Well, if you have a irqentry() specific unpoison, then you know the
context, right?

> However this is only possible irqentry_enter() itself guarantees that
> the execution cannot be rescheduled to another CPU - is that the case?

Obviously. It runs with interrupts disabled and eventually on a
separate interrupt stack.

Thanks,

        tglx
