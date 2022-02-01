Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67364A58FE
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 10:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiBAJNw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 04:13:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53872 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiBAJNw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 04:13:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F288B82D23;
        Tue,  1 Feb 2022 09:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E1CC340F3;
        Tue,  1 Feb 2022 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643706829;
        bh=hnac9oX2VXGbCvTtbNqKOCdN7oRwr6SWdV4YiEu9kyM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C3jBCI/ixEWgjooyWZg0Pf2gLBAsWdYC5KQtZyJSy1bZaxpdqnqmZV2mLvS2b1IFc
         ynbOpC5QIxeUjflPA3k50UNxGFgTQoueb8H6IcVSH4QOMcFXtHnzhO6sX44zxCdvIN
         HwR1s0XWWFi+/c6gZbeyxVhey/XzQMNLmct/O0fM3zr53GHtf+E/aqGlthTlcrsyo5
         083sI15A7w/gOmRl6iM3BFpIS67oz9XP33+endaam6lx52zO3Vy08Ow2PDfM/R/KDT
         0hJa2m3h6TyU8/xhk/Ehpn6Ldkyugyv7t3+o+ZgnGtUgC+abBE49frlN5zhRV2SQUk
         1J5pf/YToKspA==
Received: by mail-vk1-f176.google.com with SMTP id y192so9993943vkc.8;
        Tue, 01 Feb 2022 01:13:48 -0800 (PST)
X-Gm-Message-State: AOAM532LncX1C+HJY/gE+ew+hpSD2cyvyEZ3wv7Pm3tEXru0ZyWq3T16
        vRwWxgA+zWT1SiR9vlICd+0ode4PYGpaJiNQ0xw=
X-Google-Smtp-Source: ABdhPJz8fzguZPbFnae5j7V9pl/dv5oQGM4hOb4aA5V9NpHM4cr9OW86mUtht2VbhtSN0zWJb+F+yH9GTu4P2KsI3X0=
X-Received: by 2002:a05:6122:1c5:: with SMTP id h5mr9895590vko.2.1643706827991;
 Tue, 01 Feb 2022 01:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-17-guoren@kernel.org>
 <YffVZZg9GNcjgVdm@infradead.org> <CAJF2gTRXDotO1L1FMojQs6msrqvCzA782Pux8rg3AfZgA=y0ew@mail.gmail.com>
 <20220201074457.GC29119@lst.de>
In-Reply-To: <20220201074457.GC29119@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Feb 2022 17:13:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTc=zwD__zXwYbO8vmup5evWJtzyiAF9Pm-UVHLJRc5hQ@mail.gmail.com>
Message-ID: <CAJF2gTTc=zwD__zXwYbO8vmup5evWJtzyiAF9Pm-UVHLJRc5hQ@mail.gmail.com>
Subject: Re: [PATCH V4 16/17] riscv: compat: Add COMPAT Kbuild skeletal support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
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

On Tue, Feb 1, 2022 at 3:45 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jan 31, 2022 at 09:50:58PM +0800, Guo Ren wrote:
> > On Mon, Jan 31, 2022 at 8:26 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > Given that most rv64 implementations can't run in rv32 mode, what is the
> > > failure mode if someone tries it with the compat mode enabled?
> > A static linked simple hello_world could still run on a non-compat
> > support hardware. But most rv32 apps would meet different userspace
> > segment faults.
> >
> > Current code would let the machine try the rv32 apps without detecting
> > whether hw support or not.
>
> Hmm, we probably want some kind of check for not even offer running
> rv32 binaries.  I guess trying to write UXL some time during early
> boot and catching the resulting exception would be the way to go?

Emm... I think it's unnecessary. Free rv32 app running won't cause
system problem, just as a wrong elf running. They are U-mode
privileged.
>
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
> ---end quoted text---



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
