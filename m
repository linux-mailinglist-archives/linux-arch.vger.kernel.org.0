Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF35202F8
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 18:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiEIQzU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 12:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbiEIQzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 12:55:18 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF413277A
        for <linux-arch@vger.kernel.org>; Mon,  9 May 2022 09:51:22 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so26116055ybu.0
        for <linux-arch@vger.kernel.org>; Mon, 09 May 2022 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xv3YNr+ejtNXLt/3K/MJW1lmyFr4+HmU5M46knKl15A=;
        b=qzQQBeDIXPjgQg9o0N4Qf/md5IkN/vOjVl6fC5GVKpgiXu3VqQ/t2/oS949Ye1D/MP
         UoEvD6TzcTAbTEOWhMRa72QRymRlxd44YwrhzjfcdgXzCga+Om3dMx9Y+OSJQt5zRCw3
         +MuxBTB3B0MvvcOO0cZ1OiXpyzKXU1QlXZmnNuwPOI1GJaPuCVDT73Opv7ihk/0krrY8
         BC/rUoXJHVUJJXttPpWAOFWYLUYLpxOIpnTQzxAPE29v1qLwJyg8jx4Uj7aiUyLR7b7x
         g9MPBOkAhKiTuw3GTexW2rDM44fgqYj3KRXhFl+BHrBm7Llo4mUKfe4O72BYjWNiD5xd
         TPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xv3YNr+ejtNXLt/3K/MJW1lmyFr4+HmU5M46knKl15A=;
        b=hI6UiSJRRh6XtC/uaghCFtaxW1jWBGNdW6MJKTVu75hCMQMTHtfP4eqK5huxTcQuiO
         3Pfw8mugUaYKnnZhh5T8u48E/9XwF5kHPZia/4Em/vUxt4cRN+fsIFQLM1m6uW0w69jl
         k8bVKqIFNDjwhXvPjnN86ers/5SNYCHcd+EJ3ZWU/7bbn9HA8VaFwTNQpZR6tmf4cA+g
         qJB9iA3+sRA6DepyLlJFsKb62rk8hqZu8qlHxGsPdBG58biBb0hrQEfmDh+UePUAPFz+
         faLkY1bnNw6Y+FLwZaAXaMd88x9dCR68bzpVfup1YFfBGKvq0ah0h84leK/GEJ8T9xQC
         ew7w==
X-Gm-Message-State: AOAM53390J92OjcizYz1CwGRkPCPJvg5larralezOWrpxzTY1sBw1mia
        JSGUcYKHqtw1T9AwFBIpoeql47pM5ibZRVoEc+NPPA==
X-Google-Smtp-Source: ABdhPJxk2axP91QTV5WMMRiQcamRUJ0YhF0xRNVwcidsKN1FnuaSRI3NRg0kFbpLTrCWH32z8BDTWymGCd3ivXwMIZE=
X-Received: by 2002:a25:aa62:0:b0:648:590f:5a53 with SMTP id
 s89-20020a25aa62000000b00648590f5a53mr14674322ybi.5.1652115081586; Mon, 09
 May 2022 09:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-29-glider@google.com>
 <87a6c6y7mg.ffs@tglx> <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx> <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
 <878rrfiqyr.ffs@tglx> <CAG_fn=XVchXCcOhFt+rP=vinRhkyrXJSP46cyvcZeHJWaDquGg@mail.gmail.com>
 <87k0ayhc43.ffs@tglx> <CAG_fn=UpcXMqJiZvho6_G3rjvjQA-3Ax6X8ONVO0D+4Pttc9dA@mail.gmail.com>
 <87h762h5c2.ffs@tglx>
In-Reply-To: <87h762h5c2.ffs@tglx>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 May 2022 18:50:45 +0200
Message-ID: <CAG_fn=UroTgp0jt77X_E-b1DPJ+32Cye6dRL4DOZ8MRf+XSokg@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> The callchain is:
>
>   asm_sysvec_apic_timer_interrupt               <- ASM entry in gate
>      sysvec_apic_timer_interrupt(regs)          <- noinstr C entry point
>         irqentry_enter(regs)                    <- unpoisons @reg
>         __sysvec_apic_timer_interrupt(regs)     <- the actual handler
>            set_irq_regs(regs)                   <- stores regs
>            local_apic_timer_interrupt()
>              ...
>              tick_handler()                     <- One of the 4 variants
>                 regs =3D get_irq_regs();          <- retrieves regs
>                 update_process_times(user_tick =3D user_mode(regs))
>                    account_process_tick(user_tick)
>                       irqtime_account_process_tick(user_tick)
> line 382:                } else if { user_tick }   <- KMSAN complains
>
> I'm even more confused now.

Ok, I think I know what's going on.

Indeed, calling kmsan_unpoison_memory() in irqentry_enter() was
supposed to be enough, but we have code in kmsan_unpoison_memory() (as
well as other runtime functions) that checks for kmsan_in_runtime()
and bails out to prevent potential recursion if KMSAN code starts
calling itself.

kmsan_in_runtime() is implemented as follows:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
static __always_inline bool kmsan_in_runtime(void)
{
  if ((hardirq_count() >> HARDIRQ_SHIFT) > 1)
    return true;
  return kmsan_get_context()->kmsan_in_runtime;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(see the code here:
https://lore.kernel.org/lkml/20220426164315.625149-13-glider@google.com/#Z3=
1mm:kmsan:kmsan.h)

If we are running in the task context (in_task()=3D=3Dtrue),
kmsan_get_context() returns a per-task `struct *kmsan_ctx`.
If `in_task()=3D=3Dfalse` and `hardirq_count()>>HARDIRQ_SHIFT=3D=3D1`, it
returns a per-CPU one.
Otherwise kmsan_in_runtime() is considered true to avoid dealing with
nested interrupts.

So in the case when `hardirq_count()>>HARDIRQ_SHIFT` is greater than
1, kmsan_in_runtime() becomes a no-op, which leads to false positives.

The solution I currently have in mind is to provide a specialized
version of kmsan_unpoison_memory() for entry.c, which will not perform
the reentrancy checks.

> > I guess handling those will require wrapping every interrupt gate into
> > a function that performs register unpoisoning?
>
> No, guessing does not help here.
>
> The gates point to the ASM entry point, which then invokes the C entry
> point. All C entry points use a DEFINE_IDTENTRY variant.

Thanks for the explanation. I previously thought there were two
different entry points, one with asm_ and one without, that ended up
calling the same code.

> Some of the DEFINE_IDTENTRY_* C entry points are not doing anything in
> the macro, but the C function either invokes irqentry_enter() or
> irqentry_nmi_enter() open coded _before_ invoking any instrumentable
> function. So the unpoisoning of @regs in these functions should tell
> KMSAN that @regs or something derived from @regs are not some random
> uninitialized values.
>
> There should be no difference between unpoisoning @regs in
> irqentry_enter() or in set_irq_regs(), right?
>
> If so, then the problem is definitely _not_ the idt entry code.
>
> > By the way, if it helps, I think we don't necessarily have to call
> > kmsan_unpoison_memory() from within the
> > instrumentation_begin()/instrumentation_end() region?
> > We could move the call to the beginning of irqentry_enter(), removing
> > unnecessary duplication.
>
> We could, but then you need to mark unpoison_memory() noinstr too and you
> have to add the unpoison into the syscall code. No win and irrelevant to
> the problem at hand.

Makes sense, thank you!

> Thanks,
>
>         tglx
>
>


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
