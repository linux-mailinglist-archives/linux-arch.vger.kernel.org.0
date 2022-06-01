Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5196653A2B6
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 12:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbiFAKg3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 06:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350938AbiFAKg1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 06:36:27 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2447CDD0;
        Wed,  1 Jun 2022 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654079782; bh=Az6LaeM91P9NnWYSF0KdOPJoEbnukU3RI4Bg3h7Zqyw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ga7BVFJmTmsYIwgEi5aRccQn30NZX/8mXfj2P/c5DHANWGC2v4PPgwG2IrBtENNN+
         bpSnk3X/YTUHJm+lvvvZi+0tS9OdaE+wymM46SB5wGbo8qSJIkEwTngNdD31tnKiwa
         M7aLpoEiorGTgs/s5fuR7HYTCO40dLoSTmwW0Ea4=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 8F03C60104;
        Wed,  1 Jun 2022 18:36:22 +0800 (CST)
Message-ID: <92cb9e21-b48d-bf74-af71-b180600ad792@xen0n.name>
Date:   Wed, 1 Jun 2022 18:36:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [PATCH V12 01/24] irqchip: Adjust Kconfig for Loongson
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-2-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220601100005.2989022-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/1/22 17:59, Huacai Chen wrote:
> HTVEC will be shared by both MIPS-based and LoongArch-based Loongson
> processors (not only Loongson-3), so we adjust its description. HTPIC is
> only used by MIPS-based Loongson, so we add a MIPS dependency.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/irqchip/Kconfig | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 44fb8843e80e..1cb3967fe798 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -557,7 +557,7 @@ config LOONGSON_LIOINTC
>   
>   config LOONGSON_HTPIC
>   	bool "Loongson3 HyperTransport PIC Controller"
> -	depends on MACH_LOONGSON64
> +	depends on (MACH_LOONGSON64 && MIPS)
>   	default y
>   	select IRQ_DOMAIN
>   	select GENERIC_IRQ_CHIP
> @@ -565,12 +565,12 @@ config LOONGSON_HTPIC
>   	  Support for the Loongson-3 HyperTransport PIC Controller.
>   
>   config LOONGSON_HTVEC
> -	bool "Loongson3 HyperTransport Interrupt Vector Controller"
> +	bool "Loongson HyperTransport Interrupt Vector Controller"
>   	depends on MACH_LOONGSON64
>   	default MACH_LOONGSON64
>   	select IRQ_DOMAIN_HIERARCHY
>   	help
> -	  Support for the Loongson3 HyperTransport Interrupt Vector Controller.
> +	  Support for the Loongson HyperTransport Interrupt Vector Controller.
>   
>   config LOONGSON_PCH_PIC
>   	bool "Loongson PCH PIC Controller"

The series passes allmodconfig build for ARCH={x86,mips,loongarch} with 
this, it seems reasonable.

Reviewed-by: WANG Xuerui <git@xen0n.name>

