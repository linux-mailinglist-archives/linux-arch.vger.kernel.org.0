Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975B839D77F
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 10:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFGIhy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 04:37:54 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:40713 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGIhy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 04:37:54 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 1578a1M4075208
        for <linux-arch@vger.kernel.org>; Mon, 7 Jun 2021 11:36:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623054956; x=1625646956;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U2J+Ype/9wfTlT1A3imO+PgEUuLf+/IqrknC2YO9Ouw=;
        b=bG9eFawA/MiBh1Ajgsjq8Jb319A0IeZOVL7YWEF+8upJj7Op3XKkQiR6LUOOYFeV
        pzz2evNRRJ4oXxegB4le1VP+rDitLomkFYl8tZ3m4WOd5+9DUBfR5Kd2Ez4A9wax
        DyPndqwcmtdP/b3WUT055Z2UscW58fs7smtY+GwGsnsIrYNKGcJMCLxKMzBCUU7k
        rHestxfq3/fEtn+o3KpY1gQ97Igkvt8gq5pvQttpLsB5f3cgrB0h9J9RdPOeMRmr
        O9FZSATzQzZF4Aepjn0sW7FM0tsqHW//ykdK4b4gI27+/WnJi0q22JTq2lpSB6Y8
        hOCec2Kz+PIKGrxqoPr4bg==;
X-AuditID: 8b5b014d-962f1700000067b6-37-60bdda6c6f6f
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 52.7F.26550.C6ADDB06; Mon,  7 Jun 2021 11:35:56 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 07 Jun 2021 11:35:55 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Guo Ren <guoren@kernel.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Christoph Hellwig <hch@lst.de>,
        Drew Fustini <drew@beagleboard.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        =?UTF-8?Q?Wei_Wu_?= =?UTF-8?Q?=28=E5=90=B4=E4=BC=9F=29?= 
        <lazyparser@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Organization: FORTH
In-Reply-To: <CAJF2gTQuQ5bE6HeGSoNaDynA0o3+KEo4snwft42YGzE=+DjKOQ@mail.gmail.com>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de>
 <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
 <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
 <CAJF2gTTpSbNWS4VLHAu4XsV5-Vos=6R9MmPOx8-yzMFJu=wX4A@mail.gmail.com>
 <a8f2e68dcc1a6eb1ff3b95fcb8d0d0d2@mailhost.ics.forth.gr>
 <CAJF2gTQuQ5bE6HeGSoNaDynA0o3+KEo4snwft42YGzE=+DjKOQ@mail.gmail.com>
Message-ID: <7347df23102503c77c5da10b48afcf9a@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXSHT1dWTfn1t4Eg2k3ZCyefJjIZnFvxTJ2
        ixd7G1ksjj/axWKxcvVRJotLX66xWHTs+spicXnXHDaLbZ9b2Cym7NvFZnHx13xGi+Z359gt
        tm5cx2jRNovfYtbi2+wW99edY7No2T+FxUHQ493vZYwe994+YfLYOesuu8eCTaUeDzddYvLY
        tKqTzWPnQ0uPX9uPMnlsXlLv8WLzTEaP3Tcb2Dze77vK5nGp+Tq7x+dNch7tB7qZAvijuGxS
        UnMyy1KL9O0SuDIevN7MXLCCr2LDk7usDYzruLsYOTkkBEwken4fYOxi5OIQEjjGKPF26kEW
        iISpxOy9nYwgNq+AoMTJmU/A4swCFhJTr+xnhLDlJZq3zmYGsVkEVCW27twOVsMmoCkx/xLE
        HBGgmt9HO1kh6j+zSvQ/4AWxhQVsJA5dWQ8W5xcQlvh09yKYzSkQKDFlyh92iIO2skg0HnrL
        BHGEi8S9Y5tYIY5Tkfjw+wFQEQeHKJC9ea7SBEbBWUhOnYXk1FlITl3AyLyKUSCxzFgvM7lY
        Ly2/qCRDL71oEyM4Zhl9dzDe3vxW7xAjEwfjIUYJDmYlEV4vmT0JQrwpiZVVqUX58UWlOanF
        hxilOViUxHl59SbECwmkJ5akZqemFqQWwWSZODilGpgM/5z/5q9dvOFa98sH4Voitq6Rgt8c
        v+z+EP/fZIswT8CPr6cL9zy+ItomO2HHdAt/1gKzIHOWb1ZR5glfUxNl/rXeChYS8ufz9TTb
        t/DJ7/VTw9oE3vWcsH7PaP3lyy6ru/xX3Lh5LHeZrSx2UVv+bN2iunVJfV8fdlvP2LtF7yBX
        2zP1xJj3wt0WU5inf11g6KNs+4Tb+epUx6qLW3/LHRU/+n3uHqHct7LX/oqv7rn2q7isZqIG
        c17cGbmPBU+nv5TYm/btnU/u/jOHezfGakt8DDlYufaK8+4Hf89Nmf38xol3/pM31UQlP/Y7
        Pyco/oZ4tZLPsYP/3PY90yheOH+l8fTs09PLz/Hd+FFyUImlOCPRUIu5qDgRABsgYjJIAwAA
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Στις 2021-06-07 06:19, Guo Ren έγραψε:
>> The C-bit was recently dropped, there is a new proposal for Page Based
>> Memory Attributes (PBMT) that we can work on / push for.
> C-bit still needs discussion, we shouldn't drop it directly.
> 

You can always participate on the discussion on virtmem mailing list.

> Raise a page fault won't solve anything. We still need access to the
> page with proper performance.
> 

The point is that future hw implementations will be required to return a 
page fault in case we tamper with those reserved bits, they won't just 
ignore them. Supporting custom values there means supporting 
non-compliant implementations.

> 
> We need PTEs to provide a non-coherency solution, and only CMO
> instructions are not enough. We can't modify so many Linux drivers to
> fit it.
> From Linux non-coherency view, we need:
>  - Non-cache + Strong Order PTE attributes to deal with drivers' DMA 
> descriptors
>  - Non-cache + weak order to deal with framebuffer drivers
>  - CMO dma_sync to sync cache with DMA devices
>  - Userspace icache_sync solution, which prevents calls to S-mode with
> IPI fence.i. (Necessary to JIT java scenarios.)
> 
> All above are not in spec, but the real chips are done.
> (Actually, these have been talked about for more than five years, we
> still haven't the uniform idea.)
> 
> The idea of C-bit is really important for us which prevents our chips
> violates the spec.

Have you checked the PBMT proposal ? It defines (so far) the following 
attributes that can be set on PTEs to override the PMAs of the 
underlying physical memory:

Bits [62:61]
00 (WB) -> Cacheable, default ordering
01 (NC) -> Noncacheable, default ordering
10 (IO) -> Noncacheable, strong ordering

So it'll cover the use cases you mention.
