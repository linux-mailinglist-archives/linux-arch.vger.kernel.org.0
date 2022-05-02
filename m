Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CFB5179B1
	for <lists+linux-arch@lfdr.de>; Tue,  3 May 2022 00:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387858AbiEBWGi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387872AbiEBWEg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 18:04:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25421121;
        Mon,  2 May 2022 15:00:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651528836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S+6N0/e64EIdyK+q6LMgUsbq+bhYAt3HjkhVHWMdsus=;
        b=J4ag3vPsEDwZL+oCRqsEO5q2bCVT/HCkvHwIg31PZIT8GAn+5OvAJ9MB0oE+dSl/FZn9lT
        8VPpLDbIih1vFggASgksDtYmiVBbHSJwF/fubcT3vrCrUbbkVdHeGngVe0kLhHEucAvfGj
        Pyexx+cRTEiAtoXS5txfgqibNdzqinMk3iNHKba4cz7SLU/uFjbq9loqbmQWaWdX7kwDMd
        JD0HUcmMAB7CC4x/ovCypKg2bMkTHIJpPHY0BX920/Wh+q9EHwwnNq5+12TFhA2Boy6pxW
        hmtN4ct8VE5HfqtehZYAeCyycX8/yEfdLx276Zgg8Z7BShDGBYTzFqWcmVhk5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651528836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S+6N0/e64EIdyK+q6LMgUsbq+bhYAt3HjkhVHWMdsus=;
        b=CrQCUSltbRIGwTmnXdob0vtJs1is4KaNlYBouH31HPLXfAgPFVKmtpsZle3KY/3l9JTQXk
        UoH9SeEf65beUPAw==
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
In-Reply-To: <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
References: <20220426164315.625149-1-glider@google.com>
 <20220426164315.625149-29-glider@google.com> <87a6c6y7mg.ffs@tglx>
 <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
Date:   Tue, 03 May 2022 00:00:36 +0200
Message-ID: <87y1zjlhmj.ffs@tglx>
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

On Mon, May 02 2022 at 19:00, Alexander Potapenko wrote:
> On Wed, Apr 27, 2022 at 3:32 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > --- a/kernel/entry/common.c
>> > +++ b/kernel/entry/common.c
>> > @@ -23,7 +23,7 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
>> >       CT_WARN_ON(ct_state() != CONTEXT_USER);
>> >       user_exit_irqoff();
>> >
>> > -     instrumentation_begin();
>> > +     instrumentation_begin_with_regs(regs);
>>
>> I can see what you are trying to do, but this will end up doing the same
>> thing over and over. Let's just look at a syscall.
>>
>> __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
>> {
>>         ...
>>         nr = syscall_enter_from_user_mode(regs, nr)
>>
>>                 __enter_from_user_mode(regs)
>>                         .....
>>                         instrumentation_begin_with_regs(regs);
>>                         ....
>>
>>                 instrumentation_begin_with_regs(regs);
>>                 ....
>>
>>         instrumentation_begin_with_regs(regs);
>>
>>         if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
>>                 /* Invalid system call, but still a system call. */
>>                 regs->ax = __x64_sys_ni_syscall(regs);
>>         }
>>
>>         instrumentation_end();
>>
>>         syscall_exit_to_user_mode(regs);
>>                 instrumentation_begin_with_regs(regs);
>>                 __syscall_exit_to_user_mode_work(regs);
>>         instrumentation_end();
>>         __exit_to_user_mode();
>>
>> That means you memset state four times and unpoison regs four times. I'm
>> not sure whether that's desired.
>
> Regarding the regs, you are right. It should be enough to unpoison the
> regs at idtentry prologue instead.
> I tried that initially, but IIRC it required patching each of the
> DEFINE_IDTENTRY_XXX macros, which already use instrumentation_begin().

Exactly 4 instances :)

> This decision can probably be revisited.

It has to be revisited because the whole thing is incomplete if this is
not addressed.

> As for the state, what we are doing here is still not enough, although
> it appears to work.
>
> Every time an instrumented function calls another function, it sets up
> the metadata for the function arguments in the per-task struct
> kmsan_context_state.
> Similarly, every instrumented function expects its caller to put the
> metadata into that structure.
> Now, if a non-instrumented function (e.g. every `noinstr` function)
> calls an instrumented one (which happens inside the
> instrumentation_begin()/instrumentation_end() region), nobody sets up
> the state for that instrumented function, so it may report false
> positives when accessing its arguments, if there are leftover poisoned
> values in the state.
>
> To overcome this problem, ideally we need to wipe kmsan_context_state
> every time a call from the non-instrumented function occurs.
> But this cannot be done automatically exactly because we cannot
> instrument the named function :)
>
> We therefore apply an approximation, wiping the state at the point of
> the first transition between instrumented and non-instrumented code.
> Because poison values are generally rare, and instrumented regions
> tend to be short, it is unlikely that further calls from the same
> non-instrumented function will result in false positives.
> Yet it is not completely impossible, so wiping the state for the
> second/third etc. time won't hurt.

Understood. But if I understand you correctly:

> Similarly, every instrumented function expects its caller to put the
> metadata into that structure.

then

     instrumentation_begin();
     foo(fargs...);
     bar(bargs...);
     instrumentation_end();

is a source of potential false positives because the state is not
guaranteed to be correct, neither for foo() nor for bar(), even if you
wipe the state in instrumentation_begin(), right?

This approximation approach smells fishy and it's inevitably going to be
a constant source of 'add yet another kmsan annotation/fixup' patches,
which I'm not interested in at all.

As this needs compiler support anyway, then why not doing the obvious:

#define noinstr                                 \
        .... __kmsan_conditional

#define instrumentation_begin()                 \
        ..... __kmsan_cond_begin

#define instrumentation_end()                   \
        __kmsan_cond_end .......

and let the compiler stick whatever is required into that code section
between instrumentation_begin() and instrumentation_end()?

That's not violating any of the noinstr constraints at all. In fact we
allow _any_ instrumentation to be placed between this two points. We
have tracepoints there today.

We could also allow breakpoints, kprobes or whatever, but handling this
at that granularity level for a production kernel is just overkill and
the code in those instrumentable sections is usually not that
interesting as it's mostly function calls.

But if the compiler converts

     instrumentation_begin();
     foo(fargs...);
     bar(bargs...);
     instrumentation_end();

to

     instrumentation_begin();
     kmsan_instr_begin_magic();
     kmsan_magic(fargs...);
     foo(fargs...);
     kmsan_magic(bargs...);
     bar(bargs...);
     kmsan_instr_end_magic();
     instrumentation_end();

for the kmsan case and leaves anything outside of these sections alone,
then you have:

   - a minimal code change
   - the best possible coverage
   - the least false positive crap to chase and annotate

IOW, a solution which is solid and future proof.

I'm all for making use of advanced instrumentation, validation and
debugging features, but this mindset of 'make the code comply to what
the tool of today provides' is fundamentally wrong. Tools have to
provide value to the programmer and not the other way round.

Yes, it's more work on the tooling side, but the tooling side is mostly
a one time effort while chasing the false positives is a long term
nightmare.

Thanks,

        tglx
