Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932A6565A58
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 17:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiGDPtw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiGDPtv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 11:49:51 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26E6270A
        for <linux-arch@vger.kernel.org>; Mon,  4 Jul 2022 08:49:50 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c89653790so34767087b3.13
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kB0Q9EykRhYRQy5w/R9rD3NHZHzS133LEDTFMEV0gnQ=;
        b=BsVN/T+Cr7Fz7QRKx37MaIbmzPtOjRBSjLtgtEvQCniQ32QrFtiF8UfJhCBYYXZ05D
         c1clpwBbV8do3uOIfULrsIyFme7FKlxhhNloVhnb0WCwGQCsqZL2LaWdT59oDEHsZiGE
         kJpwSABagBj7urC61V/vDuT612FfRVtv3YAkF4k6oB4VDywd/VNccUpmzeIln3Z2w5pj
         6NhMc/VheMFYI03tORin+p0Ph1kBtJoa0rnZzXDoc3HKJZVJVAmsz7z8lXw2HGJuULGy
         G/ZEEkMinCjHEVeBuWXZaqX/7tYOiDhQVk7CgN/nSOCGQ3PUfhlhdXzqXu7VtXkec5yK
         7i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kB0Q9EykRhYRQy5w/R9rD3NHZHzS133LEDTFMEV0gnQ=;
        b=e9s6NsZgDcQa84+Zj3EcRH9qAVu5k6nYt9BEUp9Dx3C+tOdp8Jxk1uk1mwjRv3Uwrl
         EqaBG4dX/nPfFAo4YEWsQW20RFA88GUWeyxEcj/eR/TUKsyNbG8VAnz5YRTTmiXTeh9d
         W8tzpo8ZEPdskqd9nazNiM1rRCtal7mrO52DKNULHgcbkRqZGC0+KKNkkhm8LfRrq27k
         bifAvALB2wKSGUFqTdQIV3LgQesn7dnQcbCQc4s7B160qbA6kxUJdxzA1IsEwTW5YLPk
         qYHVR6Bal7qbqNBlQ0uc8TkqLJZiNVS8+jz5aSppxuIPK1UzFr8EUc0Mm/lOuS4L3eyn
         6SlA==
X-Gm-Message-State: AJIora9pv+3FgzsBL4jdju1Re3KSsujIuUg2Y6iISmkDT1O5wJrMvwKZ
        9js6+s5+AuKLX5b4G8rhAU6OLUB8iiAWGldrDk+DJQ==
X-Google-Smtp-Source: AGRyM1tiVL3OesiKZ3ynhuSHFjuYYA7A2DN8MA5Tl6Wm/gnSAWj/xnfNXvXMzmfAODFHhl+OtNE0xkrQCcqeO6a8LnQ=
X-Received: by 2002:a81:a847:0:b0:31c:7dd5:6d78 with SMTP id
 f68-20020a81a847000000b0031c7dd56d78mr15737307ywh.50.1656949789965; Mon, 04
 Jul 2022 08:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV> <CAG_fn=V_vDVFNSJTOErNhzk7n=GRjZ_6U6Z=M-Jdmi=ekbS5+g@mail.gmail.com>
 <YsLuoFtki01gbmYB@ZenIV>
In-Reply-To: <YsLuoFtki01gbmYB@ZenIV>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 4 Jul 2022 17:49:13 +0200
Message-ID: <CAG_fn=VTihJSzQ106WPaQNxwTuuB8iPQpZR4306v8KmXxQT_GQ@mail.gmail.com>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
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

On Mon, Jul 4, 2022 at 3:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jul 04, 2022 at 10:20:53AM +0200, Alexander Potapenko wrote:
>
> > What makes you think they are false positives? Is the scenario I
> > described above:
> >
> > """
> > In particular, if the call to lookup_fast() in walk_component()
> > returns NULL, and lookup_slow() returns a valid dentry, then the
> > `seq` and `inode` will remain uninitialized until the call to
> > step_into()
> > """
> >
> > impossible?
>
> Suppose step_into() has been called in non-RCU mode.  The first
> thing it does is
>         int err =3D handle_mounts(nd, dentry, &path, &seq);
>         if (err < 0)
>                 return ERR_PTR(err);
>
> And handle_mounts() in non-RCU mode is
>         path->mnt =3D nd->path.mnt;
>         path->dentry =3D dentry;
>         if (nd->flags & LOOKUP_RCU) {
>                 [unreachable code]
>         }
>         [code not touching seqp]
>         if (unlikely(ret)) {
>                 [code not touching seqp]
>         } else {
>                 *seqp =3D 0; /* out of RCU mode, so the value doesn't mat=
ter */
>         }
>         return ret;
>
> In other words, the value seq argument of step_into() used to have ends u=
p
> being never fetched and, in case step_into() gets past that if (err < 0)
> that value is replaced with zero before any further accesses.

Oh, I see. That is actually what had been discussed here:
https://lore.kernel.org/linux-toolchains/20220614144853.3693273-1-glider@go=
ogle.com/
Indeed, step_into() in its current implementation does not use `seq`
(which is noted in the patch description ;)), but the question is
whether we want to catch such cases regardless of that.
One of the reasons to do so is standard compliance - passing an
uninitialized value to a function is UB in C11, as Segher pointed out
here: https://lore.kernel.org/linux-toolchains/20220614214039.GA25951@gate.=
crashing.org/
The compilers may not be smart enough to take advantage of this _yet_,
but I wouldn't underestimate their ability to evolve (especially that
of Clang).
I also believe it's fragile to rely on the callee to ignore certain
parameters: it may be doing so today, but if someone changes
step_into() tomorrow we may miss it.

If I am reading Linus's message here (and the following one from him
in the same thread):
https://lore.kernel.org/linux-toolchains/CAHk-=3Dwhjz3wO8zD+itoerphWem+JZz4=
uS3myf6u1Wd6epGRgmQ@mail.gmail.com/
correctly, we should be reporting uninitialized values passed to
functions, unless those values dissolve after inlining.
While this is a bit of a vague criterion, at least for Clang we always
know that KMSAN instrumentation is applied after inlining, so the
reports we see are due to values that are actually passed between
functions.

> So it's a false positive; yes, strictly speaking compiler is allowd
> to do anything whatsoever if it manages to prove that the value is
> uninitialized.  Realistically, though, especially since unsigned int
> is not allowed any trapping representations...
>
> If you want an test stripped of VFS specifics, consider this:
>
> int g(int n, _Bool flag)
> {
>         if (!flag)
>                 n =3D 0;
>         return n + 1;
> }
>
> int f(int n, _Bool flag)
> {
>         int x;
>
>         if (flag)
>                 x =3D n + 2;
>         return g(x, flag);
> }
>
> Do your tools trigger on it?

Currently KMSAN has two modes of operation controlled by
CONFIG_KMSAN_CHECK_PARAM_RETVAL.
When enabled, that config enforces checks of function parameters at
call sites (by applying Clang's -fsanitize-memory-param-retval flag).
In that mode the tool would report the attempt to call `g(x, false)`
if g() survives inlining.
In the case CONFIG_KMSAN_CHECK_PARAM_RETVAL=3Dn, KMSAN won't be
reporting the error.

Based on the mentioned discussion I decided to make
CONFIG_KMSAN_CHECK_PARAM_RETVAL=3Dy the default option.
So far it only reported a handful of errors (i.e. enforcing this rule
shouldn't be very problematic for the kernel), but it simplifies
handling of calls between instrumented and non-instrumented functions
that occur e.g. at syscall entry points: knowing that passed-by-value
arguments are checked at call sites, we can assume they are
initialized in the callees.


HTH,
Alex

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
