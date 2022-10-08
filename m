Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9487C5F816A
	for <lists+linux-arch@lfdr.de>; Sat,  8 Oct 2022 02:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJHAA6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Oct 2022 20:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJHAA5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Oct 2022 20:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F37C0A;
        Fri,  7 Oct 2022 17:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3304261DF6;
        Sat,  8 Oct 2022 00:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946FBC433D6;
        Sat,  8 Oct 2022 00:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665187255;
        bh=1QNTKASnThQzK9t9YJPKB3S5uW+rMCtzlHpZ4T+ejK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nbaf5kXNGDwWzlsoB1UwvScZICJk41H+byHZ/oFGC1HHj6G6NNdgI/bP/IrRKpO6m
         94rwv4rTVMhQbV96xn0vJCT7fMbX7mt3hQFDHQJ6ftHeEGWMgFakkmSVai9FPVvD6M
         WiD3Hpl3Limwpe7zf5w8xMdKL7Ga+2GnaSLAUSMoSLPyFJGSmV8rrC/fEk1YX8oHkA
         Gdrs5F9PQiOa3vFSPO3gCYuHspD58Jh6CFy5OkpsvZEI8cIwKKxK2BF/Tt1i4oanwS
         PvI1HRni+yI/MxkLpx4IdX6IdMaZ0/PTOYJaBbUXT4DpXMXPzcwwsZnKBXgncd1f1B
         KRwVsi4nDwydA==
Received: by mail-oi1-f172.google.com with SMTP id t79so7299472oie.0;
        Fri, 07 Oct 2022 17:00:55 -0700 (PDT)
X-Gm-Message-State: ACrzQf3cdtCGhycme1G00YDkjTdAFx0opOHVX9M9wMPH8R8sbAxAgK93
        fIKEd5d8dnAqLb/gA3HAUh6UhMb/HmnnpZeUFHI=
X-Google-Smtp-Source: AMsMyM43x1xUF8/u4qEx0O4CLZy7PM9HGCWHCoBGuVZwK3v1D/JkfKAVQrBSId34wQKf2vHacT5ZjsmS+8zaB+iFHDo=
X-Received: by 2002:aca:6155:0:b0:353:e740:ce01 with SMTP id
 v82-20020aca6155000000b00353e740ce01mr8672777oib.19.1665187254786; Fri, 07
 Oct 2022 17:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <6c48657c-04df-132d-6167-49ed293dea44@microchip.com> <mhng-8c3bb2e7-e84e-4aaa-bce8-3e8054255a2c@palmer-ri-x1c9>
In-Reply-To: <mhng-8c3bb2e7-e84e-4aaa-bce8-3e8054255a2c@palmer-ri-x1c9>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 8 Oct 2022 08:00:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRER75PyqniiTZgeeHjiy5UKVtrr89iPrdx_EzYPUC9Lg@mail.gmail.com>
Message-ID: <CAJF2gTRER75PyqniiTZgeeHjiy5UKVtrr89iPrdx_EzYPUC9Lg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add STACKLEAK erasing the kernel stack at the end
 of syscalls
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor.Dooley@microchip.com, oleg@redhat.com, vgupta@kernel.org,
        linux@armlinux.org.uk, monstr@monstr.eu, dinguyen@kernel.org,
        davem@davemloft.net, Arnd Bergmann <arnd@arndb.de>,
        shorne@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ardb@kernel.org, heiko@sntech.de,
        daolu@rivosinc.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, xianting.tian@linux.alibaba.com,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 7, 2022 at 10:31 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 06 Sep 2022 10:35:10 PDT (-0700), Conor.Dooley@microchip.com wrote:
> > On 03/09/2022 17:23, guoren@kernel.org wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> From: Xianting Tian <xianting.tian@linux.alibaba.com>
> >>
> >> This adds support for the STACKLEAK gcc plugin to RISC-V and disables
> >> the plugin in EFI stub code, which is out of scope for the protection.
> >>
> >> For the benefits of STACKLEAK feature, please check the commit
> >> afaef01c0015 ("x86/entry: Add STACKLEAK erasing the kernel stack at the end of syscalls")
> >>
> >> Performance impact (tested on qemu env with 1 riscv64 hart, 1GB mem)
> >>     hackbench -s 512 -l 200 -g 15 -f 25 -P
> >>     2.0% slowdown
> >>
> >> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> >
> > What changed since Xianting posted it himself a week ago:
> > https://lore.kernel.org/linux-riscv/20220828135407.3897717-1-xianting.tian@linux.alibaba.com/
> >
> > There's an older patch from Du Lao adding STACKLEAK too:
> > https://lore.kernel.org/linux-riscv/20220615213834.3116135-1-daolu@rivosinc.com/
> >
> > But since there's been no activity there since June...
>
> Looks like the only issues were some commit log wording stuff, and that
> there's a test suite that should be run.  It's not clear from the
> commits that anyone has done that, I'm fine with the patch if it passes
> the tests but don't really know how to run them.
>
> Has anyone run the tests?
I'm trying to do that with genric_entry.
https://lore.kernel.org/linux-riscv/20220615213834.3116135-1-daolu@rivosinc.com/

Mark Rutland has found an issue, and I'm solving it.

>
> >
> >> ---
> >>  arch/riscv/Kconfig                    | 1 +
> >>  arch/riscv/include/asm/processor.h    | 4 ++++
> >>  arch/riscv/kernel/entry.S             | 3 +++
> >>  drivers/firmware/efi/libstub/Makefile | 2 +-
> >>  4 files changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index ed66c31e4655..61fd0dad4463 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -85,6 +85,7 @@ config RISCV
> >>         select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> >>         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> >>         select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
> >> +       select HAVE_ARCH_STACKLEAK
> >>         select HAVE_ASM_MODVERSIONS
> >>         select HAVE_CONTEXT_TRACKING_USER
> >>         select HAVE_DEBUG_KMEMLEAK
> >> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> >> index d0537573501e..5e1fc4f82883 100644
> >> --- a/drivers/firmware/efi/libstub/Makefile
> >> +++ b/drivers/firmware/efi/libstub/Makefile
> >> @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >>                                    -fno-builtin -fpic \
> >>                                    $(call cc-option,-mno-single-pic-base)
> >>  cflags-$(CONFIG_RISCV)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >> -                                  -fpic
> >> +                                  -fpic $(DISABLE_STACKLEAK_PLUGIN)
> >>
> >>  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> >>
> >> --
> >> 2.17.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >



-- 
Best Regards
 Guo Ren
