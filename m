Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E207527114
	for <lists+linux-arch@lfdr.de>; Sat, 14 May 2022 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiENM4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 May 2022 08:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiENM4n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 May 2022 08:56:43 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ED455AD;
        Sat, 14 May 2022 05:56:40 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CE700240005;
        Sat, 14 May 2022 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652532997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oM8SGEEmjqKyTL4PH4BUvpxyMwUaIngixmnGGZ9iZ0A=;
        b=Ob+fPlJen2ehiRjMLuUBKMlg0bkjx4JCLSqFi4diPnQwLi5D6eIrWMYNHCnw5CfFr9dvQS
        Ul9BxgQ5sUHl1gKPcBctJ6J2M2K1dzuVZUAo8BrLpmqeplB9VsRScePUkFLu+XbNKJAMNu
        DixHweOpIFN1Ck6E061REZssX1Sk2vs+0rhHag+HWZwOjTUAGlv0S1+/WWRDLL2URwo/m2
        68fBJohtVWRPMGlf8Kuqkke1CyCJ6d/RKY/oK9YBft2tzWG74QSts8k4sS0ARyY1nPn/sA
        hqmUNYTxwhKl2EBu+AUsdPV8N0gRcu4jh+4Gf5wbV8yhIP5fLYvJm9r2lifu1g==
Date:   Sat, 14 May 2022 14:56:32 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
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
Subject: Re: [PATCH V10 16/22] LoongArch: Add misc common routines
Message-ID: <Yn+nAFCA/+Wm+rC/@mail.local>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-17-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514080402.2650181-17-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 14/05/2022 16:03:56+0800, Huacai Chen wrote:
> diff --git a/arch/loongarch/kernel/rtc.c b/arch/loongarch/kernel/rtc.c
> new file mode 100644
> index 000000000000..d7568385219f
> --- /dev/null
> +++ b/arch/loongarch/kernel/rtc.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <asm/loongson.h>
> +
> +#define RTC_TOYREAD0    0x2C
> +#define RTC_YEAR        0x30
> +
> +unsigned long loongson_get_rtc_time(void)
> +{
> +	unsigned int year, mon, day, hour, min, sec;
> +	unsigned int value;
> +
> +	value = ls7a_readl(LS7A_RTC_REG_BASE + RTC_TOYREAD0);
> +	sec = (value >> 4) & 0x3f;
> +	min = (value >> 10) & 0x3f;
> +	hour = (value >> 16) & 0x1f;
> +	day = (value >> 21) & 0x1f;
> +	mon = (value >> 26) & 0x3f;
> +	year = ls7a_readl(LS7A_RTC_REG_BASE + RTC_YEAR);
> +
> +	year = 1900 + year;
> +
> +	return mktime64(year, mon, day, hour, min, sec);
> +}
> +
> +void read_persistent_clock64(struct timespec64 *ts)
> +{

This should rather be implemented in a proper rtc driver and then have
userspace set the system time or use hctosys.

> +	ts->tv_sec = loongson_get_rtc_time();
> +	ts->tv_nsec = 0;
> +}
> -- 
> 2.27.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
