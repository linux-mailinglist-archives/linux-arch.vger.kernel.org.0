Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF122537AF0
	for <lists+linux-arch@lfdr.de>; Mon, 30 May 2022 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiE3NBq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 May 2022 09:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiE3NBn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2022 09:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A885F94;
        Mon, 30 May 2022 06:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 333C060DD8;
        Mon, 30 May 2022 13:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9256DC3411F;
        Mon, 30 May 2022 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653915698;
        bh=P31uo602B0Lw3sp32uTNYyaSbPsuU19TeHSt9/MJjyI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fAaR0zTawFiHbHpKN5pzKPk+m99MGmCVzLz5sm2Oe043iPI2mRlzm19OnVfUGJQ+q
         hjxqRzlOaEDqfGDhQFcQEOhENj41lCAx82me6SDWpaH0BBVWcSrZWGtRvkaSIE5PsN
         Nta3N/ZMKjhueE68+BCp74+MUB3+Sz/0D9vicpRX8np6E/nv1P/fZIntobbe62/bDz
         GNMqfnu6OgS2CZ3bQ4/+OEayxmysUqlvUSLHvrfIhkzGcB0M/om5Av6hWX0OM+DGWw
         O91gx/9RQjXjm5n+F1tpfSNGqXhMI8NvX3nxxE9zXgNjd0Ux8Ig3YntNQcdmg3rBg7
         2lrCDG/rRUW7g==
Received: by mail-ua1-f54.google.com with SMTP id q1so3804844uao.1;
        Mon, 30 May 2022 06:01:38 -0700 (PDT)
X-Gm-Message-State: AOAM533s12IQrVDKYy3h8/CHc6vkZO6URorwOlORD3S/W1VULj8JazVN
        FKCduYhwEhwkXh/7OdAUTJ31rBapEyqeR36qEho=
X-Google-Smtp-Source: ABdhPJyhqQ9qgd1r5/qcNoED52QOHpIhyWBhd2usCvKUVn8AsyE5OajEl3nhKMAILqXIBpnc17BmTEG5fiUwQuc9EqE=
X-Received: by 2002:ab0:2bc9:0:b0:362:8750:8032 with SMTP id
 s9-20020ab02bc9000000b0036287508032mr19067906uar.118.1653915697481; Mon, 30
 May 2022 06:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name> <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 30 May 2022 21:01:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
Message-ID: <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic changes for 5.19
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        libc-alpha@sourceware.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        musl@lists.openwall.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
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

Hi, Arnd,

On Mon, May 30, 2022 at 4:21 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sun, May 29, 2022 at 3:10 PM WANG Xuerui <kernel@xen0n.name> wrote:
> > But what for the users and downstream projects? Do the users owning
> > LoongArch hardware (me included) and projects/companies porting their
> > offerings have to pay for Loongson's mistakes and wait another [2mo,
> > 1yr], "ideally" also missing the glibc 2.36 release too?
> ...
> > Lastly, I'd like to clarify, that this is by no means a
> > passive-aggressive statement to make the community look like "the bad
> > guy", or to make Loongson "look bad"; I just intend to provide a
> > hopefully fresh perspective from a/an {end user, hobbyist kernel
> > developer, distro developer, native Chinese speaker with a hopefully
> > decent grasp of English}'s view.
>
> Your feedback has been extremely valuable, as always. I definitely
> don't want to hold up merging the port for the glibc-2.36 release. If
> that is a risk, and if merging the architecture port without the drivers
> helps with that, I agree we should just do that. This will also help
> with build testing and any treewide changes that are going to be
> done on top of v5.19-rc1.
>
> For the continuous maintenance, would you be available as an
> additional Reviewer or co-maintainer to be listed in the maintainers
> file? I think in general it is a good idea to have at least one maintainer
> that is not directly part of the organization that owns the product,
> and you are clearly the best person outside of loongson technology
> for this.
Yes, Xuerui is very suitable as a Reviewer.

Huacai
>
> Regarding the irqchip driver, merging those is entirely up to Marc and
> Thomas. Marc already brought up the precedent of merging arch/arm64
> without the required irqchip driver support, and if it turns out that he
> find the latest driver submission acceptable, that might still make it in
> through the irqchip tree.
>
>         Arnd
