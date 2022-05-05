Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC42351BD72
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 12:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiEEKuZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 5 May 2022 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353497AbiEEKuZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 06:50:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63AF15FD7;
        Thu,  5 May 2022 03:46:44 -0700 (PDT)
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MC2sH-1ngkWc0SNh-00CTav; Thu, 05 May 2022 12:46:43 +0200
Received: by mail-wm1-f49.google.com with SMTP id q20so2393754wmq.1;
        Thu, 05 May 2022 03:46:42 -0700 (PDT)
X-Gm-Message-State: AOAM533c9sfMuPrtHgRDKUD42mJz5pnnIox0XcM4CbXmTctETUpV6QZV
        yyCxqln/3PaoAURcU+hdzEq2FXqt32sodmX2xe4=
X-Google-Smtp-Source: ABdhPJyFwBY33nx8Flpk/PWMnjLEt5creYwEvl9Kax8NgZPjrsYAYPMUU9wJqfenypJSNx98Enu2cPCLEOTeKZBJGw0=
X-Received: by 2002:a7b:cc93:0:b0:394:2622:fcd9 with SMTP id
 p19-20020a7bcc93000000b003942622fcd9mr4145550wma.20.1651747602669; Thu, 05
 May 2022 03:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <2c8c96f-a12f-aadc-18ac-34c1d371929c@linux.intel.com>
 <CAK8P3a0hy8Ras7pwF9rJADtCAfeV49K7GWkftJnzqeGiQ6j-zA@mail.gmail.com>
 <ca39c741-8d15-33c0-7bd6-635778cc436@linux.intel.com> <CAK8P3a33b4KvsGayDV7fXte0+1FzCJp_J60d8LuZO3P+i1NUEg@mail.gmail.com>
 <386eed36-94f7-8acb-926f-99c74d55915f@linux.intel.com>
In-Reply-To: <386eed36-94f7-8acb-926f-99c74d55915f@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 May 2022 12:46:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a06wdDC-c6V9kO6q3j_TB7HE7f1tdTUvC5yi7ekaHw1YQ@mail.gmail.com>
Message-ID: <CAK8P3a06wdDC-c6V9kO6q3j_TB7HE7f1tdTUvC5yi7ekaHw1YQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] termbits: Convert octal defines to hex
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:sSGfFqyReakvFmMBoIFnKxXTt3YrM/AnN0JCkz+2KDvVIBHaIhO
 imKzkV0yjeWXzBJ5JXQvWrIFnusxADrODyOLWhZQYzBhr0/M3O2+4yOrCH4lIpVQ+XyA3mx
 g4fUMdGvwaFJDRwopyDq6+GQZ8HOS+VEHC0q3TWeMpqoJ2fRxUJ6NR1OD4tqfpoJwb9raXb
 JA+qppAU7xdxMzS5qE6qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qroVvn/Q8aE=:KgtJ9Klgc8zNCMyp0WCvBW
 TmskdG82IVWkRJfBtPefNuZlNT7sEVh4wEAClPkidx2q7Kq33Xv6U0pG5jqKlN9G2TRLkMGt4
 a4iAaB10OrHTcK8VorQre3D1BQLH/PjlDjhe2QgLFzXYfwTZsl/3Jjhi1zAzK3cNMnenTjGzI
 RKudTV2wlKwZJykITtm1aVB2c3nxeNPHKwAG+LwoMGN9E8I20OgSInEMxRNOWRlPkzUtx9kXj
 L/Aozn7YpzdlU1OIOB8Exrv2tv3eenu+Tag7JwYce7bPn8Fq8bJXx/0GPx79QCzuWUlCHPmVj
 j02i85Fvnhv/XSatu1udT5ZuauLHWRB/V/HuuxJRvky/4eBGcbPqJoL70c6tubK3blDXDp68H
 27vIlyJjr3AOJGHmNekjGY9uBrHvFiTJnNabUthL92lIqz1U3WILjclO4W+RU6gKnyYVrybkF
 rfdC/CtVjny8uitU+VA6AKQ0WJgZ3CpFtq+r722T2dC4VmBs4bj+1j+FIR0Y3pJqvITPf/Xeq
 c1LsQHJeRao2bqqlDfaBsqhbHI/1lK/51A652mv3sTLiahpWQFzZGDZnjsEI0VTBi4SfiWCme
 UGbl7M82FMzm36RIm7d/dnHdKJ7oofurFS13lk+Ya889Rn6TbAGIGyypqnLSCUeF+ADc6Ea0F
 65x/M1wtGbYf1gYEB5QxjuPzdKFE0dsCQy65yC99NDxpXToIuwYg9W+wEuDaFEaOX6/8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 5, 2022 at 10:56 AM Ilpo Järvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Wed, 4 May 2022, Arnd Bergmann wrote:
> > On Wed, May 4, 2022 at 10:33 AM Ilpo Järvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Wed, 4 May 2022, Arnd Bergmann wrote:
> > > > On Wed, May 4, 2022 at 9:20 AM Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > >
> > > > After applying the patch locally, I still see a bunch of whitespace
> > > > differences in the
> > > > changed lines if I run
> > > >
> > > > vimdiff arch/*/include/uapi/asm/termbits.h include/uapi/asm-generic/termbits.h
> > > >
> > > > I think this mostly because you left the sparc version alone (it already
> > > > uses hex constants), but it may be nice to edit this a little more to
> > > > make the actual differences stick out more.
> > >
> > > I took a look on further harmonizing, however, it turned out to be not
> > > that simple. This is basically the pipeline I use to further cleanup the
> > > differences and remove comments if you want to play yourself, just remove
> > > stages from the tail to get the intermediate datas (gawk is required for
> > > --non-decimal-data):
> >
> > I've played around with it some more to adjust the number of leading
> > zeroes and the type of whitespace. This is what I ended up with on top
> > of your patch: https://pastebin.com/raw/pkDPaKN1
> >
> > Feel free to fold it into yours.
>
> Ok thanks. With that it seems to go a bit beyond octal to hex conversion
> so I'll make a series out of it. The series will also introduce
> include/uapi/asm-generic/termbits-common.h for the most obvious
> intersection.

Ok, sounds good. Here's a retroactive

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

for my changes so you can put them into a separate patch. I assume
you will change it some more in the process, so maybe retain
your ownership and just mark the bits a 'Co-developed-by: Arnd...'.

        Arnd
