Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C051C6B3
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbiEESJI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 14:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382980AbiEESJC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 14:09:02 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B4626DE
        for <linux-arch@vger.kernel.org>; Thu,  5 May 2022 11:05:22 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y2so8972400ybi.7
        for <linux-arch@vger.kernel.org>; Thu, 05 May 2022 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lfs9ILt8sxsLN7d0CVj7IGkIjZk0ddULlJ98hbLjdl0=;
        b=Ndgpe6IFiFofWceJK8I/DTEcQWT+/sHZsEWM1fYblnv9x81eSyj1R7FuXA8ILnq7mL
         MirG8+CssXftrYGqNJ4vf1ERQtOm6a4Nq9IPOlrkw8GYT4MTbR51+m8zuOlLdoGmwuqT
         LCH7motTy7WzByAkTNq0edQigKWkmNqayX293USnIaJr7BJOSxH8GmifZMRZNAE+kkk2
         zWArlAg0ixMHNJJTifGAlU5k07E2zrU6JttPU9X300dt1NgXtfBycBtCfouCZIPcZCWE
         LiBSab1rlgeKcaxikFZxkwfIaXNH19dfTS2sMDmjcRpqtla1OP0W8r34tKP8eXHD/c2L
         VqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lfs9ILt8sxsLN7d0CVj7IGkIjZk0ddULlJ98hbLjdl0=;
        b=0gA+WostTUpgqDySdV3XHs9ctZ+k40PD3sfzCmD29+ab8it/RDGbW35sVAsr/UcoHH
         mOwohrsFBvdCO2GGo3hdm73RkPM+rvMmIY+AyjGxL+XaXy6cBYH3KcFAInV1rROAsQFs
         0y67gta4QNXIAMlMAsuT+wWpJhj2zKazRWodA0qRjkSZmeUpr8f2ZWcVGmtIJTAHpI7d
         5QPSJR6nv0WstvKpnFcWFCWeEldP+K1IolrNhOxQSL5dCY1F6ZPek9CAuzVmAlUAga5Y
         1+8PA9uLLn3Fsbm5u704ytN7rTplY6N03qg/xwSBxDAGR7UuGa/jBn6NYhe4eJSyXiH6
         HW2w==
X-Gm-Message-State: AOAM533mlkhJmVAoyJ1nyOUatBHmImHVBYgLXVajJibXPQ3bBJSwrSkq
        CLygdxwihZ4DQvC2XVRNJTA5Q9g576Go9l7wjhHgCw==
X-Google-Smtp-Source: ABdhPJxOGddy4d0Gcmj8AKq4eH0h4RCWeNm0um7E0xiCZcOB55dahtuyVvi1XSbZU3Ov8nWjJGuOmIU9Rx3UziGE6Uk=
X-Received: by 2002:a25:aa62:0:b0:648:590f:5a53 with SMTP id
 s89-20020a25aa62000000b00648590f5a53mr23847856ybi.5.1651773921071; Thu, 05
 May 2022 11:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-29-glider@google.com>
 <87a6c6y7mg.ffs@tglx> <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
 <87y1zjlhmj.ffs@tglx>
In-Reply-To: <87y1zjlhmj.ffs@tglx>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 5 May 2022 20:04:44 +0200
Message-ID: <CAG_fn=XxAhBEBP2KJvahinbaxLAd1xvqTfRJdAu1Tk5r8=01jw@mail.gmail.com>
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

On Tue, May 3, 2022 at 12:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Alexander,

First of all, thanks a lot for the comments, those are greatly appreciated!
I tried to revert this patch and the previous one ("kmsan:
instrumentation.h: add instrumentation_begin_with_regs()") and
reimplement unpoisoning pt_regs without breaking into
instrumentation_begin(), see below.

> >
> > Regarding the regs, you are right. It should be enough to unpoison the
> > regs at idtentry prologue instead.
> > I tried that initially, but IIRC it required patching each of the
> > DEFINE_IDTENTRY_XXX macros, which already use instrumentation_begin().
>
> Exactly 4 instances :)
>

Not really, I had to add a call to `kmsan_unpoison_memory(regs,
sizeof(*regs));` to the following places in
arch/x86/include/asm/idtentry.h:
- DEFINE_IDTENTRY()
- DEFINE_IDTENTRY_ERRORCODE()
- DEFINE_IDTENTRY_RAW()
- DEFINE_IDTENTRY_RAW_ERRORCODE()
- DEFINE_IDTENTRY_IRQ()
- DEFINE_IDTENTRY_SYSVEC()
- DEFINE_IDTENTRY_SYSVEC_SIMPLE()
- DEFINE_IDTENTRY_DF()

, but even that wasn't enough. For some reason I also had to unpoison
pt_regs directly in
DEFINE_IDTENTRY_SYSVEC(sysvec_apic_timer_interrupt) and
DEFINE_IDTENTRY_IRQ(common_interrupt).
In the latter case, this could have been caused by
asm_common_interrupt being entered from irq_entries_start(), but I am
not sure what is so special about sysvec_apic_timer_interrupt().

Ideally, it would be great to find that single point where pt_regs are
set up before being passed to all IDT entries.
I used to do that by inserting calls to kmsan_unpoison_memory right
into arch/x86/entry/entry_64.S
(https://github.com/google/kmsan/commit/3b0583f45f74f3a09f4c7e0e0588169cef9=
18026),
but that required storing/restoring all GP registers. Maybe there's a
better way?


>
> then
>
>      instrumentation_begin();
>      foo(fargs...);
>      bar(bargs...);
>      instrumentation_end();
>
> is a source of potential false positives because the state is not
> guaranteed to be correct, neither for foo() nor for bar(), even if you
> wipe the state in instrumentation_begin(), right?

Yes, this is right.

> This approximation approach smells fishy and it's inevitably going to be
> a constant source of 'add yet another kmsan annotation/fixup' patches,
> which I'm not interested in at all.
>
> As this needs compiler support anyway, then why not doing the obvious:
>
> #define noinstr                                 \
>         .... __kmsan_conditional
>
> #define instrumentation_begin()                 \
>         ..... __kmsan_cond_begin
>
> #define instrumentation_end()                   \
>         __kmsan_cond_end .......
>
> and let the compiler stick whatever is required into that code section
> between instrumentation_begin() and instrumentation_end()?

We define noinstr as
__attribute__((disable_sanitizer_instrumentation))
(https://llvm.org/docs/LangRef.html#:~:text=3Ddisable_sanitizer_instrumenta=
tion),
which means no instrumentation will be applied to the annotated
function.
Changing that behavior by adding subregions that can be instrumented
sounds questionable.
C also doesn't have good syntactic means to define these subregions -
perhaps some __xxx_begin()/__xxx_end() intrinsics would work, but they
would require both compile-time and run-time validation.

Fortunately, I don't think we need to insert extra instrumentation
into instrumentation_begin()/instrumentation_end() regions.

What I have in mind is adding a bool flag to kmsan_context_state, that
the instrumentation sets to true before the function call.
When entering an instrumented function, KMSAN would check that flag
and set it to false, so that the context state can be only used once.
If a function is called from another instrumented function, the
context state is properly set up, and there is nothing to worry about.
If it is called from non-instrumented code (either noinstr or the
skipped files that have KMSAN_SANITIZE:=3Dn), KMSAN would detect that
and wipe the context state before use.

By the way, I've noticed that at least for now (with pt_regs
unpoisoning performed in IDT entries) the problem with false positives
in noinstr code is entirely gone, so maybe we don't even have to
bother.

> Yes, it's more work on the tooling side, but the tooling side is mostly
> a one time effort while chasing the false positives is a long term
> nightmare.

Well said.

> Thanks,
>
>         tglx



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
