Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46899517546
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358591AbiEBREk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 13:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386499AbiEBREe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 13:04:34 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B362BD7
        for <linux-arch@vger.kernel.org>; Mon,  2 May 2022 10:01:05 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f7c424c66cso154939197b3.1
        for <linux-arch@vger.kernel.org>; Mon, 02 May 2022 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZDNXgBhMz20++Q4yigO612T0eYygF7r9J92FIVtim7Y=;
        b=JgdYu4i8LXmMnXLXrkcT7kHOAMHmAidhNS6U0ueSLoMV2xM914ojCWAfQT3FwPR+1l
         PoLOfIxEoZUnpUcLAHkqdzewTFZmlPHzf2P4KtVSykjNiUaSjHEZ4JXGrO87YwYEfY29
         Z+QTsgSlKNHz0OH4JLROLS99pvqLcEwt40oWqVFt9/peS0coGpNEREGC2CeybE9udTkZ
         PBSCKT1mEj4EUvIGaFwp/YC2T3K64TVZ9MIoJHwe/x1WPyoerlcNsHxE9mUxBRzI6/O/
         dA+GoQpNe65P4xsbfG25zceIOp2apEavuWjynEw+O1ENeDzWJe9o6sXQ0vlxCo8yyC69
         UBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZDNXgBhMz20++Q4yigO612T0eYygF7r9J92FIVtim7Y=;
        b=Qmzad2XAc9UAofvlz8gD/lbazvvQXag+ai6+V7k73wLi8BNTfkDYhSSn77rNtBfufS
         kVBiNHKOPL8mpnufD0OuNk/X9ooRGrhLzxgmNL37P5pbenuKcaaVU5H9R2E07et4SXfL
         IB5vKpwFY5By83pzNy5Nz2ZXVrqPQ87FBNa618T/bidS5bEjcfkXuPkfnSoYYdMES0bR
         e6hFPq4JjgClauDGOsMoMOmw6qs5k7cfsOdUn93MqEgjazoZV3uJHBy6JBosq8LHjkmO
         ExlrpXYePen0TRsCFH9QhLElT+GWjYP5WIZCZKWQq4nCtasTQKXRgdFwqPA3QyxVUSPH
         u0Ow==
X-Gm-Message-State: AOAM533MEpjzb3wwrI+e3qWFTAWkKG4VP1ctn3GVWIB01/frPcILLLnX
        tVfZPIGyZp76f14ggnEd08Jg5Aigkd75K/e+kXblsw==
X-Google-Smtp-Source: ABdhPJy9WXshcsyYnhmFBRjyjSz+xXgG968fsEWEpZo4KzR8Ug2a15AebqyxN7IoToxv1Gm1KUB+/NnO5+jeZO0Mdww=
X-Received: by 2002:a81:1f8b:0:b0:2f8:5846:445e with SMTP id
 f133-20020a811f8b000000b002f85846445emr11776773ywf.50.1651510864112; Mon, 02
 May 2022 10:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-29-glider@google.com>
 <87a6c6y7mg.ffs@tglx>
In-Reply-To: <87a6c6y7mg.ffs@tglx>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 2 May 2022 19:00:28 +0200
Message-ID: <CAG_fn=U7PPBmmkgxFcWFQUCqZitzMizr1e69D9f26sGGzeitLQ@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 3:32 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Apr 26 2022 at 18:42, Alexander Potapenko wrote:
>
> Can you please use 'entry:' as prefix. Slapping kmsan in front of
> everything does not really make sense.
Sure, will do.

> > Replace instrumentation_begin()       with instrumentation_begin_with_r=
egs()
> > to let KMSAN handle the non-instrumented code and unpoison pt_regs
> > passed from the instrumented part.
>
> That should be:
>
>      from the non-instrumented part
> or
>      passed to the instrumented part
>
> right?

That should be "from the non-instrumented part", you are right.

> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -23,7 +23,7 @@ static __always_inline void __enter_from_user_mode(st=
ruct pt_regs *regs)
> >       CT_WARN_ON(ct_state() !=3D CONTEXT_USER);
> >       user_exit_irqoff();
> >
> > -     instrumentation_begin();
> > +     instrumentation_begin_with_regs(regs);
>
> I can see what you are trying to do, but this will end up doing the same
> thing over and over. Let's just look at a syscall.
>
> __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
> {
>         ...
>         nr =3D syscall_enter_from_user_mode(regs, nr)
>
>                 __enter_from_user_mode(regs)
>                         .....
>                         instrumentation_begin_with_regs(regs);
>                         ....
>
>                 instrumentation_begin_with_regs(regs);
>                 ....
>
>         instrumentation_begin_with_regs(regs);
>
>         if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr =
!=3D -1) {
>                 /* Invalid system call, but still a system call. */
>                 regs->ax =3D __x64_sys_ni_syscall(regs);
>         }
>
>         instrumentation_end();
>
>         syscall_exit_to_user_mode(regs);
>                 instrumentation_begin_with_regs(regs);
>                 __syscall_exit_to_user_mode_work(regs);
>         instrumentation_end();
>         __exit_to_user_mode();
>
> That means you memset state four times and unpoison regs four times. I'm
> not sure whether that's desired.

Regarding the regs, you are right. It should be enough to unpoison the
regs at idtentry prologue instead.
I tried that initially, but IIRC it required patching each of the
DEFINE_IDTENTRY_XXX macros, which already use instrumentation_begin().
This decision can probably be revisited.

As for the state, what we are doing here is still not enough, although
it appears to work.

Every time an instrumented function calls another function, it sets up
the metadata for the function arguments in the per-task struct
kmsan_context_state.
Similarly, every instrumented function expects its caller to put the
metadata into that structure.
Now, if a non-instrumented function (e.g. every `noinstr` function)
calls an instrumented one (which happens inside the
instrumentation_begin()/instrumentation_end() region), nobody sets up
the state for that instrumented function, so it may report false
positives when accessing its arguments, if there are leftover poisoned
values in the state.

To overcome this problem, ideally we need to wipe kmsan_context_state
every time a call from the non-instrumented function occurs.
But this cannot be done automatically exactly because we cannot
instrument the named function :)

We therefore apply an approximation, wiping the state at the point of
the first transition between instrumented and non-instrumented code.
Because poison values are generally rare, and instrumented regions
tend to be short, it is unlikely that further calls from the same
non-instrumented function will result in false positives.
Yet it is not completely impossible, so wiping the state for the
second/third etc. time won't hurt.

>
> instrumentation_begin()/end() are not really suitable IMO. They were
> added to allow objtool to validate that nothing escapes into
> instrumentable code unless annotated accordingly.

An alternative to this would be adding some extra code unpoisoning the
state to every non-instrumented function that contains an instrumented
region.
That code would have to precede the first instrumentation_begin()
anyway, so I thought it would be reasonable to piggyback on the
existing annotation.

>
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
