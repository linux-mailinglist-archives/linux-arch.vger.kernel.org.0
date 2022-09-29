Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B611F5EEC05
	for <lists+linux-arch@lfdr.de>; Thu, 29 Sep 2022 04:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiI2ClJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 22:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbiI2Ckr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 22:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0C4A809;
        Wed, 28 Sep 2022 19:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AACF861BA6;
        Thu, 29 Sep 2022 02:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B9BC43140;
        Thu, 29 Sep 2022 02:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664419216;
        bh=pLPnFBMn5aCaXNkrU1u/KzK79Oy1dcjNZ2+U1bKrMgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KVOyBAAzMR80GebggwikOR8qNMbk2MEAjwjDP/M5CtEpbKZ+LC9mnOt3sMO3wp0b4
         gapiDnHtk0dbWHi6UZPfL4xvf2G4ztARgPt9nQ4ziSb2wc9B4tiA8qTzQxZYLu8bQf
         TjNHw9JdyU8P2HmoqIXrgg9Tft1l50iR804IEx7PLpX4cdYxCz+QG+Zhc9tz8NKsXu
         0Q2wJ4LTt93R6Ye5/krT7zNXi9TmYIZ4rum8soHPh4EYKoEKk4IGVxhYgGcqQsKeAQ
         AEBvt+wOoWGpR2k985ZGX3JLz9BNv8v7arI872B5rfoF7MK/FW6w0QyT5MSK7IcDUs
         3kY/l+Kt1FLSg==
Received: by mail-vk1-f171.google.com with SMTP id g27so7105vkl.3;
        Wed, 28 Sep 2022 19:40:16 -0700 (PDT)
X-Gm-Message-State: ACrzQf3fUhlcmENsG+eEffeeyn8UT0mUVzfuFxNc+3CPX38T/wQet7QU
        LKo2A60CxT/eCDDIYYgeUQbPk1x3PmjXZ/1ecPg=
X-Google-Smtp-Source: AMsMyM4yUlGXqcvcrqkovn9NEeTtr/L9xuEjuFVFB27HyEcPIqKB/SKh6K9tAikwhAeyWvnsYxd77RwQnLQcrSH+ft8=
X-Received: by 2002:a1f:60cf:0:b0:3a7:a632:3649 with SMTP id
 u198-20020a1f60cf000000b003a7a6323649mr387926vkb.12.1664419215017; Wed, 28
 Sep 2022 19:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220929023735.319481-1-chenhuacai@loongson.cn>
In-Reply-To: <20220929023735.319481-1-chenhuacai@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 29 Sep 2022 10:40:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6mp_LNqYp81iQ66i_nJfpcmMDqC-1JZoRoHDjxzJNGbg@mail.gmail.com>
Message-ID: <CAAhV-H6mp_LNqYp81iQ66i_nJfpcmMDqC-1JZoRoHDjxzJNGbg@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch fixes for v5.19-rc4
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I sent the wrong mail, please ignore this. Sorry.

Huacai

On Thu, Sep 29, 2022 at 10:38 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:
>
>   Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-3
>
> for you to fetch changes up to ea18d434781105ce61ff3ef7f74c9e51812f0580:
>
>   LoongArch: Make compute_return_era() return void (2022-06-25 18:06:07 +0800)
>
> ----------------------------------------------------------------
> LoongArch fixes for v5.19-rc4
>
> Some bug fixes and a trivial cleanup.
> ----------------------------------------------------------------
> Huacai Chen (4):
>       LoongArch: Fix the !THP build
>       LoongArch: Fix the _stext symbol address
>       LoongArch: Fix sleeping in atomic context in setup_tlb_handler()
>       LoongArch: Fix EENTRY/MERRENTRY setting in setup_tlb_handler()
>
> Tiezhu Yang (2):
>       LoongArch: Fix wrong fpu version
>       LoongArch: Make compute_return_era() return void
>
>  arch/loongarch/include/asm/branch.h  |  3 +--
>  arch/loongarch/include/asm/pgtable.h | 10 +++++-----
>  arch/loongarch/kernel/cpu-probe.c    |  2 +-
>  arch/loongarch/kernel/head.S         |  2 --
>  arch/loongarch/kernel/traps.c        |  3 +--
>  arch/loongarch/kernel/vmlinux.lds.S  |  1 +
>  arch/loongarch/mm/tlb.c              |  7 ++++---
>  7 files changed, 13 insertions(+), 15 deletions(-)
