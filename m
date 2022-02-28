Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78EB4C64F2
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 09:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiB1Ijf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 03:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiB1Ije (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 03:39:34 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BA122502;
        Mon, 28 Feb 2022 00:38:55 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id j12so4784440vkr.0;
        Mon, 28 Feb 2022 00:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlQAeK0Btlmw60RaWpnzKuzYC/BbbL92OtA5xcN8u3c=;
        b=EfKNagLv2TkjVjDwI5O1tIRLgEqJTob1fN1dl/Bl8rGGJqX0ahjdS+iZ7qz6PuJstb
         /6mkOYRJA9fHZKPeRtm25oj1Z1X3XysBbNDOHETpIkR94oUKjGzgusMCrH4YPtENbwM2
         YrLbvIlKs3+Wmmyj9V5YIl/y9K5pFUmLnnFRmb/2SzCr8CbjIzWMR7LlucEsFV7blyld
         /YNxe5kwcgTaU6v0JvLG0Pl3Rt7jGU9HcRHZ6VOiYJhIsr+8t4qaPrt13/ouBY9L9heV
         b33bkROTCCu2E3j7yyonKUDeeG8JXcRJWi4yHdej/3uJfYqoDYIg+HrbiXm5EdRJ7V09
         ikCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlQAeK0Btlmw60RaWpnzKuzYC/BbbL92OtA5xcN8u3c=;
        b=IBbZrBssGS+iR8RHAun9OBIM0ZO7GS2ks3mbZ7+s1oK+SenJ/JlLa1+P8tdk3Ku+/a
         dlmR10X0aKzNUMD+S/UalRU9owhA7l0godzKxZwlOhcT+JWYDEIra9TDx7YCwJt0R3Rh
         lKL23Bdyds6v6rgnXAwzc6O24UCDzuGhk+22SYhI/H23ri92eoL7YbXsNEvqWil8GmED
         YJ5KVazkDwJY5cqrG45JZkvOvruQ83KPVLq7YnNF3Xohm2DU3JfDPmy10KSuQ7tFwquf
         APLal9j/n8ESgnDqu0ahHqDQf3Db4xs/rMnNHPYgaJq8kXiIHgXPaz0cQf3r+Cc91jBA
         yu0g==
X-Gm-Message-State: AOAM532sNqBgGzbPoqoLzD/12Md0Yciu3JvqIKlGKZ0b9yj0eYqpVd0h
        A++p5EoQq1l58YK+ZFYIV+nkW1e7fJuAcHP+i+4=
X-Google-Smtp-Source: ABdhPJw7DitUwbqJsF3nhpcPZilYHd54bS3pvFNDmnYXpruIo4G5RMUb/UxmHKC2uDwV6TJCToaP9aKUvtj1/hwL/r4=
X-Received: by 2002:a1f:9106:0:b0:333:443:279b with SMTP id
 t6-20020a1f9106000000b003330443279bmr2823707vkd.17.1646037534643; Mon, 28 Feb
 2022 00:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn> <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
 <YhupaVZvbipgke2Z@kroah.com> <CAAhV-H6hmvyniHP-CMxtOopRHp6XYaF58re13snMrk_Umj+wSQ@mail.gmail.com>
 <CAMj1kXFa447Z21q3uu0UFExDDDG9Y42ZHtiUppu6QpuNA_5bhA@mail.gmail.com>
In-Reply-To: <CAMj1kXFa447Z21q3uu0UFExDDDG9Y42ZHtiUppu6QpuNA_5bhA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 28 Feb 2022 16:38:44 +0800
Message-ID: <CAAhV-H7X+Txq4HaaF49QZ9deD=Dwx_GX-2E9q_nA8P76ZRDeXg@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Ard Biesheuvel <ardb@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ard,

On Mon, Feb 28, 2022 at 4:09 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 28 Feb 2022 at 07:34, Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > Hi, Ard and Greg,
> >
> > On Mon, Feb 28, 2022 at 12:40 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Feb 27, 2022 at 03:14:30PM +0100, Ard Biesheuvel wrote:
> > > > (add Greg and ACPI maintainers)
> > > >
> > > > On Sat, 26 Feb 2022 at 12:11, Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > >
> > > > > This patch adds basic boot, setup and reset routines for LoongArch.
> > > > > LoongArch uses UEFI-based firmware. The firmware uses ACPI and DMI/
> > > > > SMBIOS to pass configuration information to the Linux kernel (in elf
> > > > > format).
> > > > >
> > > > > Now the boot information passed to kernel is like this:
> > > > > 1, kernel get 3 register values (a0, a1 and a2) from bootloader.
> > > > > 2, a0 is "argc", a1 is "argv", so "kernel cmdline" comes from a0/a1.
> > > > > 3, a2 is "environ", which is a pointer to "struct bootparamsinterface".
> > > > > 4, "struct bootparamsinterface" include a "systemtable" pointer, whose
> > > > >    type is "efi_system_table_t". Most configuration information, include
> > > > >    ACPI tables and SMBIOS tables, come from here.
> > > > >
> > > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > > Cc: linux-efi@vger.kernel.org
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > ---
> > > > >  arch/loongarch/include/asm/acenv.h      |  17 +
> > > > >  arch/loongarch/include/asm/acpi.h       |  38 ++
> > > > >  arch/loongarch/include/asm/boot_param.h |  97 +++++
> > > > >  arch/loongarch/include/asm/bootinfo.h   |  33 ++
> > > > >  arch/loongarch/include/asm/dmi.h        |  24 ++
> > > > >  arch/loongarch/include/asm/efi.h        |  33 ++
> > > > >  arch/loongarch/include/asm/fw.h         |  18 +
> > > > >  arch/loongarch/include/asm/reboot.h     |  10 +
> > > > >  arch/loongarch/include/asm/setup.h      |  21 +
> > > > >  arch/loongarch/kernel/acpi.c            | 338 ++++++++++++++++
> > > > >  arch/loongarch/kernel/cacheinfo.c       | 122 ++++++
> > > > >  arch/loongarch/kernel/cmdline.c         |  31 ++
> > > > >  arch/loongarch/kernel/cpu-probe.c       | 305 +++++++++++++++
> > > > >  arch/loongarch/kernel/efi.c             | 208 ++++++++++
> > > > >  arch/loongarch/kernel/env.c             | 176 +++++++++
> > > > >  arch/loongarch/kernel/head.S            |  72 ++++
> > > > >  arch/loongarch/kernel/mem.c             |  89 +++++
> > > > >  arch/loongarch/kernel/reset.c           |  90 +++++
> > > > >  arch/loongarch/kernel/setup.c           | 495 ++++++++++++++++++++++++
> > > > >  arch/loongarch/kernel/time.c            | 220 +++++++++++
> > > > >  arch/loongarch/kernel/topology.c        |  13 +
> > > > >  21 files changed, 2450 insertions(+)
> > > >
> > > > As I pointed out in response to an earlier revision of this code, I
> > > > don't think we should merge this until we decide on some ground rules
> > > > regarding the support level of this architecture in the UEFI and ACPI
> > > > subsystems.
> > > >
> > > > The problem is that loongarch does not exist in the ACPI or UEFI
> > > > specifications at all, and as I understand it, the firmware
> > > > implementations themselves do not implement UEFI or ACPI entirely,
> > > > they simply present data structures in memory that look similar enough
> > > > for the Linux UEFI and ACPI code to boot the OS.
> > >
> > > Why isn't this in the ACPI/UEFI specs?  Is it a lack of access to the
> > > spec groups by the comapny making these devices, or something else?
> > We have tried our best to make LoongArch parts be in ACPI and UEFI SPECs.
> >
> > ECR for adding LoongArch support in ACPI:
> > https://mantis.uefi.org/mantis/view.php?id=2203
> >
> > ECR for adding LoongArch support in ACPI (version update):
> > https://mantis.uefi.org/mantis/view.php?id=2268
> >
> > ECR for adding LoongArch support in UEFI:
> > https://mantis.uefi.org/mantis/view.php?id=2313
> >
> > ACPI changes of LoongArch have been approved in the last year, but the
> > new version of ACPI SPEC hasn't been made public yet. And UEFI changes
> > of LoongArch are under review now.
> >
> > Is it a must that the kernel code be merged after all SPECs are
> > public? If not, I think we can provide some snapshots (If it is legal,
> > I'm not sure) of mantis.uefi.org to prove the above.
> >
>
> Thanks for the links, those with access will be able to review,
> although it would of course be preferable if this was open access.
>
> In any case, if UEFI and ACPI support is going to be ratified in the
> respective specifications, we are in a much better place to support
> this in Linux going forward.
>
> However, that still doesn't mean you should be using the internal API
> used between the EFI stub and the core kernel as a boot interface.
> Instead, you should implement LoongArch support into the EFI stub, and
> build the kernel as a PE/COFF image that can boot from EFI directly,
> from UEFI compliant firmware (u-boot or EDK2 are the most common
> examples) that exposes all the UEFI stuff that the EFI stub relies on.
We have implemented EFISTUB, but not in this first series:
https://github.com/loongson/linux/commit/d415a8e57e4d248e239958f2f18b45ea7a5fec2c
We want to add efistub support in the next series after new UEFI SPEC released.

>
> RISC-V is a useful reference for the changes needed - this is the most
> recent addition to the EFI stub, and avoids some legacy stuff that new
> architectures have no need for.
We still want to support the raw elf kernel (RISC-V also does),
because LoongArch also has MCU and SoC and we want to support FDT (I
think this is reasonable, because RISC-V also supports raw elf).

Huacai
>
> Alternatively, if ACPI is what you are after mostly, to describe the
> platform to the OS, you could expose the ACPI tables to the OS without
> relying on UEFI, although this should be part of the LoongArch
> bindings in the ACPI spec too.
>
> --
> Ard.
