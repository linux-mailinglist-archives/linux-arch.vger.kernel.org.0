Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FB64D6EBA
	for <lists+linux-arch@lfdr.de>; Sat, 12 Mar 2022 13:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiCLMsS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Mar 2022 07:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiCLMsR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Mar 2022 07:48:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2C01BE0C2;
        Sat, 12 Mar 2022 04:47:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C835260F1F;
        Sat, 12 Mar 2022 12:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212B2C340EB;
        Sat, 12 Mar 2022 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647089231;
        bh=H3gp8D41VexBopqf3rhNzKhC2EJfbt242g4EiN0GOBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oIXPRgskEBIl/4YKNylq9hUIA5UdRaj2Cfsq1LhhJ8KvIzcDM6CBFNxlWDeaGuY35
         bGW8CWqr9CFb1yrZmUW4WEheUVlQL1e0BM92OZJ0gkrWdpgFsq/ot356LWvUVK6SDh
         rKAAp1jIbrYXQ34u+gMY5qiESiIyVuPlyhJ1i9G0ufaX5yT0igqjfMaQTha4GYteLQ
         hNA+TnIGBwo01yfgVojpx+oXl5cVB9tOmREpLHFBuPtvTnLL4l/1KCbWDDVD8vx3u9
         CSL7CCtt1MB5CJf2rjmWTENarFDZuTTkOwZI8X1Za3Rsgrumfw0ERINFfY+ZyUgwii
         qtYfRHCpWmJFQ==
Received: by mail-vs1-f54.google.com with SMTP id a186so12336736vsc.3;
        Sat, 12 Mar 2022 04:47:11 -0800 (PST)
X-Gm-Message-State: AOAM532x/51JkuCcGqkwLKgPfNbg0nJcAyL+Mq6VsioBy1QsntHPwjAY
        fVlzeuLRMdA3nCYBNz3rkce5jtNApjXtgp/1GB0=
X-Google-Smtp-Source: ABdhPJy5ZidR6+hU7oi1y4oFAyxIqylb9Be+genvWRhNZ7iOORRW8nJemtq9UEHA7jF2pE6KBHQPZVnae3YTrPKV5FM=
X-Received: by 2002:a67:fc17:0:b0:320:b039:afc0 with SMTP id
 o23-20020a67fc17000000b00320b039afc0mr7728220vsq.2.1647089230100; Sat, 12 Mar
 2022 04:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20220227162831.674483-1-guoren@kernel.org> <20220227162831.674483-14-guoren@kernel.org>
 <CAJF2gTSJFMg1YJ=dbaNyemNV4sc_3P=+_PrS=RD_Y2_xz3TzPA@mail.gmail.com>
 <509d2b62-7d52-bf5c-7a6c-213a740a5c00@codethink.co.uk> <CAJF2gTSkrm+Ek5i--TTikR2RDBUa6Eo72jwvszbj3uZg=Kxorg@mail.gmail.com>
 <CAK8P3a0LqTdEk53XpUV4xRKoiJ_AvLkJSbMabqBgk7KNxF_XxQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0LqTdEk53XpUV4xRKoiJ_AvLkJSbMabqBgk7KNxF_XxQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 12 Mar 2022 20:46:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT4qT5AXcmbg+twbJn4X6NvG0XLGVC6sZc8WasrwxA9FA@mail.gmail.com>
Message-ID: <CAJF2gTT4qT5AXcmbg+twbJn4X6NvG0XLGVC6sZc8WasrwxA9FA@mail.gmail.com>
Subject: Re: [PATCH V7 13/20] riscv: compat: process: Add UXL_32 support in start_thread
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
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
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 12, 2022 at 4:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 12, 2022 at 3:13 AM Guo Ren <guoren@kernel.org> wrote:
> > On Fri, Mar 11, 2022 at 9:38 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > > On 11/03/2022 02:38, Guo Ren wrote:
> > > >> --- a/arch/riscv/kernel/process.c
> > > >> +++ b/arch/riscv/kernel/process.c
> > > >> @@ -97,6 +97,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
> > > >>          }
> > > >>          regs->epc = pc;
> > > >>          regs->sp = sp;
> > > >> +
> > > > FIxup:
> > > >
> > > > + #ifdef CONFIG_COMPAT
> > > >> +       if (is_compat_task())
> > > >> +               regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
> > > >> +       else
> > > >> +               regs->status = (regs->status & ~SR_UXL) | SR_UXL_64;
> > > > + #endif
> > > >
> > > > We still need "#ifdef CONFIG_COMPAT" here, because for rv32 we can't
> > > > set SR_UXL at all. SR_UXL is BIT[32, 33].
> > >
> > > would an if (IS_ENABLED(CONFIG_COMPAT)) { } around the lot be better
> > > than an #ifdef here?
> >
> > I don't think, seems #ifdef CONFIG_COMPAT is more commonly used in arch/*
>
> We used to require an #ifdef check around is_compat_task(), so there are
> a lot of stale #ifdefs that could be removed. In general, 'if (IS_ENABLED())'
> is considered more readable than #ifdef inside of a function. In this case
> there are a number of better ways to write the function if you want to get
> into the details:
>
>  - firstly, you should remove the #ifdef check around the definition of
>    SR_UXL, otherwise the IS_ENABLED() check does not work.
>
>  - you can use an 'if (!IS_ENABLED(CONFIG_COMPAT)) \\ return;' ahead of the
>    assignment since that is at the end of  the function.
>
>  - you can remove the bit masking since 'regs->status' is initialized above it,
>    adding in only the one bit, shortening it to
>
>     if (IS_ENABLED(CONFIG_COMPAT))
>                regs->status |= is_compat_task()) ? SR_UXL_32 : SR_UXL_64;
>
>  - to make this more logical, I would suggest always assigning the SR_UXL
>    bits regardless of CONFIG_COMPAT, and instead make it something like
>
>   if (IS_ENABLED(CONFIG_32BIT) || is_compat_task())
>             regs->status = | SR_UXL_32;
>   else
>             regs->status = | SR_UXL_64;
When CONFIG_32BIT=y, regs->status is 32bit width but SR_UXL_32 is
34bit width. That's wrong in type. (Only CONFIG_64BIT has SR_UXL).

>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
