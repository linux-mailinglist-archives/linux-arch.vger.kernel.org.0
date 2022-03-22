Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA2D4E4424
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 17:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiCVQYK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbiCVQYF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 12:24:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ECB33A3B;
        Tue, 22 Mar 2022 09:22:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id pv16so37398751ejb.0;
        Tue, 22 Mar 2022 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RnHScbAztaVNd5Ws3xzlYsRFa7RoT7IlbgCNulhiTI4=;
        b=Ac3JKCAIEdwPv6hT/maKB7TzCudO127iLco/TwRd+d0/mdS2DM9Wt/w69tk75eoI60
         HusMPH9FRmY0xuhnFQuoQrcGVOYTzCx6+l/qdEU7o1++eIylZ0CSyrbX+2U+oytJVPE3
         +K9NCYuTsO3htTMLJr7P6eTkKrkxX1U9VaofleYZvp+nos4GFQdcj4Mf1+2rjR1BjEK3
         LGJ/pVvQIj2vA2XqN4dsf5foanGcSZi5IxF2Xdt6N/d+LxI3dTYuaV+7w7w6FxjBJEoR
         c2jMhsJ3pgbWSZokL4vpISXX2xFaKLgiW9DkOW5jXDxS7G2M4L4qdxVXhDNimS87pSUH
         MKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RnHScbAztaVNd5Ws3xzlYsRFa7RoT7IlbgCNulhiTI4=;
        b=Eq19Cl9GKGNeD+SPPA17h43AzBZBr37DpM0D3tmshpQNFxhifrpHoDxlYV3QnMapqY
         9okQCDLyRwL34CgJnujsbIAcZq5hvzatHpYfUGEU/aDzfjhfZXSF/tiSQEdLuGlXaJ2M
         H/jiJMTMLYALk4+fgreieY46d4cH3pBPP3XM5M84ggLBPIn88GkWkct1tPH2Cdt6EZCH
         SuieuAxE6Ze8QIKrOzugcxun21FyFtK5WXlVJcWo6bVjNoTgIdie15wQCTz1iu8r7wXu
         R8sXQv3zG/qOFbvHM8VUbZvzPnkW5zmBWtF3U9016d7zsf5E1Iov0PaGu4sR6CPKPJgv
         zRDA==
X-Gm-Message-State: AOAM533trqP4VM5Ly69gOVOeVm4sHhXpXKIivK0Yb6mxy6xi+1TBB+o4
        5oi/h/CdNKBgYoaULagNaFP3tN+4fxs06aXZMN+ffIewYFsWnOUC
X-Google-Smtp-Source: ABdhPJyDUehJdgOjV7KxxUDx1Qbw/pHse/jIP0Hop8yImsN+QxanbBE8cK9l66s1ECIhzRuRhi+aXNY34n+zdqx8k78=
X-Received: by 2002:a17:906:c211:b0:6ce:e221:4c21 with SMTP id
 d17-20020a170906c21100b006cee2214c21mr26225642ejz.691.1647966155543; Tue, 22
 Mar 2022 09:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <Ydm7ReZWQPrbIugn@gmail.com> <YjBr10JXLGHfEFfi@gmail.com>
 <CAKBF=pvWzuPx0JB3XZ-v+i7KGbhMQTgH6xtii_Bed+qKRFx+ww@mail.gmail.com> <b8095bf8-961f-827c-2bd6-2ffa6298b730@infradead.org>
In-Reply-To: <b8095bf8-961f-827c-2bd6-2ffa6298b730@infradead.org>
From:   Kari Argillander <kari.argillander@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:24 +0200
Message-ID: <CAC=eVgQCs97N_jkB1LKOdxhd=Yvgf1SZfBWcDbG2dGhsihXLqw@mail.gmail.com>
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

22.03.2022 17.37 Randy Dunlap (rdunlap@infradead.org) wrote:
>
> Hi Kari,
>
> On 3/22/22 00:59, Kari Argillander wrote:
> > 15.3.2022 12.35 Ingo Molnar (mingo@kernel.org) wrote:
> >>
> >> This is -v3 of the "Fast Kernel Headers" tree, which is an ongoing rew=
ork
> >> of the Linux kernel's header hierarchy & header dependencies, with the=
 dual
> >> goals of:
> >>
> >>  - speeding up the kernel build (both absolute and incremental build t=
imes)
> >>
> >>  - decoupling subsystem type & API definitions from each other
> >>
> >> The fast-headers tree consists of over 25 sub-trees internally, spanni=
ng
> >> over 2,300 commits, which can be found at:
> >>
> >>     git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
> >
> > I have had problems to build master branch (defconfig) with gcc9
> >     gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
> >
> > I did also test v2 and problems where there too. I have no problem with=
 gcc10 or
> > Clang11. Error I get is:
> >
> > In file included from ./include/linux/rcuwait_api.h:7,
> >                  from ./include/linux/rcuwait.h:6,
> >                  from ./include/linux/irq_work.h:7,
> >                  from ./include/linux/perf_event_types.h:44,
> >                  from ./include/linux/perf_event_api.h:17,
> >                  from arch/x86/kernel/kprobes/opt.c:8:
> > ./include/linux/rcuwait_api.h: In function =E2=80=98rcuwait_active=E2=
=80=99:
> > ./include/linux/rcupdate.h:328:9: error: dereferencing pointer to
> > incomplete type =E2=80=98struct task_struct=E2=80=99
> >   328 |  typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> >       |         ^
> > ./include/linux/rcupdate.h:439:31: note: in expansion of macro
> > =E2=80=98__rcu_access_pointer=E2=80=99
> >   439 | #define rcu_access_pointer(p) __rcu_access_pointer((p),
> > __UNIQUE_ID(rcu), __rcu)
> >       |                               ^~~~~~~~~~~~~~~~~~~~
> > ./include/linux/rcuwait_api.h:15:11: note: in expansion of macro
> > =E2=80=98rcu_access_pointer=E2=80=99
> >    15 |  return !!rcu_access_pointer(w->task);
> >
> >     Argillander
>
> You could try the patch here:
> https://lore.kernel.org/all/917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradea=
d.org/

I have to edit it to <linux/cgroup_types.h> as there is no <linux/cgroup-de=
fs.h>
with fast headers. I also tried a couple other things but it didn't
seem to make a
difference.

> although the build error that it fixes doesn't look exactly the same
> as yours.

Quite close still. Maybe I should try to bisect this and I will also
see how bisectable
this branch is.

> >> There's various changes in -v3, and it's now ported to the latest kern=
el
> >> (v5.17-rc8).
> >>
> >> Diffstat difference:
> >>
> >>  -v2: 25332 files changed, 178498 insertions(+), 74790 deletions(-)
> >>  -v3: 25513 files changed, 180947 insertions(+), 74572 deletions(-)
>
>
> --
> ~Randy
