Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C5B39D061
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 20:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFFSQ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 14:16:27 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:57726 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFFSQ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 14:16:27 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 156IEZrl052682
        for <linux-arch@vger.kernel.org>; Sun, 6 Jun 2021 21:14:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623003270; x=1625595270;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=npEuPgoCmYcLXuGAj3lk3Z8Qz7Q4T7SBKRpOBm5UgpU=;
        b=hHDfDtMKpOyRtSkZhq7xBlnJ04RmBqARosUatJPpiYEEAzkTDz1/XCIEtmvaKA2H
        daXiSsGxxQHvUqI8eom59MU6ie0qGSaGBwLNtNm1B791BSOh5ZYYDoNjNRrVJh1w
        zGcZkeCFcE44viI0P1K0UjoF2LFnUgiFsRgdLXVL54xUxenQC+d6wNaXB2aBZ6oJ
        cChED7Low7gW8a8BEwjJxbKbqatGFFSxC/Zuk6C1LBZgC0amSvQsvocRGyVjX6Gp
        T3vfxsBf3pR3EtsL74RYViiMqz1ybhsQJM/M4gMqT9TneJcaHArVYCC1ZJrvZ/7Z
        iS5aqRjvzHkdA5Fx7bSqNw==;
X-AuditID: 8b5b014d-96ef2700000067b6-54-60bd108627a9
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 53.4A.26550.6801DB06; Sun,  6 Jun 2021 21:14:30 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 06 Jun 2021 21:14:28 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Drew Fustini <drew@beagleboard.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Organization: FORTH
In-Reply-To: <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de>
 <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
Message-ID: <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXSHT1dWbdNYG+CwbZz2hZPPkxks7i3Yhm7
        xYu9jSwWxx/tYrFYufook8WlL9dYLDp2fWWxuLxrDpvFts8tbBZT9u1is7j4az6jRfO7c+wW
        WzeuY7Rom8VvMWvxbXaL++vOsVm07J/C4iDo8e73MkaPe2+fMHnsnHWX3WPBplKPh5suMXls
        WtXJ5rHzoaXHr+1HmTw2L6n3eLF5JqPH7psNbB7v911l87jUfJ3d4/MmOY/2A91MAfxRXDYp
        qTmZZalF+nYJXBlrFu5mKejkqdj+4xtbA+Ntzi5GTg4JAROJ2xs2MnUxcnEICRxjlOhseskG
        kTCVmL23kxHE5hUQlDg58wkLiM0sYCEx9cp+RghbXqJ562xmEJtFQFVi1r9JTCA2m4CmxPxL
        B8HqRYBqfh/tZIWoX80q8fpdGIgtLGAjcejKerA4v4CwxKe7F8FsToFAiddTpjFDHLSRSeLJ
        pN3MEEe4SNy+spgR4jgViQ+/H7B3MXJwiALZm+cqTWAUnIXk1FlITp2F5NQFjMyrGAUSy4z1
        MpOL9dLyi0oy9NKLNjGCY5bRdwfj7c1v9Q4xMnEwHmKU4GBWEuH1ktmTIMSbklhZlVqUH19U
        mpNafIhRmoNFSZyXV29CvJBAemJJanZqakFqEUyWiYNTqoFpG4fN0ocMwZzHjpt3dH+Oni5Z
        Jp2zljU7XeLuS966xVtu5/cvmrI2+OHaiX8qnNcumsxw4tkUA7+EGV2x8a2bRbMSfP7m/DTc
        FDTniM2PhH3bpVceX7z/1cPLSfzfuV7wX1rupSGR78T0UuLeI2GxJIuWI9r51zqf5M2I7ply
        6aR/4NtU4UcC3oW7+9KPhpf9m1bI4lhhapt00coxfsG2wjXSDnfLEr4XqZrMuVbiFsti4P+0
        vSdzzzO1GYtfMrbFqXjNevAvt+rHxF8nj/U9uVPzb9tqlbOTpaR+WbH93P32e43mjq+PnZM3
        z34hpRiZfv2uF79EEUvpo09sCXHcPkcz+JLf7QndFLY5YDOvEktxRqKhFnNRcSIARuBeSEgD
        AAA=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Στις 2021-05-20 04:45, Guo Ren έγραψε:
> On Wed, May 19, 2021 at 2:53 PM Christoph Hellwig <hch@lst.de> wrote:
>> 
>> On Tue, May 18, 2021 at 11:44:35PM -0700, Drew Fustini wrote:
>> > This patch series looks like it might be useful for the StarFive JH7100
>> > [1] [2] too as it has peripherals on a non-coherent interconnect. GMAC,
>> > USB and SDIO require that the L2 cache must be manually flushed after
>> > DMA operations if the data is intended to be shared with U74 cores [2].
>> 
>> Not too much, given that the SiFive lineage CPUs have an uncached
>> window, that is a totally different way to allocate uncached memory.
> It's a very big MIPS smell. What's the attribute of the uncached
> window? (uncached + strong-order/ uncached + weak, most vendors still
> use AXI interconnect, how to deal with a bufferable attribute?) In
> fact, customers' drivers use different ways to deal with DMA memory in
> non-coherent SOC. Most riscv SOC vendors are from ARM, so giving them
> the same way in DMA memory is a smart choice. So using PTE attributes
> is more suitable.
> 
> See:
> https://github.com/riscv/virtual-memory/blob/main/specs/611-virtual-memory-diff.pdf
> 4.4.1
> The draft supports custom attribute bits in PTE.
> 

Not only it doesn't support custom attributes on PTEs:

"Bits63–54 are reserved for future standard use and must be zeroed by 
software for forward compatibility."

It also goes further to say that:

"if any of these bits are set, a page-fault exception is raised"
