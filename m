Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2003BCB17
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhGFK77 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhGFK77 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:59:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B99C061574
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0ED2wyQ0c4Rxfv+xmvJo7P2JNd2XceomdovbEDcGj0g=; b=MGx3k6OGxPcxkj4wr+2yVS1A6h
        Mk3BRQWn8SbbC+k6TB2BadHmWyvimWOwDpIH+BibBP8/foj7H+2Gitg7j+jPCI6gkNn5uhpic8NZx
        yK8Fw9Gv8EeyI79Vitcr4IiytNVvvxKt1XJFAEubUibCx+Xn3Lf64LBH5ejlxtkDvbHurfsJ1/bpW
        WwWW7TFIC0YJmbLZ9Hotdu0is2XN9aU3luoGY4oU0AiTniRL0FDnQ0r0IGmTGEiNUBolMBqA38Bny
        Rk/BtwUM0JRo3kquXgNpbvrA4uV2Vz8PI7FpGxtHWm8IZkCN945343jrpLZshdSh1ObiyGT5ii0Ar
        DB6VJjIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0ilE-00F1Sr-97; Tue, 06 Jul 2021 10:57:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2D73300233;
        Tue,  6 Jul 2021 12:57:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDAF0200D9D6C; Tue,  6 Jul 2021 12:57:00 +0200 (CEST)
Date:   Tue, 6 Jul 2021 12:57:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
Message-ID: <YOQ2/Dx3+r/R5jmu@hirez.programming.kicks-ass.net>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706041820.1536502-5-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 06, 2021 at 12:18:05PM +0800, Huacai Chen wrote:
> diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/include/asm/barrier.h
> new file mode 100644
> index 000000000000..8ab8d8f15b88
> --- /dev/null
> +++ b/arch/loongarch/include/asm/barrier.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_BARRIER_H
> +#define __ASM_BARRIER_H
> +
> +#include <asm/addrspace.h>
> +
> +#define __sync()	__asm__ __volatile__("dbar 0" : : : "memory")
> +
> +#define fast_wmb()	__sync()
> +#define fast_rmb()	__sync()
> +#define fast_mb()	__sync()
> +#define fast_iob()	__sync()
> +#define wbflush()	__sync()
> +
> +#define wmb()		fast_wmb()
> +#define rmb()		fast_rmb()
> +#define mb()		fast_mb()
> +#define iob()		fast_iob()

Is there any actual documentation about memory ordering for this
architecture? Or are you going to do the MIPS trainwreck?

Having a single full memory barrier for everything is very sad for a new
architecture, we're in 2021, not 1990s.
