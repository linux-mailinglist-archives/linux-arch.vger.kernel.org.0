Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65373527556
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 06:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiEOETE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 00:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiEOETD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 00:19:03 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4F93BBED;
        Sat, 14 May 2022 21:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652588340; bh=h/aaa/CG/4OCUxldGkOvQD+b2Y2kPcFZ7UF3xO706k8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=w7DcE2hNI0XM3PjvNd2zAlQo15Db0AxKojSSbvcaBNaPFscsHag2Xzd1TDWELCb+1
         VELxgqcNQgdjPhy7J3dx/e5Ga2nzchTKgffuAnVMF/jEUIcAXgdZBLktIvDIi+qlAs
         WTV0llrf7x50ATs1nr2zkiewCyqzrZUnKPAQDUew=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id D3922600B5;
        Sun, 15 May 2022 12:18:59 +0800 (CST)
Message-ID: <9dbdcb6d-90bc-e49c-cbdd-44f33b3f2351@xen0n.name>
Date:   Sun, 15 May 2022 12:18:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V10 04/22] LoongArch: Add writecombine support for drm
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
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-5-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220514080402.2650181-5-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 5/14/22 16:03, Huacai Chen wrote:
> LoongArch maintains cache coherency in hardware, but its WUC attribute
> (Weak-ordered UnCached, which is similar to WC) is out of the scope of
> cache coherency machanism. This means WUC can only used for write-only
> memory regions.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/gpu/drm/drm_vm.c         | 2 +-
>   drivers/gpu/drm/ttm/ttm_module.c | 2 +-
>   include/drm/drm_cache.h          | 8 ++++++++
>   3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
> index e957d4851dc0..f024dc93939e 100644
> --- a/drivers/gpu/drm/drm_vm.c
> +++ b/drivers/gpu/drm/drm_vm.c
> @@ -69,7 +69,7 @@ static pgprot_t drm_io_prot(struct drm_local_map *map,
>   	pgprot_t tmp = vm_get_page_prot(vma->vm_flags);
>   
>   #if defined(__i386__) || defined(__x86_64__) || defined(__powerpc__) || \
> -    defined(__mips__)
> +    defined(__mips__) || defined(__loongarch__)
>   	if (map->type == _DRM_REGISTERS && !(map->flags & _DRM_WRITE_COMBINING))
>   		tmp = pgprot_noncached(tmp);
>   	else
> diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
> index a3ad7c9736ec..b3fffe7b5062 100644
> --- a/drivers/gpu/drm/ttm/ttm_module.c
> +++ b/drivers/gpu/drm/ttm/ttm_module.c
> @@ -74,7 +74,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
>   #endif /* CONFIG_UML */
>   #endif /* __i386__ || __x86_64__ */
>   #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
> -	defined(__powerpc__) || defined(__mips__)
> +	defined(__powerpc__) || defined(__mips__) || defined(__loongarch__)
>   	if (caching == ttm_write_combined)
>   		tmp = pgprot_writecombine(tmp);
>   	else
> diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
> index 22deb216b59c..08e0e3ffad13 100644
> --- a/include/drm/drm_cache.h
> +++ b/include/drm/drm_cache.h
> @@ -67,6 +67,14 @@ static inline bool drm_arch_can_wc_memory(void)
>   	 * optimization entirely for ARM and arm64.
>   	 */
>   	return false;
> +#elif defined(CONFIG_LOONGARCH)
> +	/*
> +	 * LoongArch maintains cache coherency in hardware, but its WUC attribute
> +	 * (Weak-ordered UnCached, which is similar to WC) is out of the scope of
> +	 * cache coherency machanism. This means WUC can only used for write-only
> +	 * memory regions.
> +	 */
> +	return false;
>   #else
>   	return true;
>   #endif

The code changes look reasonable, given the adequate comments, but have 
the drm people given acks? This seems to exclusively touch drm bits and 
not directly related to arch bring-up. (You may get scrambled screen 
output but everything else is working, I'm running my LoongArch devbox 
headlessly ever since I first set it up last year.)

If anything, IMO you could even take this patch out and still get the 
arch properly brought up. What do others think?

Nevertheless,

Reviewed-by: WANG Xuerui <git@xen0n.name>

