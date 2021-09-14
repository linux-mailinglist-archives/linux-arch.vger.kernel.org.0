Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2919740A9FB
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhINIzp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Sep 2021 04:55:45 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:53581 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231503AbhINIze (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Sep 2021 04:55:34 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id B29772B012A8;
        Tue, 14 Sep 2021 04:54:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 14 Sep 2021 04:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=s
        T/bwjG5lVTLn0wUrVQ5PSObsjCHjK6vy4pIevgX+fM=; b=ltnTWW1eQSWazPmSM
        utwvppK96dHVJD2nVmUKyUPHaXO/OLyZEazXy83rjOR3/GtgOlNy5ikQ1WUTbYq6
        EjQsfFk2DvpmRzw5gjGlsUDdorlt3jsbX3wS+AGUA1Q6HKOee/jzTurv4h2bXqHa
        ZeD0w74l4KniCuSypuWovraJyujfRDlGdhdDzvGkdxi9rJe646iwVxp7MtGOIYck
        eD4ClXVI4M4DSJm4/2uDaUTgD+4OhC4npY8Iw+SQhOedGosDKPqQHjmm7a16O5Tk
        miPRBZJw12ImiFgvf7QJ3C+4TDNgxP64sYBuEVNmy0ppt+qS/IO1oEJutcoreDPZ
        RFW2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=sT/bwjG5lVTLn0wUrVQ5PSObsjCHjK6vy4pIevgX+
        fM=; b=H4486TkxH62xP6MMVenFZbqxj0boInlsvbYSkWpxAnVYELa5DnS5jt83n
        PjrGR7bcq5jdPKH+NKarhUuYA+yEi83MfVqqF0JdT8vlimnE1UhBVapF9mP/qwwN
        rf5YiruolzAWqkZi0viorJswGxgjGMHzAy1F5EQNw6rQBXv0FKpVbPnjiVkAC+98
        qD8kDJFOaz81lgkAvy8bRFYyJm+vByc0YE83QNwuM6JjxpjV8DUf6XMRlO1/7nnI
        0UFXEkTBeZL2LUe7F3iEr1c1q8cAesExn1Oe0i4oJvxCIQ4FzM1Tvg5aDGzo4ZPF
        X3sGqJE5S/A4yy+0Vjls5mzJEU25Q==
X-ME-Sender: <xms:M2NAYVei-jZA0_gCW4L0QTe14uTJ0AAwqDFzfBp26EK9WQCi1F28ZQ>
    <xme:M2NAYTNlu_j05q0S7GkEgsarQdddnItGWBcLpmTXXOHSpIyeAOzCpdWxWTSQs5aw8
    ax8sunDHqK-KjXd07s>
X-ME-Received: <xmr:M2NAYehAGsEBjUY9bHkuC_NFw6i7mgtDlQeLeBj2cYypE8bfMQ53B_iXKxduxMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehieduvdevhfekjeeftddtkeeitefhudekvdeiueeulefgleei
    jeeghedvkeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:M2NAYe9-QRlhLNz3mpX-giOLuKFyZ3EZ1DdQeYRi1B6RLE9c1YLG5g>
    <xmx:M2NAYRuKhRsh1h0m12DkcPyrKG5HvGZwG4532MtyGqcjQ507eStRgg>
    <xmx:M2NAYdGruu1HK13C_-yw7_xJpdfEYnbkhIbm1I1jOnWOWpyc25IsMg>
    <xmx:NmNAYSnZnkzucflI5UPw7Q1yGUVMrq6lrFvuIwMo10En9c_ILRZOstVLrKvXWd37>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 04:54:10 -0400 (EDT)
Message-ID: <3907ec0f-42a0-ff4c-d4ea-63ad2a1516c2@flygoat.com>
Date:   Tue, 14 Sep 2021 09:54:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 0/2] MIPS: convert to generic entry
To:     Feiyang Chen <chris.chenfeiyang@gmail.com>,
        tsbogend@alpha.franken.de, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, chenhuacai@kernel.org,
        zhouyu@wanyeetech.com, hns@goldelico.com
References: <cover.1631583258.git.chenfeiyang@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <cover.1631583258.git.chenfeiyang@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



在 2021/9/14 2:50, Feiyang Chen 写道:
> Convert MIPS to use the generic entry infrastructure from
> kernel/entry/*.
>
> v2: Use regs->regs[27] to mark whether to restore all registers in
> handle_sys and enable IRQ stack.
Hi Feiyang,

Thanks for your patch, could you please expand how could this improve 
the performance?

Thanks.
- Jiaxun
>
> Feiyang Chen (2):
>    MIPS: convert syscall to generic entry
>    MIPS: convert irq to generic entry
>
>   arch/mips/Kconfig                         |   1 +
>   arch/mips/include/asm/entry-common.h      |  13 ++
>   arch/mips/include/asm/irqflags.h          |  42 ----
>   arch/mips/include/asm/ptrace.h            |   8 +-
>   arch/mips/include/asm/sim.h               |  70 -------
>   arch/mips/include/asm/stackframe.h        |   8 +
>   arch/mips/include/asm/syscall.h           |   5 +
>   arch/mips/include/asm/thread_info.h       |  17 +-
>   arch/mips/include/uapi/asm/ptrace.h       |   7 +-
>   arch/mips/kernel/Makefile                 |  14 +-
>   arch/mips/kernel/entry.S                  | 143 +-------------
>   arch/mips/kernel/genex.S                  | 150 +++------------
>   arch/mips/kernel/head.S                   |   1 -
>   arch/mips/kernel/linux32.c                |   1 -
>   arch/mips/kernel/ptrace.c                 |  78 --------
>   arch/mips/kernel/r4k-bugs64.c             |  14 +-
>   arch/mips/kernel/scall.S                  | 136 +++++++++++++
>   arch/mips/kernel/scall32-o32.S            | 223 ---------------------
>   arch/mips/kernel/scall64-n32.S            | 107 ----------
>   arch/mips/kernel/scall64-n64.S            | 116 -----------
>   arch/mips/kernel/scall64-o32.S            | 221 ---------------------
>   arch/mips/kernel/signal.c                 |  59 +-----
>   arch/mips/kernel/signal_n32.c             |  15 +-
>   arch/mips/kernel/signal_o32.c             |  29 +--
>   arch/mips/kernel/syscall.c                | 148 +++++++++++---
>   arch/mips/kernel/syscalls/syscall_n32.tbl |   8 +-
>   arch/mips/kernel/syscalls/syscall_n64.tbl |   8 +-
>   arch/mips/kernel/syscalls/syscall_o32.tbl |   8 +-
>   arch/mips/kernel/traps.c                  | 225 ++++++++++++++++------
>   arch/mips/kernel/unaligned.c              |  19 +-
>   arch/mips/mm/c-octeon.c                   |  15 ++
>   arch/mips/mm/cex-oct.S                    |   8 +-
>   arch/mips/mm/fault.c                      |  12 +-
>   arch/mips/mm/tlbex-fault.S                |   7 +-
>   34 files changed, 594 insertions(+), 1342 deletions(-)
>   create mode 100644 arch/mips/include/asm/entry-common.h
>   delete mode 100644 arch/mips/include/asm/sim.h
>   create mode 100644 arch/mips/kernel/scall.S
>   delete mode 100644 arch/mips/kernel/scall32-o32.S
>   delete mode 100644 arch/mips/kernel/scall64-n32.S
>   delete mode 100644 arch/mips/kernel/scall64-n64.S
>   delete mode 100644 arch/mips/kernel/scall64-o32.S
>

