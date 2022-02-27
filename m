Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C744C5D7D
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 17:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiB0Qk4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 11:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiB0Qkz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 11:40:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F80A3E0E2;
        Sun, 27 Feb 2022 08:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6428BCE0B5C;
        Sun, 27 Feb 2022 16:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76D1C340E9;
        Sun, 27 Feb 2022 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645980013;
        bh=sn143wRUl1QuCGhTXJ1NE23NeLyOuFLAyxALHc08zDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+wUc0Dkfo/uqnrBEsgX6LW7XVTCrZm5DIJ+4wtZ2gZ2xDBpRiyYe6sMHBERaZAA9
         PG27e+n4iZeLP3z8TVN87wx/yGP8ke/1HK1oMGUddI48LpQF18wH8gL10EhaJfqFZG
         LIg9Bf/y2fEvCV6Q6KeQdljh9T/wZ/xxmtFNYftE=
Date:   Sun, 27 Feb 2022 17:40:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
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
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
Message-ID: <YhupaVZvbipgke2Z@kroah.com>
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn>
 <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 27, 2022 at 03:14:30PM +0100, Ard Biesheuvel wrote:
> (add Greg and ACPI maintainers)
> 
> On Sat, 26 Feb 2022 at 12:11, Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > This patch adds basic boot, setup and reset routines for LoongArch.
> > LoongArch uses UEFI-based firmware. The firmware uses ACPI and DMI/
> > SMBIOS to pass configuration information to the Linux kernel (in elf
> > format).
> >
> > Now the boot information passed to kernel is like this:
> > 1, kernel get 3 register values (a0, a1 and a2) from bootloader.
> > 2, a0 is "argc", a1 is "argv", so "kernel cmdline" comes from a0/a1.
> > 3, a2 is "environ", which is a pointer to "struct bootparamsinterface".
> > 4, "struct bootparamsinterface" include a "systemtable" pointer, whose
> >    type is "efi_system_table_t". Most configuration information, include
> >    ACPI tables and SMBIOS tables, come from here.
> >
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: linux-efi@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/acenv.h      |  17 +
> >  arch/loongarch/include/asm/acpi.h       |  38 ++
> >  arch/loongarch/include/asm/boot_param.h |  97 +++++
> >  arch/loongarch/include/asm/bootinfo.h   |  33 ++
> >  arch/loongarch/include/asm/dmi.h        |  24 ++
> >  arch/loongarch/include/asm/efi.h        |  33 ++
> >  arch/loongarch/include/asm/fw.h         |  18 +
> >  arch/loongarch/include/asm/reboot.h     |  10 +
> >  arch/loongarch/include/asm/setup.h      |  21 +
> >  arch/loongarch/kernel/acpi.c            | 338 ++++++++++++++++
> >  arch/loongarch/kernel/cacheinfo.c       | 122 ++++++
> >  arch/loongarch/kernel/cmdline.c         |  31 ++
> >  arch/loongarch/kernel/cpu-probe.c       | 305 +++++++++++++++
> >  arch/loongarch/kernel/efi.c             | 208 ++++++++++
> >  arch/loongarch/kernel/env.c             | 176 +++++++++
> >  arch/loongarch/kernel/head.S            |  72 ++++
> >  arch/loongarch/kernel/mem.c             |  89 +++++
> >  arch/loongarch/kernel/reset.c           |  90 +++++
> >  arch/loongarch/kernel/setup.c           | 495 ++++++++++++++++++++++++
> >  arch/loongarch/kernel/time.c            | 220 +++++++++++
> >  arch/loongarch/kernel/topology.c        |  13 +
> >  21 files changed, 2450 insertions(+)
> 
> As I pointed out in response to an earlier revision of this code, I
> don't think we should merge this until we decide on some ground rules
> regarding the support level of this architecture in the UEFI and ACPI
> subsystems.
> 
> The problem is that loongarch does not exist in the ACPI or UEFI
> specifications at all, and as I understand it, the firmware
> implementations themselves do not implement UEFI or ACPI entirely,
> they simply present data structures in memory that look similar enough
> for the Linux UEFI and ACPI code to boot the OS.

Why isn't this in the ACPI/UEFI specs?  Is it a lack of access to the
spec groups by the comapny making these devices, or something else?

> As the UEFI subsystem maintainer, I am concerned that future changes
> to the UEFI subsystem that are rooted in the the UEFI specification as
> it evolves may trigger unanticipated results on this architecture, and
> I imagine the ACPI maintainers may have similar concerns.

I agree, I would be concerned about that as well.

> So what can we do about this? Do we merge this code, but as a second
> class citizen in terms of UEFI/ACPI subsystem support, i.e., you are
> welcome to use it, but if something breaks, the UEFI/ACPI maintainers
> are not on the hook to see to it that it gets fixed? I don't think
> this is a great solution, but I'm not sure if there are alternatives
> that are any better.

That's not going to work, it's the kernel's job to fix up hardware
problems.  But as this is all firmware, why can't the firmware be
changed to properly follow the public specifications?  What's wrong with
requiring that at this point in time (i.e. _BEFORE_ the code is merged)?

thanks,

greg k-h
