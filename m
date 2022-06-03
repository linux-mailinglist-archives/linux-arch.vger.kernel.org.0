Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F24253C98B
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 13:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244085AbiFCLtE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiFCLtD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 07:49:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B980381B4;
        Fri,  3 Jun 2022 04:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7A63B822CE;
        Fri,  3 Jun 2022 11:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2A1C34115;
        Fri,  3 Jun 2022 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654256939;
        bh=X8VUkQQIsdul5nRaZx8jcDZ3dHSCnETsIvwz4JcA9+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HnKVQW64OQEMmE4jBWCM0wy4/jCMxwqwsZN98sUAe1Zkqa8+xEaRBx5BUWRDRapvQ
         mwIPh5JKkkUclWhIPENdgDy84xtaUizMtHO7psKhzVY5+66dy27EzPmBWB3Jho46fp
         jBgTGP2or2Lj+RXKqRK4tN6Q6rSSMwHyD67N2QEx2yp0j2jy5QfBf+OCHhyiosMBPn
         9QfFj5d44xnxpz2l+VHmyh+tmeTPaqPdQ9yCRfvRn1TmGBXgqteBe+g/oxcgmJcHQ2
         6oWpS2r5jLJUsIwQh5ZMlVP1vMFtD7Vl8pW7tI3iI1MLp0AfoxlAy3eN6iq+L0DzCh
         PmMWtDMyOFisw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e5e433d66dso10275139fac.5;
        Fri, 03 Jun 2022 04:48:59 -0700 (PDT)
X-Gm-Message-State: AOAM532xjGCNId7cXPqc/SSS8NNCrEchQDGb0kSZFN/at8yQ1rmV2K9p
        LEUcTkkoZNuIkCv2lAtI0ig5fDpOyZwTA95TCDc=
X-Google-Smtp-Source: ABdhPJw05wRHg99uYpgtAnCv/XqNeM0d/Ebfy5iJ9wfQPaCKtcJTDHMiG8UneinMTluS1Utm3DjYuPp5l621EaDHkR8=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr5452735oan.126.1654256938205; Fri, 03
 Jun 2022 04:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
 <20220603072053.35005-12-chenhuacai@loongson.cn> <4213df91-c762-ae56-f08d-8c925759fa63@xen0n.name>
 <CAK8P3a2mW7KmgxqWsaf76Q4V++B+0e6bH=tb4w4cA0XkZYuSLA@mail.gmail.com> <fcdbe7bd-bb4a-fc50-a96d-c2dd1456bc9b@xen0n.name>
In-Reply-To: <fcdbe7bd-bb4a-fc50-a96d-c2dd1456bc9b@xen0n.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 3 Jun 2022 13:48:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXENy9Wf4EtNp7F+RHfF2WaUXsaXsMJVCVAXc4i_-nH=VA@mail.gmail.com>
Message-ID: <CAMj1kXENy9Wf4EtNp7F+RHfF2WaUXsaXsMJVCVAXc4i_-nH=VA@mail.gmail.com>
Subject: Re: [PATCH V15 11/24] LoongArch: Add boot and setup routines
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        WANG Xuerui <git@xen0n.name>, Yun Liu <liuyun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 3 Jun 2022 at 12:37, WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 6/3/22 18:02, Arnd Bergmann wrote:
> > On Fri, Jun 3, 2022 at 11:27 AM WANG Xuerui <kernel@xen0n.name> wrote:
> >> On 6/3/22 15:20, Huacai Chen wrote:
> >>> Add basic boot, setup and reset routines for LoongArch. Now, LoongArch
> >>> machines use UEFI-based firmware. The firmware passes configuration
> >>> information to the kernel via ACPI and DMI/SMBIOS.
> >>>
> >>> Currently an existing interface between the kernel and the bootloader
> >>> is implemented. Kernel gets 2 values from the bootloader, passed in
> >>> registers a0 and a1; a0 is an "EFI boot flag" distinguishing UEFI and
> >>> non-UEFI firmware, while a1 is a pointer to an FDT with systable,
> >>> memmap, cmdline and initrd information.
> >>>
> >>> The standard UEFI boot protocol (EFISTUB) will be added later.
> >>>
> >>> Cc: linux-efi@vger.kernel.org
> >>> Cc: Ard Biesheuvel <ardb@kernel.org>
> >>> Reviewed-by: WANG Xuerui <git@xen0n.name>
> >>> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>> Co-developed-by: Yun Liu <liuyun@loongson.cn>
> >>> Signed-off-by: Yun Liu <liuyun@loongson.cn>
> >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >> Would you please look at this patch, which has all the arch-independent
> >> changes backed out, and Ack if it is fit for mainlining?
> >>
> >> I communicated a little with Huacai about the approach for supporting
> >> alternative boot protocols down the road, and we agreed to carry the
> >> respective changes downstream. And if needs truly arise for modifying
> >> common EFI logic, we can do so in a non-rushed manner later.
> >>
> >> For the current status of the code, apparently it just accepts the
> >> standard efistub-shape FDT pointer from (whatever booting the image),
> >> and everything onwards are fully using the common code without
> >> modification as you can see from the diffstat. I rebased my BPI support
> >> patch on top of this (basically translating Loongson BPI data structures
> >> into the expected FDT form), and can confirm the boot can progress to
> >> the same point as before -- indeed the SVAM changes etc. are not
> >> necessary for a working system, and the code remains working.
> > I'm a bit lost here: Does this mean the v15 version is back to the old
> > pre-efistub interface and allows booting with existing firmware, or
> > is it now left out completely? I still see a kernel_entry() function
> > in head.S, and I see references to loongson_sysconf, but I don't
> > see if that is what gets passed in from the bootloader.
> It's not the same interface as in some of the very early revisions; the
> earlier versions relied on "struct bootparamsinterface" or BPI, while
> it's the same FDT-based interface to initialize EFI from, as in
> arch/arm64 and arch/riscv I believe. No Loongson-specific things remain now.

OK, excellent.

> >
> > I really want to make sure that without the EFI stub, there is no
> > other way to boot the kernel that would have to get maintained
> > in the long run.
> Yeah this is the case right now. No LoongArch bootloader that I know of
> can prepare the EFI stub-shaped FDT that the current code expects, and I
> don't know of any future Loongson plan to do that either (Loongson's
> previous in-house efforts all looked something different). So it's
> pretty safe to say the current code wouldn't get frozen once mainlined.

The use of DT is part of the internal stub <-> kernel ABI, and if
LoongArch does not make use of DT otherwise, I could well imagine
changing this down the road.

I'll send out some RFC patches for review after the merge window closes.
