Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F865370BD
	for <lists+linux-arch@lfdr.de>; Sun, 29 May 2022 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiE2LYu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 May 2022 07:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiE2LYt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 29 May 2022 07:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2CD9981F;
        Sun, 29 May 2022 04:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E917660CA0;
        Sun, 29 May 2022 11:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F532C3411A;
        Sun, 29 May 2022 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653823487;
        bh=n5imSYsxcraXvt9W67bQOaHduIFER9PH0V0anzdv7i0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wmt+ra0j8bhYh0DqTIzycS4sRl5tQYL8zLx/jZDRpuw2WDya0FepLi28p6T1b127R
         lXKVn6AkPvv1FVf4fUAQ6gvCtuhlNykalpzbs2OW92SjL+hmSgiFJWJc1KIVMpe6Tq
         2HjAZQe2GazJjtGVPdQ6nBK1X5D7mdN/vbE8huF+ZRW/TNS3oEl5BEykgfsTlKjim8
         a+WdS/EXdqxlcoYv8n3IQxq+XBVGs0GcyBVzvf6qCYfhZhGC7ACoMdrySt65rRioTb
         UBgL6l9ZVpjTwVu66N68+KU1m4TfX/wZ2ythyTZkIx6lrAv9MvyRpwi6Y+Rj7b2tGF
         eIQ+KOMeT8YjA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ff7b90e635so85230077b3.5;
        Sun, 29 May 2022 04:24:47 -0700 (PDT)
X-Gm-Message-State: AOAM532ErBSVpktHt3bOR8u3/KiGc0p0AJDh3q3vsyY98F1C+7/eRBF9
        gkOd3rgSjpNp9VphawnFUjSKmjKS7wmqkxXCn2w=
X-Google-Smtp-Source: ABdhPJz7nN74Pj/emKhtpgomvyBWhFE6NQmWO0sHsI5NyVpND4Z2zOw2Sb8Dy5BOO8CBxJYzBEx/NQUBKD+gj4xRsGc=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr53738568ywf.347.1653823486366; Sun, 29
 May 2022 04:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 29 May 2022 13:24:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
Message-ID: <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic changes for 5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, Marc Zyngier <maz@kernel.org>,
        libc-alpha@sourceware.org, musl@lists.openwall.com,
        ardb@kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
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

On Thu, May 26, 2022 at 5:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
> - A series to add a generic ticket spinlock that can be shared by most
>   architectures with a working cmpxchg or ll/sc type atomic, including
>   the conversion of riscv, csky and openrisc. This series is also a
>   prerequisite for the loongarch64 architecture port that will come as
>   a separate pull request.

An update on Loongarch: I was originally planning to  send Linus a
pull request with
the branch with the contents from

https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next

but I saw that this includes both the architecture code and some
device drivers (irqchip,
pci, acpi) that are essential for the kernel to actually boot. At
least the irqchip driver
has not passed review because it uses a nonstandard way to integrate into ACPI,
and the PCI stuff may or may not be ready but has no Reviewed-by or
Acked-by tags
from the maintainers. I clearly don't want to bypass the subsystem
maintainers on
those drivers by sending a pull request for the current branch.

My feeling is that there is also no point in merging a port without
the drivers as it cannot
work on any hardware. On the other hand, the libc submissions (glibc
and musl) are
currently blocked while they are waiting for the kernel port to get merged.

       Arnd
