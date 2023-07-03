Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B82745E07
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jul 2023 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGCN6Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jul 2023 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGCN6X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2023 09:58:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36674E51;
        Mon,  3 Jul 2023 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/XBj/KASDZEwaINZN6zR62oMWEpcbbmzAAJb5oHzCeI=; b=W8MiGSK63K7sPBiin8aiix6wVO
        nHiTld2qumxTI7KLvLiwRcb6+D867gCT4fcfIrf2UUrOCFffjXpjVD2DolVTfso0nq3diFjiGDl7u
        I5R7gSTbdHSFUrmZXgVcKXmALtqvVzN9LEI4Lug2UX5PSrFU19UfvLyffICP0tjPS3Z263iCSCX8Q
        NG7pwby6B82QH/I9tyBuHDRRg52Dvqxu2PWPJE6HcnpfmsSfWKfnO9hjIskcCD2Vwy21zuqEGbyXI
        n52/HizMJdjIcYm/Lk/JIgxjXRuwiGvNZSsrmij1Tn9hr4h5xsz9/UA0pRH1DMprbqSBd5tjIh4q8
        Wxemefbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGK3e-00A60O-03;
        Mon, 03 Jul 2023 13:57:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FC4E30012F;
        Mon,  3 Jul 2023 15:57:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 308802028FBD3; Mon,  3 Jul 2023 15:57:34 +0200 (CEST)
Date:   Mon, 3 Jul 2023 15:57:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yair Podemsky <ypodemsk@redhat.com>
Cc:     mtosatti@redhat.com, ppandit@redhat.com, david@redhat.com,
        linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, keescook@chromium.org, paulmck@kernel.org,
        frederic@kernel.org, will@kernel.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to MM CPUs
Message-ID: <20230703135734.GK4253@hirez.programming.kicks-ass.net>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
 <20230620144618.125703-3-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620144618.125703-3-ypodemsk@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 20, 2023 at 05:46:18PM +0300, Yair Podemsky wrote:
> @@ -191,7 +191,13 @@ static void tlb_remove_table_smp_sync(void *arg)
>  	/* Simply deliver the interrupt */
>  }
>  
> -void tlb_remove_table_sync_one(void)
> +#ifdef CONFIG_ARCH_HAS_CPUMASK_BITS
> +#define REMOVE_TABLE_IPI_MASK mm_cpumask(mm)
> +#else
> +#define REMOVE_TABLE_IPI_MASK cpu_online_mask
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

Aside from what Dave said about the REMOVE_TABLE_IPI_MASK thing, this
isn't right.

on_each_cpu_mask() includes the current cpu, while smp_call_function()
explicitly does not.

Yes, they all end up in smp_call_function_many_cond(), but the
on_each_cpu*() family will have SCF_RUN_LOCAL set, while the
smp_call_function*() family will not.
