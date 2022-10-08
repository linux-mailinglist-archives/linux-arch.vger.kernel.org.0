Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02B5F82C9
	for <lists+linux-arch@lfdr.de>; Sat,  8 Oct 2022 05:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJHD0W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Oct 2022 23:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJHD0V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Oct 2022 23:26:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C239F21258;
        Fri,  7 Oct 2022 20:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78C07B82492;
        Sat,  8 Oct 2022 03:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D41C4314D;
        Sat,  8 Oct 2022 03:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665199577;
        bh=dx5QNR37bluhcPrfXpakH+Q9ORjOYbKGNzt/yiv55wU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=etsX3UBW7HdrGX0b9naVCAhDDrLybUV5GGOLEo/8gqpRfVMqfdOJ7uSg3qE7c7HqW
         cejl+P2ze0pXvxbxrnC/XS8deyYQe+qtQadMwkDDmJkK71syrT/3mKt0mtsVEbX8G1
         ZScM2+lxg7YWb65LjNvkcKO/iCMvzsX1Pjne20NsDXdbpoPgWh55T1y7wfbQTnL7Cc
         pTTPEzFaE8lje8S7apVVVmxGPVbC/lnTSQwS+zFk8hBftlRNgrDAhK4WzK9YU1DatN
         W0i1kygMC5cnSLil9mcGznU/9x/F4NKtrDvqRipQVD9hqEM3BMT4ty0hLhhTdA6m8R
         rw9iOALunP25g==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1324e7a1284so7474434fac.10;
        Fri, 07 Oct 2022 20:26:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Z2hD+kZoqLsAIuhCkJ87dLFXSK5ryY6YGKiLKBuK5yYo4PpbE
        ciYMhJ83/ouV/s+VmHisp6Bbr818xXFn+ICWeTI=
X-Google-Smtp-Source: AMsMyM6pVxOoqteWeb25gGC2TDYG65YSUA4MRjcJXNfd0hoYnGFAPTuxKuJFzcPlZgsuhTe5Ez67AQaSV4bVGisb1Lw=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr9634023oap.19.1665199575953; Fri, 07 Oct
 2022 20:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221002012451.2351127-1-guoren@kernel.org> <20221002012451.2351127-10-guoren@kernel.org>
 <YzrI1QFMpHnhvDnI@FVFF77S0Q05N>
In-Reply-To: <YzrI1QFMpHnhvDnI@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 8 Oct 2022 11:26:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRU21=SrEEVrPo5YaYB7k-H8St14DV=Q1YK-1Oev_89Cg@mail.gmail.com>
Message-ID: <CAJF2gTRU21=SrEEVrPo5YaYB7k-H8St14DV=Q1YK-1Oev_89Cg@mail.gmail.com>
Subject: Re: [PATCH V6 09/11] riscv: Add support for STACKLEAK gcc plugin
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zouyipeng@huawei.com,
        bigeasy@linutronix.de, David.Laight@aculab.com,
        chenzhongjin@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Dao Lu <daolu@rivosinc.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 3, 2022 at 7:34 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Sat, Oct 01, 2022 at 09:24:49PM -0400, guoren@kernel.org wrote:
> > From: Dao Lu <daolu@rivosinc.com>
> >
> > Add support for STACKLEAK gcc plugin to riscv by implementing
> > stackleak_check_alloca, based heavily on the arm64 version, and
> > modifying the entry.S. Additionally, this disables the plugin for EFI
> > stub code for riscv. All modifications base on generic_entry.
>
> I think this commit message is stale; `stackleak_check_alloca` doesn't exist
> any more.
>
> > Link: https://lore.kernel.org/linux-riscv/20220615213834.3116135-1-daolu@rivosinc.com/
> > Signed-off-by: Dao Lu <daolu@rivosinc.com>
> > Co-developed-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> > Co-developed-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Conor Dooley <Conor.Dooley@microchip.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  arch/riscv/Kconfig                    | 1 +
> >  arch/riscv/kernel/entry.S             | 8 +++++++-
> >  drivers/firmware/efi/libstub/Makefile | 2 +-
> >  3 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index dfe600f3526c..76bde12d9f8c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -81,6 +81,7 @@ config RISCV
> >       select HAVE_ARCH_MMAP_RND_BITS if MMU
> >       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> >       select HAVE_ARCH_SECCOMP_FILTER
> > +     select HAVE_ARCH_STACKLEAK
> >       select HAVE_ARCH_TRACEHOOK
> >       select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
> >       select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 5f49517cd3a2..39097c1474a0 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -130,7 +130,6 @@ END(handle_exception)
> >  ENTRY(ret_from_exception)
> >       REG_L s0, PT_STATUS(sp)
> >
> > -     csrc CSR_STATUS, SR_IE
> >  #ifdef CONFIG_RISCV_M_MODE
> >       /* the MPP value is too large to be used as an immediate arg for addi */
> >       li t0, SR_MPP
> > @@ -139,6 +138,9 @@ ENTRY(ret_from_exception)
> >       andi s0, s0, SR_SPP
> >  #endif
> >       bnez s0, 1f
> > +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> > +     call stackleak_erase
> > +#endif
>
> I assume this can happen on an arbitrary stack, and so you can't use the
> stackleak_erase_{on,off}_task_stack variants?
I misunderstood before.

Yes, riscv could use stackleak_erase_on_task_stack. Because the sp has
changed to task_stack, even when irq/soft_irq.

>
> Just to check, have you given this a spin with LKDTM and the STACKLEAK_ERASING
> test? If not, it'd be good to test that (and ideally, put some sample output
> from that into the commit message).
>
> For example, as per:
>
>   https://lore.kernel.org/all/20220427173128.2603085-1-mark.rutland@arm.com/
>
> ... on arm64 this looks something like:
>
> | # uname -a
> | Linux buildroot 5.18.0-rc1-00013-g26f638ab0d7c #3 SMP PREEMPT Wed Apr 27 16:21:37 BST 2022 aarch64 GNU/Linux
> | # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry STACKLEAK_ERASING
> | lkdtm: stackleak stack usage:
> |   high offset: 336 bytes
> |   current:     688 bytes
> |   lowest:      1232 bytes
> |   tracked:     1232 bytes
> |   untracked:   672 bytes
> |   poisoned:    14136 bytes
> |   low offset:  8 bytes
> | lkdtm: OK: the rest of the thread stack is properly erased
>
> Thanks,
> Mark.
>
> >
> >       /* Save unwound kernel stack pointer in thread_info */
> >       addi s0, sp, PT_SIZE_ON_STACK
> > @@ -148,8 +150,12 @@ ENTRY(ret_from_exception)
> >        * Save TP into the scratch register , so we can find the kernel data
> >        * structures again.
> >        */
> > +     csrc CSR_STATUS, SR_IE
> >       csrw CSR_SCRATCH, tp
> > +     j 2f
> >  1:
> > +     csrc CSR_STATUS, SR_IE
> > +2:
> >       /*
> >        * The current load reservation is effectively part of the processor's
> >        * state, in the sense that load reservations cannot be shared between
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index d0537573501e..5e1fc4f82883 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                  -fno-builtin -fpic \
> >                                  $(call cc-option,-mno-single-pic-base)
> >  cflags-$(CONFIG_RISCV)               := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > -                                -fpic
> > +                                -fpic $(DISABLE_STACKLEAK_PLUGIN)
> >
> >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> >
> > --
> > 2.36.1
> >



-- 
Best Regards
 Guo Ren
