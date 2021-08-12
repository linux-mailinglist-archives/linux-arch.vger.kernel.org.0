Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F011B3EA431
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 13:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhHLL7U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 07:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbhHLL7T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 07:59:19 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37CCC061765
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:58:54 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r72so7995485iod.6
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rd5PSxGyteQMZ/s4O9qcJO/Z8UKncgItM94FXPsqxLg=;
        b=uaG4JewrgYzPUlZA5w/2FQLNkgg6QLuybkdIzt674SCECu/ZGCUpA+hYz3VedKDNBd
         kCaCNft3/C98GvvqncHyrz976I9RTiLGfh49IUQoD7enSay5dqUYh2EEVbp1RswS1VP3
         yJbuEXpd9I68iNvxBzDnzJDolKafUvU8lCw0VkrEiv6ejTG6xMY1E2/4TWnlvbzI1Ebu
         6boJDtlZkp89NNpcB75rqImRWPq7pJtOQt1d4824Ue+jI/DGy3PxeLsmiEqsJgX/G9ue
         PTTs3V88/2La0cA/4pLfxoVem50acf5/NTj5E3rPP2aWKI/nGJbhVp2VYMGeXWhCPFIW
         hZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rd5PSxGyteQMZ/s4O9qcJO/Z8UKncgItM94FXPsqxLg=;
        b=cbY1CmqNbTNCdCjI9WFu12k7SaWUyztqBhfLJ5R8MEPRxK6QbaO0t0L96cmq5y36Lg
         YgQXU5w+6Urq7zVZZQQBE0rD9vngavL/GBmtAdPwJr9J4NQFqXL8tmkL2fHCXX4/VABP
         KFpjnYCDLNboxNiGq/z+fAmYrGEZ30w5EQpp9oiLG2L6FsmHBYAru62VhSKmTkhRlCB9
         u+GLKogKLec2pPL82UzKgTQa9O1aXacn77P3CnvNSp6R+VSzEzH+At3cKRVptRWNEvcT
         6zGddDH034x8sR00gB6MasqGKEW3vvMxNgvSUN3vc53Y2Oqd+HGqIxRYRKPPpUdZ7n3S
         f9rw==
X-Gm-Message-State: AOAM5311MovvNx6uZxndqzYpVDCOSy+LHJ5EVtot7BLTidqu8P8q2J/J
        cqWuqo6VfXC3Y37AXIoXzQbP7wTi0CDfgtu/Qqo=
X-Google-Smtp-Source: ABdhPJzVVs+kA22kt1/fuRSair836jsJVd+QxZoMtOMDiHqHabqt4UF25RARfgNV3wcvkypuUVMeSW2DEIEGHn76JXs=
X-Received: by 2002:a05:6638:14d:: with SMTP id y13mr3535695jao.78.1628769534358;
 Thu, 12 Aug 2021 04:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-20-chenhuacai@loongson.cn> <CAK8P3a2J+axpXoP_P+PApo90upUqn57=6_wY5RPZv6oNVV7oUA@mail.gmail.com>
In-Reply-To: <CAK8P3a2J+axpXoP_P+PApo90upUqn57=6_wY5RPZv6oNVV7oUA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 19:58:43 +0800
Message-ID: <CAAhV-H7y7z6HsxMYbzAmtjfEOHLcP2+emm__9ZjNoy2Hk2xjkw@mail.gmail.com>
Subject: Re: [PATCH 19/19] LoongArch: Add Loongson-3 default config file
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Tue, Jul 6, 2021 at 6:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> > +CONFIG_EMBEDDED=y
>
> You probably should not set this one.
>
> > +CONFIG_CAIF=y
>
> And almost certainly not this one.
>
> > +CONFIG_PCCARD=m
> > +CONFIG_YENTA=m
> > +CONFIG_RAPIDIO=y
> > +CONFIG_RAPIDIO_TSI721=y
>
> These seem unlikely as well. Can you confirm that you have both old-style
> PC-Card support and RAPIDIO support on your most common hardware?
>
> > +CONFIG_PARPORT=y
> > +CONFIG_PARPORT_PC=y
> > +CONFIG_PARPORT_SERIAL=y
> > +CONFIG_PARPORT_PC_FIFO=y
> > +CONFIG_PRINTER=m
>
> Is this an on-board PCI device you actually have?
> What do you connect to the PC parport? Most printers
> in the past 15 years only have USB or network connections.
>
> > +CONFIG_8139CP=m
> > +CONFIG_8139TOO=m
>
> Do you actually support legacy PCI slots?
>
> > +CONFIG_SERIAL_8250=y
> > +CONFIG_SERIAL_8250_CONSOLE=y
> > +CONFIG_SERIAL_8250_NR_UARTS=16
> > +CONFIG_SERIAL_8250_RUNTIME_UARTS=16
> > +CONFIG_SERIAL_8250_EXTENDED=y
> > +CONFIG_SERIAL_8250_MANY_PORTS=y
> > +CONFIG_SERIAL_8250_SHARE_IRQ=y
> > +CONFIG_SERIAL_8250_RSA=y
> > +CONFIG_SERIAL_OF_PLATFORM=y
>
> I don't see any device tree support in your patches, so I think the
> SERIAL_OF_PLATFORM is not needed.
>
> > +CONFIG_RAW_DRIVER=m
>
> This is gone now.
>
> > +CONFIG_INFINIBAND=m
>
> You don't seem to enable any infiniband host drivers, so the core
> layer can probably remain turned off
>
> > +CONFIG_RTC_CLASS=y
> > +CONFIG_RTC_DRV_EFI=y
> > +CONFIG_UIO=m
>
> same for UIO.
>
> > +CONFIG_EXT2_FS=y
> > +CONFIG_EXT2_FS_XATTR=y
> > +CONFIG_EXT2_FS_POSIX_ACL=y
> > +CONFIG_EXT2_FS_SECURITY=y
> > +CONFIG_EXT3_FS=y
> > +CONFIG_EXT3_FS_POSIX_ACL=y
> > +CONFIG_EXT3_FS_SECURITY=y
>
> I would generally recommend using EXT4 over EXT2 or EXT3
>
> > +CONFIG_FRAME_WARN=1024
>
> On 64-bit platforms, you probably want to increase this a bit,
> otherwise you get extra warnings about code that works as
> intended. The default is 2048, but you should be able to get by
> with 1280, if that lets you build a defconfig kernel without warnings.
Most of your suggestions here will be accepted, but PARPORT and PCMCIA
will be keeped, we use some legacy devices with superio.

Huacai
>
>
>       Arnd
