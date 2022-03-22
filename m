Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAD54E466D
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 20:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiCVTFi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 15:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiCVTFg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 15:05:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA25DE85;
        Tue, 22 Mar 2022 12:04:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b24so22830262edu.10;
        Tue, 22 Mar 2022 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hfLUfSmKk/F6oL+pEdnJmHbr46HHHKKN6gcQZmfRAMw=;
        b=XwH1KBP7s8AWHIdqkpt29/9jKPxp2TUdIHq4DYz2SkEkpNwuXBjh3+Jy773jmZN6vj
         sGD8nlOqmKY20ZzqpHgfGQ7HA1sKoi1IGecbHnUkjkXIJHX9nSBa4vEcYvbfXLmwf9oA
         PAOYtiyhUEIHXoC7hcexSBXROndfo13UwiiWpxZmGa4lGFc6v8cRehieAJDpVYKVAQRR
         PVfct1tzf+vcw2wkAWT3DyWC8aCjz4nfCSYkYOMam1zXJrrwGB0+V9/dJlPdDpWUCewS
         zyspE8YDK/F8HcmixEnYeAmTYvTj40gQOd8cSN6U1Be3leUfhC1PtA7n+8mASN1LJCsW
         EgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hfLUfSmKk/F6oL+pEdnJmHbr46HHHKKN6gcQZmfRAMw=;
        b=PX7OQml7m+370t6HaGT1d2RkmkeX527LEHYVocFYqQLqQ7T5EDGaMjwVSPuSM5EhpG
         BUokspA1bm8m8dW3p1WTjz8gtWJhyvuDEj0fLCFPj3oid6dWV2eAIJKLsE9zwuOrfBu1
         s98RcQMzqZVXgJ15WDAnfzIPNmNTTXtYuLjOfLW4SPkwjW8iY+Ux4kiRBDXyW9AFFOlH
         7d7o8jaPHgjQX63jKQZqfKq0PB6a2dkNIUAG9K68M8Baw/JOaWc0a33btuUUeEzIg9pN
         CC52CgCdItbieKvbm6GWHIk+jwlWYIAQOHi25vUJVo0ZP7zuQ9+J4fSNYMyktO5q7XVT
         2Dmw==
X-Gm-Message-State: AOAM532+Wn7cN3ScyjqMyqywp1RJnHNGXBfalOrdUk8/yzwcUopPZ/ZS
        /4aZYkVKzLrCb5a2rj2n0lezUE/PX1v2XXyVYCo=
X-Google-Smtp-Source: ABdhPJwfpbpd/pXkiH2VtyBbD4b0xTNa7Dts7vTqnqzOw6ZriE6R584i1NaFtOgyocc/mhJuDI6NiS1GOuS42sgPR9w=
X-Received: by 2002:a50:ec16:0:b0:40f:28a0:d0d6 with SMTP id
 g22-20020a50ec16000000b0040f28a0d0d6mr24268596edr.368.1647975847194; Tue, 22
 Mar 2022 12:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <Ydm7ReZWQPrbIugn@gmail.com> <YjBr10JXLGHfEFfi@gmail.com>
 <CAKBF=pvWzuPx0JB3XZ-v+i7KGbhMQTgH6xtii_Bed+qKRFx+ww@mail.gmail.com>
 <b8095bf8-961f-827c-2bd6-2ffa6298b730@infradead.org> <CAC=eVgQCs97N_jkB1LKOdxhd=Yvgf1SZfBWcDbG2dGhsihXLqw@mail.gmail.com>
In-Reply-To: <CAC=eVgQCs97N_jkB1LKOdxhd=Yvgf1SZfBWcDbG2dGhsihXLqw@mail.gmail.com>
From:   Kari Argillander <kari.argillander@gmail.com>
Date:   Tue, 22 Mar 2022 21:03:56 +0200
Message-ID: <CAC=eVgQeawN4Kr2DSePunCdLr_z9zbE=W72vVcLpHU63_3u4YA@mail.gmail.com>
Subject: Re: [TREE] "Fast Kernel Headers" Tree -v3
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Kari Argillander <kari.argillander@stargateuniverse.net>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

22.03.2022 18.22 Kari Argillander (kari.argillander@gmail.com) wrote:
>
> 22.03.2022 17.37 Randy Dunlap (rdunlap@infradead.org) wrote:
> >
> > Hi Kari,
> >
> > On 3/22/22 00:59, Kari Argillander wrote:
> > > 15.3.2022 12.35 Ingo Molnar (mingo@kernel.org) wrote:
> > >>
> > >> This is -v3 of the "Fast Kernel Headers" tree, which is an ongoing r=
ework
> > >> of the Linux kernel's header hierarchy & header dependencies, with t=
he dual
> > >> goals of:
> > >>
> > >>  - speeding up the kernel build (both absolute and incremental build=
 times)
> > >>
> > >>  - decoupling subsystem type & API definitions from each other
> > >>
> > >> The fast-headers tree consists of over 25 sub-trees internally, span=
ning
> > >> over 2,300 commits, which can be found at:
> > >>
> > >>     git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git mast=
er
> > >
> > > I have had problems to build master branch (defconfig) with gcc9
> > >     gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
> > >
> > > I did also test v2 and problems where there too. I have no problem wi=
th gcc10 or
> > > Clang11. Error I get is:
> > >
> > > In file included from ./include/linux/rcuwait_api.h:7,
> > >                  from ./include/linux/rcuwait.h:6,
> > >                  from ./include/linux/irq_work.h:7,
> > >                  from ./include/linux/perf_event_types.h:44,
> > >                  from ./include/linux/perf_event_api.h:17,
> > >                  from arch/x86/kernel/kprobes/opt.c:8:
> > > ./include/linux/rcuwait_api.h: In function =E2=80=98rcuwait_active=E2=
=80=99:
> > > ./include/linux/rcupdate.h:328:9: error: dereferencing pointer to
> > > incomplete type =E2=80=98struct task_struct=E2=80=99
> > >   328 |  typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> > >       |         ^
> > > ./include/linux/rcupdate.h:439:31: note: in expansion of macro
> > > =E2=80=98__rcu_access_pointer=E2=80=99
> > >   439 | #define rcu_access_pointer(p) __rcu_access_pointer((p),
> > > __UNIQUE_ID(rcu), __rcu)
> > >       |                               ^~~~~~~~~~~~~~~~~~~~
> > > ./include/linux/rcuwait_api.h:15:11: note: in expansion of macro
> > > =E2=80=98rcu_access_pointer=E2=80=99
> > >    15 |  return !!rcu_access_pointer(w->task);
> > >
> > >     Argillander
> >
> > You could try the patch here:
> > https://lore.kernel.org/all/917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infrad=
ead.org/
>
> I have to edit it to <linux/cgroup_types.h> as there is no <linux/cgroup-=
defs.h>
> with fast headers. I also tried a couple other things but it didn't
> seem to make a
> difference.
>
> > although the build error that it fixes doesn't look exactly the same
> > as yours.
>
> Quite close still. Maybe I should try to bisect this and I will also
> see how bisectable
> this branch is.

Ok. I have now bisect first bad to this commit.
c4ad6fcb67c4 ("sched/headers: Reorganize, clean up and optimize
kernel/sched/fair.c dependencies")
Note that this has been also bisect by others.

With this I get little bit different error:

In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from ./include/linux/compiler.h:255,
                 from ./include/linux/export.h:43,
                 from ./include/linux/linkage.h:7,
                 from ./include/linux/kernel.h:17,
                 from ./include/linux/cpumask.h:10,
                 from ./include/linux/energy_model.h:4,
                 from kernel/sched/fair.c:23:
./include/linux/psi.h: In function =E2=80=98cgroup_move_task=E2=80=99:
./include/linux/rcupdate.h:414:36: error: dereferencing pointer to
incomplete type =E2=80=98struct css_set=E2=80=99
  414 | #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
      |                                    ^~~~

Which is actually the same error that is in Randy's message. Patch of
Randy works
on top of this commit. But I cannot get this patch to work with HEAD,
but probably
I'm just missing something obvious. Still nice to see that probably a
solution is near.

> > >> There's various changes in -v3, and it's now ported to the latest ke=
rnel
> > >> (v5.17-rc8).
> > >>
> > >> Diffstat difference:
> > >>
> > >>  -v2: 25332 files changed, 178498 insertions(+), 74790 deletions(-)
> > >>  -v3: 25513 files changed, 180947 insertions(+), 74572 deletions(-)
> >
> >
> > --
> > ~Randy
