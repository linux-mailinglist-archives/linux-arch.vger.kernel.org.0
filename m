Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DFE5376AF
	for <lists+linux-arch@lfdr.de>; Mon, 30 May 2022 10:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiE3IV3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 May 2022 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiE3IVT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2022 04:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA06D19E;
        Mon, 30 May 2022 01:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 236D660E8E;
        Mon, 30 May 2022 08:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83626C3411E;
        Mon, 30 May 2022 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653898877;
        bh=6mZJiJbmBP5nIWsu49+CXVUX8jQfK+UvVFjRNgWXebw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XaoiQTO07UWKTKa7DvAu3E1TqyqCrZvDMjSawN2jqjs76oebLWXuHNyMMHpEHCuW2
         RWVc8AQkaQdSALmWN1qEnP0U8+tmhvdUUIDC3u1bZpg/H6AlLeWXqRxTX/vimIu5bw
         OXy7mEv0vYi2vsR/WO2VshcjWhH9onv5cq3HaCOzUDMYDdSqutECZxfI+ZI4FnTXlx
         PNqKIZPahp6AyssPmubpmLdigj+1u+H946fyAVrYADTUucMm/fFuIBWV9X6L1Zmr14
         QpLIbLZkXFgalB1GAGy3ay5uv7IuaVB4BOqOQrDUDblPJ+kvhE44AXYO5EfX0654Vb
         Oc99QbaK00vFw==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-30c1b401711so38155747b3.2;
        Mon, 30 May 2022 01:21:17 -0700 (PDT)
X-Gm-Message-State: AOAM530PAd9NbmwcjyGNwsNsNXlbx4pNk0C7Y1eP7B/M3yqeHOIbnB71
        KAYKCayUz6DR6nrKuQd/NV4ac5wnAgu2nGBnXLk=
X-Google-Smtp-Source: ABdhPJwtYtcRJBvW0OhdeYiTGlxOaw+f4fu0VS7H8dnFKjbyUOJjLxz2DuwfUfrH0XZz0QtT75LFMu05vESNYppoiso=
X-Received: by 2002:a81:488c:0:b0:302:549f:ffbc with SMTP id
 v134-20020a81488c000000b00302549fffbcmr21167071ywa.495.1653898876538; Mon, 30
 May 2022 01:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com> <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name>
In-Reply-To: <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 30 May 2022 10:20:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
Message-ID: <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic changes for 5.19
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        libc-alpha@sourceware.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        musl@lists.openwall.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-acpi@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        linux-pci@vger.kernel.org, ardb@kernel.org,
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

On Sun, May 29, 2022 at 3:10 PM WANG Xuerui <kernel@xen0n.name> wrote:
> But what for the users and downstream projects? Do the users owning
> LoongArch hardware (me included) and projects/companies porting their
> offerings have to pay for Loongson's mistakes and wait another [2mo,
> 1yr], "ideally" also missing the glibc 2.36 release too?
...
> Lastly, I'd like to clarify, that this is by no means a
> passive-aggressive statement to make the community look like "the bad
> guy", or to make Loongson "look bad"; I just intend to provide a
> hopefully fresh perspective from a/an {end user, hobbyist kernel
> developer, distro developer, native Chinese speaker with a hopefully
> decent grasp of English}'s view.

Your feedback has been extremely valuable, as always. I definitely
don't want to hold up merging the port for the glibc-2.36 release. If
that is a risk, and if merging the architecture port without the drivers
helps with that, I agree we should just do that. This will also help
with build testing and any treewide changes that are going to be
done on top of v5.19-rc1.

For the continuous maintenance, would you be available as an
additional Reviewer or co-maintainer to be listed in the maintainers
file? I think in general it is a good idea to have at least one maintainer
that is not directly part of the organization that owns the product,
and you are clearly the best person outside of loongson technology
for this.

Regarding the irqchip driver, merging those is entirely up to Marc and
Thomas. Marc already brought up the precedent of merging arch/arm64
without the required irqchip driver support, and if it turns out that he
find the latest driver submission acceptable, that might still make it in
through the irqchip tree.

        Arnd
