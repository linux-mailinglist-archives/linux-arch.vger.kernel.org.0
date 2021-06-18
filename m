Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB23ACDA9
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhFROjc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 10:39:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34517 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbhFROjb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 10:39:31 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0G5n-1l7WI33OAZ-00xIjH; Fri, 18 Jun 2021 16:37:20 +0200
Received: by mail-wr1-f44.google.com with SMTP id m18so11035687wrv.2;
        Fri, 18 Jun 2021 07:37:20 -0700 (PDT)
X-Gm-Message-State: AOAM5334/0pusQfhiktLmyGNSxC6H/mMKRhx4h6bJfwhtNoWw1UXDKgg
        oGO8L2d6G3DtXelG51OKXrJDqrPAis9ZaZucM50=
X-Google-Smtp-Source: ABdhPJzGTel7+XBugylK0JPy7eWhukAPUYYErZjXohSKjAs4Xg8IaayGgubfS77p1lNo+CYC4yUzeoSt+cpf4I9g9Ew=
X-Received: by 2002:a5d:5084:: with SMTP id a4mr13105629wrt.286.1624027040475;
 Fri, 18 Jun 2021 07:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210617214328.3501174-1-trix@redhat.com> <20210617214328.3501174-3-trix@redhat.com>
 <CAK8P3a14uKvDZ4OevR5z2+AJervkepDcPjGWwstTo5antbQyXA@mail.gmail.com> <312e5b85-bfa5-e7f1-c1f7-a13a5d2583b8@redhat.com>
In-Reply-To: <312e5b85-bfa5-e7f1-c1f7-a13a5d2583b8@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Jun 2021 16:35:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a29bdyw=K8fNm1_pkbrsLG3f5FeTZhNKUYhdP3cs_fO=A@mail.gmail.com>
Message-ID: <CAK8P3a29bdyw=K8fNm1_pkbrsLG3f5FeTZhNKUYhdP3cs_fO=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] bug: mark generic BUG() as unreachable
To:     Tom Rix <trix@redhat.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yL83Sv+dsPQYvQMia5To51ICrhGI6x9kNcX1q6ERgJAuBjt2sTa
 7fp6FUh1Dk4TQypTS3XtvklCH88Epi/kfTQrhd4R3FNJVMS9wtM3fEtGEe/Y4N2xhaTnJu4
 u715zTvCjK0VXOSmNN5CZwSWNQwWAoFlgH7sE8l67O0f82PNXVN3RGijG/4LJ7CWuQcnC61
 Snror1cNaWrSK6OGHFz+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TYhvqB9a+aA=:mfwQ3nIv+rzZhIOfPPNGgY
 Vsnbs+juzhA9I6pdsrgZ0qBFHVkXCAId28cEC19dhJPkI9RqMIDZwwS/cwk3R8xUrYaeHoSy7
 h21PJxjnlOipRLmE2DbWZJkSymEsoQIfdvMcmyJPhcPIGtohyzCgrYfnZZAtMHdCjkfW68cub
 UdLQixgFzJJz0crE9BikHQkBTt/KuLU8IRh/8LGwV4iFR7eLf/RvCRvI2ICzKACSupmZeXazh
 e+7SKilIBwiyLkwCJ1qecHiqPC52swHjo3Fvy59hhGAzOhldssuADEumNsKh4V9V37uFaUMvd
 g0aikOh/SPIQHWH5/trZAGRjyuAwL6gVpb/keidWdMnaxt5Hlu1FGReqESkf+XY/zSG9vC5jL
 h74kcdwG/naNVOl1cqwhyPLZuf5xc4LozU9CUxeLavSLsnHrURO3HAHJefuzfA83GFpOmeG9C
 kqde7+hTEKN8hCl722inH+Nlc0iHZDkIQVA3mf95i1aSQ+n41E2xMAMVxGwIQDcHQMxy8IM6s
 DlXvOays2h2NEEWseMGpMRn6rT7ivETwY3Vz79JY0okpPL5PtPou2ob39Z3QXzV/DGsa3iJVg
 xudDgR1yx0Nf6/42eHFobhe4RFWNgFBn2sSMa22q7xmqc0MqrWlbiPtipS6tyBbyPK9fLDth6
 8lyg=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 18, 2021 at 3:43 PM Tom Rix <trix@redhat.com> wrote:
> On 6/18/21 1:20 AM, Arnd Bergmann wrote:
> > On Thu, Jun 17, 2021 at 11:44 PM <trix@redhat.com> wrote:
> >> From: Tom Rix <trix@redhat.com>
> >>
> >> This spurious error is reported for powerpc64, CONFIG_BUG=n
> >>
> >> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> >> index f152b9bb916fc..b250e06d7de26 100644
> >> --- a/include/asm-generic/bug.h
> >> +++ b/include/asm-generic/bug.h
> >> @@ -177,7 +177,10 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
> >>
> >>   #else /* !CONFIG_BUG */
> >>   #ifndef HAVE_ARCH_BUG
> >> -#define BUG() do {} while (1)
> >> +#define BUG() do {                                             \
> >> +               do {} while (1);                                \
> >> +               unreachable();                                  \
> >> +       } while (0)
> >>   #endif
> > Please let's not go back to this version, we had good reasons to use
> > the infinite loop,
> > mostly to avoid undefined behavior that would lead to the compiler producing
> > completely random output in code paths that lead to a BUG() statement. Those
> > do cause other kinds of warnings from objtool and from other compilers.
> >
> > The obvious workaround here would be to add a return statement locally, but
> > it may also help to figure out what exactly triggers the warning, as I don't see
> > it in my randconfig builds and it may be that there is a bug elsewhere.
> >
> > I've tried a simple reproducer on https://godbolt.org/z/341P949bG that did not
> > show this warning in any of the compilers I tried. Can you try to narrow down
> > the exact compiler versions and commmand line options that produce the
> > warning? https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ has
> > most of the supported gcc versions in case you need those.
>
> Please follow the link in the cover letter to the original issue
> reported for fs/afs/dir + gcc ppc64 9.x / 10.3.1
>
> Adding the return was the first, rejected solution.

Ok, I was able to reproduce it now and have a better idea of what is going on.

I also misread your patch (sorry about that), and missed that you keep the
"do {} while (1)" loop ahead of the unreachable(), and that should address
all the concerns I had. I would still try to find the old email thread about
the change, just to make sure we don't already know about other problems
with your version.

      Arnd
