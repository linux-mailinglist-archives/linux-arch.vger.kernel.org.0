Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B95472E39B
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 15:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbjFMNBO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242486AbjFMNBM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 09:01:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32A71734
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 06:01:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso7561595e9.0
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686661269; x=1689253269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOXAw3N0QLUmhl9VhAasY8VpoF1ITbQ/C2xV1UG3SvY=;
        b=SCzheP188hDhSW3yx/yBltis0n46wXq6+HYX4XK5bSFxYqaiy0CTYRu48aCV9U6yhP
         892Su+mJ27pIwHfwG1dLkluD9LhNwNUQmZzETRnDOiLFxZrKKjqWG8caRWtyHWURvRum
         Y71YuejOUK1oT4F7H7IQsC9MlMZ4QY02q5UjVg2yWEF+xP9UNqsillUJXtyqr4wRG+cc
         XqMCTMF/HsKC5QTE/Qh4yfxITY9MwlIABxJROHykiSAqDz98Qbjmxk0qlG4St4YVs2HN
         k2GodccQxTLjI7qOIiQlffNOzA0E/r7gRoW/p3ga7O0a/roXhPZQodCYygBZlYAgd6tv
         Z+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686661269; x=1689253269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOXAw3N0QLUmhl9VhAasY8VpoF1ITbQ/C2xV1UG3SvY=;
        b=BQLECezjdHP7C+waUe6HWO5oQthBaPOsBgKN/ok7I6DdVI2ImcjiEcgkMR1CirNbsA
         KRhH7CaOqZ9+wDYKqsmvS5miFqPGfzptl5FrdSn9Nw50ybyBt5bRoO01Rsghmd3GGXLy
         8DeDOmzmMY4822gcO52SSXCZoK5ebjmR4CCI2nddEZATxsgWAcAiA+NvHh7Lv57cO3ou
         zeaV3TDg+WMufn0+NUCOlOIPKCuH0stVUeGBPGup7PeZeLbZyNp8ikoumP+EjtBu+MsB
         pQ0QfH7LvCxWvtkcmFRmaZozkkD1djpQNbVcRO5LVyMamgsUm/2WyhtJ5WEyNompG509
         ORYg==
X-Gm-Message-State: AC+VfDzw8XTslB9wtCpCucE/hDkA+eRSrgvJm6S0VCbgwU/mDWWAW7UG
        TDEJRtsdBSiEGQWuvt71alF99g==
X-Google-Smtp-Source: ACHHUZ7souI+dx9fRazMepY3th0ShmUbMRKdVHs47vqo/IJMam4Wbe9ZTuR8tN0WeZs8tAGFUV1zMg==
X-Received: by 2002:a05:600c:3501:b0:3f5:927:2b35 with SMTP id h1-20020a05600c350100b003f509272b35mr9996222wmq.1.1686661268841;
        Tue, 13 Jun 2023 06:01:08 -0700 (PDT)
Received: from ?IPV6:2a01:cb15:81c2:f100:cd4e:ad51:613b:f447? ([2a01:cb15:81c2:f100:cd4e:ad51:613b:f447])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c114a00b003f7e60622f0sm14406350wmz.6.2023.06.13.06.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 06:01:08 -0700 (PDT)
Message-ID: <f686f36b-4c09-5099-3ba4-90f87f914654@rivosinc.com>
Date:   Tue, 13 Jun 2023 15:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next V12 1/3] riscv: stack: Support
 HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     guoren@kernel.org, arnd@arndb.de, palmer@rivosinc.com,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        bjorn@kernel.org, greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, paul.walmsley@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230529084600.2878130-1-guoren@kernel.org>
 <20230529084600.2878130-2-guoren@kernel.org>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230529084600.2878130-2-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 29/05/2023 10:45, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add independent irq stacks for percpu to prevent kernel stack overflows.
> It is also compatible with VMAP_STACK by arch_alloc_vmap_stack.
> 
> Tested-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Conor Dooley <conor.dooley@microchip.com>
> ---
>   arch/riscv/Kconfig                   |  7 ++++++
>   arch/riscv/include/asm/irq_stack.h   | 32 +++++++++++++++++++++++++
>   arch/riscv/include/asm/thread_info.h |  2 ++
>   arch/riscv/kernel/irq.c              | 33 ++++++++++++++++++++++++++
>   arch/riscv/kernel/traps.c            | 35 ++++++++++++++++++++++++++--
>   5 files changed, 107 insertions(+), 2 deletions(-)
>   create mode 100644 arch/riscv/include/asm/irq_stack.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fa256f2e23c1..44b4c9690f94 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -588,6 +588,13 @@ config FPU
>   
>   	  If you don't know what to do here, say Y.
>   
> +config IRQ_STACKS
> +	bool "Independent irq stacks" if EXPERT
> +	default y
> +	select HAVE_IRQ_EXIT_ON_IRQ_STACK
> +	help
> +	  Add independent irq stacks for percpu to prevent kernel stack overflows.
> +
>   endmenu # "Platform type"
>   
>   menu "Kernel features"
> diff --git a/arch/riscv/include/asm/irq_stack.h b/arch/riscv/include/asm/irq_stack.h
> new file mode 100644
> index 000000000000..b0dcee9a3fa2
> --- /dev/null
> +++ b/arch/riscv/include/asm/irq_stack.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_RISCV_IRQ_STACK_H
> +#define _ASM_RISCV_IRQ_STACK_H
> +
> +#include <linux/bug.h>
> +#include <linux/gfp.h>
> +#include <linux/kconfig.h>
> +#include <linux/vmalloc.h>
> +#include <linux/pgtable.h>
> +#include <asm/thread_info.h>
> +
> +DECLARE_PER_CPU(ulong *, irq_stack_ptr);
> +
> +#ifdef CONFIG_VMAP_STACK
> +/*
> + * To ensure that VMAP'd stack overflow detection works correctly, all VMAP'd
> + * stacks need to have the same alignment.
> + */
> +static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
> +{
> +	void *p;
> +
> +	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));

Hi Guo,

Since this function is already guarded with #ifdef CONFIG_VMAP_STACK, I 
guess this BUILD_BUG_ON() is unnecessary).

Clément
