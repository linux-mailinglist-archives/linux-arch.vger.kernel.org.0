Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AB874CB5A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 06:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjGJEpY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 00:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGJEpW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 00:45:22 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720F118;
        Sun,  9 Jul 2023 21:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1688964317; bh=nIwe2M/K3NQxgFY9TidL4zat/EkEm3ppvGS805ltn0Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IgmaXU1t56yfNOvUBbXMAV5UkrjaHK6Vsn4HnnThZx5mazGwlEeGxejhyB4Zheo5c
         DThGe01Wvw7ZpeECCJVYhXUNa3w5uCjz6DQd9anvI0LG+mc+uzBLIBeOKK7o7C70Sc
         HRuacz4YfI3J0RbA8pgIXpvPX0SxTwwjNLfxq1jw=
Received: from [100.100.34.13] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 0F71F600AE;
        Mon, 10 Jul 2023 12:45:17 +0800 (CST)
Message-ID: <51181fd7-fc1f-2222-9b8a-8ce44fe85ea5@xen0n.name>
Date:   Mon, 10 Jul 2023 12:45:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] LoongArch: Fix module relocation error with binutils 2.41
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230710042924.2518198-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230710042924.2518198-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/7/10 12:29, Huacai Chen wrote:
> Binutils 2.41 enable linker relaxation by default, but kernel module

"enables" / "will enable"

> loader doesn't support that, so disable it. Otherwise we get such an
> error when loading modules: "Unknown relocation type 102".

IMO it could be better to also justify the disabling (instead of adding 
proper support): linker relaxation is relatively large complexity that 
may or may not bring a similar gain, and we don't really want to include 
this linker pass in the kernel.

> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 09ba338a64de..7466d3b15db8 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -68,6 +68,8 @@ LDFLAGS_vmlinux			+= -static -n -nostdlib
>   ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
>   cflags-y			+= $(call cc-option,-mexplicit-relocs)
>   KBUILD_CFLAGS_KERNEL		+= $(call cc-option,-mdirect-extern-access)
> +KBUILD_AFLAGS_MODULE		+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno-relax)
> +KBUILD_CFLAGS_MODULE		+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno-relax)
>   else
>   cflags-y			+= $(call cc-option,-mno-explicit-relocs)
>   KBUILD_AFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel

The code changes are good. With the commit message improved:

Reviewed-by: WANG Xuerui <git@xen0n.name>

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

