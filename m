Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5597D4C6301
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 07:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiB1GfQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 01:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiB1GfP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 01:35:15 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDFC66C83;
        Sun, 27 Feb 2022 22:34:37 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id 63so4996327uaw.10;
        Sun, 27 Feb 2022 22:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQG4s8WE2x1LNgZqIzGp20XGhXGocdIMbbXafkH7Qc8=;
        b=GruZ2YoSOvvXfZVZ6KA5WEH0ZPPUg9N2AP5RrkdgnOLAviKh6yO5H1ky1McosPzMSP
         t84aBstIN9acMIz5FhxyewgGkxfrqsPFfkqY7Or8kbGjmt0mDcyUpAi/GnuKKA5N+ZKi
         R+brUdZB+s2Zq369kTj3/oSCilGJk8RlU+JElfYeXDSf7kgopr7PgIsRSUxpI1mGODSD
         zheBU/avNxJPTk+Mhpq3zz1tO2FapqfGIGoMKMP5cjOb/Pgr0FA1hkLjIlmxUV/bFKs2
         xCMq+QM07HRFWVmJYKN4A7LQBgk/61YwuzwVITqBZCz0GNlIHlKpIqYTvJaQ/fvbMlf1
         w5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQG4s8WE2x1LNgZqIzGp20XGhXGocdIMbbXafkH7Qc8=;
        b=rKi3ITCjhIqbbH3Wh1NfL0aagwuoMP74K1enrSAM2+GfJmEkIhtEnVMjRgMdrQdZXG
         vPyUHYA4/iCdVHnCdCSu28lMHUm0JQRBkXeSfrEShQ0wMM72f9qpep2YeB9oXTtHi60W
         2OhmU84VPVJ16zjMOFKG3FfINMR5eZox3jtVHyoSIMJZYIxE9cP/ChzygtiYABDTWVuU
         N7vNwjMNygNu3YgN3rxUh8lOqxKwvmXCKO84SL3ha777MzsU6ifgnMbeNsCaeJoQ8U1N
         2uBffgUKnoIEftz4JYQ5FWasSp0Wx5vmLMQCHPwa0orotz0E/Fiy7Ax1ODD+WhyuHnZ9
         zQCg==
X-Gm-Message-State: AOAM533oghqfBwbgcx6+xEmnTq7/cHSp2NZ3Lv0m5l1oNHSaNtwQkT5v
        DoF8OtUZM9BII6Y/2xE8V6zL/MSE0AxM4dFUCfhpA+k1hYznZA==
X-Google-Smtp-Source: ABdhPJzEXt+L46gCFw+ULUhU5ealXcEhvdwROaLTbtefttrWg20EEksoLIWs4q7qU/6kVxnQzPI1Gr2hXMpssF1Jsqs=
X-Received: by 2002:ab0:3da4:0:b0:306:a7f8:f28b with SMTP id
 l36-20020ab03da4000000b00306a7f8f28bmr7527955uac.47.1646030076362; Sun, 27
 Feb 2022 22:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn> <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
 <YhupaVZvbipgke2Z@kroah.com>
In-Reply-To: <YhupaVZvbipgke2Z@kroah.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 28 Feb 2022 14:34:26 +0800
Message-ID: <CAAhV-H6hmvyniHP-CMxtOopRHp6XYaF58re13snMrk_Umj+wSQ@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

Hi, Ard and Greg,

On Mon, Feb 28, 2022 at 12:40 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Feb 27, 2022 at 03:14:30PM +0100, Ard Biesheuvel wrote:
> > (add Greg and ACPI maintainers)
> >
> > On Sat, 26 Feb 2022 at 12:11, Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > This patch adds basic boot, setup and reset routines for LoongArch.
> > > LoongArch uses UEFI-based firmware. The firmware uses ACPI and DMI/
> > > SMBIOS to pass configuration information to the Linux kernel (in elf
> > > format).
> > >
> > > Now the boot information passed to kernel is like this:
> > > 1, kernel get 3 register values (a0, a1 and a2) from bootloader.
> > > 2, a0 is "argc", a1 is "argv", so "kernel cmdline" comes from a0/a1.
> > > 3, a2 is "environ", which is a pointer to "struct bootparamsinterface".
> > > 4, "struct bootparamsinterface" include a "systemtable" pointer, whose
> > >    type is "efi_system_table_t". Most configuration information, include
> > >    ACPI tables and SMBIOS tables, come from here.
> > >
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: linux-efi@vger.kernel.org
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  arch/loongarch/include/asm/acenv.h      |  17 +
> > >  arch/loongarch/include/asm/acpi.h       |  38 ++
> > >  arch/loongarch/include/asm/boot_param.h |  97 +++++
> > >  arch/loongarch/include/asm/bootinfo.h   |  33 ++
> > >  arch/loongarch/include/asm/dmi.h        |  24 ++
> > >  arch/loongarch/include/asm/efi.h        |  33 ++
> > >  arch/loongarch/include/asm/fw.h         |  18 +
> > >  arch/loongarch/include/asm/reboot.h     |  10 +
> > >  arch/loongarch/include/asm/setup.h      |  21 +
> > >  arch/loongarch/kernel/acpi.c            | 338 ++++++++++++++++
> > >  arch/loongarch/kernel/cacheinfo.c       | 122 ++++++
> > >  arch/loongarch/kernel/cmdline.c         |  31 ++
> > >  arch/loongarch/kernel/cpu-probe.c       | 305 +++++++++++++++
> > >  arch/loongarch/kernel/efi.c             | 208 ++++++++++
> > >  arch/loongarch/kernel/env.c             | 176 +++++++++
> > >  arch/loongarch/kernel/head.S            |  72 ++++
> > >  arch/loongarch/kernel/mem.c             |  89 +++++
> > >  arch/loongarch/kernel/reset.c           |  90 +++++
> > >  arch/loongarch/kernel/setup.c           | 495 ++++++++++++++++++++++++
> > >  arch/loongarch/kernel/time.c            | 220 +++++++++++
> > >  arch/loongarch/kernel/topology.c        |  13 +
> > >  21 files changed, 2450 insertions(+)
> >
> > As I pointed out in response to an earlier revision of this code, I
> > don't think we should merge this until we decide on some ground rules
> > regarding the support level of this architecture in the UEFI and ACPI
> > subsystems.
> >
> > The problem is that loongarch does not exist in the ACPI or UEFI
> > specifications at all, and as I understand it, the firmware
> > implementations themselves do not implement UEFI or ACPI entirely,
> > they simply present data structures in memory that look similar enough
> > for the Linux UEFI and ACPI code to boot the OS.
>
> Why isn't this in the ACPI/UEFI specs?  Is it a lack of access to the
> spec groups by the comapny making these devices, or something else?
We have tried our best to make LoongArch parts be in ACPI and UEFI SPECs.

ECR for adding LoongArch support in ACPI:
https://mantis.uefi.org/mantis/view.php?id=2203

ECR for adding LoongArch support in ACPI (version update):
https://mantis.uefi.org/mantis/view.php?id=2268

ECR for adding LoongArch support in UEFI:
https://mantis.uefi.org/mantis/view.php?id=2313

ACPI changes of LoongArch have been approved in the last year, but the
new version of ACPI SPEC hasn't been made public yet. And UEFI changes
of LoongArch are under review now.

Is it a must that the kernel code be merged after all SPECs are
public? If not, I think we can provide some snapshots (If it is legal,
I'm not sure) of mantis.uefi.org to prove the above.

Huacai

>
> > As the UEFI subsystem maintainer, I am concerned that future changes
> > to the UEFI subsystem that are rooted in the the UEFI specification as
> > it evolves may trigger unanticipated results on this architecture, and
> > I imagine the ACPI maintainers may have similar concerns.
>
> I agree, I would be concerned about that as well.
>
> > So what can we do about this? Do we merge this code, but as a second
> > class citizen in terms of UEFI/ACPI subsystem support, i.e., you are
> > welcome to use it, but if something breaks, the UEFI/ACPI maintainers
> > are not on the hook to see to it that it gets fixed? I don't think
> > this is a great solution, but I'm not sure if there are alternatives
> > that are any better.
>
> That's not going to work, it's the kernel's job to fix up hardware
> problems.  But as this is all firmware, why can't the firmware be
> changed to properly follow the public specifications?  What's wrong with
> requiring that at this point in time (i.e. _BEFORE_ the code is merged)?
>
> thanks,
>
> greg k-h
