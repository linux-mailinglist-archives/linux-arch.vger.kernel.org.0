Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49E53BC9F
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiFBQe4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 12:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiFBQe4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 12:34:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1C513CA3E;
        Thu,  2 Jun 2022 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=svPrOg1UVwIs7S0rtpWPp9k1K9FF0OCGxIhcYj8TkIQ=; b=VJc18BtxygRpXKEn5jq8wa3gzs
        Tb1bKMXzyrjOyJ00zBlPnoMmSynEG87rNHrmR26ANwkd45ZpMzYMT77Eyk9xHLNV43/SnSVPy8m8t
        WaHKGjAIiTNpW5cIUC1VgV5fqi0MP0x3QLSoX0lxFZe+IVCRN+uHx0sgtrykwmAdpQ7yqNVdP1rWy
        NWUD3gUNmbUVlEGbvFFhib7vh7sTsnqm1QIsccZP+uvYOmQLpYc67lbJwwP/lsWch5c7dy7EhCuVH
        fMIlJowdLIMGSZ6JYvXBFyq/uWTFMgaPTF/d7xCYVM16NurM2Stgy8B3IS68GuOECVf6Dk+/emBFF
        BX2GPKkQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwnmM-0049mu-9X; Thu, 02 Jun 2022 16:34:34 +0000
Message-ID: <e68000bf-a271-d1f2-56a5-a9ddce2bbb7c@infradead.org>
Date:   Thu, 2 Jun 2022 09:34:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V14 01/24] irqchip: Adjust Kconfig for Loongson
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>, WANG Xuerui <git@xen0n.name>
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-2-chenhuacai@loongson.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220602115141.3962749-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 6/2/22 04:51, Huacai Chen wrote:
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 44fb8843e80e..1cb3967fe798 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -557,7 +557,7 @@ config LOONGSON_LIOINTC
>  
>  config LOONGSON_HTPIC
>  	bool "Loongson3 HyperTransport PIC Controller"
> -	depends on MACH_LOONGSON64
> +	depends on (MACH_LOONGSON64 && MIPS)

If you ever have another patch version, please drop the unnecessary left and
right parentheses above.

	depends on MACH_LOONGSON64 && MIPS

>  	default y
>  	select IRQ_DOMAIN
>  	select GENERIC_IRQ_CHIP

thanks.
-- 
~Randy
