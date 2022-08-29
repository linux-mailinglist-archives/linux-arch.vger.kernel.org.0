Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC085A4FB6
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiH2O6L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Aug 2022 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2O6K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2022 10:58:10 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D13E83F06
        for <linux-arch@vger.kernel.org>; Mon, 29 Aug 2022 07:58:09 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-334dc616f86so201983037b3.8
        for <linux-arch@vger.kernel.org>; Mon, 29 Aug 2022 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=/oXossRp5gmk91oxr3O2OqpJJYrYzHF/cnO4ugwp7xo=;
        b=nGGmFoI9UliEJbzlc2zbQNhXBHme0qkBgWGshv+bWBaLHZpUeQMOVvvUrGWdOdsv2s
         z5Ehp7oMbRTdg+fVQRiSMK/zovc/4PZxJygGY6fYt1LZQrfMxU72O1YtezQhX/fnxzkC
         hmwVjlv/xKQo9DHfnd32ZDWEPqc152dFOYaB2PyLHyNyMJety1bDK/EIVt0/JqQbR5XV
         qdFEYni5N+tQ2+b3v0Dx5IVr02NabMS/3gg+JSkAURNZ9r88RywUcuZzF+eHthf3Q0XR
         67tO7fg4mTyO+KE7/f/lfZsV8urY1AIDELRGlFKb052EpzQj6KOeJMaWZfchAtOzoL5W
         H8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=/oXossRp5gmk91oxr3O2OqpJJYrYzHF/cnO4ugwp7xo=;
        b=wKKazj7Qm7LLct7yogRk117HDdvf+dmi+PoNTKvNHY8oVARBlmxJOceYUN81eZyUb1
         opYmskdbrzjqiWrkxKIXtBE7kJQVmPWA31AQ82JssIPiTRNFbEEzmDP8dV+tFE/Epy6y
         YN2M0Qw4bPzxyHNp9Q9Ej/+YGeZK1AoR6ttfyQcx+qhslVbn1S0FCFiKrRCaygvDcsHk
         CpCIEg3azv4hZlDAZCrM5qEVpeejfW23NorDH/it9ZohiteKaqHEf447Glf9F/esOG8Y
         IPBl9OETeJouRq5pN86k6c83QEtcukRR2CdsrPMfTdcQUtf5wqVh2Fx65Q7q3R5FEeG5
         XjOA==
X-Gm-Message-State: ACgBeo3AgSxNw4nWDgc9pAlH3hv7HlC6rDqPb5j1+NbB8a+uJxEUWysC
        7GQXwATOB0eGQ0mw1W3GrUsOLg3UqjPmlONt+qGD7w==
X-Google-Smtp-Source: AA6agR5mmCyZc+bx/GJcaJ2M15hFLmoQSQdVojOAReBVIxBPIuK06EfnXzBQa/1JVFnFAiIHR+JBBUgib19jDvUn/E8=
X-Received: by 2002:a25:bc3:0:b0:673:bc78:c095 with SMTP id
 186-20020a250bc3000000b00673bc78c095mr8579874ybl.376.1661785088326; Mon, 29
 Aug 2022 07:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220826150807.723137-1-glider@google.com> <20220826150807.723137-5-glider@google.com>
 <20220826211729.e65d52e7919fee5c34d22efc@linux-foundation.org>
In-Reply-To: <20220826211729.e65d52e7919fee5c34d22efc@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 29 Aug 2022 16:57:31 +0200
Message-ID: <CAG_fn=Xpva_yx8oG-xi7jqJyM2YLcjNda+8ZyQPGBMV411XgMQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user() and put_user()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Sat, Aug 27, 2022 at 6:17 AM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Fri, 26 Aug 2022 17:07:27 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> > Use hooks from instrumented.h to notify bug detection tools about
> > usercopy events in variations of get_user() and put_user().
>
> And this one blows up x86_64 allmodconfig builds.

How do I reproduce this?
I tried running `make mrproper; make allmodconfig; make -j64` (or
allyesconfig, allnoconfig) on both KMSAN tree
(https://github.com/google/kmsan/commit/ac3859c02d7f40f59992737d63afcacda0a=
972ec,
which is Linux v6.0-rc2 plus the 44 KMSAN patches) and
linux-mm/mm-stable @ec6624452e36158d0813758d837f7a2263a4109d with
KMSAN patches applied on top of it.
All builds were successful.

I then tried to cherry-pick just the first 4 commits to mm-stable and
see if allmodconfig works - it resulted in numerous "implicit
declaration of function =E2=80=98instrument_get_user=E2=80=99" errors (quit=
e silly of
me), but nothing looking like the errors you posted.
I'll try to build-test every patch in the series after fixing the
missing declarations, but so far I don't see other problems.

Could you share the mmotm commit id which resulted in the failures?


> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -5,6 +5,7 @@
> >   * User space memory access functions
> >   */
> >  #include <linux/compiler.h>
> > +#include <linux/instrumented.h>
> >  #include <linux/kasan-checks.h>
> >  #include <linux/string.h>
> >  #include <asm/asm.h>
>
> instrumented.h looks like a higher-level thing than uaccess.h, so this
> inclusion is an inappropriate layering.  Or maybe not.
>
> In file included from ./include/linux/kernel.h:22,
>                  from ./arch/x86/include/asm/percpu.h:27,
>                  from ./arch/x86/include/asm/nospec-branch.h:14,
>                  from ./arch/x86/include/asm/paravirt_types.h:40,
>                  from ./arch/x86/include/asm/ptrace.h:97,
>                  from ./arch/x86/include/asm/math_emu.h:5,
>                  from ./arch/x86/include/asm/processor.h:13,
>                  from ./arch/x86/include/asm/timex.h:5,
>                  from ./include/linux/timex.h:67,
>                  from ./include/linux/time32.h:13,
>                  from ./include/linux/time.h:60,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:13,
>                  from init/do_mounts.c:2:
> ./include/linux/page-flags.h: In function 'page_fixed_fake_head':
> ./include/linux/page-flags.h:226:36: error: invalid use of undefined type=
 'const struct page'
>   226 |             test_bit(PG_head, &page->flags)) {
>       |                                    ^~
>
> [25000 lines snipped]
>
>
> And kmsan-add-kmsan-runtime-core.patch introduces additional build
> errors with x86_64 allmodconfig.
>
> This is all with CONFIG_KMSAN=3Dn
>
> I'll disable the patch series.  Please do much more compilation testing
> - multiple architectures, allnoconfig, allmodconfig, allyesconfig,
> defconfig, randconfig, etc.  Good luck, it looks ugly :(
>


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
