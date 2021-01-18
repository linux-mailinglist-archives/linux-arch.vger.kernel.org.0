Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6742F9787
	for <lists+linux-arch@lfdr.de>; Mon, 18 Jan 2021 03:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbhARCBB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Jan 2021 21:01:01 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52001 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730784AbhARCBA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 17 Jan 2021 21:01:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7429F580691;
        Sun, 17 Jan 2021 20:59:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 17 Jan 2021 20:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=/
        sgmulDHp9rb7PANJ3YQeT7vYqlzAUl9a9PJU2TOFmU=; b=SBt8i3AAOYoPS+tjZ
        a+fFzGY9e8jJmmqjZU+Q71NK3b8q/2JOCTc+hu45JQDaFlWojNYOIhrBhHEYfQxp
        yFVszswjnwlEgYvWu7F7py0Np5jYg0XzqBx6EuEVSM5tSabVfzOFjjfrX3QpiQO7
        IovmrFRlOApeAiiAiBdYJ/LBlQjUUMfhiYlIBlQzSbTvx3ZVO5oFz17A3+2FpkJh
        fLpodCI5TZXzF8d05UPKu0FeIgTmKpiIYJu2OGYRpGo3+xzjHMPNXOpSglK5E4a2
        EL03IiWrzZh97JEaRHCoHEiF3rGD107d5TxVnrKebIZKOr39QkHlTZqJql68jDDD
        hJhsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=/sgmulDHp9rb7PANJ3YQeT7vYqlzAUl9a9PJU2TOF
        mU=; b=Fu9oVD8v9DVMtGCVFAH82kUeTkasi1oQ9IvWAQLpkBMwFGuFII/uKhJCA
        vCDnAl5WpofkNH3jw5sFZeDoUjxpZDdVTp3r5wX++ZRqJn2POKdUTmBwQHLIiN25
        fFGRY+eMJ4Hr9CJk42Evx1Jq8nI6mYlnpJHgR5tpbJJIesM2QC/uetLcSHEUkFe4
        YIL69305CCgiQPvo8qco12LT3hN6sVgQlFLJJC4pWL3o/Rg2uZ11XZ5Y7DDKY2/u
        Y3dyEJsbiYBggoSFWgZ9INpnCiPUTSp2rAETOnz95GPFVStfis8aNbXKfT/4pFjt
        uR9JZ8c2lZy5sMRDobR17JHXKBcZQ==
X-ME-Sender: <xms:l-sEYJCkLZH2UJGzP2vauPOP_nwPhqRBwS-gPvYPrl3EJzxJwWAoPQ>
    <xme:l-sEYHiN_q4EIFerhwAkJTKdlGgBIseViXndJRDQoFE7GPQCatRtwjbztlHjSWZxY
    OT6kag8fkpVasACCrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeftnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepteduueduffeghfefgeetfeevtdfftedugfdtveduudetgfefffel
    vddtgfelleefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepgeehrdeffe
    drhedtrddvheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:l-sEYElkfKcR0HURU7YnX7c3Eioemnj04tRfeRSe9ZPFAochYuzn9Q>
    <xmx:l-sEYDy1PxiYh387JoY6s3D_ghWw3g85QJuv9mX1M_QsaN9mQGT-rA>
    <xmx:l-sEYOTWh-c5IJtu0rCvHQGOENBFGPPQvL7uYkxs7gfVaOS7nsgQ4w>
    <xmx:mesEYFK9Va2bqi9zNc3sMjbUy_AnW_rFTYuRMqUpEfxU1TaY5KOxGzE9yO4>
Received: from [0.0.0.0] (li1000-254.members.linode.com [45.33.50.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id BDEFB1080059;
        Sun, 17 Jan 2021 20:59:44 -0500 (EST)
Subject: Re: [PATCH RFC 0/4] Fix arm64 crash for accessing unmapped IO port
 regions (reboot)
To:     John Garry <john.garry@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, arnd@arndb.de, akpm@linux-foundation.org,
        xuwei5@hisilicon.com, lorenzo.pieralisi@arm.com,
        helgaas@kernel.org, song.bao.hua@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxarm@openeuler.org
References: <1610729929-188490-1-git-send-email-john.garry@huawei.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <982ed6eb-6975-aea8-1555-a557633966f5@flygoat.com>
Date:   Mon, 18 Jan 2021 09:59:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1610729929-188490-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ÔÚ 2021/1/16 ÉÏÎç12:58, John Garry Ð´µÀ:
> This is a reboot of my original series to address the problem of drivers
> for legacy ISA devices accessing unmapped IO port regions on arm64 systems
> and causing the system to crash.
>
> There was another recent report of such an issue [0], and some old ones
> [1] and [2] for reference.
>
> The background is that many systems do not include PCI host controllers,
> or they do and controller probe may have failed. For these cases, no IO
> ports are mapped. However, loading drivers for legacy ISA devices can
> crash the system as there is nothing to stop them accessing those IO
> ports (which have not been io remap'ed).
>
> My original solution tried to keep the kernel alive in these situations by
> rejecting logical PIO access to PCI IO regions until PCI IO port regions
> have been mapped.
>
> This series goes one step further, by just reserving the complete legacy
> IO port range in 0x0--0xffff for arm64. The motivation for doing this is
> to make the request_region() calls for those drivers fail, like this:
>
> root@ubuntu:/home/john# insmod mk712.ko
>   [ 3415.575800] mk712: unable to get IO region
> insmod: ERROR: could not insert module mk712.ko: No such device
>
> Otherwise, in theory, those drivers could initiate rogue accesses to
> mapped IO port regions for other devices and cause corruptions or
> side-effects. Indeed, those drivers should not be allowed to access
> IO ports at all in such a system.
>
> As a secondary defence, for broken drivers who do not call
> request_region(), IO port accesses in range 0--0xffff will be ignored,
> again preserving the system.
>
> I am sending as an RFC as I am not sure of any problem with reserving
> first 0x10000 of IO space like this. There is reserve= commandline
> argument, which does allow this already.

Hi John,

Is it ok with ACPI? I'm not really familiar with ACPI on arm64 but my 
impression
is ACPI would use legacy I/O ports to communicate with kbd controller, 
EC and
power management facilities.

We'd better have a method to detect if ISA bus is not present on the system
instead of reserve them unconditionally.

Thanks.

- Jiaxun

>
> For reference, here's how /proc/ioports looks on my arm64 system with
> this change:
>
> root@ubuntu:/home/john# more /proc/ioports
> 00010000-0001ffff : PCI Bus 0002:f8
>    00010000-00010fff : PCI Bus 0002:f9
>      00010000-00010007 : 0002:f9:00.0
>        00010000-00010007 : serial
>      00010008-0001000f : 0002:f9:00.1
>        00010008-0001000f : serial
>      00010010-00010017 : 0002:f9:00.2
>      00010018-0001001f : 0002:f9:00.2
> 00020000-0002ffff : PCI Bus 0004:88
> 00030000-0003ffff : PCI Bus 0005:78
> 00040000-0004ffff : PCI Bus 0006:c0
> 00050000-0005ffff : PCI Bus 0007:90
> 00060000-0006ffff : PCI Bus 000a:10
> 00070000-0007ffff : PCI Bus 000c:20
> 00080000-0008ffff : PCI Bus 000d:30
>
> [0] https://lore.kernel.org/linux-input/20210112055129.7840-1-song.bao.hua@hisilicon.com/T/#mf86445470160c44ac110e9d200b09245169dc5b6
> [1] https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
> [2] https://lore.kernel.org/linux-arm-kernel/e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com/
>
> Difference since v4:
> https://lore.kernel.org/linux-pci/1560262374-67875-1-git-send-email-john.garry@huawei.com/
> - Reserve legacy ISA region
>
> John Garry (4):
>    arm64: io: Introduce IO_SPACE_BASE
>    asm-generic/io.h: Add IO_SPACE_BASE
>    kernel/resource: Make ioport_resource.start configurable
>    logic_pio: Warn on and discard accesses to addresses below
>      IO_SPACE_BASE
>
>   arch/arm64/include/asm/io.h |  1 +
>   include/asm-generic/io.h    |  4 ++++
>   include/linux/logic_pio.h   |  5 +++++
>   kernel/resource.c           |  2 +-
>   lib/logic_pio.c             | 20 ++++++++++++++------
>   5 files changed, 25 insertions(+), 7 deletions(-)
>

