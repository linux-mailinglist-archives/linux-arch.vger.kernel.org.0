Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5975B53770B
	for <lists+linux-arch@lfdr.de>; Mon, 30 May 2022 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiE3IYE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 May 2022 04:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiE3IYD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2022 04:24:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B702870932;
        Mon, 30 May 2022 01:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 723D8B80B8C;
        Mon, 30 May 2022 08:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03624C3411C;
        Mon, 30 May 2022 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653899039;
        bh=ziDIAEc7g+1E4mW3as6Ps9AEfz+2BHYsygKs8QcKuy4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dd1oX3NlmptzEvjI4JEG5Edx65zEfnF+Mpq2UcNPvScWXKuqvMvNq4VzIaK0fEUBv
         tulre+TE4nQFLsxbdio20l/juEyj0pUnTORe1r8Ba/32jcwwMdSencOBOWDs9mUKMF
         geQVmZWH7UY5oOMgr1ZfkioFz82L3PyTalGJoT/oNGPgbnmAK1/0YYPKthHJL0mcwH
         FUISxMK+YQU9sZrn2s1LCHDhB8uii7wU8JeC9SpJif4QlITccZYaMleN0lVk/mPDZU
         VDsk8ALgoBymJj0vNb4lYePxFLyaxQawhRgDcCr/34jVi3tcZOTDlFE4FFmJVHofMt
         Rcf22g9l4G1Dg==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ef5380669cso101518307b3.9;
        Mon, 30 May 2022 01:23:58 -0700 (PDT)
X-Gm-Message-State: AOAM531+ICClQvaVBP6mIzd0yzbre+8lZ/2l2nOV82G5wzl8UzbYNMud
        Xe+QP5QG4pdbrL+uqUvXuw+1hk0Tk0WDDixPlXY=
X-Google-Smtp-Source: ABdhPJzv/FemciRjN1uYS9zyr/cVvRRBKH6md2A/ekgrEEK6qu8OC/IzKOMLVZP+1vKl3A1riaDtnOnDAsIMbwQ4ROY=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr58350303ywk.209.1653899038059; Mon, 30
 May 2022 01:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com> <875ylomq3m.wl-maz@kernel.org>
In-Reply-To: <875ylomq3m.wl-maz@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 30 May 2022 10:23:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0dcmeehX=ByKqFe_aa7=fJFjAfpCG6ch99BzK8N4FA2A@mail.gmail.com>
Message-ID: <CAK8P3a0dcmeehX=ByKqFe_aa7=fJFjAfpCG6ch99BzK8N4FA2A@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic changes for 5.19
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, libc-alpha@sourceware.org,
        musl@lists.openwall.com, ardb@kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
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

On Sun, May 29, 2022 at 3:21 PM Marc Zyngier <maz@kernel.org> wrote:
> > My feeling is that there is also no point in merging a port without
> > the drivers as it cannot work on any hardware. On the other hand,
> > the libc submissions (glibc and musl) are currently blocked while
> > they are waiting for the kernel port to get merged.
>
> I'd tend to agree. But if on the other hand the userspace ABI is
> clearly defined, I think it could make sense to go for it (if I
> remember well, we merged arm64 without any support irqchip support,
> and the arm64 GIC support appeared later in the game).

Ok, thanks for taking another look. I think we should just merge the
port without the drivers then, and you can make a decision on
the irqchip drivers after you've reviewed the latest version.

      Arnd
