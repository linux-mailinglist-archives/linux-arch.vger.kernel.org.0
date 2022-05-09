Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932AA5202F6
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiEIQ4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbiEIQ4a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 12:56:30 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071ED2AACCD
        for <linux-arch@vger.kernel.org>; Mon,  9 May 2022 09:52:36 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y76so26075059ybe.1
        for <linux-arch@vger.kernel.org>; Mon, 09 May 2022 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXiFk325eT/uin6juY8MDs9uDbcZ0rRGYF4uwLrhYoM=;
        b=CU57t1DGavqfk6REfm4jRrmgtCHhA9Bxhq2YKjsvtcug8qNwcUw80SzW3L1amX/eub
         aWHrplchw1istxVlUaUqAhQHIEM8hsceFJO5JdyQz47ykHSStdl3M0N1JESaF9e0u5ET
         upwfQlac2YdqILyIu5hYCpNmJDkQ6jcNcvVSPUfOJR5QX3UaEFzcUOY5WJlp44FK8QKq
         kAJJMWIH9muaZmmyuxcPnCOPkOrgn8pItEUdQcV8XOUyXlezRsYugSSsA9pqfGIOaQcO
         2+0WkYzqIPwPTT/I+Wky0adhyCLHO6M8xSl9FA8nkJWQ7OdR+VbR7QCM7s9ZqkuxB5N4
         qpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXiFk325eT/uin6juY8MDs9uDbcZ0rRGYF4uwLrhYoM=;
        b=ljD+X1oS9N6yB+fGpGb4ukanzs+XDfflhjk9xlnbbG0hmZUh6IOaegzKpGpUI0OiHc
         gz2JFIg528oU/1Rs4tXwMX0FeiwevXm8HNP6K2SUntzXskgC2B7yvIvYOIeQjliDqO55
         5WuZuKgLPCwgyWO3FyW5IW9cb6HQtKqACnFw3Z7wqJI2qD+o3bKRjFORm1S/vfaI9cZQ
         vLWuUt96Mk61JUjoZuUGW94VewKQE0M0+j/bpOpmILWR8sBDXYsgT4NCF8pXl1swwjjp
         a2YDIufS5BH/3J5OP70/RqgKN9sTu5RYFpHu9Q2aLJ2Pt0GKDUE4FL0gQXOuol1eIlXY
         5p3g==
X-Gm-Message-State: AOAM531tAiFtMbybnr3siRqqKwQmtYsZ5/DeIPFLYnaMa4mlVVHoqOYh
        qmblXIFpxgTD9bLMY0unZ4cOWUItg32ATFUC/BcwrA==
X-Google-Smtp-Source: ABdhPJzD5+vOjoR45J8vJybqt5bFVkZynODUV+GbSK3Xg47Qljq/cxhdIWBHvAQIVHV3k2CB3K52qDrkMO0vgvJva+4=
X-Received: by 2002:a25:e7d1:0:b0:645:7216:d9d0 with SMTP id
 e200-20020a25e7d1000000b006457216d9d0mr14454488ybh.307.1652115155053; Mon, 09
 May 2022 09:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-29-glider@google.com>
 <87a6c6y7mg.ffs@tglx> <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx> <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
 <878rrfiqyr.ffs@tglx> <CAG_fn=XVchXCcOhFt+rP=vinRhkyrXJSP46cyvcZeHJWaDquGg@mail.gmail.com>
 <87k0ayhc43.ffs@tglx> <CAG_fn=UpcXMqJiZvho6_G3rjvjQA-3Ax6X8ONVO0D+4Pttc9dA@mail.gmail.com>
 <87h762h5c2.ffs@tglx> <CAG_fn=UroTgp0jt77X_E-b1DPJ+32Cye6dRL4DOZ8MRf+XSokg@mail.gmail.com>
In-Reply-To: <CAG_fn=UroTgp0jt77X_E-b1DPJ+32Cye6dRL4DOZ8MRf+XSokg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 May 2022 18:51:59 +0200
Message-ID: <CAG_fn=X8mc9-_-S-+b9HuF4_-PhN3=1umu5twY8oYn1OgRhuLg@mail.gmail.com>
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
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 9, 2022 at 6:50 PM Alexander Potapenko <glider@google.com> wrote:
>
> > The callchain is:
> >
> >   asm_sysvec_apic_timer_interrupt               <- ASM entry in gate
> >      sysvec_apic_timer_interrupt(regs)          <- noinstr C entry point
> >         irqentry_enter(regs)                    <- unpoisons @reg
> >         __sysvec_apic_timer_interrupt(regs)     <- the actual handler
> >            set_irq_regs(regs)                   <- stores regs
> >            local_apic_timer_interrupt()
> >              ...
> >              tick_handler()                     <- One of the 4 variants
> >                 regs = get_irq_regs();          <- retrieves regs
> >                 update_process_times(user_tick = user_mode(regs))
> >                    account_process_tick(user_tick)
> >                       irqtime_account_process_tick(user_tick)
> > line 382:                } else if { user_tick }   <- KMSAN complains
> >
> > I'm even more confused now.
>
> Ok, I think I know what's going on.
>
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
Should be "kmsan_unpoison_memory() becomes a no-op..."
