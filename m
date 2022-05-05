Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF2C51CBAE
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 23:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbiEEV75 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 17:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiEEV75 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 17:59:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1753A5C743;
        Thu,  5 May 2022 14:56:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651787773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xigc7SGokGXaGXENHUlGV+lz8hEFE/+jKrwKMtiGA38=;
        b=PSrYskSYyUHsNEO0GqK1VFP4p09LSXsNqDvhWx4yX+BCy0bhLEjJWkHBAyfK35Ml82+SLB
        QhIbjlbXkoGWzoOqsNE/QD0hU23fHRzFfzIBvZdDsZOJ/zNH09WX0Ns/YBZPTaT5Pifvgf
        AoND8IAnLQbJxr2U6F1tVnHsPUpW4xYj4bdwfo7zjTTsGjOENwAnmvrRUpr2wh6vXO8zu2
        LDCXHhbd8KbvfMwx5O88EDcaxIUo+RFafdnJWtbGU6M0AkNTNvrWVw7zXUsvY/4/ZTBqct
        EXrRY+ty7Xb/YcaKhuki/G+Hcn0CirsxaVLpth4e8Vtd7Q5c8uEdBdPb2ZtV4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651787773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xigc7SGokGXaGXENHUlGV+lz8hEFE/+jKrwKMtiGA38=;
        b=Rn3RCXeCWzxAluumapgAbVqbQIAk6BhZPfuwnrm8z/Sc3mHPD7EetWFlsTT3/u/QXAtx4s
        QDbwokMO61HhvgBA==
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
In-Reply-To: <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
References: <20220426164315.625149-1-glider@google.com>
 <20220426164315.625149-29-glider@google.com> <87a6c6y7mg.ffs@tglx>
 <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx>
 <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
Date:   Thu, 05 May 2022 23:56:12 +0200
Message-ID: <878rrfiqyr.ffs@tglx>
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

Alexander,

On Thu, May 05 2022 at 20:04, Alexander Potapenko wrote:
> On Tue, May 3, 2022 at 12:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > Regarding the regs, you are right. It should be enough to unpoison the
>> > regs at idtentry prologue instead.
>> > I tried that initially, but IIRC it required patching each of the
>> > DEFINE_IDTENTRY_XXX macros, which already use instrumentation_begin().
>>
>> Exactly 4 instances :)
>>
>
> Not really, I had to add a call to `kmsan_unpoison_memory(regs,
> sizeof(*regs));` to the following places in
> arch/x86/include/asm/idtentry.h:
> - DEFINE_IDTENTRY()
> - DEFINE_IDTENTRY_ERRORCODE()
> - DEFINE_IDTENTRY_RAW()
> - DEFINE_IDTENTRY_RAW_ERRORCODE()
> - DEFINE_IDTENTRY_IRQ()
> - DEFINE_IDTENTRY_SYSVEC()
> - DEFINE_IDTENTRY_SYSVEC_SIMPLE()
> - DEFINE_IDTENTRY_DF()
>
> , but even that wasn't enough. For some reason I also had to unpoison
> pt_regs directly in
> DEFINE_IDTENTRY_SYSVEC(sysvec_apic_timer_interrupt) and
> DEFINE_IDTENTRY_IRQ(common_interrupt).
> In the latter case, this could have been caused by
> asm_common_interrupt being entered from irq_entries_start(), but I am
> not sure what is so special about sysvec_apic_timer_interrupt().
>
> Ideally, it would be great to find that single point where pt_regs are
> set up before being passed to all IDT entries.
> I used to do that by inserting calls to kmsan_unpoison_memory right
> into arch/x86/entry/entry_64.S
> (https://github.com/google/kmsan/commit/3b0583f45f74f3a09f4c7e0e0588169cef918026),
> but that required storing/restoring all GP registers. Maybe there's a
> better way?

Yes. Something like this should cover all exceptions and syscalls before
anything instrumentable can touch @regs. Anything up to those points is
either off-limit for instrumentation or does not deal with @regs.

--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -24,6 +24,7 @@ static __always_inline void __enter_from
 	user_exit_irqoff();
 
 	instrumentation_begin();
+	unpoison(regs);
 	trace_hardirqs_off_finish();
 	instrumentation_end();
 }
@@ -352,6 +353,7 @@ noinstr irqentry_state_t irqentry_enter(
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
 		instrumentation_begin();
+		unpoison(regs);
 		trace_hardirqs_off_finish();
 		instrumentation_end();
 
@@ -367,6 +369,7 @@ noinstr irqentry_state_t irqentry_enter(
 	 */
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	instrumentation_begin();
+	unpoison(regs);
 	rcu_irq_enter_check_tick();
 	trace_hardirqs_off_finish();
 	instrumentation_end();
@@ -452,6 +455,7 @@ irqentry_state_t noinstr irqentry_nmi_en
 	rcu_nmi_enter();
 
 	instrumentation_begin();
+	unpoison(regs);
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
 	instrumentation_end();

As I said: 4 places :)

> Fortunately, I don't think we need to insert extra instrumentation
> into instrumentation_begin()/instrumentation_end() regions.
>
> What I have in mind is adding a bool flag to kmsan_context_state, that
> the instrumentation sets to true before the function call.
> When entering an instrumented function, KMSAN would check that flag
> and set it to false, so that the context state can be only used once.
> If a function is called from another instrumented function, the
> context state is properly set up, and there is nothing to worry about.
> If it is called from non-instrumented code (either noinstr or the
> skipped files that have KMSAN_SANITIZE:=n), KMSAN would detect that
> and wipe the context state before use.

Sounds good.

Thanks,

	tglx
