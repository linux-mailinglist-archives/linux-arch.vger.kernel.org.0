Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47097524CC3
	for <lists+linux-arch@lfdr.de>; Thu, 12 May 2022 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346102AbiELMZZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 May 2022 08:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353736AbiELMZJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 May 2022 08:25:09 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1A0249888
        for <linux-arch@vger.kernel.org>; Thu, 12 May 2022 05:25:06 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v59so9370681ybi.12
        for <linux-arch@vger.kernel.org>; Thu, 12 May 2022 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D4KhC5f7akNZCYIX8CtlWMuJDmlYSG1ZIcg9H4X+0cs=;
        b=sXaJnq0WTlzePRDnCEPZnv1ywN9iZDx3YdJpMPUTYdKyBc8fpCzfJxYzshSq0xZyPe
         3qjM6nIbUB2rt1rmwfWS/Jcfqq50vfkOvDQfANthsZF9YuSm9eHP0oDAoLD+L4fPR+El
         nBRGApfUqlwsgLqYtQyQjb17FCffj5UWbAxAZXKzfK3Vq9PkBEHfYg3N77c4XzqbJpv9
         x/FsGiWdRSgBll1tVMNM8DbxLdSHE/ITKEww13LBKWvcDPxGnKdO7EtCXTdbFAVZrIgg
         oehXpKop+Vl5sNUZ1rkni1wpkj2K+Z+snfW+rRiZ55fAaAqe+wK9Avr49louivL9fuEw
         3l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D4KhC5f7akNZCYIX8CtlWMuJDmlYSG1ZIcg9H4X+0cs=;
        b=5Vuu10aIxV3QNN3pyxjN8psT74c2tQqLQ4tsn71cVjEo5S2w5/PD3Y38oB5SBdjno4
         1fI/tMphA5IoIQHh1R2Nvi70U/0kmma+bf3An1Dl/U9+/1pXYyBQbFG0JY3+7Q7uD+tp
         KESwS4YE1FDjmCKvQVz6J6ZW14+n6CuLCZFX1cn8UJAQmixqJqi+bMrfUn6C1VzjXpsW
         lzDw+K9iFcyI51uuNaeUZ6A4KR2UhxvowlWL5UTBf03i/+mZ3fSecZjJye8nCnyjt3Di
         Bl7MP97kbEXlPhDnl44/haUBlJL7QoWcnNpL+or340KCd8RuDf8fjGO6hataATo/BrZQ
         CyXg==
X-Gm-Message-State: AOAM532onxqLpVIyd/YVLVllgeOAKJzq5hInm/Tz0NVaeUL2vSk8vOtG
        L0jF1rNc21iivHjkz3pDqN/kwFEnLkFRcsJkJZi74g==
X-Google-Smtp-Source: ABdhPJyoD+H2LGgZwY+Bi30AMPIZBme8GNjgmAInKiNdqlZrW6PHBOWbalHNrR1jrF+lMZFQr9DfRd3NZTkSSxTJSUs=
X-Received: by 2002:a25:aa62:0:b0:648:590f:5a53 with SMTP id
 s89-20020a25aa62000000b00648590f5a53mr29319927ybi.5.1652358305516; Thu, 12
 May 2022 05:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-29-glider@google.com>
 <87a6c6y7mg.ffs@tglx> <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx> <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
 <878rrfiqyr.ffs@tglx> <CAG_fn=XVchXCcOhFt+rP=vinRhkyrXJSP46cyvcZeHJWaDquGg@mail.gmail.com>
 <87k0ayhc43.ffs@tglx> <CAG_fn=UpcXMqJiZvho6_G3rjvjQA-3Ax6X8ONVO0D+4Pttc9dA@mail.gmail.com>
 <87h762h5c2.ffs@tglx> <CAG_fn=UroTgp0jt77X_E-b1DPJ+32Cye6dRL4DOZ8MRf+XSokg@mail.gmail.com>
 <871qx2r09k.ffs@tglx>
In-Reply-To: <871qx2r09k.ffs@tglx>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 May 2022 14:24:29 +0200
Message-ID: <CAG_fn=VtQw1gL_UVONHi=OJakOuMa3wKfkzP0jWcuvGQEmV9Vw@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 9, 2022 at 9:09 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, May 09 2022 at 18:50, Alexander Potapenko wrote:
> > Indeed, calling kmsan_unpoison_memory() in irqentry_enter() was
> > supposed to be enough, but we have code in kmsan_unpoison_memory() (as
> > well as other runtime functions) that checks for kmsan_in_runtime()
> > and bails out to prevent potential recursion if KMSAN code starts
> > calling itself.
> >
> > kmsan_in_runtime() is implemented as follows:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > static __always_inline bool kmsan_in_runtime(void)
> > {
> >   if ((hardirq_count() >> HARDIRQ_SHIFT) > 1)
> >     return true;
> >   return kmsan_get_context()->kmsan_in_runtime;
> > }
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > (see the code here:
> > https://lore.kernel.org/lkml/20220426164315.625149-13-glider@google.com=
/#Z31mm:kmsan:kmsan.h)
> >
> > If we are running in the task context (in_task()=3D=3Dtrue),
> > kmsan_get_context() returns a per-task `struct *kmsan_ctx`.
> > If `in_task()=3D=3Dfalse` and `hardirq_count()>>HARDIRQ_SHIFT=3D=3D1`, =
it
> > returns a per-CPU one.
> > Otherwise kmsan_in_runtime() is considered true to avoid dealing with
> > nested interrupts.
> >
> > So in the case when `hardirq_count()>>HARDIRQ_SHIFT` is greater than
> > 1, kmsan_in_runtime() becomes a no-op, which leads to false positives.
>
> But, that'd only > 1 when there is a nested interrupt, which is not the
> case. Interrupt handlers keep interrupts disabled. The last exception fro=
m
> that rule was some legacy IDE driver which is gone by now.

That's good to know, then we probably don't need this hardirq_count()
check anymore.

> So no, not a good explanation either.

After looking deeper I see that unpoisoning was indeed skipped because
kmsan_in_runtime() returned true, but I was wrong about the root
cause.
The problem was not caused by a nested hardirq, but rather by the fact
that the KMSAN hook in irqentry_enter() was called with in_task()=3D=3D1.

Roughly said, T0 was running some code in the task context, then it
started executing KMSAN instrumentation and entered the runtime by
setting current->kmsan_ctx.kmsan_in_runtime.
Then an IRQ kicked in and started calling
asm_sysvec_apic_timer_interrupt() =3D> sysvec_apic_timer_interrupt(regs)
=3D> irqentry_enter(regs) - but at that point in_task() was still true,
therefore kmsan_unpoison_memory() became a no-op.

As far as I can see, it is irq_enter_rcu() that makes in_task() return
0 by incrementing the preempt count in __irq_enter_raw(), so our
unpoisoning can only work if we perform it after we enter the IRQ
context.

I think the best that can be done here is (as suggested above) to
provide some kmsan_unpoison_pt_regs() function that will only be
called from the entry points and won't be doing reentrancy checks.
It should be safe, because unpoisoning boils down to calculating
shadow/origin addresses and calling memset() on them, no instrumented
code will be involved.

We could try to figure out the places in idtentry code where normal
kmsan_unpoison_memory() can be called in IRQ context, but as far as I
can see it will depend on the type of the entry point.

Another way to deal with the problem is to not rely on in_task(), but
rather use some per-cpu counter in irqentry_enter()/irqentry_exit() to
figure out whether we are in IRQ code already.
However this is only possible irqentry_enter() itself guarantees that
the execution cannot be rescheduled to another CPU - is that the case?

> Thanks,
>
>         tglx
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/871qx2r09k.ffs%40tglx.



--=20
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
