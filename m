Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608174D0EE8
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 06:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiCHFCX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 00:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiCHFCU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 00:02:20 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300CC24BC3;
        Mon,  7 Mar 2022 21:01:24 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id l45so7479045uad.1;
        Mon, 07 Mar 2022 21:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKvhppFceChLgmUpgQVEk1mZ3VY0JaSZJA2aB43Q7Vk=;
        b=VSM2HLY0kX84OL07y9j206vTbYJdekrGShRw4CrfWN3ujt3SEitgG1bAfG8KlfUSOw
         ElJWiSRFumUKR+fyDaiQhfWzvG908o7Ub3CRG6tvrBdC1ZBAlcQns5X15xg+DVcA98sR
         xefn8uAIem+hS4+KTbQmIiAaZstaqv+dXPNdvJdQEX0DTlkxdbO9uz+LJhZEGYcq5ydy
         SRQ8UlIZvCr9Ep4TQyn6e0AenP5jKJY5XOt87AXUbuP0M3OpLMIYGV1YwjzxOFyFeqvX
         7GfhoIaJGtsAqYuTKqfFV/EG2YMuWM5eOZkavzjm/tqiEgUyIZLQSpgKMSrca/ZKaTP0
         ItkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKvhppFceChLgmUpgQVEk1mZ3VY0JaSZJA2aB43Q7Vk=;
        b=dwxDxgOS+ujuBkT3lpxio1d75N8uR53sk19RGz+cUYlyV7aNGJ2GlO0PNKwFj1FAoH
         uKUij1fTeRS3uMZuBehrVoskwPR33nuEzrfmGvh36JcL19j9ofQFUzZIL1mqfPBpOVni
         eVupYGaKFkFOKKSR1oc4LSaD5eUKsdnCpY5yR6/exPAInQ09s++iupjv5UAemlDxZ2Qe
         tE3kjHpOUI2tNwVG83jgHJh42NkD7GA/IgzkkhiY8y+g8VNJG5uietHRzbREm6A8oJgB
         ozypjOrUqEd8mSDW/13O+6h0Fwa/Jdy8h0pFUPwTWIBErHzCLg7DZJiWgCDwnSdwZKRb
         2b5g==
X-Gm-Message-State: AOAM531Mod8Awta1IAXu/WmqgkzIWxaMlQiOZYtucITNMGOzO1otic3+
        +1T9fSSyPziHALMaGWe3QeisdWFd5KkSfKc1SGQvVkbFS3ldCA==
X-Google-Smtp-Source: ABdhPJzbMqED95ln7Nv/0kYruwHO9Qug+J1OiHrch1cXgj6krfHGEm91/jREsdcS5fHYIgs4Bkzz5WRXAqvKWZl8ixc=
X-Received: by 2002:a9f:24d6:0:b0:348:d872:5917 with SMTP id
 80-20020a9f24d6000000b00348d8725917mr5014892uar.118.1646715683203; Mon, 07
 Mar 2022 21:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn> <YiCpYRwoUSmd/GE3@kernel.org>
 <CAAhV-H4-zVjjUkoVFw4ppg_tsM-wxBZmPr-2q8zuoLDHTWAE0w@mail.gmail.com>
 <YiHuuyqW8KSAri/M@kernel.org> <CAAhV-H6z3H3QbzvG6=fgVJF1z2qEvKVGnyqb--bkqomH3jTXJQ@mail.gmail.com>
 <YiZCypeuJ+0FCJ+w@kernel.org>
In-Reply-To: <YiZCypeuJ+0FCJ+w@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 8 Mar 2022 13:01:11 +0800
Message-ID: <CAAhV-H6WnnqVs+9syRcRYWTdqYKWr1c03TR2_cJB-tN223MS-w@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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

Hi, Mike,

On Tue, Mar 8, 2022 at 1:37 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> Hi,
>
> On Fri, Mar 04, 2022 at 08:43:03PM +0800, Huacai Chen wrote:
> > Hi, Mike,
> >
> > On Fri, Mar 4, 2022 at 6:49 PM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > >
> > > So ideally, the physical memory detection and registration should follow
> > > something like:
> > >
> > > * memblock_reserve() the memory used by firmware, kernel and initrd
> > > * detect NUMA topology
> > > * add memory regions along with their node ids to memblock.
> > >
> > > s390::setup_arch() is a good example of doing early reservations:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/setup.c#n988
> > I have a fast reading of S390, and I think we can do some adjust:
> > 1, call memblock_set_node(0, ULONG_MAX, &memblock.memory, 0) in
> > early_memblock_init().
> > 2, move memblock_reserve(PHYS_OFFSET, 0x200000) and
> > memblock_reserve(__pa_symbol(&_text), __pa_symbol(&_end) -
> > __pa_symbol(&_text)) to early_memblock_init().
> > 3, Reserve initrd memory in the first place.
> > It is nearly the same as the S390, then.
>
> It does not have to look like the same as s390 :)
> The important thing is to reserve all the memory before memblock
> allocations are possible.
New version is here, it's not completely the same as S390, but very similar:
https://lore.kernel.org/linux-arch/20220306112850.811504-1-chenhuacai@loongson.cn/T/#Z2e.:..:20220306112850.811504-10-chenhuacai::40loongson.cn:1arch:loongarch:kernel:mem.c

Firmware is not in SYSRAM regions, so we don't need to reserve them.
The first 2MB and the kernel region are reserved in
early_memblock_init(), before any allocations.

Initrd information is passed by cmdline, and initrd is now reserved
immediately after cmdline has parsed, by merging
init_initrd/finalize_initrd as you suggested:
https://lore.kernel.org/linux-arch/20220306112850.811504-1-chenhuacai@loongson.cn/T/#Z2e.:..:20220306112850.811504-10-chenhuacai::40loongson.cn:1arch:loongarch:kernel:setup.c

>
> > > > > > +early_param("memmap", early_parse_memmap);
> > > > >
> > > > > The memmap= processing is a hack indented to workaround bugs in firmware
> > > > > related to the memory detection. Please don't copy if over unless there is
> > > > > really strong reason.
> > > >
> > > > Hmmm, I have read the documents, most archs only support mem=limit,
> > > > but MIPS support mem=limit@base. memmap not only supports
> > > > memmap=limit@base, but also a lot of advanced syntax. LoongArch needs
> > > > both limit and limit@base syntax. So can we make our code to support
> > > > only mem=limit and memmap=limit@base, and remove all other syntax
> > > > here?
> > >
> > > The documentation describes what was there historically and both these
> > > options tend not to play well with complex memory layouts.
> > >
> > > If you must have them it's better to use x86 as an example rather than
> > > MIPS, just take into the account that on x86 memory always starts from 0,
> > > so they never needed to have a different base.
> > >
> > > For what use-cases LoongArch needs options?
> >
> > The use-case of limit@base syntax is kdump, because our kernel is not
> > relocatable. I'll use X86 as an example.
>
> I missed that mem= can be used several times, so with MIPS implementation
> it's possible to define something like "mem=limit0@base0 mem=limit1@base1"
> and this will create two contiguous memory regions.
The new version is here:
https://lore.kernel.org/linux-arch/20220306112850.811504-1-chenhuacai@loongson.cn/T/#Z2e.:..:20220306112850.811504-10-chenhuacai::40loongson.cn:1arch:loongarch:kernel:setup.c
If I use the MIPS implementation, then memmap= is useless and can be
removed, but the MIPS implementation is not obey the rules in kernel
documents.

Huacai
>
> > Huacai
>
> --
> Sincerely yours,
> Mike.
