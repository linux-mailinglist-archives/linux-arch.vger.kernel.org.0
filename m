Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A746A6A6E
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 11:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCAKHf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 05:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCAKHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 05:07:35 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7817F3B664;
        Wed,  1 Mar 2023 02:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1677665250; bh=v2kuNm+Q39kK7NHvc+m9+z6V+1IGL9skdWhRln3C/7I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J13AztCgrcycFD3eJc5DKBwOUJ+WeByW2G1Si+X6jzYCLeVlWPugqbh54Jps3IT1I
         C8sX9W0PkB8buEivEbRMEtSrHh96yjSQ6u69wNdneQ8wzYkKU+BMrXXXu8BevFTUjx
         9eWA5LF93/9sEv7ppRfyIGozb25vmirQ01j0yP/c=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 9070F600D4;
        Wed,  1 Mar 2023 18:07:29 +0800 (CST)
Message-ID: <b22aa314-5804-ef10-7865-2445222e2f49@xen0n.name>
Date:   Wed, 1 Mar 2023 18:07:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] LoongArch: Export some symbols without GPL
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230301085109.2373524-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230301085109.2373524-1-chenhuacai@loongson.cn>
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

Hi,

On 2023/3/1 16:51, Huacai Chen wrote:
> Some symbols, i.e., vm_map_base, empty_zero_page and invalid_pmd_table,
> could be accessed widely by some out-of-tree non-GPL but important file
> systems or drivers (e.g., OpenZFS). Let's use EXPORT_SYMBOL() instead of
> EXPORT_SYMBOL_GPL() to export them, so as to avoid build errors.

The commit title probably could become "Mark 3 symbol exports as non-GPL".

Also you could drop the "some symbols, i.e.," part and go straight to 
the 3 symbols. It sounds more natural to me at least (because I know the 
current wording is 1:1 perfectly idiomatic Chinese, so it is highly 
likely some adjustment would be needed: idiomatic English don't 
*perfectly* map to Chinese).

In addition to this, I've did some archaeology:

In the OpenZFS case, empty_zero_page and vm_map_base are affected. 
vm_map_base is arch/loongarch invention so we actually kind of have 
"authority" over it, but what follows is a little more background on why 
EXPORT_SYMBOL is arguably more appropriate for empty_zero_page.

As it stands today, only 3 architectures export empty_zero_page as a GPL 
symbol: ia64, loongarch and mips. loongarch gets the GPL export by 
inheriting from mips, and the mips export was first introduced in commit 
497d2adcbf50b ("[MIPS] Export empty_zero_page for sake of the ext4 
module."). The ia64 export was similar: commit a7d57ecf4216e ("[IA64] 
Export three symbols for module use") did so for kvm.

In both ia64 and mips, the export of empty_zero_page was done for 
satisfying some in-kernel component built as module (kvm and ext4 
respectively), and given its reasonably low-level nature, GPL is a 
reasonable choice. But looking at the bigger picture it is evident most 
other architectures do not regard it as GPL, so in effect the symbol 
probably should not be treated as such, in favor of consistency.

You could incorporate some or all of this into the commit message to 
give others some background on the justification. After all reverting 
symbols to non-GPL is relatively rare compared to all the GPL-marking 
actions.

> 
> Details about vm_map_base: may be referenced through macros PCI_IOBASE,
> VMALLOC_START and VMALLOC_END.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/kernel/cpu-probe.c | 2 +-
>   arch/loongarch/mm/init.c          | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
> index 008b0249905f..001e43dd94ca 100644
> --- a/arch/loongarch/kernel/cpu-probe.c
> +++ b/arch/loongarch/kernel/cpu-probe.c
> @@ -60,7 +60,7 @@ static inline void set_elf_platform(int cpu, const char *plat)
>   
>   /* MAP BASE */
>   unsigned long vm_map_base;
> -EXPORT_SYMBOL_GPL(vm_map_base);
> +EXPORT_SYMBOL(vm_map_base);
>   
>   static void cpu_probe_addrbits(struct cpuinfo_loongarch *c)
>   {
> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> index e018aed34586..3b7d8129570b 100644
> --- a/arch/loongarch/mm/init.c
> +++ b/arch/loongarch/mm/init.c
> @@ -41,7 +41,7 @@
>    * don't have to care about aliases on other CPUs.
>    */
>   unsigned long empty_zero_page, zero_page_mask;
> -EXPORT_SYMBOL_GPL(empty_zero_page);
> +EXPORT_SYMBOL(empty_zero_page);
>   EXPORT_SYMBOL(zero_page_mask);
>   
>   void setup_zero_pages(void)
> @@ -270,7 +270,7 @@ pud_t invalid_pud_table[PTRS_PER_PUD] __page_aligned_bss;
>   #endif
>   #ifndef __PAGETABLE_PMD_FOLDED
>   pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
> -EXPORT_SYMBOL_GPL(invalid_pmd_table);
> +EXPORT_SYMBOL(invalid_pmd_table);
>   #endif
>   pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
>   EXPORT_SYMBOL(invalid_pte_table);

And in the latter two cases it seems we're actually fixing 
inconsistencies. Nice!

Reviewed-by: WANG Xuerui <git@xen0n.name>

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

