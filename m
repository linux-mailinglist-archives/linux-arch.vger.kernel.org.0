Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8F15252FA
	for <lists+linux-arch@lfdr.de>; Thu, 12 May 2022 18:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356680AbiELQsm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 May 2022 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349749AbiELQsl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 May 2022 12:48:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB612685FE;
        Thu, 12 May 2022 09:48:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652374118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hSX9OFf5tzvIcNgVCMLyCC6NV4cYH+8sLce95997SMQ=;
        b=dNG6zwNhF9OUuVyKVZ3nmgj1iI9P+NOQjZMoo+ixnf6np32nRm7iOb/snaa6Yh6q4H7zJ+
        u/uVMdw2BaGy43kBjD4QXWRY/2owMXR0MTVD3dqUi+eXHeHc34KgqYLGnl3/QxFyOGYTle
        HZYrCTB6AUYKRjzbRCNyEBs7omeeNxAPg9KnUpMODqWp9/+eMR4fQRIj1zXWD1g8VE74BM
        5Vbq6Dqdd77zoaSWNBz4yMLNOrkWENhnz8Ajr60VtTgGavBnrDJ/CTm1rDV875uc13LI1x
        oNnZAD7v9H07fYlGuxRNjNdBhutYsoILILZnN07UAFUmT4BHYP+fTF1VVMY4Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652374118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hSX9OFf5tzvIcNgVCMLyCC6NV4cYH+8sLce95997SMQ=;
        b=GgB2jaA6SJpjjCA9C/bYLMwCZArP4xDXp8WFAObc2KO4QJQw2QMoX/09cNKaYH97nQRf1w
        FOGCByOo9GPjzdBg==
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
In-Reply-To: <87h75uvi7s.ffs@tglx>
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
 <87h75uvi7s.ffs@tglx>
Date:   Thu, 12 May 2022 18:48:38 +0200
Message-ID: <87ee0yvgrd.ffs@tglx>
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

On Thu, May 12 2022 at 18:17, Thomas Gleixner wrote:
> On Thu, May 12 2022 at 14:24, Alexander Potapenko wrote:
>> We could try to figure out the places in idtentry code where normal
>> kmsan_unpoison_memory() can be called in IRQ context, but as far as I
>> can see it will depend on the type of the entry point.
>
> NMI is covered as it increments before it invokes the unpoison().
>
> Let me figure out why we increment the preempt count late for
> interrupts. IIRC it's for symmetry reasons related to softirq processing
> on return, but let me double check.

It's even documented:

 https://www.kernel.org/doc/html/latest/core-api/entry.html#interrupts-and-regular-exceptions

But who reads documentation? :)

So, I think the simplest and least intrusive solution is to have special
purpose unpoison functions. See the patch below for illustration.

The reasons why I used specific ones:

  1) User entry

     Whether that's a syscall or interrupt/exception does not
     matter. It's always on the task stack and your machinery cannot be
     running at that point because it came from user space.

  2) Interrupt/exception/NMI entry kernel
  
     Those can nest into an already active context, so you really want
     to unpoison @regs.

     Also while regular interrupts cannot nest because of interrupts
     staying disabled, exceptions triggered in the interrupt handler and
     NMIs can nest.

     -> device interrupt()
           irqentry_enter(regs)

        -> NMI()
           irqentry_nmi_enter(regs)

           -> fault()
              irqentry_enter(regs)
          
              --> debug_exception()
                  irqentry_nmi_enter(regs)

     Soft interrupt processing on return from interrupt makes it more
     interesting:

     interrupt()
       handler()
       do_softirq()
         local_irq_enable()
            interrupt()
              NMI
                ....

     And everytime you get a new @regs pointer to deal with.

Wonderful, isn't it?

Thanks,

        tglx

---
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -24,6 +24,7 @@ static __always_inline void __enter_from
 	user_exit_irqoff();
 
 	instrumentation_begin();
+	unpoison_user(regs);
 	trace_hardirqs_off_finish();
 	instrumentation_end();
 }
@@ -352,6 +353,7 @@ noinstr irqentry_state_t irqentry_enter(
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
 		instrumentation_begin();
+		unpoison_irq(regs);
 		trace_hardirqs_off_finish();
 		instrumentation_end();
 
@@ -367,6 +369,7 @@ noinstr irqentry_state_t irqentry_enter(
 	 */
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	instrumentation_begin();
+	unpoison_irq(regs);
 	rcu_irq_enter_check_tick();
 	trace_hardirqs_off_finish();
 	instrumentation_end();
@@ -452,6 +455,7 @@ irqentry_state_t noinstr irqentry_nmi_en
 	rcu_nmi_enter();
 
 	instrumentation_begin();
+	unpoison_irq(regs);
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
 	instrumentation_end();
