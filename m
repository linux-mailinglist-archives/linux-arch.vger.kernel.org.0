Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CED5374B3
	for <lists+linux-arch@lfdr.de>; Mon, 30 May 2022 09:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiE3G21 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 May 2022 02:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiE3G2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2022 02:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8096E12630;
        Sun, 29 May 2022 23:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35AC5B80B9D;
        Mon, 30 May 2022 06:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C580FC341CB;
        Mon, 30 May 2022 06:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653892101;
        bh=XDzSIoHWePkmP+hpw6NVJQ2xptrOcdraIZACeo0G99g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QcJjk/Inplt4PZq9fjYRnwhB9hUn6LTrjwBSL6gpDtXYnyadjF+DGlGse6l1zTloW
         kCzkvEfOizdurZrM9A3+xqlPnxZGHVDNaALT9IibCphP/bN8mh4XcHTZUQ2nWmx4bD
         1uz7rNyx+o3r2XV6XgdtWTYR4CZEfuiK88ZUe88mo6yQfPG4celZl9OzmJV7tS42x6
         DVGxWyiPH/hFI1lb47pKaDa5uERPNS9UwYMpCGW8r8BKc/NrjtN64PHXd2yG/ClUT6
         RXTuGOgZRcbaSrUCqPgbzl0iSTuWMvID1Jvsbye0r/0uXIO5EWmwRECloRm0gD+Yjr
         4KsgaK3Uk6QNw==
Received: by mail-vs1-f51.google.com with SMTP id b7so9931572vsq.1;
        Sun, 29 May 2022 23:28:21 -0700 (PDT)
X-Gm-Message-State: AOAM533M0XK43njrW1enHlotiZ/tElsQYuOWj0M/HJ7oTJEPR2hYY4uM
        JKmARiT8Ewy0oHVlAIPpuzoMHHhpY8+PBRw3CAc=
X-Google-Smtp-Source: ABdhPJxEAsyCh28072V1AnS6ZttgQlEUduuZqZSfbFoSlejtUq2u+WNsxkkpfH04f8xnjxHcuhayk+gBn3uuHKqnFdg=
X-Received: by 2002:a67:e899:0:b0:337:932a:2fc5 with SMTP id
 x25-20020a67e899000000b00337932a2fc5mr18547320vsn.40.1653892100644; Sun, 29
 May 2022 23:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com> <875ylomq3m.wl-maz@kernel.org>
In-Reply-To: <875ylomq3m.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 30 May 2022 14:28:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4icDqABQiT4ckKdsmfVzqBKjxncDt9649c2ijOD093gw@mail.gmail.com>
Message-ID: <CAAhV-H4icDqABQiT4ckKdsmfVzqBKjxncDt9649c2ijOD093gw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic changes for 5.19
To:     Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, libc-alpha@sourceware.org,
        musl@lists.openwall.com, Ard Biesheuvel <ardb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 29, 2022 at 9:21 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 29 May 2022 12:24:29 +0100,
> Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Thu, May 26, 2022 at 5:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > - A series to add a generic ticket spinlock that can be shared by most
> > >   architectures with a working cmpxchg or ll/sc type atomic, including
> > >   the conversion of riscv, csky and openrisc. This series is also a
> > >   prerequisite for the loongarch64 architecture port that will come as
> > >   a separate pull request.
> >
> > An update on Loongarch: I was originally planning to  send Linus a
> > pull request with
> > the branch with the contents from
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
> >
> > but I saw that this includes both the architecture code and some
> > device drivers (irqchip, pci, acpi) that are essential for the
> > kernel to actually boot. At least the irqchip driver has not passed
> > review because it uses a nonstandard way to integrate into ACPI, and
> > the PCI stuff may or may not be ready but has no Reviewed-by or
> > Acked-by tags from the maintainers. I clearly don't want to bypass
> > the subsystem maintainers on those drivers by sending a pull request
> > for the current branch.
>
> It seems that there is now a new contributor on the irqchip front, and
> the current approach *should* be better than the "copy MIPS and run"
> approach that was previously taken. I'm still to find time to review
> the new series (I just came back from a week off), but hopefully next
> week.
>
> > My feeling is that there is also no point in merging a port without
> > the drivers as it cannot work on any hardware. On the other hand,
> > the libc submissions (glibc and musl) are currently blocked while
> > they are waiting for the kernel port to get merged.
>
> I'd tend to agree. But if on the other hand the userspace ABI is
> clearly defined, I think it could make sense to go for it (if I
> remember well, we merged arm64 without any support irqchip support,
> and the arm64 GIC support appeared later in the game).
(adding linux-pci and linux-acpi maintainers to Cc)

Hi Bjorn and Rafael,

I'd like to confirm the review status of the respective LoongArch
patchsets ([1], [2]), to see if we can make it into this merge window.

Specifically:

I'd like to confirm with Bjorn, if the PCI patches are in a reasonable
shape and can get an Acked-by.

And Rafael: would you sync with the ACPICA repos to bring in the
LoongArch changes upstreamed there?

[1]: https://lore.kernel.org/linux-pci/20220430084846.3127041-1-chenhuacai@loongson.cn/T/#t
[2]: https://lore.kernel.org/linux-acpi/20220306111838.810959-1-chenhuacai@loongson.cn/T/#t

Thanks,
Huacai

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
