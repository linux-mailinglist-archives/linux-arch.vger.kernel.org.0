Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5EB4A48AA
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 14:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359684AbiAaNvL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 08:51:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40002 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiAaNvL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 08:51:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C11612D4;
        Mon, 31 Jan 2022 13:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644FCC340EE;
        Mon, 31 Jan 2022 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643637070;
        bh=Zm6bqi0OhyogvNh7aVMw7s3EunV9nSGhxKYNcbdO5KQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VB1HtyLzdS8WyvTpKJiOpoPPxcoguxNbLzYv4abyqilCHSyogINouv1glvQJZFH4Q
         klN9Wf3wTM0XCcb+sbaTp/p8xQ3BGlv3yDFVAn7mISzfv+RJ6uwysKLrZqcIeuZsV0
         BafaHReeaiYXGCqOvoDbXH50/QdF/KmcOkwUxcC6z5s7S+ynuf4rtQHXbffR8BjGLb
         OitbrZLld31AnRz+oX2yFY1TO1RrEA5ZhTTBsfnzjWQo8vsm9Slf91RTtqGsq68Oz9
         hbWbewIN8h4nsorfwtz6FBkTHNk15L724FloIzYmecGANavOB6kIoQwYSRDlSCKONR
         zPKyniu/L1/aw==
Received: by mail-vs1-f44.google.com with SMTP id a19so11839475vsi.2;
        Mon, 31 Jan 2022 05:51:10 -0800 (PST)
X-Gm-Message-State: AOAM5330A0mXBUdcy4Y3G+5BgP2ej2DwUNFPV+d3Qv289jE2pfndtfD2
        PfSBnVOuYMiutKOz5WJYyxyt+FItoI2qMeWNa+0=
X-Google-Smtp-Source: ABdhPJz6ty+HfMaRNZhEmkeOc11XYS0No2YCxA7dV1DvlPk1ApPFjUS4E1RUl7Xx1jtPl3XXvKrXpTneiT3oAugpR68=
X-Received: by 2002:a67:e947:: with SMTP id p7mr7921986vso.59.1643637069468;
 Mon, 31 Jan 2022 05:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-17-guoren@kernel.org>
 <YffVZZg9GNcjgVdm@infradead.org>
In-Reply-To: <YffVZZg9GNcjgVdm@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 31 Jan 2022 21:50:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRXDotO1L1FMojQs6msrqvCzA782Pux8rg3AfZgA=y0ew@mail.gmail.com>
Message-ID: <CAJF2gTRXDotO1L1FMojQs6msrqvCzA782Pux8rg3AfZgA=y0ew@mail.gmail.com>
Subject: Re: [PATCH V4 16/17] riscv: compat: Add COMPAT Kbuild skeletal support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
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

On Mon, Jan 31, 2022 at 8:26 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Given that most rv64 implementations can't run in rv32 mode, what is the
> failure mode if someone tries it with the compat mode enabled?
A static linked simple hello_world could still run on a non-compat
support hardware. But most rv32 apps would meet different userspace
segment faults.

Current code would let the machine try the rv32 apps without detecting
whether hw support or not.


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
