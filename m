Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B4F4B09C4
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 10:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiBJJnK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 10 Feb 2022 04:43:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiBJJnJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 04:43:09 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E84198
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 01:43:10 -0800 (PST)
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MmlCY-1nzR3i0nG2-00jtxd; Thu, 10 Feb 2022 10:38:04 +0100
Received: by mail-wr1-f45.google.com with SMTP id o24so5777689wro.3;
        Thu, 10 Feb 2022 01:38:04 -0800 (PST)
X-Gm-Message-State: AOAM533kp+AEBUaVNUg6ZmbOJEWztxtLWnPklf0Y6tAEDEjjH6kSeSey
        pB1W+XW88RgTxZ2XM1D4vy9w4HnyV6mqNffl8OY=
X-Google-Smtp-Source: ABdhPJxyuPFqVuAPp0m7wxkmSqedZ5gdhAYe8N0BP0zMGS9YdwnNAcEToFaurnCdHolQDzxAj8ZmIRKq3k4br+ZsfeY=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr681191wrn.317.1644485883806;
 Thu, 10 Feb 2022 01:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org> <20220210021129.3386083-4-masahiroy@kernel.org>
In-Reply-To: <20220210021129.3386083-4-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Feb 2022 10:37:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a07kN8H-8Zx2vX8b0rHfAjaeWyg4-c1aNEVhTF=miOEpA@mail.gmail.com>
Message-ID: <CAK8P3a07kN8H-8Zx2vX8b0rHfAjaeWyg4-c1aNEVhTF=miOEpA@mail.gmail.com>
Subject: Re: [PATCH 3/6] android/binder.h: add linux/android/binder(fs).h to
 UAPI compile-test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:c/BbFZ5D1fK5UZMctKsor9U6uDxXVPmqFomyNPi5TWKLgvq2Dwi
 0dsQp76fHAMUch5kg1AbIlwHf3dPcS2tJMhAKdJn6zL6/T9uxE+BA8wgJz2g3RYVBKHb/30
 GnOmU2B4U9UsoJnhTnDFOTekt9bCbyQqYL6Xp90dyNOLDcuxAd1GiNHW05eqn6RPSzUMJLD
 FnWT8ipfqwV5kcRaGyL0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k9FZneEZ10I=:gfFpsIbz4URS+tHOasrHsR
 wdBu4fzHHwZhGZgXLo+QC2iR+B2YXBlVG0RPZsVqXa2VvQ4CgY3YhZiHGukocmyknjl/p+rir
 pdI+wTfj+0D19mprFUavXwBQXLEcJvEgI0KaGdk1K/d3LNMhuZgkJw5nWX6Yjvs2c+MEBXEd8
 IkVVOokzyhT+wjOvHWuwEYeizR/ei5twQJcBr0lqgFeBVF5FPM0cFBTAVmqtE6WYoFmUebBPq
 BygLMR0UKBdQqNeYW00extBdV1GkAXpTy1fm0Y9sFdvkr7nmnYP5ssnSrR1NpcNojOhjT7m83
 wcjlC1tzfM8xtiCjK4Mgu+zP58MPEva9fGiOcC3b57LUpqV6Q4qgFqLL8kSjh8yLuabPbHSFB
 gV8qzd2RA6YfnQBbxgLs8tDS3G0T9FXu+TQdFgttBT6Up/aqD8lICxGTA1ev1DpSqwLnzO+bT
 IUZ6wXGt+HYwiahHqUybReBKlHjHmKmc4KmBmLPtaArGLrQz1S6NvqwMkTSC3zed4VO/e8Ua5
 McckcsRog3F7NYxK/aqgOPGsFbgDH9SeLfHGaWbS3Wiy+VEKK4QzdQtY0STbg9c82ZQMKQXFf
 AxahakWpAZqm+/pphzd+ea8McfWn9Hpr+0ZXsTT0LfgxpRMUgHHq+lmYBcxCmZTHdC1tWH9OQ
 5zCNfvfF9qp43rDp8Ogc+OPa4w1JTGwesqM/koIaB3EFGlK00GEJ2+/JJgDLoxfIWczo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 3:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> linux/android/binder.h and linux/android/binderfs.h are currently
> excluded from the UAPI compile-test because of the errors like follows:
>
>     HDRTEST usr/include/linux/android/binder.h
>   In file included from <command-line>:
>   ./usr/include/linux/android/binder.h:291:9: error: unknown type name ‘pid_t’
>     291 |         pid_t           sender_pid;
>         |         ^~~~~
>   ./usr/include/linux/android/binder.h:292:9: error: unknown type name ‘uid_t’
>     292 |         uid_t           sender_euid;
>         |         ^~~~~
>
> The errors can be fixed by replacing {pid,uid}_t with __kernel_{pid,uid}_t.
>
> Then, remove the no-header-test entries from user/include/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
