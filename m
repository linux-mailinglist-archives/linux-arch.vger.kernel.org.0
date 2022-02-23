Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2AB4C0F16
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 10:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiBWJWk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 04:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiBWJWj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 04:22:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8A3A71F;
        Wed, 23 Feb 2022 01:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A88AB61676;
        Wed, 23 Feb 2022 09:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13426C340F3;
        Wed, 23 Feb 2022 09:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645608131;
        bh=qr8aGN/GfpzREfWWEWfy67hMxOcd5xgEZdDkbd5B0Fc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fvP1S9ICDfQF8hCsfx1j5bfZ8MyW/1rG6leAkItXfaKKhotabi5LJfUSgdtHnAs1e
         e//NBoK00IXi9zTUjPv7rNpA1RU7H3GNLpb9V1grfG21006D6HV2Tb4+Qk5tLh0HIo
         Y8xDpIW1XwC917uzpPR1esP/YuSq+XHVf/PTy1JzpDjvNBh8Jh8OysgZZO5Bjpcj+Q
         EJYwG2Z8BOyrYZNJ4iSfk1NrfuQSK+S4t7xQPNsmD2s/GQ8tcuq/JigD7ZEI9VXG1f
         eljgFZP39JEv9+yiNsBLF4dJImtQrUvYwdNENxl33kkrfAUIOs6Dsce/NuZ/ym9xNY
         WkfVAuCjEyWQw==
Received: by mail-ua1-f43.google.com with SMTP id 10so1100160uar.9;
        Wed, 23 Feb 2022 01:22:11 -0800 (PST)
X-Gm-Message-State: AOAM533GHSt2VO5OSbN+/PMx85QJ5OXAdQ125cZm9ZqDIt+0V7ZFSAZ6
        sGYfO00CUeafNlgt1z+1b/gNa4WNVJ+uoaUYCOU=
X-Google-Smtp-Source: ABdhPJydckZxxdHIMfr4RcZ21Y/DNoqRFXVrN4eEPW4jdar5CY+FIz7J7onmSF87bCDroUCQYiJcpWM17ymdodrxxjk=
X-Received: by 2002:ab0:5543:0:b0:33c:9e1c:a30d with SMTP id
 u3-20020ab05543000000b0033c9e1ca30dmr11349278uaa.97.1645608129880; Wed, 23
 Feb 2022 01:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20220201150545.1512822-14-guoren@kernel.org> <mhng-5c3b969c-9a23-48dc-ab10-a1addc6a5349@palmer-ri-x1c9>
In-Reply-To: <mhng-5c3b969c-9a23-48dc-ab10-a1addc6a5349@palmer-ri-x1c9>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 23 Feb 2022 17:21:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQd_5Ei9RDUg5uYAAjf0+idCqUtxdemb0CEMsxq7m3+UA@mail.gmail.com>
Message-ID: <CAJF2gTQd_5Ei9RDUg5uYAAjf0+idCqUtxdemb0CEMsxq7m3+UA@mail.gmail.com>
Subject: Re: [PATCH V5 13/21] riscv: compat: process: Add UXL_32 support in start_thread
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 9:42 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 01 Feb 2022 07:05:37 PST (-0800), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > If the current task is in COMPAT mode, set SR_UXL_32 in status for
> > returning userspace. We need CONFIG _COMPAT to prevent compiling
> > errors with rv32 defconfig.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> >  arch/riscv/kernel/process.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index 03ac3aa611f5..1a666ad299b4 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -97,6 +97,11 @@ void start_thread(struct pt_regs *regs, unsigned lon=
g pc,
> >       }
> >       regs->epc =3D pc;
> >       regs->sp =3D sp;
> > +
> > +#ifdef CONFIG_COMPAT
> > +     if (is_compat_task())
> > +             regs->status |=3D SR_UXL_32;
>
> Not sure if I'm just misunderstanding the bit ops here, but aren't we
> trying to set the UXL field to 1 (for UXL=3D32)?  That should be a bit
> field set op, not just an OR.
You are right, I would modify like this:
+     if (is_compat_task())
+             regs->status =3D =EF=BC=88regs->status & ~SR_UXL) | SR_UXL_32=
;
+     else
+.            regs->status =3D =EF=BC=88regs->status & ~SR_UXL) | SR_UXL_64=
;


>
> > +#endif
> >  }
> >
> >  void flush_thread(void)
>
> Additionally: this isn't really an issue so much with this patch, but it
> does bring up that we're relying on someone else to have set UXL=3D64 on
> CONFIG_COMPAT=3Dn systems.  I don't see that in any spec anywhere, so we
> should really be setting UXL in Linux for all systems (ie, not just those=
 with
> COMPAT=3Dy).



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
