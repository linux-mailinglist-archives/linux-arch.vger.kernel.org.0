Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCD4A3497
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 06:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiA3Fyf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 00:54:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60604 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiA3Fyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Jan 2022 00:54:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33BDEB828BB;
        Sun, 30 Jan 2022 05:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B706CC340EE;
        Sun, 30 Jan 2022 05:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643522071;
        bh=KTwtRKH/OVKhaNoB2dpS+9CRT5rYtiTrBbRTY58frfI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KbqY9YcjYQ53gmY2dHmrpw7RqkS4V6dNNJjtLBbW8U4K47uqz0ecQoZbQwgfGmZma
         tRCWkNjivI6OGFruhAjydv25WQ48WPT8wiGKtc8VkkqRijcv4FkBddBEiA9bZ6UpWM
         I5RJVntAdZO8XAOSx+Hzslf2/jqxqMaVH/0ebTmNHQjz/YBFdn/6EIt7d+vxsPHNSZ
         ZaFIL+Fyvt5HOclTxwg6T2ZdaTD4y5Z172agNJmW87mhTO2d74ig4seQ3g/0cZwPaa
         1X8MVufLeenvPKvFey3paLO3ejlnzOfUnZP2orkztfEtq678+ZCjwp7m/wgaw/Qbsh
         4OleGJIuGH/Uw==
Received: by mail-vs1-f50.google.com with SMTP id r20so7975499vsn.0;
        Sat, 29 Jan 2022 21:54:31 -0800 (PST)
X-Gm-Message-State: AOAM5308+np7kMCyDNQotlUnib0rAwi3GriWPQ1cZ5QdfJumkteRXJBX
        RSAYzQhONChfOJBk15UkoH22tLJIvwifVVQsqXY=
X-Google-Smtp-Source: ABdhPJw3SI5w6wpfoRZZErXNv34dgmNp5eduh3H4LQwaI7qbmi+2hfTO0XEH13fEEhf3iFH2jsVqfmVsSGc5OwjgZr4=
X-Received: by 2002:a67:e0d9:: with SMTP id m25mr5857135vsl.51.1643522070834;
 Sat, 29 Jan 2022 21:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-9-guoren@kernel.org>
 <CAK8P3a3JGP6fLVOyLgdNw2YpRSmArbEX8orUhRrN=GHmcdk=1g@mail.gmail.com>
In-Reply-To: <CAK8P3a3JGP6fLVOyLgdNw2YpRSmArbEX8orUhRrN=GHmcdk=1g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 Jan 2022 13:54:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQQnrUFNQ85vvoMkpxnCWuMw8iXtPZOJwWGaEA9f+rTwA@mail.gmail.com>
Message-ID: <CAJF2gTQQnrUFNQ85vvoMkpxnCWuMw8iXtPZOJwWGaEA9f+rTwA@mail.gmail.com>
Subject: Re: [PATCH V4 08/17] riscv: compat: syscall: Add compat_sys_call_table
 implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 30, 2022 at 6:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Implement compat sys_call_table and some system call functions:
> > truncate64, ftruncate64, fallocate, pread64, pwrite64,
> > sync_file_range, readahead, fadvise64_64 which need argument
> > translation.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>
> This all looks really good, but I would change one detail:
>
> > +#ifndef compat_arg_u64
> > +#define compat_arg_u64(name)           u32  name##_lo, u32  name##_hi
> > +#define compat_arg_u64_dual(name)      u32, name##_lo, u32, name##_hi
> > +#define compat_arg_u64_glue(name)      (((u64)name##_hi << 32) | \
> > +                                        ((u64)name##_lo & 0xffffffffUL))
> > +#endif
>
> I would make these endian-specific, and reverse them on big-endian
> architectures. That way it
> should be possible to share them across all compat architectures
> without needing the override
> option.
I hope it could be another patch. Because it's not clear to
_LITTLE_ENDIAN definition in archs.

eg: Names could be __ORDER_LITTLE_ENDIAN__ CPU_LITTLE_ENDIAN
SYS_SUPPORTS_LITTLE_ENDIAN __LITTLE_ENDIAN

riscv is little-endian, but no any LITTLE_ENDIAN definition.

So let's keep them in the patch, first, Thx

>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
