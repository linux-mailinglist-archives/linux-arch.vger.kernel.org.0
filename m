Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834A753A40E
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 13:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352664AbiFAL2g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 07:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352656AbiFAL2f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 07:28:35 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1A95C865
        for <linux-arch@vger.kernel.org>; Wed,  1 Jun 2022 04:28:33 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-300628e76f3so14700337b3.12
        for <linux-arch@vger.kernel.org>; Wed, 01 Jun 2022 04:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDA6PuH6NICvxSpkxUN08aIv7E1lLbWtwbYMOmp3DFc=;
        b=qZ4wk7dYHXk+svmWhmtwD5F01nOrHanF/nZcd2rNt/sATC0umgD7nFxlyirkk7t7yt
         /5NSe+GKx657K37eu29ixICiLnZ+U5EhmxLGckjho8BnQPOSc1PytOmMl6dueOaOkRfp
         DK5IdYHqNZRD8IyzEHTH+X04qE9G9cXrdrwM7Gd2ldpCMdWe/bhKK0FJ+oJcIm+1NXnd
         1c5MqLPnhnJ3tz9ErQexOBcfjZPLSbQweY61tDKiErca+u+a4dbYtfvmsF3W9dTrjtkf
         9GPnypBdkQvxxu/eYpcMAJS42Y+VITDDdkbpWf4+uiNiaR6Na/D7SpKNUJAX1i+IgkSv
         VNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDA6PuH6NICvxSpkxUN08aIv7E1lLbWtwbYMOmp3DFc=;
        b=Mj5ut7CM77eXL6qtJAzxq5gn/pCJYfgLJz4B3DDV55smBvUNeD8lRHBBomPPQx/1Rq
         xmNOPLGk2Ubiw952Fy/kST+KVxeOVfaSgJJQ7fGUGX0dnc8Q+wCEVakmBzHqK8LaAa4k
         MXS1kkX5iDdfVaMY1IqGtCHOaULZx2hR2op+SYyb8e1azDpFh8UBDMUtFVJEhUIadg0o
         NMhLZprJDmEZEo+oFkEGHZ/9qm9duDsx8FHwpMlDyMrlQTtxwjooVcWwUTQDZb5xOayV
         CFF0HyAAloTLi45rZ5QE3EezPdth/+/iyjTuPhNz9fDeIiVqEIq6DkD2DP0lDs7K5FXz
         hOnw==
X-Gm-Message-State: AOAM533L6LngwYGL23gUm3W2M3U0ph4FN/mE8Sx6jiNQdXVPD+SdDPN8
        tQGzsELuNyRHI6WOd+c0tVKBhtPqgZzum8Q+WdM7aw==
X-Google-Smtp-Source: ABdhPJyo22i6mb4t9rd8RWOXkFixboX4VLMr4JB+/qGQCmpcDVlUNjyMNUrEjFthhS3/evNm77t2vXH8qRIY3ppOfOY=
X-Received: by 2002:a81:1f8b:0:b0:2f8:5846:445e with SMTP id
 f133-20020a811f8b000000b002f85846445emr69247959ywf.50.1654082912126; Wed, 01
 Jun 2022 04:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-29-glider@google.com>
 <87a6c6y7mg.ffs@tglx> <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx> <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
 <878rrfiqyr.ffs@tglx> <CAG_fn=XVchXCcOhFt+rP=vinRhkyrXJSP46cyvcZeHJWaDquGg@mail.gmail.com>
 <87k0ayhc43.ffs@tglx> <CAG_fn=UpcXMqJiZvho6_G3rjvjQA-3Ax6X8ONVO0D+4Pttc9dA@mail.gmail.com>
 <87h762h5c2.ffs@tglx> <CAG_fn=UroTgp0jt77X_E-b1DPJ+32Cye6dRL4DOZ8MRf+XSokg@mail.gmail.com>
 <871qx2r09k.ffs@tglx> <CAG_fn=VtQw1gL_UVONHi=OJakOuMa3wKfkzP0jWcuvGQEmV9Vw@mail.gmail.com>
 <87h75uvi7s.ffs@tglx> <87ee0yvgrd.ffs@tglx>
In-Reply-To: <87ee0yvgrd.ffs@tglx>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 1 Jun 2022 13:27:56 +0200
Message-ID: <CAG_fn=XP9uFKA+zvCp_txBO_xGwH10=hhF9FDQL107b4YUh6sA@mail.gmail.com>
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

On Thu, May 12, 2022 at 6:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, May 12 2022 at 18:17, Thomas Gleixner wrote:
> > On Thu, May 12 2022 at 14:24, Alexander Potapenko wrote:
> >> We could try to figure out the places in idtentry code where normal
> >> kmsan_unpoison_memory() can be called in IRQ context, but as far as I
> >> can see it will depend on the type of the entry point.
> >
> > NMI is covered as it increments before it invokes the unpoison().
> >
> > Let me figure out why we increment the preempt count late for
> > interrupts. IIRC it's for symmetry reasons related to softirq processing
> > on return, but let me double check.
>
> It's even documented:
>
>  https://www.kernel.org/doc/html/latest/core-api/entry.html#interrupts-and-regular-exceptions
>
> But who reads documentation? :)
>
> So, I think the simplest and least intrusive solution is to have special
> purpose unpoison functions. See the patch below for illustration.

This patch works well and I am going to adopt it for my series.
But the problem with occasional calls of instrumented functions from
noinstr still persists: if there is a noinstr function foo() and an
instrumented function bar() called from foo() with one or more
arguments, bar() must wipe its kmsan_context_state before using the
arguments.

I have a solution for this problem described in https://reviews.llvm.org/D126385
The plan is to pass __builtin_return_address(0) to
__msan_get_context_state_caller() at the beginning of each
instrumented function.
Then KMSAN runtime can check the passed return address and wipe the
context if it belongs to the .noinstr code section.

Alternatively, we could employ MSan's -fsanitize-memory-param-retval
flag, that will report supplying uninitialized parameters when calling
functions.
Doing so is currently allowed in the kernel, but Clang aggressively
applies the noundef attribute (see https://llvm.org/docs/LangRef.html)
to function arguments, which effectively makes passing uninit values
as function parameters an UB.
So if we make KMSAN detect such cases as well, we can ultimately get
rid of all cases when uninits are passed to functions.
As a result, kmsan_context_state will become unnecessary, because it
will never contain nonzero values.


> The reasons why I used specific ones:
>
>   1) User entry
>
>      Whether that's a syscall or interrupt/exception does not
>      matter. It's always on the task stack and your machinery cannot be
>      running at that point because it came from user space.
>
>   2) Interrupt/exception/NMI entry kernel
>
>      Those can nest into an already active context, so you really want
>      to unpoison @regs.
>
>      Also while regular interrupts cannot nest because of interrupts
>      staying disabled, exceptions triggered in the interrupt handler and
>      NMIs can nest.
>
>      -> device interrupt()
>            irqentry_enter(regs)
>
>         -> NMI()
>            irqentry_nmi_enter(regs)
>
>            -> fault()
>               irqentry_enter(regs)
>
>               --> debug_exception()
>                   irqentry_nmi_enter(regs)
>
>      Soft interrupt processing on return from interrupt makes it more
>      interesting:
>
>      interrupt()
>        handler()
>        do_softirq()
>          local_irq_enable()
>             interrupt()
>               NMI
>                 ....
>
>      And everytime you get a new @regs pointer to deal with.
>
> Wonderful, isn't it?
>
> Thanks,
>
>         tglx
>
