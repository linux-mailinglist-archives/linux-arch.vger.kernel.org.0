Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2E0520501
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbiEITNZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 15:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbiEITNY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 15:13:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD642CCD09;
        Mon,  9 May 2022 12:09:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652123368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VawBhkp/iVX6wIchfdV6yUwkO3Wiahi7D6DYX4ALtEQ=;
        b=oVLpbua2F51imTuUaCqhV2+tynkaE/0W46R/u/Ylc4zzKQfAnTT/f4Im++Ucg+RkNzJ/hN
        bEb6OMwxPx9QUDW7IRFzZRDzOsB56DTxlJgMj6RHuJHo8gvEEVPHdbctzCpWazF/ISy7W1
        HHlZSqzEpUDDYolJhc/j3GV/wUFpAJCGwSpFqnC2uH1frWVxJscfbfPgWJ36FCRFx8e5zT
        DDIpU3jiZemHAXmIHkg0+z8xM6suFIuf3rgTfbP4WXfmcxXMMmldoM1HFAK2qXThGOQeHt
        5Jv67t5NZPZaiGZLeAYLTWiFZxEbhrcarUsXRocx2XPwesDlfNDM7EpqRONy5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652123368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VawBhkp/iVX6wIchfdV6yUwkO3Wiahi7D6DYX4ALtEQ=;
        b=UvZgazfQq/GqF7NhfTSquz3f+mV65lytaY+y7GU3ZJ4yfzTagDuVaUmX92GGwEBcJlNJHW
        zAnfw07wpj9oXcAg==
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
In-Reply-To: <CAG_fn=UroTgp0jt77X_E-b1DPJ+32Cye6dRL4DOZ8MRf+XSokg@mail.gmail.com>
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
Date:   Mon, 09 May 2022 21:09:27 +0200
Message-ID: <871qx2r09k.ffs@tglx>
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

On Mon, May 09 2022 at 18:50, Alexander Potapenko wrote:
> Indeed, calling kmsan_unpoison_memory() in irqentry_enter() was
> supposed to be enough, but we have code in kmsan_unpoison_memory() (as
> well as other runtime functions) that checks for kmsan_in_runtime()
> and bails out to prevent potential recursion if KMSAN code starts
> calling itself.
>
> kmsan_in_runtime() is implemented as follows:
>
> ==============================================
> static __always_inline bool kmsan_in_runtime(void)
> {
>   if ((hardirq_count() >> HARDIRQ_SHIFT) > 1)
>     return true;
>   return kmsan_get_context()->kmsan_in_runtime;
> }
> ==============================================
> (see the code here:
> https://lore.kernel.org/lkml/20220426164315.625149-13-glider@google.com/#Z31mm:kmsan:kmsan.h)
>
> If we are running in the task context (in_task()==true),
> kmsan_get_context() returns a per-task `struct *kmsan_ctx`.
> If `in_task()==false` and `hardirq_count()>>HARDIRQ_SHIFT==1`, it
> returns a per-CPU one.
> Otherwise kmsan_in_runtime() is considered true to avoid dealing with
> nested interrupts.
>
> So in the case when `hardirq_count()>>HARDIRQ_SHIFT` is greater than
> 1, kmsan_in_runtime() becomes a no-op, which leads to false positives.

But, that'd only > 1 when there is a nested interrupt, which is not the
case. Interrupt handlers keep interrupts disabled. The last exception from
that rule was some legacy IDE driver which is gone by now.

So no, not a good explanation either.

Thanks,

        tglx
