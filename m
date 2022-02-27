Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFCF4C5BE6
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 15:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiB0OPU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 09:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiB0OPU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 09:15:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDD9286F8;
        Sun, 27 Feb 2022 06:14:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6877260F34;
        Sun, 27 Feb 2022 14:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D49C340F6;
        Sun, 27 Feb 2022 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645971282;
        bh=8cKC3x+yO+OOmvmNlTcBSbC/huZFIvHs2Pt5pQnt/7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aw+LvfEpp4g4ddvoCAqLsW9hWiVvlurCwOxI8uaRl7mIKrKXdEpggfEspYvXEdius
         WYzl6GgGvNVsWDILLsa8fmM6zGbZlPWuY+NJC5DUVirbBjsFSyyi1zCmsVJfGdUjJx
         8kcdojBLhwKEAE66nKxgkrNUDIpsnsd9USlQ40QJxRU8d4k85k3onaQO+nUrbrv/VI
         t+nEosHpfJV0zLR7jyFWe9KvlrAoiHEGlZPehUlSOXDcf4rUxII0cyGM8CLG0nYrAw
         S/8S/PKaoTu0dLVzwk6CgUFkliUjcUnGQRxEnWDCK3/aatr5mldHvTplRVfZslWCRs
         gbh6cLdrWQHhw==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2db569555d6so25057197b3.12;
        Sun, 27 Feb 2022 06:14:42 -0800 (PST)
X-Gm-Message-State: AOAM531IhZupdztQNqR+HWcTwMWX1gHH5K6mfq3Dp4iyqW4BUvmLllAo
        w2acBJE922hD9RwVGP5w/j01d2l67VrwLgLPzhg=
X-Google-Smtp-Source: ABdhPJzQR6vt45LoUc69dX7W5U+c9WI4+t885UX0AYC0RvuJ7LzJl8Q8c91dRL+Diu/nj2sBe+NsDUQChVrwF7WOefQ=
X-Received: by 2002:a81:178c:0:b0:2d7:8d37:a83 with SMTP id
 134-20020a81178c000000b002d78d370a83mr15511772ywx.205.1645971281713; Sun, 27
 Feb 2022 06:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn> <20220226110338.77547-10-chenhuacai@loongson.cn>
In-Reply-To: <20220226110338.77547-10-chenhuacai@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 27 Feb 2022 15:14:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
Message-ID: <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
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
        Huacai Chen <chenhuacai@gmail.com>,
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

(add Greg and ACPI maintainers)

On Sat, 26 Feb 2022 at 12:11, Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> This patch adds basic boot, setup and reset routines for LoongArch.
> LoongArch uses UEFI-based firmware. The firmware uses ACPI and DMI/
> SMBIOS to pass configuration information to the Linux kernel (in elf
> format).
>
> Now the boot information passed to kernel is like this:
> 1, kernel get 3 register values (a0, a1 and a2) from bootloader.
> 2, a0 is "argc", a1 is "argv", so "kernel cmdline" comes from a0/a1.
> 3, a2 is "environ", which is a pointer to "struct bootparamsinterface".
> 4, "struct bootparamsinterface" include a "systemtable" pointer, whose
>    type is "efi_system_table_t". Most configuration information, include
>    ACPI tables and SMBIOS tables, come from here.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/acenv.h      |  17 +
>  arch/loongarch/include/asm/acpi.h       |  38 ++
>  arch/loongarch/include/asm/boot_param.h |  97 +++++
>  arch/loongarch/include/asm/bootinfo.h   |  33 ++
>  arch/loongarch/include/asm/dmi.h        |  24 ++
>  arch/loongarch/include/asm/efi.h        |  33 ++
>  arch/loongarch/include/asm/fw.h         |  18 +
>  arch/loongarch/include/asm/reboot.h     |  10 +
>  arch/loongarch/include/asm/setup.h      |  21 +
>  arch/loongarch/kernel/acpi.c            | 338 ++++++++++++++++
>  arch/loongarch/kernel/cacheinfo.c       | 122 ++++++
>  arch/loongarch/kernel/cmdline.c         |  31 ++
>  arch/loongarch/kernel/cpu-probe.c       | 305 +++++++++++++++
>  arch/loongarch/kernel/efi.c             | 208 ++++++++++
>  arch/loongarch/kernel/env.c             | 176 +++++++++
>  arch/loongarch/kernel/head.S            |  72 ++++
>  arch/loongarch/kernel/mem.c             |  89 +++++
>  arch/loongarch/kernel/reset.c           |  90 +++++
>  arch/loongarch/kernel/setup.c           | 495 ++++++++++++++++++++++++
>  arch/loongarch/kernel/time.c            | 220 +++++++++++
>  arch/loongarch/kernel/topology.c        |  13 +
>  21 files changed, 2450 insertions(+)

As I pointed out in response to an earlier revision of this code, I
don't think we should merge this until we decide on some ground rules
regarding the support level of this architecture in the UEFI and ACPI
subsystems.

The problem is that loongarch does not exist in the ACPI or UEFI
specifications at all, and as I understand it, the firmware
implementations themselves do not implement UEFI or ACPI entirely,
they simply present data structures in memory that look similar enough
for the Linux UEFI and ACPI code to boot the OS.

As the UEFI subsystem maintainer, I am concerned that future changes
to the UEFI subsystem that are rooted in the the UEFI specification as
it evolves may trigger unanticipated results on this architecture, and
I imagine the ACPI maintainers may have similar concerns.

So what can we do about this? Do we merge this code, but as a second
class citizen in terms of UEFI/ACPI subsystem support, i.e., you are
welcome to use it, but if something breaks, the UEFI/ACPI maintainers
are not on the hook to see to it that it gets fixed? I don't think
this is a great solution, but I'm not sure if there are alternatives
that are any better.

Thoughts, please?

-- 
Ard.
