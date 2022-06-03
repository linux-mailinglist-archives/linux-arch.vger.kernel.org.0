Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E5F53CAC4
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 15:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbiFCNlN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 09:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiFCNlL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 09:41:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A266F33375;
        Fri,  3 Jun 2022 06:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F3D8B82336;
        Fri,  3 Jun 2022 13:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE3FC385B8;
        Fri,  3 Jun 2022 13:41:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="phyVwxW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654263663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K1HzLPo4qxiHGh3bnL/3IKmiTPz5L0lYhMPjd5oJuMk=;
        b=phyVwxW+C5XVYbh/egIVh2lGmIhFJNWX0LVc7lgz05w2u3RJVS1QE9Vv08PPgGfPfyjO60
        Nlp3vTR9tMr7luUx/90pZIf0DMqjO+Dc07A2sZoYhw3qhbVXphtWihAeP9PS6k02PYUOTD
        7Kbbc/WxM82tjm72SgwFHBy4XERVMpw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f75f6eda (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 3 Jun 2022 13:41:02 +0000 (UTC)
Date:   Fri, 3 Jun 2022 15:40:54 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
Subject: Re: [PATCH V15 10/24] LoongArch: Add other common headers
Message-ID: <YpoPZjJ/Adfu3uH9@zx2c4.com>
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
 <20220603072053.35005-11-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220603072053.35005-11-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

On Fri, Jun 03, 2022 at 03:20:39PM +0800, Huacai Chen wrote:
> diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
> new file mode 100644
> index 000000000000..d3ed99a4fdbd
> --- /dev/null
> +++ b/arch/loongarch/include/asm/timex.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_TIMEX_H
> +#define _ASM_TIMEX_H
> +
> +#ifdef __KERNEL__
> +
> +#include <linux/compiler.h>
> +
> +#include <asm/cpu.h>
> +#include <asm/cpu-features.h>
> +
> +/*
> + * Standard way to access the cycle counter.
> + * Currently only used on SMP for scheduling.
> + *
> + * We know that all SMP capable CPUs have cycle counters.
> + */
> +
> +typedef unsigned long cycles_t;
> +
> +#define get_cycles get_cycles
> +
> +static inline cycles_t get_cycles(void)
> +{
> +	return drdtime();
> +}
> +
> +#endif /* __KERNEL__ */
> +
> +#endif /*  _ASM_TIMEX_H */

"Currently only used on SMP for scheduling" isn't quite correct. It's
also used by random_get_entropy(). And anything else that uses
get_cycles() for, e.g., benchmarking, might use it too.

You wrote also, "we know that all SMP capable CPUs have cycle counters",
so if I gather from this statement that some !SMP CPUs don't have a
cycle counter, though some do. If that's a correct supposition, then
you may need to rewrite this file to be something like:

    static inline bool cpu_has_rdtime(void)
    {
        return IS_ENABLED(CONFIG_SMP) ? true : { ... some magic to determine on !SMP ... };
    }

    typedef unsigned long cycles_t;
    static inline cycles_t get_cycles(void)
    {
    	return cpu_has_rdtime() ? drdtime() : 0;
    }
    #define get_cycles get_cycles

    static inline unsigned long random_get_entropy(void)
    {
        return cpu_has_rdtime() ? drdtime() : random_get_entropy_fallback();
    }
    #define random_get_entropy random_get_entropy

Does that make sense? More importantly, is my presumption about !SMP
correct?

In any case, please do CC me on this patch for v+1.

Regards,
Jason
