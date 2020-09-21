Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066EA271AE6
	for <lists+linux-arch@lfdr.de>; Mon, 21 Sep 2020 08:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIUG2Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 02:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIUG2Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Sep 2020 02:28:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA6BC061755;
        Sun, 20 Sep 2020 23:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tci2tqg3leIbmrKKmdytiLIb3svt+yq3AUhipK0JnoY=; b=eHeD509SDxyAiHGiTwo9U9RK6O
        BdV0ol0+bUl0JcuR4cH5K4iJppCvrjMC+FXmd1lF9otzHdHbgaqWCPBbYEVccspM4hNb0ELFrDX41
        s330N9PwkKFmY1+L4xtZqC6TuuZXPpHTsXwNy2mxRh6hHZxeOvX7QA3hIrIh11xqjXXtgY0KOrH1g
        TAa/FH4UUQzLwOqDXwmFk20iXdkTE1C5bNJ47X+kA8GBuFsMKdIwnr8VE2F05aYZUn3BWrCVUA/8S
        mbIk+BpzsIVAf7vJcwgjD0vdvWTXz3H9YwI8DG/vud/142FwM17JAPgxfqgTAucNSaDR8ooXWbNYe
        L6UrCpkA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKFJD-0000eG-TH; Mon, 21 Sep 2020 06:28:19 +0000
Date:   Mon, 21 Sep 2020 07:28:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Paul McKenney <paulmck@kernel.org>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch RFC 02/15] highmem: Provide generic variant of
 kmap_atomic*
Message-ID: <20200921062819.GB32081@infradead.org>
References: <20200919091751.011116649@linutronix.de>
 <20200919092615.990731525@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919092615.990731525@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +# ifndef ARCH_NEEDS_KMAP_HIGH_GET
> +static inline void *arch_kmap_temporary_high_get(struct page *page)
> +{
> +	return NULL;
> +}
> +# endif

Turn this into a macro and use #ifndef on the symbol name?

> +static inline void __kunmap_atomic(void *addr)
> +{
> +	kumap_atomic_indexed(addr);
> +}
> +
> +
> +#endif /* CONFIG_KMAP_ATOMIC_GENERIC */

Stange double empty line above the endif.

> -#define kunmap_atomic(addr)                                     \
> -do {                                                            \
> -	BUILD_BUG_ON(__same_type((addr), struct page *));       \
> -	kunmap_atomic_high(addr);                                  \
> -	pagefault_enable();                                     \
> -	preempt_enable();                                       \
> -} while (0)
> -
> +#define kunmap_atomic(addr)						\
> +	do {								\
> +		BUILD_BUG_ON(__same_type((addr), struct page *));	\
> +		__kunmap_atomic(addr);					\
> +		preempt_enable();					\
> +	} while (0)

Why the strange re-indent to a form that is much less common and less
readable?

> +void *kmap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot)
> +{
> +	pagefault_disable();
> +	return __kmap_atomic_pfn_prot(pfn, prot);
> +}
> +EXPORT_SYMBOL(kmap_atomic_pfn_prot);

The existing kmap_atomic_pfn & co implementation is EXPORT_SYMBOL_GPL,
and this stuff should preferably stay that way.
