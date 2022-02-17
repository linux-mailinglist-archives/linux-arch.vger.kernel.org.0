Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37494B9BB1
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 10:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiBQJHT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 04:07:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiBQJHT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 04:07:19 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEBF657AF;
        Thu, 17 Feb 2022 01:07:04 -0800 (PST)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MlO5j-1nzmaQ0Axx-00liYK; Thu, 17 Feb 2022 10:07:03 +0100
Received: by mail-wr1-f41.google.com with SMTP id d27so7758079wrc.6;
        Thu, 17 Feb 2022 01:07:02 -0800 (PST)
X-Gm-Message-State: AOAM533yWynfJkNjeQ1FV7TSltwrEldlFJ+M9bVXT/yty9a60w/GGbkz
        B5zbkdVGvrz7KLYmW0NHRzTvJeah7MTLaM3aQfM=
X-Google-Smtp-Source: ABdhPJz1KVbjXinYSsuA5sj6zeOrKbgVgI7t2t1etmf7LJS/zyEgNWwFSyl60gguU+H2vuTgm0W9IGvJwW2VzR6X/ME=
X-Received: by 2002:adf:ea01:0:b0:1e4:b3e6:1f52 with SMTP id
 q1-20020adfea01000000b001e4b3e61f52mr1337040wrm.317.1645085721351; Thu, 17
 Feb 2022 00:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org>
 <CAK8P3a3uZJuf9naTerxMdUeW4CEuvfK0knC0JDTZteYHPqddTw@mail.gmail.com> <CAK7LNATPU6yc4i15i2XDCKDMEjwUK9H3TSYP9b8qkrhsuSRXLw@mail.gmail.com>
In-Reply-To: <CAK7LNATPU6yc4i15i2XDCKDMEjwUK9H3TSYP9b8qkrhsuSRXLw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Feb 2022 09:15:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3WsyftXrKSeif2ycBMjN+q9BFj6AWg7Chn=Oa+ObpDAQ@mail.gmail.com>
Message-ID: <CAK8P3a3WsyftXrKSeif2ycBMjN+q9BFj6AWg7Chn=Oa+ObpDAQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add more export headers to compile-test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mjnUqCT/oKrQp45WCtx0Sd7S/cGyoKeoNty/4APwXDTe0RDC9Yo
 josKtshswUnml7u7VkjR3VoArDa9n6ACGtVKLPBdpYE1SuMCL43dohglyiqAc+zi9/6PiRt
 gb2q/RcIcoHVt8NdK5bAQrOP67FfzAOwcYr5+GZX9blAypnnHTRqT2grhOmfyhIT0e+51zD
 0N984GMSk5ihvLy18U1qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yJvV+w09HrA=:0UGhFXCfQ6fJbpSpAkJc4h
 gnt4otqNBFMua3lV5eeSGSnXxtk6RXkqHRxCLEBvzzgzPgEMyh6dPJKmJBAXaRe7HFSY8EqE7
 u+GGzq/XrjRoqDZrbFsPBSSmgKSXyB8LxPkWu0hpyEaefaojnTLmNRkSkBEeQ8u9XTcTHm7of
 YExBoLBLrRyGfr3jBGTXi5Eppo+KA7ykzOi3su3eLHK/iZVbYm90Kqr089qo1wlwTFMoGTut1
 T6zpQIWHz0brZl6U+paaSneu83HQqHrdPCTDA16T5qWxBaBrjE6Zu6t4t2/gQsIUg9U3D807g
 Mlk1oF+eqNCWNsVKoiofsroUOw6vnXJ8OsrjOyVjSay5LJK6glqd3kFtmh6AVcN/FvzjJTrPG
 GOGlsjOo3CBoJ4L5wDuVrUDi5WqtRK5MIP/JhehDDDZBw1CHbXDZoC7lLWDnhkaaktwtidBF7
 E33rkTzXxDTm57dj2Ihz+MDQdCs/4ZyDlp48ir4Gk/rtE5K1/GcrCpm1AvoyS7TISF1Et+5FC
 5SKxXSDES02g4uICpsGmpr61gVNDv7gT4PJzU00OrWoh9uQUam48nvK7HId8ptu535NF3I95O
 WRGewiPBq5sDGYu86QPhs1MpRv+QGv+gY//aHW/SrZ/DI+sSatvZaObl/9dyh+TQckUPYFGOl
 jydw2xhxoRodMVHAVpUurbSn4Xze4i7MDkMLdiYeO0ospi162T8Y+fMkC8UNe5k0BFrZ8MNqz
 8qPgD2Q0sTfqmyj/sOmPQf5azV4DpW1LeD3n1fIfy5EdN4CATbdNvAMomDQJ9AaCCOevF2Mlx
 DDECpvxEDJgA8O979sQTbkuBIE34NN4xjySgpfRL/yOrRfUWu8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 11, 2022 at 6:23 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Feb 10, 2022 at 6:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Feb 10, 2022 at 3:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > Masahiro Yamada (6):
> > >   signal.h: add linux/signal.h and asm/signal.h to UAPI compile-test
> > >     coverage
> > >   shmbuf.h: add asm/shmbuf.h to UAPI compile-test coverage
> > >   android/binder.h: add linux/android/binder(fs).h to UAPI compile-test
> > >     coverage
> > >   fsmap.h: add linux/fsmap.h to UAPI compile-test coverage
> > >   kexec.h: add linux/kexec.h to UAPI compile-test coverage
> > >   reiserfs_xattr.h: add linux/reiserfs_xattr.h to UAPI compile-test
> > >     coverage
> >
> > Very nice! Should I pick these up into the asm-generic tree?
>
> Yes, please.

Done now.

       Arnd
