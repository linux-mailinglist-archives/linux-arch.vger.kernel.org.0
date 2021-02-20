Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630C332040B
	for <lists+linux-arch@lfdr.de>; Sat, 20 Feb 2021 06:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhBTFdl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Feb 2021 00:33:41 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:48857 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230125AbhBTFdi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 20 Feb 2021 00:33:38 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 021F7C66;
        Sat, 20 Feb 2021 00:32:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 20 Feb 2021 00:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=s
        gbAB7vyqaLQKJwGNk9KixP9bH0fTh7k6Pdv8GtmCKY=; b=hLurI2NWNmhSCVW9j
        nwwrECxlJ7Au8M55Dqyy2Bxr57kU6Ru6A+sGln/1giRM9CpJ8R5AXmDh6BlTAeb8
        1FGzKGJOKT73Ht1mwQqQW+1au+QgbtGCXzTiebUHq7ebbSX5tTrpMX5HJYiteemC
        I7c6q90PZ1CpLmHRi0JsV23lO1obpvabA8zWPHXeRgPXsbZcG3iqaMCo19GVE8FU
        Et0K8XeVV3AEKPc0seHM8fBXESdwHx9Lh30n5ceSjnlL8pARMsF4RqckL/fW8mIx
        HexdhZEs5/O3nWutfU1XDs6jzII2qgW2faoOIbL4dW/P56P+QILhnIenluA0UO5L
        x+gVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=sgbAB7vyqaLQKJwGNk9KixP9bH0fTh7k6Pdv8GtmC
        KY=; b=KSp5HFIKAGKK5ErUFlv/rVdggqpXuEd1ez51sQuQ0f+oUAYQE6orBNMOK
        GFbUU0eVBAFHGu+bIkmljf63pD4OUoVXBjGiTaMcNpCNoUpzMCuhI0HIjo1BmgGI
        lAJEEjHcjjhuTWql9WUjKHuMqWbqdedbj6TOD0CdiT1K6wvNK9NX5LznwpsQKhxH
        I0mVwlPjxEQeGMLygxDu1tI7IN7BNDo3HNDRPde2phids7WHOkOddoXrGSivs0dA
        And2Xa/0UYBkQfTqa1OowJXI9yUlFGunsFfO/jGyFJbOjPgxv1p2R00qXSTVrL+o
        lqD8sHPSXXuxedGfotBuLs5d2hpbQ==
X-ME-Sender: <xms:7J4wYEcmeNSN290yYTZ1LC3TbiHrH-p5aFlTq5ob7sTY1cPxPezhgQ>
    <xme:7J4wYGMy9oyGUD3xaQ6H4qLZvO4m4OyfLYfvps6Z4tZwqTBV_GDEbQK-iN_gaz6C6
    uJcsnu4E_OU2p4ohM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeejgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeftnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepfeeludeitddvkeffgefgueekjeegfeefteelgffhkeffueetieej
    geehhfeuffdvnecukfhppeduheegrddujedruddvrdelkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:7J4wYFi-vHoHZPv9mO7xBUl5hg0h7hk7Nr1Ezoai99TvHWXFb0x71Q>
    <xmx:7J4wYJ-HY-NLcXDSi4ngdt5u3Zxjm1aY2d2DmHlpe7mGNiu52LlPtQ>
    <xmx:7J4wYAtdEWK_6vGW3eKeGNw4XtMsTiI7yR_tQC8LVnmXdMgEOXvRAw>
    <xmx:7p4wYAExEIvxhJQ9tDenvQcwD6WG_hCDTBt9_LgqEsx4bUMRdZY9-ZlsEEQ>
Received: from [0.0.0.0] (unknown [154.17.12.98])
        by mail.messagingengine.com (Postfix) with ESMTPA id 71C5B1080059;
        Sat, 20 Feb 2021 00:32:24 -0500 (EST)
Subject: Re: [PATCH] MIPS: loongson64: use 0b011 instead of 0b101 as xphys
 cached
To:     Huang Pei <huangpei@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
References: <20210220033155.3856-1-huangpei@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <a3b02ec6-ed82-22b6-df95-d8a74dd8bc7d@flygoat.com>
Date:   Sat, 20 Feb 2021 13:32:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210220033155.3856-1-huangpei@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ÔÚ 2021/2/20 ÉÏÎç11:31, Huang Pei Ð´µÀ:
> Loongson 3 use *0b011* as Cachable(not 0b101), this only affect
> loongson64 without enough CP0 Kscratch for holding current pgd.
> 3A2000+ use CP0 PWbase holding current (user) pgd
>
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>   arch/mips/mm/tlbex.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index a7521b8f7658..51effa5dbf9d 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -848,8 +848,15 @@ void build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>   		/* Clear lower 23 bits of context. */
>   		uasm_i_dins(p, ptr, 0, 0, 23);
>   
> +#ifdef CONFIG_CPU_LOONGSON64
> +		/* 1 0	0 1 1  << 6  xkphys cached */
> +		/* 0x98xx xxxx xxxx xxxx */
> +		uasm_i_ori(p, ptr, ptr, 0x4c0);

Hi Pei,

What about (CAC_BASE >> 53) instead of magic number?

Also there is another similar usage at build_fast_tlb_refill_handler, please
fix it as well.

Thanks.

- Jiaxun

> +#else
>   		/* 1 0	1 0 1  << 6  xkphys cached */
> +		/* 0xa8xx xxxx xxxx xxxx */
>   		uasm_i_ori(p, ptr, ptr, 0x540);
> +#endif
>   		uasm_i_drotr(p, ptr, ptr, 11);
>   #elif defined(CONFIG_SMP)
>   		UASM_i_CPUID_MFC0(p, ptr, SMP_CPUID_REG);

