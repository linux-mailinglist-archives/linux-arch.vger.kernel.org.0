Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E304C6460
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 09:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiB1IKB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 03:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiB1IKA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 03:10:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3981B692B8;
        Mon, 28 Feb 2022 00:09:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C984F6112E;
        Mon, 28 Feb 2022 08:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33190C340F4;
        Mon, 28 Feb 2022 08:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646035761;
        bh=PExA9eVPgTY2q4PKJWJAKXGvdazs5vyTea5Swc8L/KU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OmdX19kaY0LUIEeh5kP/NeE6tESCaXCF3/uJGnILNjQW9u4pMRnLzC1o0WopwV7XW
         h4iz1fnDf/FTy8J/vHc19A9YDHeWx3jNb2d86kJwBCRAbKxjze4b+OepOulZtneiJN
         tdLt2cm6CV3NRptbMA/+rJaGl0Nsy7KIWbMUIIQ7PQeaLLhlbTNW0XAu3JaLbP/5ip
         PFI3tm+YqB8Wcps5a34G9UYzydFNt41uOr4qQ3VTJuMNRs9B+KJU+e8oxDfXDMx1IE
         4RauivEOiRRl1633u7BRUQhPtOWSsj3Q7LzPtcNGfnu+hOHLeMUQ3mhTwPwp9ZM9wL
         XdVet7MTY8EAQ==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2d07c4a0d06so97952967b3.13;
        Mon, 28 Feb 2022 00:09:21 -0800 (PST)
X-Gm-Message-State: AOAM530mcLDh3RCMWLQ4ednItkOC7r54ht+8b1sN3Sb17bVT7aQbwBbJ
        /+VqnPtxJYbyh0oESvl95Vput84FBdkMXCbkiKs=
X-Google-Smtp-Source: ABdhPJwRpjS/1qd5VxKyFLR01BpJVxanwLfUv0a6WYAPTtAzwtX8bCbimU2oqoADWWXD4QpICy67f2d9j/0k0MRtqD0=
X-Received: by 2002:a81:84d5:0:b0:2d1:e85:bf04 with SMTP id
 u204-20020a8184d5000000b002d10e85bf04mr19223230ywf.465.1646035760199; Mon, 28
 Feb 2022 00:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn> <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
 <YhupaVZvbipgke2Z@kroah.com> <CAAhV-H6hmvyniHP-CMxtOopRHp6XYaF58re13snMrk_Umj+wSQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6hmvyniHP-CMxtOopRHp6XYaF58re13snMrk_Umj+wSQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Feb 2022 09:09:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFa447Z21q3uu0UFExDDDG9Y42ZHtiUppu6QpuNA_5bhA@mail.gmail.com>
Message-ID: <CAMj1kXFa447Z21q3uu0UFExDDDG9Y42ZHtiUppu6QpuNA_5bhA@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Feb 2022 at 07:34, Huacai Chen <chenhuacai@gmail.com> wrote:
>
> Hi, Ard and Greg,
>
> On Mon, Feb 28, 2022 at 12:40 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Feb 27, 2022 at 03:14:30PM +0100, Ard Biesheuvel wrote:
> > > (add Greg and ACPI maintainers)
> > >
> > > On Sat, 26 Feb 2022 at 12:11, Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > This patch adds basic boot, setup and reset routines for LoongArch.
> > > > LoongArch uses UEFI-based firmware. The firmware uses ACPI and DMI/
> > > > SMBIOS to pass configuration information to the Linux kernel (in elf
> > > > format).
> > > >
> > > > Now the boot information passed to kernel is like this:
> > > > 1, kernel get 3 register values (a0, a1 and a2) from bootloader.
> > > > 2, a0 is "argc", a1 is "argv", so "kernel cmdline" comes from a0/a1.
> > > > 3, a2 is "environ", which is a pointer to "struct bootparamsinterface".
> > > > 4, "struct bootparamsinterface" include a "systemtable" pointer, whose
> > > >    type is "efi_system_table_t". Most configuration information, include
> > > >    ACPI tables and SMBIOS tables, come from here.
> > > >
> > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > Cc: linux-efi@vger.kernel.org
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  arch/loongarch/include/asm/acenv.h      |  17 +
> > > >  arch/loongarch/include/asm/acpi.h       |  38 ++
> > > >  arch/loongarch/include/asm/boot_param.h |  97 +++++
> > > >  arch/loongarch/include/asm/bootinfo.h   |  33 ++
> > > >  arch/loongarch/include/asm/dmi.h        |  24 ++
> > > >  arch/loongarch/include/asm/efi.h        |  33 ++
> > > >  arch/loongarch/include/asm/fw.h         |  18 +
> > > >  arch/loongarch/include/asm/reboot.h     |  10 +
> > > >  arch/loongarch/include/asm/setup.h      |  21 +
> > > >  arch/loongarch/kernel/acpi.c            | 338 ++++++++++++++++
> > > >  arch/loongarch/kernel/cacheinfo.c       | 122 ++++++
> > > >  arch/loongarch/kernel/cmdline.c         |  31 ++
> > > >  arch/loongarch/kernel/cpu-probe.c       | 305 +++++++++++++++
> > > >  arch/loongarch/kernel/efi.c             | 208 ++++++++++
> > > >  arch/loongarch/kernel/env.c             | 176 +++++++++
> > > >  arch/loongarch/kernel/head.S            |  72 ++++
> > > >  arch/loongarch/kernel/mem.c             |  89 +++++
> > > >  arch/loongarch/kernel/reset.c           |  90 +++++
> > > >  arch/loongarch/kernel/setup.c           | 495 ++++++++++++++++++++++++
> > > >  arch/loongarch/kernel/time.c            | 220 +++++++++++
> > > >  arch/loongarch/kernel/topology.c        |  13 +
> > > >  21 files changed, 2450 insertions(+)
> > >
> > > As I pointed out in response to an earlier revision of this code, I
> > > don't think we should merge this until we decide on some ground rules
> > > regarding the support level of this architecture in the UEFI and ACPI
> > > subsystems.
> > >
> > > The problem is that loongarch does not exist in the ACPI or UEFI
> > > specifications at all, and as I understand it, the firmware
> > > implementations themselves do not implement UEFI or ACPI entirely,
> > > they simply present data structures in memory that look similar enough
> > > for the Linux UEFI and ACPI code to boot the OS.
> >
> > Why isn't this in the ACPI/UEFI specs?  Is it a lack of access to the
> > spec groups by the comapny making these devices, or something else?
> We have tried our best to make LoongArch parts be in ACPI and UEFI SPECs.
>
> ECR for adding LoongArch support in ACPI:
> https://mantis.uefi.org/mantis/view.php?id=2203
>
> ECR for adding LoongArch support in ACPI (version update):
> https://mantis.uefi.org/mantis/view.php?id=2268
>
> ECR for adding LoongArch support in UEFI:
> https://mantis.uefi.org/mantis/view.php?id=2313
>
> ACPI changes of LoongArch have been approved in the last year, but the
> new version of ACPI SPEC hasn't been made public yet. And UEFI changes
> of LoongArch are under review now.
>
> Is it a must that the kernel code be merged after all SPECs are
> public? If not, I think we can provide some snapshots (If it is legal,
> I'm not sure) of mantis.uefi.org to prove the above.
>

Thanks for the links, those with access will be able to review,
although it would of course be preferable if this was open access.

In any case, if UEFI and ACPI support is going to be ratified in the
respective specifications, we are in a much better place to support
this in Linux going forward.

However, that still doesn't mean you should be using the internal API
used between the EFI stub and the core kernel as a boot interface.
Instead, you should implement LoongArch support into the EFI stub, and
build the kernel as a PE/COFF image that can boot from EFI directly,
from UEFI compliant firmware (u-boot or EDK2 are the most common
examples) that exposes all the UEFI stuff that the EFI stub relies on.

RISC-V is a useful reference for the changes needed - this is the most
recent addition to the EFI stub, and avoids some legacy stuff that new
architectures have no need for.

Alternatively, if ACPI is what you are after mostly, to describe the
platform to the OS, you could expose the ACPI tables to the OS without
relying on UEFI, although this should be part of the LoongArch
bindings in the ACPI spec too.

-- 
Ard.
