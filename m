Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10A64D6D9A
	for <lists+linux-arch@lfdr.de>; Sat, 12 Mar 2022 09:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiCLIhn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Mar 2022 03:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiCLIhm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Mar 2022 03:37:42 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334461081AE;
        Sat, 12 Mar 2022 00:36:36 -0800 (PST)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MLz3X-1nkl6Z3az3-00HwKj; Sat, 12 Mar 2022 09:36:34 +0100
Received: by mail-wr1-f48.google.com with SMTP id x15so16177660wru.13;
        Sat, 12 Mar 2022 00:36:34 -0800 (PST)
X-Gm-Message-State: AOAM530+dzW2/6sWsLn+tnWQF1trrz3LOSKQs1I4K4jswEo5ho/21oSd
        8ZXQ7d3JMi11zTud1t270janiW2dktymq9hoSEE=
X-Google-Smtp-Source: ABdhPJwrBgijWcFmabOKnFeCHeAhHQBR3PR+3P0h6p5JQhHZX/5odIXHkxJDpCBUEOwN9ui3K5nWlIusCnBN24XocoE=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr7048966wrq.192.1647074194359; Sat, 12
 Mar 2022 00:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20220227162831.674483-1-guoren@kernel.org> <20220227162831.674483-14-guoren@kernel.org>
 <CAJF2gTSJFMg1YJ=dbaNyemNV4sc_3P=+_PrS=RD_Y2_xz3TzPA@mail.gmail.com>
 <509d2b62-7d52-bf5c-7a6c-213a740a5c00@codethink.co.uk> <CAJF2gTSkrm+Ek5i--TTikR2RDBUa6Eo72jwvszbj3uZg=Kxorg@mail.gmail.com>
In-Reply-To: <CAJF2gTSkrm+Ek5i--TTikR2RDBUa6Eo72jwvszbj3uZg=Kxorg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 12 Mar 2022 09:36:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0LqTdEk53XpUV4xRKoiJ_AvLkJSbMabqBgk7KNxF_XxQ@mail.gmail.com>
Message-ID: <CAK8P3a0LqTdEk53XpUV4xRKoiJ_AvLkJSbMabqBgk7KNxF_XxQ@mail.gmail.com>
Subject: Re: [PATCH V7 13/20] riscv: compat: process: Add UXL_32 support in start_thread
To:     Guo Ren <guoren@kernel.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
X-Provags-ID: V03:K1:JoxTfVCDx79fTzCQvh7Xq1YJCdm6SCwktIxWlWwG8+VS9j7ECgR
 hisYe2M+lp7cotgX4ZOr1/udkDnAl+SMAtnscPfPkB60bFL01UxsPNzr1d9fqJ66zp8K+IC
 c1xfjwfasZ1PVhIGHp944L/lvwV1OFpcPoLYg0YiArtXbNKbywR/VdNjAT4zxn6/LC948R0
 4MdwsLevkhtUQokHlCtcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YZy9s3VKLyM=:6W94UhPkUrs6eRrOTLOKUz
 YwE7Ow7awnu9Eal9apRYnGmelK+LS+wwP4NXm0p9qgBfD3nTyvZQY7IlgPB9ea6EuvA0w8iRy
 mC7QLEM7gW0I2sfHOg71mdxrpykeknCXLueKOyJM/geekQ08Sk72GSIacK3oMZYH0NBsly32J
 Tr/oPffhmGzB05FXW8vtOf4gIVN0263o62Cn/wj5sIxk55a/R3VShvXCGN2Uq38C6vXFFh9xa
 qEu2k5F79SEPayYbTQUOICgTaZOWr3wUOa4HE6qPpvUeEy/BvAf9GW7O6gxvc3KcXz7GkKiNn
 7rcYvIYH+tmQaOQoBYSVzruDi1UozUrvGZ8tvMyGt0m7Hi+Hr+krqeXDND0chtFmlmrt0ViIB
 55lB+fHTzuT9NMlCCPITsRxHLmEpVUzPy+oD0O/2+dbs07nzjRLAds1uhn9N9k6bqa/ejABtj
 FqgNy0sZBUk1jXQj8HOOPTnhnexBKgKlpZQN6DpSWKba5x2JNztRMfjESA2d2ODK8/ZW7TNad
 ThErjQT+log5l2svhx9BiWBeO7S3bRlQPzPrjBS8yz3+pj5vnJXvyWHwG1kzvapj/6xXl1NZ0
 97/rqFoDL5G5AUUGB9mmFpHoX8uZgTXyILJpQhUpI651kDEAdTAuwp9JGfiVGtD8t3g/nxxyb
 iPhdRrnbd8R5Nnajf2Jffw7ylfaQdPUgDRebhxUjBUUQN93PWtd7ajVYMWKJazN0N4maaixer
 QUQKQFEvNQmuiBepIj4MN2u0813744Whkmr3d8Xq92rZtr3mW5i055mu6i+WNFVEYyahONPsN
 NeW2OrfS2AIT0fp4Te5a2oihZf6bWXFt2SECvIqWt1OyT5h2ok=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 12, 2022 at 3:13 AM Guo Ren <guoren@kernel.org> wrote:
> On Fri, Mar 11, 2022 at 9:38 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > On 11/03/2022 02:38, Guo Ren wrote:
> > >> --- a/arch/riscv/kernel/process.c
> > >> +++ b/arch/riscv/kernel/process.c
> > >> @@ -97,6 +97,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
> > >>          }
> > >>          regs->epc = pc;
> > >>          regs->sp = sp;
> > >> +
> > > FIxup:
> > >
> > > + #ifdef CONFIG_COMPAT
> > >> +       if (is_compat_task())
> > >> +               regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
> > >> +       else
> > >> +               regs->status = (regs->status & ~SR_UXL) | SR_UXL_64;
> > > + #endif
> > >
> > > We still need "#ifdef CONFIG_COMPAT" here, because for rv32 we can't
> > > set SR_UXL at all. SR_UXL is BIT[32, 33].
> >
> > would an if (IS_ENABLED(CONFIG_COMPAT)) { } around the lot be better
> > than an #ifdef here?
>
> I don't think, seems #ifdef CONFIG_COMPAT is more commonly used in arch/*

We used to require an #ifdef check around is_compat_task(), so there are
a lot of stale #ifdefs that could be removed. In general, 'if (IS_ENABLED())'
is considered more readable than #ifdef inside of a function. In this case
there are a number of better ways to write the function if you want to get
into the details:

 - firstly, you should remove the #ifdef check around the definition of
   SR_UXL, otherwise the IS_ENABLED() check does not work.

 - you can use an 'if (!IS_ENABLED(CONFIG_COMPAT)) \\ return;' ahead of the
   assignment since that is at the end of  the function.

 - you can remove the bit masking since 'regs->status' is initialized above it,
   adding in only the one bit, shortening it to

    if (IS_ENABLED(CONFIG_COMPAT))
               regs->status |= is_compat_task()) ? SR_UXL_32 : SR_UXL_64;

 - to make this more logical, I would suggest always assigning the SR_UXL
   bits regardless of CONFIG_COMPAT, and instead make it something like

  if (IS_ENABLED(CONFIG_32BIT) || is_compat_task())
            regs->status = | SR_UXL_32;
  else
            regs->status = | SR_UXL_64;

       Arnd
