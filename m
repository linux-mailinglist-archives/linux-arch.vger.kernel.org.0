Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9276E78B5E3
	for <lists+linux-arch@lfdr.de>; Mon, 28 Aug 2023 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjH1RFz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Aug 2023 13:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjH1RFa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Aug 2023 13:05:30 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01314E1;
        Mon, 28 Aug 2023 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1693242322; bh=wdm/od9k2G1TkbM8um/tI2Oyg+f12wcVxlgODMk1a2s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YTqA3v6nYyC1XpBUdxUQkEp0J+jzr57XhRVp5b8/7Ibr099uGdb3yRRMHPD4Js0dL
         o3iuePdl//J48+5crqpwEAV9RhKCpyz/Pnx4/aTECHQFO1hdZtDWAsJu/YDGQMq2q+
         ig8uiw3ELQeSsHqjfKLaSgiwjucn6I8kF8DlsdjQ=
Received: from [192.168.9.172] (unknown [101.88.24.218])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 0E28A6018A;
        Tue, 29 Aug 2023 01:05:22 +0800 (CST)
Message-ID: <08503cb1-102e-9101-51a1-47b7cf7cb0be@xen0n.name>
Date:   Tue, 29 Aug 2023 01:05:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] LoongArch: Remove shm_align_mask and use SHMLBA instead
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Jiantao Shan <shanjiantao@loongson.cn>
References: <20230828152540.1194317-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230828152540.1194317-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/28/23 23:25, Huacai Chen wrote:
> Both shm_align_mask and SHMLBA want to avoid cache alias. But they are
> inconsistent: shm_align_mask is (PAGE_SIZE - 1) while SHMLBA is SZ_64K,
> but PAGE_SIZE is not always equal to SZ_64K.
>
> This may cause problems when shmat() twice. Fix this problem by removing
> shm_align_mask and using SHMLBA (SHMLBA - 1, strctly) instead.
"strictly SHMLBA - 1"?
>
> Reported-by: Jiantao Shan <shanjiantao@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/mm/cache.c      |  1 -
>   arch/loongarch/mm/mmap.c       | 12 ++++--------
>   3 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
> index 72685a48eaf0..6be04d36ca07 100644
> --- a/arch/loongarch/mm/cache.c
> +++ b/arch/loongarch/mm/cache.c
> @@ -156,7 +156,6 @@ void cpu_cache_init(void)
>   
>   	current_cpu_data.cache_leaves_present = leaf;
>   	current_cpu_data.options |= LOONGARCH_CPU_PREFETCH;
> -	shm_align_mask = PAGE_SIZE - 1;
>   }
>   
>   static const pgprot_t protection_map[16] = {
> diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
> index fbe1a4856fc4..c99c8015651a 100644
> --- a/arch/loongarch/mm/mmap.c
> +++ b/arch/loongarch/mm/mmap.c
> @@ -8,12 +8,8 @@
>   #include <linux/mm.h>
>   #include <linux/mman.h>
>   
> -unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
> -EXPORT_SYMBOL(shm_align_mask);

By removing this altogether, a lot of code duplication is introduced it 
seems. Better make this a private #define so use sites remain nicely 
symbolic:

"#define SHM_ALIGN_MASK (SHMLBA - 1)"

> -
> -#define COLOUR_ALIGN(addr, pgoff)				\
> -	((((addr) + shm_align_mask) & ~shm_align_mask) +	\
> -	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
> +#define COLOUR_ALIGN(addr, pgoff)			\
> +	((((addr) + (SHMLBA - 1)) & ~(SHMLBA - 1)) + (((pgoff) << PAGE_SHIFT) & (SHMLBA - 1)))
>   
>   enum mmap_allocation_direction {UP, DOWN};
>   
> @@ -40,7 +36,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
>   		 * cache aliasing constraints.
>   		 */
>   		if ((flags & MAP_SHARED) &&
> -		    ((addr - (pgoff << PAGE_SHIFT)) & shm_align_mask))
> +		    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
>   			return -EINVAL;
>   		return addr;
>   	}
> @@ -63,7 +59,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
>   	}
>   
>   	info.length = len;
> -	info.align_mask = do_color_align ? (PAGE_MASK & shm_align_mask) : 0;
> +	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
>   	info.align_offset = pgoff << PAGE_SHIFT;
>   
>   	if (dir == DOWN) {

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

