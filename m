Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65636D6684
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 17:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjDDPAF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 11:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjDDO72 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 10:59:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B953C2F;
        Tue,  4 Apr 2023 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KBh4rzbfHfMkMMlE9cw+MqyUsj44Di5Ker7OlwFYGXg=; b=FmENSU8DdsJwRKLNIy11pT5rwr
        gZFbISKwxtxGEbpRDZI+PdPBb8ubt+23BYYSER2yHfUnSI2zgXRlA/A9liB6dhfL6rTy6LYIMRvQm
        gyR6cAIG2mB+TC5hkfYw1+vYNcbuY++BpvLFCCjlbeWJmHkcNxGqSYl+N/wcgrOkou9YFrZd67E9m
        w2uM4nUqUiAoo0Tu2WJytt+fQkxTpy55fgWCKZrUonHITpNDOnhhCxIBg+tWp3ViIM8YS9U4v2tUE
        9jirZfuWp7fZAvU8W0ipyUy++FGIYwgfKD5XO1ksJowLv7OYriDmtjptXbGAC0187adFlCZx+HUPA
        RAWV4RFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pji6d-00FSN3-3U; Tue, 04 Apr 2023 14:57:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7720D30003A;
        Tue,  4 Apr 2023 16:57:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C05626442AC2; Tue,  4 Apr 2023 16:57:51 +0200 (CEST)
Date:   Tue, 4 Apr 2023 16:57:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yair Podemsky <ypodemsk@redhat.com>
Cc:     linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, paulmck@kernel.org,
        jpoimboe@kernel.org, samitolvanen@google.com, frederic@kernel.org,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com, alougovs@redhat.com
Subject: Re: [PATCH 2/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to MM CPUs
Message-ID: <20230404145751.GA297936@hirez.programming.kicks-ass.net>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-3-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404134224.137038-3-ypodemsk@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 04, 2023 at 04:42:23PM +0300, Yair Podemsky wrote:
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 2b93cf6ac9ae..5ea9be6fb87c 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -191,7 +191,13 @@ static void tlb_remove_table_smp_sync(void *arg)
>  	/* Simply deliver the interrupt */
>  }
>  
> -void tlb_remove_table_sync_one(void)
> +#ifdef CONFIG_ARCH_HAS_CPUMASK_BITS
> +#define REMOVE_TABLE_IPI_MASK mm_cpumask(mm)
> +#else
> +#define REMOVE_TABLE_IPI_MASK NULL
> +#endif /* CONFIG_ARCH_HAS_CPUMASK_BITS */
> +
> +void tlb_remove_table_sync_one(struct mm_struct *mm)
>  {
>  	/*
>  	 * This isn't an RCU grace period and hence the page-tables cannot be
> @@ -200,7 +206,8 @@ void tlb_remove_table_sync_one(void)
>  	 * It is however sufficient for software page-table walkers that rely on
>  	 * IRQ disabling.
>  	 */
> -	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
> +	on_each_cpu_mask(REMOVE_TABLE_IPI_MASK, tlb_remove_table_smp_sync,
> +			NULL, true);
>  }

Uhh, I don't think NULL is a valid @mask argument. Should that not be
something like:

#ifdef CONFIG_ARCH_HAS_CPUMASK
#define REMOVE_TABLE_IPI_MASK mm_cpumask(mm)
#else
#define REMOVE_TABLE_IPI_MASK cpu_online_mask
#endif

	preempt_disable();
	on_each_cpu_mask(REMOVE_TABLE_IPI_MASK, tlb_remove_table_smp_sync, NULL true);
	preempt_enable();


?
