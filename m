Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814DF3BD9F7
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 17:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhGFPUf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 11:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhGFPUb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 11:20:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7884C0613DE
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TmdOFM+mj6Uk1eEl22+IljwTx/zfo4lWBPGtrox+eSc=; b=ZdbdxkD+9wG8t3bOwN6eUlsALX
        FDPZNIcoRJeOaDBzS2h8WPv310DJilHmIKBSi3BEaheljbMt35x8krxmpCoyd9RlALcN+8tyFWQ5a
        3mpR0O7sl02VmMSYOCQyGJh3Ih/qpHV2/D1Dak4hs92+bNJn34DukyERvMrgjhNE9yYyNz/knfyfT
        vF0k0EIrsYP60qsYGwDFdTKa3jncu+eTp580SgqxlKcQvy2Aw1C2aSKO/j3bLA4PsA7y3hKMyeSss
        Lc7t6uPKUmbLu76XkcUlhLIzvjeTmaK9ZpA6ytkLOjjmnmcDpGext/BodgfQlJS1SnCd893lOfM+g
        CXVzdRPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0lUa-00BR90-2A; Tue, 06 Jul 2021 13:52:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA88D300056;
        Tue,  6 Jul 2021 15:52:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 942892028DC15; Tue,  6 Jul 2021 15:52:03 +0200 (CEST)
Date:   Tue, 6 Jul 2021 15:52:03 +0200
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
Subject: Re: [PATCH 17/19] LoongArch: Add multi-processor (SMP) support
Message-ID: <YORgAzFANxzhwUfL@hirez.programming.kicks-ass.net>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-18-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706041820.1536502-18-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 06, 2021 at 12:18:18PM +0800, Huacai Chen wrote:
> +#define __smp_load_acquire(p)							\
> +({										\
> +	union { typeof(*p) __val; char __c[1]; } __u;				\
> +	unsigned long __tmp = 0;							\
> +	compiletime_assert_atomic_type(*p);					\
> +	switch (sizeof(*p)) {							\
> +	case 1:									\
> +		*(__u8 *)__u.__c = *(volatile __u8 *)p;				\
> +		__smp_mb();							\
> +		break;								\
> +	case 2:									\
> +		*(__u16 *)__u.__c = *(volatile __u16 *)p;			\
> +		__smp_mb();							\
> +		break;								\
> +	case 4:									\
> +		__asm__ __volatile__(						\
> +		"amor.w %[val], %[tmp], %[mem]	\n"				\
> +		: [val] "=&r" (*(__u32 *)__u.__c)				\
> +		: [mem] "ZB" (*(u32 *) p), [tmp] "r" (__tmp)			\
> +		: "memory");							\
> +		break;								\
> +	case 8:									\
> +		__asm__ __volatile__(						\
> +		"amor.d %[val], %[tmp], %[mem]	\n"				\
> +		: [val] "=&r" (*(__u64 *)__u.__c)				\
> +		: [mem] "ZB" (*(u64 *) p), [tmp] "r" (__tmp)			\
> +		: "memory");							\
> +		break;								\
> +	default:								\
> +		barrier();							\
> +		__builtin_memcpy((void *)__u.__c, (const void *)p, sizeof(*p));	\
> +		__smp_mb();							\

smp_load_acquire() is explicitly not defined on longer than machine word
sizes.

> +	}									\
> +	__u.__val;								\
> +})

By using that cute AMO-fetch-or, this LOAD turns into a LOAD-STORE
cycle. Which means you cannot use it on RO memory -- also cache fail.

Surely just the volatile load and smp_mb() is faster and saner.
