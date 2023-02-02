Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF51687A5D
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 11:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjBBKg7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 05:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjBBKg7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 05:36:59 -0500
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 02:36:56 PST
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F644F843;
        Thu,  2 Feb 2023 02:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1675333849; bh=pxzyuwtPjht0CvEbp2BUK8o32JDLmwrAyaaDPGgn1YE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aSIO1WEiRitrrWL/lY6pSFFIiPbl7Jz0PSkrRsQ2bQZQZzmb6TxBZp/gkjBzn35mw
         x/n8xyqhobJmV52K0xFt3Qafe3iS2HxZKKhkFDAqWpImh7mr+H5g0ujUImykSE526g
         yV/uMjGJu4pb/QvYrvoljua5PYekjzrKxLeVS1Zc=
Received: from [100.100.35.204] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 7189F60112;
        Thu,  2 Feb 2023 18:30:48 +0800 (CST)
Message-ID: <5fc85453-1e2c-1f00-7879-1b5fa318c78a@xen0n.name>
Date:   Thu, 2 Feb 2023 18:30:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Firefox/111.0 Thunderbird/111.0a1
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230202084238.2408516-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/2/2 16:42, Huacai Chen wrote:
> Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
> configurable.
> 
> Not all LoongArch cores support h/w unaligned access, we can use the
> -mstrict-align build parameter to prevent unaligned accesses.
> 
> This option is disabled by default to optimise for performance, but you
> can enabled it manually if you want to run kernel on systems without h/w
> unaligned access support.

It's customary to accompany "performance-related" changes like this with 
some benchmark numbers and concrete use cases where this would be 
profitable. Especially given that arch/loongarch developer and user base 
is relatively small, we probably don't want to allow customization of 
such a low-level characteristic. In general kernel performance does not 
vary much with compiler flags like this, so I'd really hope to see some 
numbers here to convince people that this is *really* providing gains.

Also, defaulting to emitting unaligned accesses would mean those future, 
likely embedded models (and AFAIK some existing models that haven't 
reached GA yet) would lose support with the defconfig. Which means 
downstream packagers that care about those use cases would have one more 
non-default, non-generic option to carry within their Kconfig. We 
probably don't want to repeat the history of other architectures (think 
arch/arm or arch/mips) where there wasn't really generic builds and 
board-specific tweaks proliferated.

> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/Kconfig  | 10 ++++++++++
>   arch/loongarch/Makefile |  2 ++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 9cc8b84f7eb0..7470dcfb32f0 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -441,6 +441,16 @@ config ARCH_IOREMAP
>   	  protection support. However, you can enable LoongArch DMW-based
>   	  ioremap() for better performance.
>   
> +config ARCH_STRICT_ALIGN
> +	bool "Enable -mstrict-align to prevent unaligned accesses"
> +	help
> +	  Not all LoongArch cores support h/w unaligned access, we can use
> +	  -mstrict-align build parameter to prevent unaligned accesses.
> +
> +	  This is disabled by default to optimise for performance, you can
> +	  enabled it manually if you want to run kernel on systems without
> +	  h/w unaligned access support.
> +
>   config KEXEC
>   	bool "Kexec system call"
>   	select KEXEC_CORE
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 4402387d2755..ccfb52700237 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -91,10 +91,12 @@ KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
>   # instead of .eh_frame so we don't discard them.
>   KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>   
> +ifdef CONFIG_ARCH_STRICT_ALIGN
>   # Don't emit unaligned accesses.
>   # Not all LoongArch cores support unaligned access, and as kernel we can't
>   # rely on others to provide emulation for these accesses.
>   KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
> +endif >
>   KBUILD_CFLAGS += -isystem $(shell $(CC) -print-file-name=include)
>   

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

