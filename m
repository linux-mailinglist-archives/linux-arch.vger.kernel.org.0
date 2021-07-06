Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27A93BD68C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhGFMh1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 08:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245148AbhGFMM3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 08:12:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B59C06175F
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2t9sN6puYeqWD9QWqD72qQ4Fzv8Fx8r3Cx6JTjnUVJg=; b=g31MsG5x4LTSqYN28VWLpEd6FF
        ncj/v1D/9cU3rdKCNK8bMug+nigVzn6TLTRXE0fYC84NFckHdqEDY16gzUKmkhcWINlZlB+Cl3jl3
        s2MqJz/kgJstcL0B190lAgkDeyczrpCIaCMYvZt1ktnBJoBHUdax0uDAX6VUamhtzfh7c8UPw7wc/
        QkgVA2oIsgJ4K8azrCvyQrlcdJBGovjKhy63dZTACnx3VYQTGvouQPsiUj4oekOo6XRhGlYZeW4OL
        yjexadnBXEGWxU+u6D/K7DgsJXmY/8iyq0bcxVgFUNvE3FKAdlYOuISbB1LkO2mXQygfxMDvwjAa5
        rpzmQAaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0jjS-00BHIx-Os; Tue, 06 Jul 2021 11:59:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8ED43001DC;
        Tue,  6 Jul 2021 13:59:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3747200E4A06; Tue,  6 Jul 2021 13:59:17 +0200 (CEST)
Date:   Tue, 6 Jul 2021 13:59:17 +0200
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
Message-ID: <YORFlcUWeKZsBTUi@hirez.programming.kicks-ass.net>
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
> +		__asm__ __volatile__(
> +		"1:	ll.w	%1, %2		# atomic_sub_if_positive\n"
> +		"	addi.w	%0, %1, %3				\n"
> +		"	or	%1, %0, $zero				\n"
> +		"	blt	%0, $zero, 1f				\n"
> +		"	sc.w	%1, %2					\n"
> +		"	beq	$zero, %1, 1b				\n"
> +		"1:							\n"

Can you please make that 2: for everyone's sanity? (idem for all the
other sites you done this).

> +		: "=&r" (result), "=&r" (temp),
> +		  "+" GCC_OFF_SMALL_ASM() (v->counter)
> +		: "I" (-i));
