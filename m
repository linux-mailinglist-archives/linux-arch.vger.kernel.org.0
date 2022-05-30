Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826115385C2
	for <lists+linux-arch@lfdr.de>; Mon, 30 May 2022 18:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiE3QBI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 May 2022 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243044AbiE3QAf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2022 12:00:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2C526AD4;
        Mon, 30 May 2022 08:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E407B80E2E;
        Mon, 30 May 2022 15:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FBDC341C5;
        Mon, 30 May 2022 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653926162;
        bh=vZNOahuquc61LYGJE+zDOh1Tfc1eF8K3ftYrqLR3Jlg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dgYj/Yzu6xQgvbDr+aTMPj3JC11vuXrprxRvhYSLFKVR2F8er+ja/ylKcZNMSUjkT
         WGMwvpDTgm8oxIMmajdhHZfNdq8Wm9Bi7f9UP9icxcb6p6BvkjZZIwu+kLGCiKbXZd
         39HUgv2IbaKQ1xEbQG9jYq0t18S9YjJKZGMtS7q80RHTpBZ1ZIm5oGDK7FiufTCUr/
         U3+enbtWDaCLOR8mx60jcCGOXkqTnSOfG0Po2CrZysqy1vXk7emgiIsopVywnfNwnl
         fDEDzpuI4HVb4MMGALQW4bQRnPTk1+1hSmuGQ5xhW1ulVyCcy9FnGjXTY7D+7fXsPc
         IuUCHkGo1VgWw==
Received: by mail-yb1-f181.google.com with SMTP id p13so8111378ybm.1;
        Mon, 30 May 2022 08:56:02 -0700 (PDT)
X-Gm-Message-State: AOAM530imDYHVcD/QI/7M9b+VMF2w1U3ti959Q5LTQVXhWPhavEKL2As
        tzyfJEKXKVj4El0JsgLEgXIuN1M7jxrdQJpso0U=
X-Google-Smtp-Source: ABdhPJw8YN2D7OioGQU3VBmoUMbh0gioLp3yRY1XdaTroJXM/gLDD3ji8AXoRaouQ2fK2WQ4/43SP4bwYsUoMcacvmc=
X-Received: by 2002:a25:4f0a:0:b0:64f:6a76:3d8f with SMTP id
 d10-20020a254f0a000000b0064f6a763d8fmr43939287ybb.134.1653926161185; Mon, 30
 May 2022 08:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name> <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
 <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com> <358025d1-28e6-708b-d23d-3f22ae12a800@xen0n.name>
In-Reply-To: <358025d1-28e6-708b-d23d-3f22ae12a800@xen0n.name>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 30 May 2022 17:55:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1ge2bZS13ahm_LdO3jEcbtR4w3do-gLjggKvppqnBDkw@mail.gmail.com>
Message-ID: <CAK8P3a1ge2bZS13ahm_LdO3jEcbtR4w3do-gLjggKvppqnBDkw@mail.gmail.com>
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
To:     musl@lists.openwall.com
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
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

On Mon, May 30, 2022 at 5:00 PM WANG Xuerui <kernel@xen0n.name> wrote:
> On 5/30/22 21:01, Huacai Chen wrote:
>
> Thanks for the recognition from both of you; it is my honor and pleasure
> to contribute to the LoongArch port and to Linux in general.
>
> As I'm still not entirely satisfied with my kernel development skills,
> plus my day job is not kernel-related nor Loongson/LoongArch-related at
> all, listing me as reviewer should be enough for now. I will take care
> of the arch as long as I have the hardware.

Thanks, sounds good to me.

> BTW, there were already several breakages when rebasing the previous
> revision (I believe it's commit 215da6d2dac0 ("MAINTAINERS: Add
> maintainer information for LoongArch")) on top of linus' tree.

Right, at least most of these should be fairly easy to address by disabling
the corresponding features. For the allmodconfig build, I see some
warnings that are introduced in gcc-12.1 across all architectures, and
those can be ignored for now.

Some of the errors already have fixes on top of the 215da6d2dac0
commit, but some of the other commits look like we should leave
them out here.

I also see some conflicts between local symbol definitions and device
drivers such as

arch/loongarch/include/asm/loongarch.h:240:29: note: previous
definition of 'csr_writel' with type 'void(u32,  u32)' {aka
'void(unsigned int,  unsigned int)'}
  240 | static __always_inline void csr_writel(u32 val, u32 reg)
      |                             ^~~~~~~~~~
drivers/media/platform/amphion/vpu_core.h:10:5: error: conflicting
types for 'csr_readl'; have 'u32(struct vpu_core *, u32)' {aka
'unsigned int(struct vpu_core *, unsigned int)'}

and

drivers/usb/cdns3/cdns3-imx.c:85: error: "PS_MASK" redefined [-Werror]

I would suggest renaming the loongarch specific symbols here, though we
may want to also change those drivers to use less generic identifiers.

> Now I see
> the loongarch-next HEAD is already rebased on top of what I believe to
> be the current main branch, however I vaguely remember that it's not
> good to base one's patches on top of "some random commit", so I wonder
> whether the current branch state is appropriate for a PR?

You are correct, a pull request should always be based on an -rc, orat least
have the minimum set of dependencies. The branch was previously
based on top of the spinlock implementation, which is still the best
place to start here.

       Arnd
