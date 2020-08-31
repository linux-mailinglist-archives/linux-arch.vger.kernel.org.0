Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720AF257B24
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHaOQO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgHaOQJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 10:16:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32468C061573
        for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2020 07:16:06 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w1so1968943edr.3
        for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2020 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MQqx7y3LNHRl2Hja22cjbswtkGc/E1FQj6IzdW9NZtg=;
        b=Cslil3lNQuI0x+eP5rZvfAI5i06RIx9I8HVhB0ZoNY66Ro0BhD8CeBzQHrtAFBujAZ
         8CbydJ7ByJ3tIfIZizWaxbyQwiUO0zMFdV4jaf7GoeARcd8XVpaOhZekcAnwW5IVPeaP
         rJhPVDhm4U+MxBZemGSt45KUCawD4Hnfnu2hQF0+/CmK0l267m2GNNSO5okX7aESA3w6
         Yr31n9WXW84yLjrWOa0xNFK2Obj2+SmmD4+RPNc34TpR7qCbrfnkCQitO5/gg85O1Snm
         RUimj6V1T7p4BMc/xfHJhQsj6Q89Q709VapiGBXldJH1Zs26xS/4jnGJc/7JAGrLrePl
         RC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MQqx7y3LNHRl2Hja22cjbswtkGc/E1FQj6IzdW9NZtg=;
        b=UASvYUKcBfLUhcYkNc9l2GjKsA0WLbcogb1CNX3H/snYjRoXieUxZ1GeQnqglCiwSp
         hr7hs53y8jzRU81jUNnk/oZuviYdIpckF6HVX7o1bdmOaRBIQUf4qBY7/JlbZIItNhQ9
         wI6WgMCCv/NtDXmoHusrPckDzp2vjHKUFWAtpI0RdQRb/COx1LNBkfih8w1k88bNYWhE
         hLNFiYIjCC88DKujwW7vawqy9h/otVEldrwUTd+Wh3BZ4+jQwE8JhW6zP9FvuGHFPCL4
         lIkaO5sNOdtgRPz5zYGwMTvoD5wguQUobNZwBEG9PmsTQLGXsWK1/tMGpH0n0cWaxA6r
         9uMQ==
X-Gm-Message-State: AOAM5331H0U+cAAxfUMUU3NgcW5lMK7/ptOLz3WCjPJhlyeCiUH3Ub3e
        F+b8953OULXnzWBUeq+DwFZamA==
X-Google-Smtp-Source: ABdhPJxTUW8Sk91br4Y41M5OUbetxa4fQXLu8gSFvsyEuvcPZfJuAKj129esL8jjmQiECwHFeP8Myg==
X-Received: by 2002:a05:6402:1d97:: with SMTP id dk23mr1488478edb.350.1598883364628;
        Mon, 31 Aug 2020 07:16:04 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z21sm7780846edq.42.2020.08.31.07.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 07:16:02 -0700 (PDT)
Subject: Re: [PATCH v2 10/23] microblaze: use asm-generic/mmu_context.h for
 no-op implementations
To:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
 <20200826145249.745432-11-npiggin@gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <4d2bdc87-f39c-3737-0aa8-b2efe7b2d93e@monstr.eu>
Date:   Mon, 31 Aug 2020 16:15:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826145249.745432-11-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 26. 08. 20 16:52, Nicholas Piggin wrote:
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/microblaze/include/asm/mmu_context_mm.h | 8 ++++----
>  arch/microblaze/include/asm/processor.h      | 3 ---
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microblaze/include/asm/mmu_context_mm.h
> index a1c7dd48454c..c2c77f708455 100644
> --- a/arch/microblaze/include/asm/mmu_context_mm.h
> +++ b/arch/microblaze/include/asm/mmu_context_mm.h
> @@ -33,10 +33,6 @@
>     to represent all kernel pages as shared among all contexts.
>   */
>  
> -static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
> -{
> -}
> -
>  # define NO_CONTEXT	256
>  # define LAST_CONTEXT	255
>  # define FIRST_CONTEXT	1
> @@ -105,6 +101,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
>  /*
>   * We're finished using the context for an address space.
>   */
> +#define destroy_context destroy_context
>  static inline void destroy_context(struct mm_struct *mm)
>  {
>  	if (mm->context != NO_CONTEXT) {
> @@ -126,6 +123,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>   * After we have set current->mm to a new value, this activates
>   * the context for the new mm so we see the new mappings.
>   */
> +#define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *active_mm,
>  			struct mm_struct *mm)
>  {
> @@ -136,5 +134,7 @@ static inline void activate_mm(struct mm_struct *active_mm,
>  
>  extern void mmu_context_init(void);
>  
> +#include <asm-generic/mmu_context.h>
> +
>  # endif /* __KERNEL__ */
>  #endif /* _ASM_MICROBLAZE_MMU_CONTEXT_H */
> diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
> index 1ff5a82b76b6..616211871a6e 100644
> --- a/arch/microblaze/include/asm/processor.h
> +++ b/arch/microblaze/include/asm/processor.h
> @@ -122,9 +122,6 @@ unsigned long get_wchan(struct task_struct *p);
>  #  define KSTK_EIP(task)	(task_pc(task))
>  #  define KSTK_ESP(task)	(task_sp(task))
>  
> -/* FIXME */
> -#  define deactivate_mm(tsk, mm)	do { } while (0)
> -
>  #  define STACK_TOP	TASK_SIZE
>  #  define STACK_TOP_MAX	STACK_TOP
>  
> 

I am fine with the patch but I pretty much don't like that commit
message is empty and there is only subject.
With fixing that you can add my:
Acked-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

