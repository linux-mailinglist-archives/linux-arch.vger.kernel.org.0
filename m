Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1204A370E
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355242AbiA3O5X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 09:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbiA3O5X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Jan 2022 09:57:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AE8C061714;
        Sun, 30 Jan 2022 06:57:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4710A61209;
        Sun, 30 Jan 2022 14:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD710C340F4;
        Sun, 30 Jan 2022 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643554641;
        bh=JxoHCxPtVM6TBwNWYVTkv4xgv4xXqSSrocAD8RhKPvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kos3V8Vk5hA0UEtlbCmKfvDbCn6hgvFJPW0hutP471S22DT8zQZjqZYl8oPtPERRN
         mHTKJGaAu0B69fJNmAFmItV05nnqnnpRKb/kYsBaVswrhiA3ecXak702UJ1xD+aRyO
         Cyu417cH+tx6RjZLY1F4C0+gldC8KeEtNsbWOyaylils+pWq32+O/qNqqF6K8vS+Qa
         DU2SBhQ6eWn63e/dlaU9XUJXP5eg51s3F1n6055BcvsAgOgE2YRIXu5gQZ14MzwtZF
         RJhpqwiYSrbL56M0Y1luR1ep1hIfdzFS7gAvAKX1Hfe2YnV2vSbhGb9SEapKZC8pBf
         gYvL1GNaKIrpg==
Received: by mail-vk1-f177.google.com with SMTP id 48so6819292vki.0;
        Sun, 30 Jan 2022 06:57:21 -0800 (PST)
X-Gm-Message-State: AOAM531SRkd//thuARO2vrWnSGybN+UPIiums/Svgjjbto+7QjfzP2Sp
        NGvD6y/C6qS73OI1JKaTS38670D5BDrYaFvVsh0=
X-Google-Smtp-Source: ABdhPJwXaD5cftVV1gTUpOLnxRw19SJ6xh2ZrT8jBGfIh39KXnRkloqQEHlrygYgN8HHE2HZ4UXsJQOHGX4lm9oymh8=
X-Received: by 2002:a05:6122:1c5:: with SMTP id h5mr6907805vko.2.1643554640709;
 Sun, 30 Jan 2022 06:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-9-guoren@kernel.org>
 <CAK8P3a3JGP6fLVOyLgdNw2YpRSmArbEX8orUhRrN=GHmcdk=1g@mail.gmail.com>
 <CAJF2gTQQnrUFNQ85vvoMkpxnCWuMw8iXtPZOJwWGaEA9f+rTwA@mail.gmail.com> <CAK8P3a12CygLFT7qoQ9K=sowvTgNpeRej6Zh6Pv2PL_e2zMhMQ@mail.gmail.com>
In-Reply-To: <CAK8P3a12CygLFT7qoQ9K=sowvTgNpeRej6Zh6Pv2PL_e2zMhMQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 Jan 2022 22:57:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSULHYYvAjfDvHiD-rJFsOy0-x58AKcD2upzpxaVf5sZQ@mail.gmail.com>
Message-ID: <CAJF2gTSULHYYvAjfDvHiD-rJFsOy0-x58AKcD2upzpxaVf5sZQ@mail.gmail.com>
Subject: Re: [PATCH V4 08/17] riscv: compat: syscall: Add compat_sys_call_table
 implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 30, 2022 at 7:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Jan 30, 2022 at 6:54 AM Guo Ren <guoren@kernel.org> wrote:
> > On Sun, Jan 30, 2022 at 6:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > I would make these endian-specific, and reverse them on big-endian
> > > architectures. That way it
> > > should be possible to share them across all compat architectures
> > > without needing the override
> > > option.
> > I hope it could be another patch. Because it's not clear to
> > _LITTLE_ENDIAN definition in archs.
> >
> > eg: Names could be __ORDER_LITTLE_ENDIAN__ CPU_LITTLE_ENDIAN
> > SYS_SUPPORTS_LITTLE_ENDIAN __LITTLE_ENDIAN
> >
> > riscv is little-endian, but no any LITTLE_ENDIAN definition.
> >
> > So let's keep them in the patch, first, Thx
>
> The correct way to do it is to check for CONFIG_CPU_BIG_ENDIAN,
> which works on all architectures. Since nothing else selects the
> __ARCH_WANT_COMPAT_* symbols, there is also no risk for
> regressions, so just use this and leave the #ifndef compat_arg_u64
> check in place.
Okay, got it.

>
>       Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
