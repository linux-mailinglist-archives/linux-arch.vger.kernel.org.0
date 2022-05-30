Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1E95376CC
	for <lists+linux-arch@lfdr.de>; Mon, 30 May 2022 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiE3IhL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 May 2022 04:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiE3IhK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2022 04:37:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F3412AFB;
        Mon, 30 May 2022 01:37:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AE2D60F2D;
        Mon, 30 May 2022 08:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E2AC341C8;
        Mon, 30 May 2022 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653899824;
        bh=joaNwl2fglJBNL3HOsZi03uJqqPgjSPdmOy8fc9Csbs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iI4m4dIr/FEIkPPpu9FdnrrNSbIBYVhvxduTEeSlAV9jqA9sz2TH+uqGybCOrT1fu
         u2PrMAL6/d/JHj6Km6epM6iSoAun5OL9b/H2VsbcvXSS3VkhV/ETiyA5i3QtLQGNr0
         3Jtc3FOygZDxkY4p6IFkBaCIGNqwUEeZk5+Cp458X070B/Lk180yRxPf3+52q1k39j
         dYpCE5+YrtMY4gcCSbEb/YTgPi30ewDdQ//lcP2Rvo7OujYcIl2IMO4Wn3DkLs4qTL
         nvy0A5O2MHDjwIS45FXemOYJe97196JcxPnZ4rwGfDA9UbGce6f4c4itJw7QbS9GaE
         ewIn3D1qpGd6g==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ff90e0937aso102036907b3.4;
        Mon, 30 May 2022 01:37:04 -0700 (PDT)
X-Gm-Message-State: AOAM532IIyWjZZp7xByQRKFvEh9ex9pB5MAS/on/b3A8NJlTRiy/M1Ou
        Nl1P6UII6j1F6zKJBQMHbnqbvrcDw5Wm5eXTLr4=
X-Google-Smtp-Source: ABdhPJw8WweVAyA25Gq4dNf35mk0GYgpbsvXPpTIBf1QNFJB7VQoktGvUZiRkWA77LZQ+jp6sCFNhFuRdf+fx5DDzq0=
X-Received: by 2002:a0d:efc2:0:b0:2fe:d2b7:da8 with SMTP id
 y185-20020a0defc2000000b002fed2b70da8mr54769437ywe.42.1653899823455; Mon, 30
 May 2022 01:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <875ylomq3m.wl-maz@kernel.org> <CAAhV-H4icDqABQiT4ckKdsmfVzqBKjxncDt9649c2ijOD093gw@mail.gmail.com>
In-Reply-To: <CAAhV-H4icDqABQiT4ckKdsmfVzqBKjxncDt9649c2ijOD093gw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 30 May 2022 10:36:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0aQO2rOVD0F6w811z6ooeGcmLd4UkpPK7dX_SGGy7WDw@mail.gmail.com>
Message-ID: <CAK8P3a0aQO2rOVD0F6w811z6ooeGcmLd4UkpPK7dX_SGGy7WDw@mail.gmail.com>
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
To:     musl@lists.openwall.com
Cc:     Marc Zyngier <maz@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, libc-alpha@sourceware.org,
        Ard Biesheuvel <ardb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
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

On Mon, May 30, 2022 at 8:28 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Sun, May 29, 2022 at 9:21 PM Marc Zyngier <maz@kernel.org> wrote:
> > On Sun, 29 May 2022 12:24:29 +0100, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > I'd tend to agree. But if on the other hand the userspace ABI is
> > clearly defined, I think it could make sense to go for it (if I
> > remember well, we merged arm64 without any support irqchip support,
> > and the arm64 GIC support appeared later in the game).
> (adding linux-pci and linux-acpi maintainers to Cc)
>
> I'd like to confirm the review status of the respective LoongArch
> patchsets ([1], [2]), to see if we can make it into this merge window.

In the meantime, can you rebase the tree once more to split out the
driver patches and make sure the architecture port without the drivers
still builds cleanly (at least defconfig and allmodconfig) using the compiler
from [1]? If this requires additional patches, please add them on top.

Once that is done, we can ask Linus to consider merging the branch
for the architecture port, while you keep working with the pci and irqchip
maintainers to merge the drivers either for 5.19 or a future release.

While this means merging a branch that does not actually work on any
hardware by itself, it should be sufficient for the libc patches to
consider the ABI stable, and it is consistent with how we keep
CPU architecture support separate from platform driver support
elsewhere.

       Arnd

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/12.1.0/x86_64-gcc-12.1.0-nolibc-loongarch64-linux.tar.xz
