Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0BE596A48
	for <lists+linux-arch@lfdr.de>; Wed, 17 Aug 2022 09:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiHQHRu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Aug 2022 03:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbiHQHRn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Aug 2022 03:17:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F93B6BD40;
        Wed, 17 Aug 2022 00:17:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0207E61206;
        Wed, 17 Aug 2022 07:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6011EC433B5;
        Wed, 17 Aug 2022 07:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660720657;
        bh=Iku0+d+FQuVMCgZnPZy445F/29cJFnswOhoJKSJKVCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sHZcDMETEfgn7pDvOwLmlNA/1Mpvpd6MhVa4lIFXRW6i6qXCptUf3fGO18/3ZR4OM
         B8waZ/AR0ERMiU74G7MdTdLWX98z2Y9Yordpa/SeRfys+pYkk4V5BAzze1Rr7Sg5NO
         9AuBsbugNcFndJHLDAl3ElnAqDO4L73ntsWGfi4SYnl/Pnleekj94dQ7zSbjEgBDip
         i0WoGP5QuCssdtTQkCwVO4d2IiLDZ+hDZrtWF96xb3q8Wnw3UI15AqdTG7h+7t7Kc2
         gy7MwPn8XLeoA96/4n+5CDA6swy1qqGLkRvZkxijNsqqX7KmaYMmuhCHQvYZqeplKc
         bNWJmBnqU065Q==
Received: by mail-ua1-f45.google.com with SMTP id e3so1471761uax.4;
        Wed, 17 Aug 2022 00:17:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo24nTcRdt4HSZPTCyupIjow/zGs6u77GLflZ1wnX4vOKdym22eC
        h2TDtUHHFVWZHYKL6IsaxtgJenYp76d6+vkvXQU=
X-Google-Smtp-Source: AA6agR6N7z03YQBXBECUXa/oOuXfL9z2PAa5hMYbSwM9ZKKXyRGTZw0jmBWWVkat2rrELEIVlNuaSh6qnjN4C/6l7NA=
X-Received: by 2002:ab0:6944:0:b0:391:10d8:83ac with SMTP id
 c4-20020ab06944000000b0039110d883acmr3092033uas.23.1660720656236; Wed, 17 Aug
 2022 00:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145754.582056-1-chenhuacai@loongson.cn>
 <CAMj1kXERN209b7dbVs_hy4BeUwrmk2p9_vF+Wq2W8PUeHOQTkg@mail.gmail.com>
 <CAAhV-H60CJDRY4c+Eu+L=rNgHsXQqx=HK9nNSqg69WVV+Bm3SQ@mail.gmail.com>
 <CAMj1kXE1MijqonkPeH+Ydg8ti4_4YFXxBKK6Wztb=HtSY5EAgQ@mail.gmail.com>
 <CAAhV-H503hgyUZND2MmZ2h3qVb3SRt79HcQy7HrFmfGBci-QMA@mail.gmail.com> <CAMj1kXEzzAXYP3nXo8-Ny+iwuDorrO-JqoKjg3R+4kmhV_v_KQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEzzAXYP3nXo8-Ny+iwuDorrO-JqoKjg3R+4kmhV_v_KQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 17 Aug 2022 15:17:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H60mSKx3k1CwBCdubswosgqe+NuVaMtKA=hpjBhq5w5wA@mail.gmail.com>
Message-ID: <CAAhV-H60mSKx3k1CwBCdubswosgqe+NuVaMtKA=hpjBhq5w5wA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add efistub booting support
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
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

Hi, Ard,

On Wed, Aug 17, 2022 at 3:00 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 17 Aug 2022 at 08:43, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Ard,
> >
> > On Tue, Aug 16, 2022 at 11:32 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Tue, 16 Aug 2022 at 17:23, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> ...
> > > >
> > >
> > > No that makes no difference. The point is that the EFI stub and the
> > > core kernel are the same image, so when the stub runs, the core
> > > kernel's screen_info already exists in memory - the only thing you
> > > need to do is make it accessible by adding it to image-vars.h
> > Emm,  in ARM64,
> > #define alloc_screen_info(x...)         &screen_info
> >
> > So screen_info is a global variable in the core kernel. For the zboot
> > case (our own implementation, not sure about the proposing new
> > method), efistub may be able to fill this info, but while
> > decompressing, screen_info will be overwritten. I think.
> >
>
> Right. So you can drop it then.
OK, then can we rename LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID to
LINUX_EFI_SCREEN_INFO_TABLE_GUID and avoid define a dedicated GUID for
each arch?

>
> >
> > >
> > > ...
> > > > > > +
> > > > > > +/*
> > > > > > + * set_virtual_map() - create a virtual mapping for the EFI memory map and call
> > > > > > + * efi_set_virtual_address_map enter virtual for runtime service
> > > > > > + *
> > > > > > + * This function populates the virt_addr fields of all memory region descriptors
> > > > > > + * in @memory_map whose EFI_MEMORY_RUNTIME attribute is set. Those descriptors
> > > > > > + * are also copied to @runtime_map, and their total count is returned in @count.
> > > > > > + */
> > > > >
> > > > > You mentioned before that this must be done in the core kernel and not
> > > > > in the EFI stub, but I don't remember the reason.
> > > > >
> > > > > Can you add a comment here why the below conversions cannot be done by
> > > > > the EFI stub? Doing this in the stub removes the need to set up a 1:1
> > > > > mapping just for a single invocation of SetVirtualAddressMap(), so if
> > > > > there is any way to move this into the stub, I would strongly prefer
> > > > > it.
> > > > In the current implementation of generic efistub, efi runtime is in a
> > > > separate address space, but we want to map efi runtime in the kernel
> > > > address space. So, even if we do SVAM in stub, we still need to modify
> > > > some code.
> > >
> > > That is fine.
> > >
> > > > And if we do SVAM in the core kernel, we don't need to
> > > > modify generic stub (as a side effect, this makes the non-EFI kernel
> > > > be also able to use efi runtime).
> > > >
> > > > If use efi runtime in non-EFI kernel is unacceptable, and if we are
> > > > free to modify the generic stub, then we can move SVAM to the stub.
> > > >
> > >
> > > We should only support EFI runtime services when booting via the EFI stub.
> > OK, I will move SVAM to the stub.
> >
>
> OK
>
> > >
> > > ...
> > > > > > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > > > > > index 7aa4717cdcac..9e4645e5a5c0 100644
> > > > > > --- a/drivers/firmware/efi/Kconfig
> > > > > > +++ b/drivers/firmware/efi/Kconfig
> > > > > > @@ -118,7 +118,7 @@ config EFI_GENERIC_STUB
> > > > > >
> > > > > >  config EFI_ARMSTUB_DTB_LOADER
> > > > > >         bool "Enable the DTB loader"
> > > > > > -       depends on EFI_GENERIC_STUB && !RISCV
> > > > > > +       depends on EFI_GENERIC_STUB && !RISCV && !LOONGARCH
> > > > > >         default y
> > > > > >         help
> > > > > >           Select this config option to add support for the dtb= command
> > > > >
> > > > > Please make the initrd command line loader depend on !LOONGARCH.
> > > > > systemd-boot already supports this, and GRUB patches are on the list
> > > > > (the one you quoted above is part of the series that adds support for
> > > > > it). Your QEMU/edk2 firmware port also implements support for the
> > > > > LoadFile2 based method.
> > > > I agree to not select "initrd command line loader" by default, but can
> > > > we have a chance to select it even just for debugging? Because
> > > > sometimes we want to load the kernel and initrd via the command line
> > > > in the EFI shell.
> > > >
> > >
> > > The EFI shell has a 'initrd' command which implements the LoadFile2
> > > protocol: please refer to
> > >
> > > OvmfPkg/LinuxInitrdDynamicShellCommand/LinuxInitrdDynamicShellCommand.inf
> > >
> > > and include it in your build of the UEFI shell. (It can be added to
> > > the UEFI shell even when it runs on non-QEMU systems)
> > OK, then we will disable "initrd command line loader".
> >
>
> OK
>
> > > > > This code is not checking a platform feature so it does not belong here.
> > > > >
> > > > > The EFI stub code is an ordinary EFI app, and it runs in the execution
> > > > > context provided by EFI. So why is this needed so early? Can you move
> > > > > it into the kernel entry routine instead?
> > > > This is useful once we use our own zboot implementation, maybe we
> > > > don't need it with the new method you are proposing.
> > > >
> > >
> > > If this is part of your zboot implementation, please drop it for now.
> > > Let's try using the generic EFI zboot instead - if we need to, we can
> > > find a way to add it there.
> > >
> > > But out of curiosity, why is this needed at all?
> > My mistake, the real reason of configuring DMW in stub is that the
> > address of real_kernel_entry() is a kernel va, not a efi va (which is
> > the same as pa).
> >
>
> That means you can move this code to efi_enter_kernel(), no?
Yes, we can move to efi_enter_kernel(), thank you.

Huacai
