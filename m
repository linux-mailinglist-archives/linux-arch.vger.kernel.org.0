Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D44A39D2D7
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 04:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFGCSd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 22:18:33 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:56545 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhFGCSd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 22:18:33 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 1572GfoZ061576
        for <linux-arch@vger.kernel.org>; Mon, 7 Jun 2021 05:16:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623032196; x=1625624196;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7+nGwPamCaq87hvoY8I/2It3nzp5ksOheQ6kJN1VYpI=;
        b=g0huyOMuZXFVoaT472uHkr9I43HoImJIsX6gS1eaNwm+W2XryaBiTe0WB5mn+9oY
        E1O9jOv345s67n5dBeknFFDyEa7EQCm9+MkupJg7qghwhE9Y5oxX78VAos0HXB3h
        hACLfl8UirfB5cMWySXD2Qw22YQ/phbxk+GsyU1ZyLUckU+LaOE/1aoDDrfv8Cz4
        xlpeL6ux75qctc1hX5Hx58evx18mQXSqdsfWkh/dpCcXZ7mzYT6Ycway/+NDaQTb
        qvE23idBtkXBfjZlEi2g9S+NVejqW4zTIDuphrgNDFHtow2okQymqMDvHT3mHKg+
        OVE15kXjyE+LNCP9Ni2wmQ==;
X-AuditID: 8b5b014d-962f1700000067b6-83-60bd81842d36
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 08.AB.26550.4818DB06; Mon,  7 Jun 2021 05:16:36 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 07 Jun 2021 05:16:35 +0300
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
In-Reply-To: <CAJF2gTTpSbNWS4VLHAu4XsV5-Vos=6R9MmPOx8-yzMFJu=wX4A@mail.gmail.com>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de>
 <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
 <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
 <CAJF2gTTpSbNWS4VLHAu4XsV5-Vos=6R9MmPOx8-yzMFJu=wX4A@mail.gmail.com>
Message-ID: <a8f2e68dcc1a6eb1ff3b95fcb8d0d0d2@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsXSHT1dWbelcW+CwcLLKhZPPkxks7i3Yhm7
        xYu9jSwWxx/tYrFYufook8WlL9dYLDp2fWWxuLxrDpvFts8tbBZT9u1is7j4az6jRfO7c+wW
        WzeuY7Rom8VvMWvxbXaL++vOsVm07J/C4iDo8e73MkaPe2+fMHnsnHWX3WPBplKPh5suMXls
        WtXJ5rHzoaXHr+1HmTw2L6n3eLF5JqPH7psNbB7v911l87jUfJ3d4/MmOY/2A91MAfxRXDYp
        qTmZZalF+nYJXBlrLl5jL9gpVbG54RxbA+NXkS5GDg4JAROJM9vduxi5OIQEjjFKbJ40kamL
        kRMobioxe28nI4jNKyAocXLmExYQm1nAQmLqlf2MELa8RPPW2cwgNouAqsScrc3sIDabgKbE
        /EsHwepFgGp+H+1khaj/zCrR/4AXxBYWsJE4dGU9WJxfQFji092LYDanQKDEufkQ84UENjNL
        bF0sAHGDi8SEqX1sELepSHz4/YAd5H5RIHvzXKUJjIKzkFw6C8mls5BcuoCReRWjQGKZsV5m
        crFeWn5RSYZeetEmRnC8MvruYLy9+a3eIUYmDsZDjBIczEoivF4yexKEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ8/LqTYgXEkhPLEnNTk0tSC2CyTJxcEo1MNU6JC4RlV5TtspO4USJkvELG0dj
        puVnw0Li/6j9XZ/f2sXy5OKiSpsJO+pY/Cov8TsGCPPus/6kJzdrm7ucN/Ph5rjv7qnn3Z49
        ffXzB19VquSDfS6FszcK7jtX/8SPe/2WzZmfvW67/9u405w3X/2X1i37S2fCPvU1XV56eUpe
        ay9DQVXiVqcfnzctCKlvPO8nVKl7IvrEgietS+4/Mwyabh38QWGrb23V+WS1mFynZSdC+eZm
        zOl9LbPO+Y/3lDmfOPgnSLGl2VyewHTqszB3blqZw9SQLf8MWfrUz6jOkE1duEbdWCbh9L23
        q+osN2u9dL3wVTlgWWhxxbnsefn5q/US8zIalCslGjlilFiKMxINtZiLihMBQ+jQ5EYDAAA=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Στις 2021-06-07 03:04, Guo Ren έγραψε:
> On Mon, Jun 7, 2021 at 2:14 AM Nick Kossifidis <mick@ics.forth.gr> 
> wrote:
>> 
>> Στις 2021-05-20 04:45, Guo Ren έγραψε:
>> > On Wed, May 19, 2021 at 2:53 PM Christoph Hellwig <hch@lst.de> wrote:
>> >>
>> >> On Tue, May 18, 2021 at 11:44:35PM -0700, Drew Fustini wrote:
>> >> > This patch series looks like it might be useful for the StarFive JH7100
>> >> > [1] [2] too as it has peripherals on a non-coherent interconnect. GMAC,
>> >> > USB and SDIO require that the L2 cache must be manually flushed after
>> >> > DMA operations if the data is intended to be shared with U74 cores [2].
>> >>
>> >> Not too much, given that the SiFive lineage CPUs have an uncached
>> >> window, that is a totally different way to allocate uncached memory.
>> > It's a very big MIPS smell. What's the attribute of the uncached
>> > window? (uncached + strong-order/ uncached + weak, most vendors still
>> > use AXI interconnect, how to deal with a bufferable attribute?) In
>> > fact, customers' drivers use different ways to deal with DMA memory in
>> > non-coherent SOC. Most riscv SOC vendors are from ARM, so giving them
>> > the same way in DMA memory is a smart choice. So using PTE attributes
>> > is more suitable.
>> >
>> > See:
>> > https://github.com/riscv/virtual-memory/blob/main/specs/611-virtual-memory-diff.pdf
>> > 4.4.1
>> > The draft supports custom attribute bits in PTE.
>> >
>> 
>> Not only it doesn't support custom attributes on PTEs:
>> 
>> "Bits63–54 are reserved for future standard use and must be zeroed by
>> software for forward compatibility."
>> 
>> It also goes further to say that:
>> 
>> "if any of these bits are set, a page-fault exception is raised"
> 
> In RISC-V VM TG, A C-bit discussion is raised. So it's a comm idea to
> support it.
> 

The C-bit was recently dropped, there is a new proposal for Page Based 
Memory Attributes (PBMT) that we can work on / push for.

> Let Linux support custom PTE attributes won't get any side effect in 
> practice.
> 
> IMO:
> We needn't waste a bit in PTE, but the custom idea in PTE reserved
> bits is necessary. Because Allwinner D1 needs custom PTE bits in
> reserved bits to work around.
> So I recommend just remove the "C" bit in PTE, but allow vendors to
> define their own PTE attributes in reserved bits. I've found a way to
> compact different PTE attributes of different vendors during the Linux
> boot stage. That means we still could use One Image for all vendors in
> Linux

The spec is clear, those attributes are for standard use only, not for 
custom/platform use. It's one thing to implement custom CMOs where the 
ISA doesn't have anything for it and doesn't prevent you to do so (so 
you are not violating anything, it's just a custom extension), and we 
can hide them behind SBI calls etc, and another to violate the current 
Privilege Spec by using bits on PTEs that are reserved for standard use 
only. The intentions of the VM TG are clear, not only those bits are 
reserved but if software uses them the hw will result a page fault in 
future revisions of the spec. What's the idea here, to support 
non-compliant implementations on mainline ? I'm sure you have a good 
idea on how to make this work, but as long as it violates the spec it 
can't go in IMHO.
