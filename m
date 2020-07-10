Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B391721B2A7
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 11:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGJJsN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGJJsN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 05:48:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EEEC08C5CE;
        Fri, 10 Jul 2020 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w3kp1+jdf3bXyU6T7tLgS3NnoV3a3u51ChfZ8zM0K6Y=; b=br/6N3S/jhoP3JJtrayUvCy7E2
        /oRU43tMNdc0fhNyVDv7fH8+PstYkTFr08/wfrTrxhGC49B2ucWOnnRIlRuLDLPqDItmT26eTHVVT
        rKad4E6DtLTLe7r82xihXktEnX6M01WB8CtpTMKx0JkiRXLtOdgDsB46LJ2Um4Kwx0VPp7Sn4uFnj
        9peCcN+glsBEtOBgkQNs5SlFneyn96pQGzqF1XgyfYmbBC6yaqpGsgv4jn5/X3BVoAhe1YjIuxGN7
        +Ih7bvd7BtJLcLS+PaTsRy3yVa67fyYc9A2jpYSkiYQJx+S2batZv+RGXRz90Vxfyba40R2zVSQm8
        SQgM/Jpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtpdR-0001ld-Ea; Fri, 10 Jul 2020 09:48:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EAD99304E03;
        Fri, 10 Jul 2020 11:48:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7BCF2B5130F2; Fri, 10 Jul 2020 11:48:00 +0200 (CEST)
Date:   Fri, 10 Jul 2020 11:48:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [RFC PATCH 5/7] lazy tlb: introduce lazy mm refcount helper
 functions
Message-ID: <20200710094800.GA4800@hirez.programming.kicks-ass.net>
References: <20200710015646.2020871-1-npiggin@gmail.com>
 <20200710015646.2020871-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710015646.2020871-6-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 10, 2020 at 11:56:44AM +1000, Nicholas Piggin wrote:

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 73199470c265..ad95812d2a3f 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1253,7 +1253,7 @@ void start_secondary(void *unused)
>  	unsigned int cpu = smp_processor_id();
>  	struct cpumask *(*sibling_mask)(int) = cpu_sibling_mask;
>  
> -	mmgrab(&init_mm);
> +	mmgrab(&init_mm); /* XXX: where is the mmput for this? */
>  	current->active_mm = &init_mm;
>  
>  	smp_store_cpu_info(cpu);

Right; so IIRC it should be this one:

> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 134688d79589..ff9fcbc4e76b 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -578,7 +578,7 @@ static int finish_cpu(unsigned int cpu)
>  	 */
>  	if (mm != &init_mm)
>  		idle->active_mm = &init_mm;
> -	mmdrop(mm);
> +	mmdrop_lazy_tlb(mm);
>  	return 0;
>  }

