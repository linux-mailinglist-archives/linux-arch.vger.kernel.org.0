Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C4C53A2C0
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 12:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiFAKht (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352073AbiFAKhs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 06:37:48 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3518D7E1EF;
        Wed,  1 Jun 2022 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654079863; bh=YcjpCe19/pVR4de7LNXBIwhHExjMgtkhxajw/KiCdKA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ubGvyNDjkBH6aTlakteo1aAcEg/qRtt3STkoqt+hwaZGEDt315BDKmIInQ4eQ7Obr
         EETh1gedqvTd9nEeMirE7wDDnTCqqlPpr3pCEY65WM69mmDvVRCI0R6pv6yXr/1kIq
         LXPQMK8d3tslnt9a+2w6tYgBy6y9H7OVTLdK8Ox0=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 54CD860104;
        Wed,  1 Jun 2022 18:37:43 +0800 (CST)
Message-ID: <61034cb8-8847-0ca5-897d-a607f24bc6ba@xen0n.name>
Date:   Wed, 1 Jun 2022 18:37:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [PATCH V12 02/24] irqchip/loongson-liointc: Fix build error for
 LoongArch
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
 <20220601100005.2989022-3-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220601100005.2989022-3-chenhuacai@loongson.cn>
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
> liointc driver is shared by MIPS and LoongArch, this patch adjust the
> code to fix build error for LoongArch.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/irqchip/irq-loongson-liointc.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> index 649c58391618..aed88857d90f 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -16,7 +16,11 @@
>   #include <linux/smp.h>
>   #include <linux/irqchip/chained_irq.h>
>   
> +#ifdef CONFIG_MIPS
>   #include <loongson.h>
> +#else
> +#include <asm/loongson.h>
> +#endif
>   
>   #define LIOINTC_CHIP_IRQ	32
>   #define LIOINTC_NUM_PARENT 4
> @@ -53,7 +57,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
>   	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
>   	struct irq_chip *chip = irq_desc_get_chip(desc);
>   	struct irq_chip_generic *gc = handler->priv->gc;
> -	int core = get_ebase_cpunum() % LIOINTC_NUM_CORES;
> +	int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
>   	u32 pending;
>   
>   	chained_irq_enter(chip, desc);

Trivial enough.

Reviewed-by: WANG Xuerui <git@xen0n.name>

