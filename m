Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41223348614
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 01:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhCYAvf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 20:51:35 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:54253 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239410AbhCYAvF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 20:51:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id E4CF71525;
        Wed, 24 Mar 2021 20:50:58 -0400 (EDT)
Received: from imap1 ([10.202.2.51])
  by compute6.internal (MEProxy); Wed, 24 Mar 2021 20:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=zjatyvvSSE46LUdl98TXIwR6kX6pq3G
        UAfknNyuutZM=; b=xGbs5TbNM2wBAWrIdMOdRUUzzyVyoMLN5O+H/tc8f0qX0mO
        9C+jUVpckEclXRJHD2JStmJNFMB8loOwo6NuAl6SKwx+T/LGlQRewcPlXQOfCR8F
        dGDYKIXUk2w3U0HoUJZ49kVsmXB0AM+FlsgdPQj5/FeodaFmGcvK8Ogi1LfW+OMa
        39GVevwPrtH8zvrS51w9qGmzepWV9LR7Ve4ZKGKX0ShbFHR3jgY3ivKF2HPZ01GR
        IE8KM6yaQ/LF71ZHFrw7YP86Ay0FJ9KiOsDF+oKLPLqk+rmzMcVhnvV0G9MeLUUq
        5PPICBHUOQZXSl09SjaNeeI9a/oVZA64jcSH7bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zjatyv
        vSSE46LUdl98TXIwR6kX6pq3GUAfknNyuutZM=; b=kdwzp3nrbVsWe/nv5dw2Ef
        WW7UtbSqn+9uy6LIZ0aty8nfNxnrQnOKD76YkgrghN2smYklAmmJaJ1h5k8F3oR5
        aYcRvuGgmnyciZpLbKb6ykdYUUGEqcKTf53XPG8yMvu2StrYv/qdkRCRvSoKDWlC
        OrR7bii0xe8I+sOE72h41riSa3g3jP1Fwq5TSFjkpyj52dcnmSpGB3ZR1I5STlx9
        hNAW6xejxiWXMVf9/Rvc4O2ulRV6gKXoqeTxFhPc6LWC9EeoxHOWA71k8UnWADBJ
        AzO28cnixDNhZF5hkvaxmcS9APd6xKc8ZCzZsqEy8K0wdmDuH9bxpb4s28XKWOPA
        ==
X-ME-Sender: <xms:cN5bYPg0Rj_s_VWytEEsgni7esOPIdIje8tIqNoVSH5cYZEpaRlgxA>
    <xme:cN5bYMB5ETEm2vTvfaqxGIje5h1TMqrCOHaWce2pOhnU9Azzd5x3vc-lqWdwrkctw
    SJiYG97nladjL0xEjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeekleehtefhhefftddtleeiveefieehueduieefueegueei
    leeitdeujeehheehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:cd5bYPGuM0yKVk7jb9M7l1Dz4UZuqLOWVqmzep4KTwUB14iFEmy0tw>
    <xmx:cd5bYMRuPWrb3JAMdKKtMrTiTGFzdwBn5chm92CiJG1CePBm9FIzzw>
    <xmx:cd5bYMwFoL4di2U1Q6WkhAm02DK_n1M3oOSI2wSkR5xK-PB6mROC0w>
    <xmx:ct5bYIfIW0Kba--7zmV3uWGLw-6ztj-bbh0tc3lZZTe9nHU32yz94gb5ciw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DA81313004BF; Wed, 24 Mar 2021 20:50:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <6e8521f8-80e3-49c8-b85c-ccb2c7f349b5@www.fastmail.com>
In-Reply-To: <20210324032451.27569-1-huangpei@loongson.cn>
References: <20210324032451.27569-1-huangpei@loongson.cn>
Date:   Thu, 25 Mar 2021 08:50:36 +0800
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Huang Pei" <huangpei@loongson.cn>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     "Bibo Mao" <maobibo@loongson.cn>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Gao Juxin" <gaojuxin@loongson.cn>,
        "Huacai Chen" <chenhuacai@loongson.cn>,
        "Jinyang He" <hejinyang@loongson.cn>
Subject: Re: [PATCH] MIPS: loongson64: fix bug when PAGE_SIZE > 16KB
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Wed, Mar 24, 2021, at 11:24 AM, Huang Pei wrote:
> When page size larger than 16KB, arguments "vaddr + size(16KB)" in
> "ioremap_page_range(vaddr, vaddr + size,...)" called by
> "add_legacy_isa_io" is not page-aligned.
> 
> As loongson64 needs at least page size 16KB to get rid of cache alias,
> and "vaddr" is 64KB-aligned, and 64KB is largest page size supported,
> rounding "size" up to PAGE_SIZE is enough for all page size supported.
> 
> Fixes: 6d0068ad15e4 ("MIPS: Loongson64: Process ISA Node in DeviceTree")
> Signed-off-by: Huang Pei <huangpei@loongson.cn>

Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

> ---
>  arch/mips/loongson64/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
> index ed75f7971261..052cce6a8a99 100644
> --- a/arch/mips/loongson64/init.c
> +++ b/arch/mips/loongson64/init.c
> @@ -82,7 +82,7 @@ static int __init add_legacy_isa_io(struct 
> fwnode_handle *fwnode, resource_size_
>  		return -ENOMEM;
>  
>  	range->fwnode = fwnode;
> -	range->size = size;
> +	range->size = size = round_up(size, PAGE_SIZE);
>  	range->hw_start = hw_start;
>  	range->flags = LOGIC_PIO_CPU_MMIO;
>  
> -- 
> 2.17.1
> 
>

-- 
- Jiaxun
