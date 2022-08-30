Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D485A6636
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 16:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiH3OY1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH3OYX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 10:24:23 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F4711C15C
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 07:24:21 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3321c2a8d4cso277264817b3.5
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=gt/5eV/ZpK3WodQ+XAEGUey1G3s7WAZiZKt3bPC8X9Y=;
        b=NJkAG1gpVqHfWInlurGJmVG3R+RA9MT+JGCwiveMgAZ2izde0jgt/HGcHXZpxsoM+D
         VX2DmYxU5+R06Av1HoBK2lfCyrLi0SHU35Xn3Eqg/1pT/OOEJXltQTuKai98zcE4qPc3
         IyPVDXb7QXZdAdQs102YteFR2UaXoJog7lMP6N8UOoGxqzL+0EmI/kRV05/P/fNgYP1R
         u+tfUGRZZmvy2fluAPQYX/tLrSXQtbMStUsiHRhm7CaVhrm7UsEkVAAX9h6nlIKKWaF1
         9zcnoe03OdMBz4ny6yBrIehUOgNyXloHhB7PVq+sp0OVonxt1HYY+lLh93wCriBKPj7N
         Rhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=gt/5eV/ZpK3WodQ+XAEGUey1G3s7WAZiZKt3bPC8X9Y=;
        b=74gMMSSSPdbFk+o7bD77TCAWF3ET267K7UrmFa4XCZpWrMXY+xGXJkruLbq2m/hfw9
         Txv/aLqa4xKIeD898+EvAu7lq45BnSZiIlLkumc1i8F51tLGvhuGJuRG+LU9U+Z4EIBI
         wFDF01Babv668ApQn6s9MNNFSyaPEgWlSXjcPUWku7Hkd9qJelaUbwrxPZX8go2Kv7K3
         D1wJyeyLVHAHaXRkfQZbyG+n9ZtGyiL/4XToRr9VzkGdU7L0xSQ8oW/SZYxm5rY3RYYV
         wbAjXXPYnO+Pm2skE/m5Lq8MAlFPENAZvlPv8E0MwZBnd6UWGv1XxzUR69f+NjzCXLN/
         bB7Q==
X-Gm-Message-State: ACgBeo39RcvLlQ+o8u6OTRHL9j97YWfhdWO39ll/Ophg1rfdcY77BE4R
        nxZmQz/zdGuoT4oFbOYpxFeKgwvmIXF3QBE2ntIlOg==
X-Google-Smtp-Source: AA6agR7jvVei8SmZabQHeD/SkA+/TrCqpW8qHKuBCJ3rJnHGAOGAH2dSiGFPEKmuWrV3gqrtSOKO3hjd/206yNSfB14=
X-Received: by 2002:a05:6902:1106:b0:695:c353:2c32 with SMTP id
 o6-20020a056902110600b00695c3532c32mr12729722ybu.398.1661869460597; Tue, 30
 Aug 2022 07:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220826150807.723137-1-glider@google.com> <20220826150807.723137-5-glider@google.com>
 <20220826211729.e65d52e7919fee5c34d22efc@linux-foundation.org>
 <CAG_fn=Xpva_yx8oG-xi7jqJyM2YLcjNda+8ZyQPGBMV411XgMQ@mail.gmail.com> <20220829122452.cce41f2754c4e063f3ae8b75@linux-foundation.org>
In-Reply-To: <20220829122452.cce41f2754c4e063f3ae8b75@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 30 Aug 2022 16:23:44 +0200
Message-ID: <CAG_fn=X6eZ6Cdrv5pivcROHi3D8uymdgh+EbnFasBap2a=0LQQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user() and put_user()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>
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

On Mon, Aug 29, 2022 at 9:24 PM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Mon, 29 Aug 2022 16:57:31 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> > On Sat, Aug 27, 2022 at 6:17 AM Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> > >
> > > On Fri, 26 Aug 2022 17:07:27 +0200 Alexander Potapenko <glider@google=
.com> wrote:
> > >
> > > > Use hooks from instrumented.h to notify bug detection tools about
> > > > usercopy events in variations of get_user() and put_user().
> > >
> > > And this one blows up x86_64 allmodconfig builds.
> >
> > How do I reproduce this?
> > I tried running `make mrproper; make allmodconfig; make -j64` (or
> > allyesconfig, allnoconfig) on both KMSAN tree
> > (https://github.com/google/kmsan/commit/ac3859c02d7f40f59992737d63afcac=
da0a972ec,
> > which is Linux v6.0-rc2 plus the 44 KMSAN patches) and
> > linux-mm/mm-stable @ec6624452e36158d0813758d837f7a2263a4109d with
> > KMSAN patches applied on top of it.
> > All builds were successful.
> >
> > I then tried to cherry-pick just the first 4 commits to mm-stable and
> > see if allmodconfig works - it resulted in numerous "implicit
> > declaration of function =E2=80=98instrument_get_user=E2=80=99" errors (=
quite silly of
> > me), but nothing looking like the errors you posted.
> > I'll try to build-test every patch in the series after fixing the
> > missing declarations, but so far I don't see other problems.
> >
> > Could you share the mmotm commit id which resulted in the failures?
>
> I just pushed out a tree which exhibits this with gcc-12.1.1 and with
> gcc-11.1.0.  Tag is mm-everything-2022-08-29-19-17.
>
> The problem is introduced by d0d9a44d2210 ("kmsan: add KMSAN runtime core=
")
>
> make mrproper
> make allmodconfig
> make init/do_mounts.o
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
> ./include/linux/page-flags.h: In function =E2=80=98page_fixed_fake_head=
=E2=80=99:
> ./include/linux/page-flags.h:226:36: error: invalid use of undefined type=
 =E2=80=98const struct page=E2=80=99
>   226 |             test_bit(PG_head, &page->flags)) {
>       |                                    ^~
> ./include/linux/bitops.h:50:44: note: in definition of macro =E2=80=98bit=
op=E2=80=99
>    50 |           __builtin_constant_p((uintptr_t)(addr) !=3D (uintptr_t)=
NULL) && \
>       |                                            ^~~~
> ./include/linux/page-flags.h:226:13: note: in expansion of macro =E2=80=
=98test_bit=E2=80=99
>   226 |             test_bit(PG_head, &page->flags)) {
>       |             ^~~~~~~~
> ...

Gotcha, this is a circular dependency: mm_types.h -> sched.h ->
kmsan.h -> gfp.h -> mmzone.h -> page-flags.h -> mm_types.h, where the
inclusion of sched.h into mm_types.h was only introduced in "mm:
multi-gen LRU: support page table walks" - that's why the problem was
missing in other trees.

In fact sched.h only needs the definitions of `struct
kmsan_context_state` and `struct kmsan_ctx` from kmsan.h, so I am
splitting them off into kmsan_types.h to break this circle.
Doing so also helped catch a couple of missing/incorrect inclusions of
KMSAN headers in subsystems.

I'll fix those and do more testing.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
