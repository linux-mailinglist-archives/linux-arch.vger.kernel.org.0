Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ED95274B7
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 02:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiEOABo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 May 2022 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiEOABn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 May 2022 20:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96624F34;
        Sat, 14 May 2022 17:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ED7360C77;
        Sun, 15 May 2022 00:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92ED8C340EE;
        Sun, 15 May 2022 00:01:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LF2BHC23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652572895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbeJpfAzZqKlcW2gnPn7UeQQW5Vthh4v2JU+1Y3Do4I=;
        b=LF2BHC23HiZypFaW4/oFFz3rtooK0g3A0x0ESrklX/UPaMHFSf5n5TZlBzYdpIJ/YF1qZG
        KPvuYzVJlTID9PqF9aIhy6BNXVTqmogF11Cr2ko9+w3MkzxycBCycpP4t51xeVnZKyJQqR
        nKDPiErAdUSPZO8QLBxzIfy2wSIHa3o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1e89a44e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 15 May 2022 00:01:35 +0000 (UTC)
Date:   Sun, 15 May 2022 02:01:31 +0200
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
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH V10 08/22] LoongArch: Add other common headers
Message-ID: <YoBC2+2fvmNtcftr@zx2c4.com>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-9-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220514080402.2650181-9-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 14, 2022 at 04:03:48PM +0800, Huacai Chen wrote:
> diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
> new file mode 100644
> index 000000000000..3f8db082f00d
> --- /dev/null
> +++ b/arch/loongarch/include/asm/timex.h
> @@ -0,0 +1,31 @@
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
> +static inline cycles_t get_cycles(void)
> +{
> +	return drdtime();
> +}

Please add:

    #define get_cycles get_cycles

which is what other archs are getting for 5.19.

Jason
