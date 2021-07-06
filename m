Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98EA3BD439
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 14:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbhGFMFm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbhGFLg5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 07:36:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A53DC0A8878
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rx9zsygjVKO6Fd94HbJP1bvxBX1w6e7olzywzjqToVI=; b=CYKtm9goucH5L0MK2NHyqLkIam
        GYPxdPr6Ue/lhK/4pBiXnWaJWMClqPFZYPmjPswk7IliqaWdQYd4niBiG3jSym3Tj4F+KF22W1jaW
        Snq9E8Ij078g++7C70WPt+en92sAy7MzVSrqJ1MA2HDN23m975ojKd2DOhNUlEPeo8ZpDEB8Av+Ot
        EBqFKMIYXdVL5cx9eZ+Brsw2XPzyiPWpeOh9I1pPI+nimNCQ4FhUB91z5icRWHUDrDBpMv03qU53S
        p7oixBkmG3xp9sKXDkD7BiOtoR/NYiVi4Gn5QFWXkC8yKIdiWNevh8KJNQtHbCqY443sNU9CypB07
        q0EXQ7UQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0jAo-00F1ox-0v; Tue, 06 Jul 2021 11:23:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76240300233;
        Tue,  6 Jul 2021 13:23:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46EC4200843AD; Tue,  6 Jul 2021 13:23:28 +0200 (CEST)
Date:   Tue, 6 Jul 2021 13:23:28 +0200
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
Message-ID: <YOQ9MGbTrPKWl1N/@hirez.programming.kicks-ass.net>
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
> +/* CSR */
> +static inline u32 csr_readl(u32 reg)
> +{
> +	return __csrrd(reg);
> +}
> +
> +static inline u64 csr_readq(u32 reg)
> +{
> +	return __dcsrrd(reg);
> +}
> +
> +static inline void csr_writel(u32 val, u32 reg)
> +{
> +	__csrwr(val, reg);
> +}
> +
> +static inline void csr_writeq(u64 val, u32 reg)
> +{
> +	__dcsrwr(val, reg);
> +}
> +
> +static inline u32 csr_xchgl(u32 val, u32 mask, u32 reg)
> +{
> +	return __csrxchg(val, mask, reg);
> +}
> +
> +static inline u64 csr_xchgq(u64 val, u64 mask, u32 reg)
> +{
> +	return __dcsrxchg(val, mask, reg);
> +}

What are these __csrfoo() things, I cannot seem to find a definition of
them anywhere..
