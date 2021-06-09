Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846823A1168
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhFIKue (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 06:50:34 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:19361 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbhFIKu2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jun 2021 06:50:28 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 1599j9GO050390
        for <linux-arch@vger.kernel.org>; Wed, 9 Jun 2021 12:45:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623231904; x=1625823904;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yjGGcXj2vYqKeS5nQsMSbZLVyeA0Yb+og64ORh4pZoc=;
        b=ZHIEsIIyg1A+E4IlEj4+7B+gOESDbGe3/DVcdBzG2InLyO5KOso+4rJ+Amgkpe7r
        EfWQ81kDSjg5z5gHscQNF4ZcRI2EBPD3PkLetk2l4lV+vAbYol08wZgkhtMx9qae
        TCep7BFW773GcnRJf8LZE8yLJT+MM0wqoy5aIrJT1G+X/6gF1/pW42ROoFYWCDlY
        fQftNnsQvTTViH88ENDycxAAxCLJ33TlJzaxS9JdigaCffsZ2+Yy3LVBOBDxbVTM
        JS5Y7r/BALQ9oIFMVvGfusmyPOi0/yzyl0YLlLaKyVZKD43uEb+7x2iMC1alIm91
        4TTq1b0YLhXu5DwaJ23pUQ==;
X-AuditID: 8b5b014d-962f1700000067b6-3c-60c08d9f9466
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id C8.43.26550.F9D80C06; Wed,  9 Jun 2021 12:45:03 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 09 Jun 2021 12:45:01 +0300
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
In-Reply-To: <CAJF2gTQ5271AP8aw42yvfOg0LjtnmPD8j_Uza6NH2nHxVz_QgQ@mail.gmail.com>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de>
 <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
 <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
 <CAJF2gTQ5271AP8aw42yvfOg0LjtnmPD8j_Uza6NH2nHxVz_QgQ@mail.gmail.com>
Message-ID: <78f544f739120f5b541238a1d5f6e23b@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsXSHT1dWXd+74EEg9cXrC2efJjIZnFvxTJ2
        ixd7G1ksjj/axWKxcvVRJotLX66xWHTs+spicXnXHDaLbZ9b2Cym7NvFZnHx13xGi+Z359gt
        tm5cx2jRNovfYtbi2+wW99edY7No2T+FxUHQ493vZYwe994+YfLYOesuu8eCTaUeDzddYvLY
        tKqTzWPnQ0uPX9uPMnlsXlLv8WLzTEaP3Tcb2Dze77vK5nGp+Tq7x+dNch7tB7qZAvijuGxS
        UnMyy1KL9O0SuDK+P53EXrBdumLzz07GBsYPol2MnBwSAiYSR/5MYO5i5OIQEjjGKLHt8CNG
        iISpxOy9nWA2r4CgxMmZT1hAbGYBC4mpV/YzQtjyEs1bZzOD2CwCqhL9S2ayg9hsApoS8y8d
        BKsXAar5fbSTFaL+M6tE/wNeEFtYwEbi0JX1YHF+AWGJT3cvgtmcAoESjzZ9YgKxhQQ2M0ss
        +sYHcYOLxJ3FS1khblOR+PD7AdAuDg5RIHvzXKUJjIKzkFw6C8mls5BcuoCReRWjQGKZsV5m
        crFeWn5RSYZeetEmRnDEMvruYLy9+a3eIUYmDsZDjBIczEoivGWG+xKEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ8/LqTYgXEkhPLEnNTk0tSC2CyTJxcEo1MLUyLPXyVnqg5HHmyoRTkdfnnP3z
        +ek5odpJUz/zvl9Qb3jVQHnudEmmO4/VHurXzD+6ausRf5vmeFl9rUKOZVHbZvQcj5lycOX3
        2FOt7oZOS7wUHL/rfF/KIXO0fUPV5y83J372Oe0gW6XCniLQEqZu2vfU0vDbE8ZNB/7cDM+7
        93D3w02HzJpF0n87v2d/cb91+VYNqSOqUje+e1lkRxnIzwjuvu7QdfWChZ+Uvexh4Tid5aJ5
        /s4aL/pVNVLK1x4JDAlPP/rpnPfnqSl/GF+t36qfVOBccss6YEo1z+wdm/fZySzo4jedfOHF
        laUvvl01vTJbTcay1tou98o/rUgG1svXRH2unrA7UfyM470SS3FGoqEWc1FxIgDm0E7aRwMA
        AA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Στις 2021-06-09 06:28, Guo Ren έγραψε:
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
> Agree, when our processor's mmu works in compatible mmu, we must keep
> "Bits63–54 bit" zero in Linux.
> So, I think this is the first version of the PTE format.
> 
> If the "PBMT" extension proposal is approved, it will cause the second
> version of the PTE format.
> 
> Maybe in the future, we'll get more versions of the PTE formats.
> 
> So, seems Linux must support multi versions of PTE formats with one
> Image, right?
> 
> Okay, we could stop arguing with the D1 PTE format. And talk about how
> to let Linux support multi versions of PTE formats that come from the
> future RISC-V privilege spec.

The RISC-V ISA specs are meant to be backwards compatible, so newer PTE 
versions should work on older devices (note that the spec says that 
software must set those bits to zero for "forward compatibility" and are 
"reserved for future use" so current implementations must ignore them). 
Obviously the proposed "if any of these bits are set, a page-fault 
exception is raised" will break backwards compatibility which is why we 
need to ask for it to be removed from the draft.

As an example the PBMT proposal uses bits 62:61 that on older hw should 
be ignored ("reserved for future use"), if Linux uses those bits we 
won't need a different code path for supporting older hw/older PTE 
versions, we'll just set them and older hw will ignore them. Because of 
the guarantee that ISA specs maintain backwards compatibility, the 
functionality of bits 62:61 is guaranteed to remain backwards 
compatible.

In other words we don't need any special handling of multiple PTE 
formats, we just need to support the latest Priv. Spec and the Spec 
itself will guarantee backwards compatibility.
