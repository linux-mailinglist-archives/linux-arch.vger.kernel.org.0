Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE35AF97B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Sep 2022 03:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiIGBvx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 21:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGBvw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 21:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D9F80E99;
        Tue,  6 Sep 2022 18:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800A5616EB;
        Wed,  7 Sep 2022 01:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE50FC43148;
        Wed,  7 Sep 2022 01:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662515509;
        bh=ALcTG3mOVuLLio4WhI2L2jJkbp5XvNqkTSaJ5wmwyeM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KD4YkRAGIO3nhCBJBkD2pwrs2ava5BAoX9wtcgu3IFRoQVjrtiZuB4R9MgbpEzsxq
         KW4AFCVtiUZlgB2+cstExwawru05w/BuMHDhwnpc7WjQGj+QVhkknLUVfBDmKGedGD
         99jvlAe7BYgLqXHlUmDho9+hJ1g+JDEgK63SfRqWTf36g22O56vOPdF29EpBYq/p8b
         dtek3UzHb1QYIE+Jy4pecoCJYlNRkpFOMwxlx+Mb+1LMdMCgPvlJIOZQE3xh2MIUwq
         tR/PZy8WV7Tq4lJxm3DRN05aNFEm2H8PKdO2xzn+gkLKBPu+bFQhwgcCWo9JIcLYAj
         kJ4OnuZ6o3Ctw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-127ba06d03fso9079218fac.3;
        Tue, 06 Sep 2022 18:51:49 -0700 (PDT)
X-Gm-Message-State: ACgBeo33eMSFNqgev5qm16SohsXvBqtm6nn2sWT/xYZyddz/j6hjcjYS
        5OYyywvpH/0/Yu5sMXPtkhDbiv9SOxY5nINGIn8=
X-Google-Smtp-Source: AA6agR5wU71q9oB13ta4xOEzTPcP8MJegkjW8lQNxzqUr3gEPcisWNIZ8cv6sJH9sEHuSDJ+obWgGJ+KHlsomjMI+dE=
X-Received: by 2002:a05:6808:150f:b0:343:3202:91cf with SMTP id
 u15-20020a056808150f00b00343320291cfmr10871221oiw.112.1662515508882; Tue, 06
 Sep 2022 18:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220903162328.1952477-1-guoren@kernel.org> <20220828135407.3897717-1-xianting.tian@linux.alibaba.com>
 <6c48657c-04df-132d-6167-49ed293dea44@microchip.com>
In-Reply-To: <6c48657c-04df-132d-6167-49ed293dea44@microchip.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Sep 2022 09:51:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQvPpXwrfS_fTo+Pn=nufeCWE_tCcmPB-YZAZjdt9GbvA@mail.gmail.com>
Message-ID: <CAJF2gTQvPpXwrfS_fTo+Pn=nufeCWE_tCcmPB-YZAZjdt9GbvA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add STACKLEAK erasing the kernel stack at the end
 of syscalls
To:     Conor.Dooley@microchip.com
Cc:     oleg@redhat.com, vgupta@kernel.org, linux@armlinux.org.uk,
        monstr@monstr.eu, dinguyen@kernel.org, palmer@dabbelt.com,
        davem@davemloft.net, arnd@arndb.de, shorne@gmail.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, ardb@kernel.org,
        heiko@sntech.de, daolu@rivosinc.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, xianting.tian@linux.alibaba.com,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

How about the generic_entry version:

https://lore.kernel.org/lkml/20220907014809.919979-1-guoren@kernel.org/

On Wed, Sep 7, 2022 at 1:35 AM <Conor.Dooley@microchip.com> wrote:
>
> On 03/09/2022 17:23, guoren@kernel.org wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > From: Xianting Tian <xianting.tian@linux.alibaba.com>
> >
> > This adds support for the STACKLEAK gcc plugin to RISC-V and disables
> > the plugin in EFI stub code, which is out of scope for the protection.
> >
> > For the benefits of STACKLEAK feature, please check the commit
> > afaef01c0015 ("x86/entry: Add STACKLEAK erasing the kernel stack at the end of syscalls")
> >
> > Performance impact (tested on qemu env with 1 riscv64 hart, 1GB mem)
> >     hackbench -s 512 -l 200 -g 15 -f 25 -P
> >     2.0% slowdown
> >
> > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>
> What changed since Xianting posted it himself a week ago:
> https://lore.kernel.org/linux-riscv/20220828135407.3897717-1-xianting.tian@linux.alibaba.com/
>
> There's an older patch from Du Lao adding STACKLEAK too:
> https://lore.kernel.org/linux-riscv/20220615213834.3116135-1-daolu@rivosinc.com/
>
> But since there's been no activity there since June...
>
> > ---
> >  arch/riscv/Kconfig                    | 1 +
> >  arch/riscv/include/asm/processor.h    | 4 ++++
> >  arch/riscv/kernel/entry.S             | 3 +++
> >  drivers/firmware/efi/libstub/Makefile | 2 +-
> >  4 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index ed66c31e4655..61fd0dad4463 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -85,6 +85,7 @@ config RISCV
> >         select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> >         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> >         select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
> > +       select HAVE_ARCH_STACKLEAK
> >         select HAVE_ASM_MODVERSIONS
> >         select HAVE_CONTEXT_TRACKING_USER
> >         select HAVE_DEBUG_KMEMLEAK
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index d0537573501e..5e1fc4f82883 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                    -fno-builtin -fpic \
> >                                    $(call cc-option,-mno-single-pic-base)
> >  cflags-$(CONFIG_RISCV)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > -                                  -fpic
> > +                                  -fpic $(DISABLE_STACKLEAK_PLUGIN)
> >
> >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> >
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>


-- 
Best Regards
 Guo Ren
