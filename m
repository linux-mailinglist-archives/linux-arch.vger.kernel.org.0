Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615A34A5805
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 08:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiBAHpC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 02:45:02 -0500
Received: from verein.lst.de ([213.95.11.211]:57800 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbiBAHpC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Feb 2022 02:45:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C0AE68AA6; Tue,  1 Feb 2022 08:44:57 +0100 (CET)
Date:   Tue, 1 Feb 2022 08:44:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
        the arch/x86 maintainers <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V4 16/17] riscv: compat: Add COMPAT Kbuild skeletal
 support
Message-ID: <20220201074457.GC29119@lst.de>
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-17-guoren@kernel.org> <YffVZZg9GNcjgVdm@infradead.org> <CAJF2gTRXDotO1L1FMojQs6msrqvCzA782Pux8rg3AfZgA=y0ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRXDotO1L1FMojQs6msrqvCzA782Pux8rg3AfZgA=y0ew@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 31, 2022 at 09:50:58PM +0800, Guo Ren wrote:
> On Mon, Jan 31, 2022 at 8:26 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Given that most rv64 implementations can't run in rv32 mode, what is the
> > failure mode if someone tries it with the compat mode enabled?
> A static linked simple hello_world could still run on a non-compat
> support hardware. But most rv32 apps would meet different userspace
> segment faults.
> 
> Current code would let the machine try the rv32 apps without detecting
> whether hw support or not.

Hmm, we probably want some kind of check for not even offer running
rv32 binaries.  I guess trying to write UXL some time during early
boot and catching the resulting exception would be the way to go?

> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
---end quoted text---
