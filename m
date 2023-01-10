Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87462663B2B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 09:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjAJIeF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 03:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjAJIeE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 03:34:04 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0B49151;
        Tue, 10 Jan 2023 00:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t0g8sAMw0YuigClEe8J6Of8uYBawzqc1qw15eQtTooo=; b=KEFepgJrWEeL9uBmLyGXAalt+U
        Jm4LcNJKx5mAdHe57CNNrg4oj1j9hd1AqdvItVQRtm35W5v6TQ/B49MYBUcKX83cd2sxykixLdens
        8jhJ8pzVNn91Rh2XPC1hSMP2uABFLZcrCe9GEh3q+8P0+2R2OqKSgyLcJbPq5hPwGINuqzl71a4mI
        X49DYcRt1ylSGtFdZpTLwoGxLb+KGoauNXiPa7vOZzBtgrkEDDjGRG1Vi2GA2BML1dLqBevRADk+9
        MlCuhRDzSLaHRh2zyvNm/Ijuu/qQxDjQLZ7ToLhyEqv2J3dVAwzQy5ULTGGQgSERvvbnfS0KVpfj9
        a0WPVTmA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFA3w-0033Qg-1y;
        Tue, 10 Jan 2023 08:32:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BE59300033;
        Tue, 10 Jan 2023 09:32:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF2782C4AA552; Tue, 10 Jan 2023 09:32:55 +0100 (CET)
Date:   Tue, 10 Jan 2023 09:32:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 08/12] s390: Replace cmpxchg_double() with
 cmpxchg128()
Message-ID: <Y70it59wuvsnKJK1@hirez.programming.kicks-ass.net>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.352918965@infradead.org>
 <Y70SWXHDmOc3RhMd@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y70SWXHDmOc3RhMd@osiris>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 10, 2023 at 08:23:05AM +0100, Heiko Carstens wrote:

> So, Alexander Gordeev reported that this code was already prior to your
> changes potentially broken with respect to missing READ_ONCE() within the
> cmpxchg_double() loops.

Unless there's an early exit, that shouldn't matter. If you managed to
read garbage the cmpxchg itself will simply fail and the loop retries.

> @@ -1294,12 +1306,16 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
>  		num_sdb++;
>  
>  		/* Reset trailer (using compare-double-and-swap) */
> +		/* READ_ONCE() 16 byte header */
> +		prev.val = __cdsg(&te->header.val, 0, 0);
>  		do {
> +			old.val = prev.val;
> +			new.val = prev.val;
> +			new.f = 0;
> +			new.a = 1;
> +			new.overflow = 0;
> +			prev.val = __cdsg(&te->header.val, old.val, new.val);
> +		} while (prev.val != old.val);

So this, and

> +		/* READ_ONCE() 16 byte header */
> +		prev.val = __cdsg(&te->header.val, 0, 0);
>  		do {
> +			old.val = prev.val;
> +			new.val = prev.val;
> +			orig_overflow = old.overflow;
> +			new.f = 0;
> +			new.overflow = 0;
>  			if (idx == aux->alert_mark)
> +				new.a = 1;
>  			else
> +				new.a = 0;
> +			prev.val = __cdsg(&te->header.val, old.val, new.val);
> +		} while (prev.val != old.val);

this case are just silly and expensive. If that initial read is split
and manages to read gibberish the cmpxchg will fail and we retry anyway.

> +	/* READ_ONCE() 16 byte header */
> +	prev.val = __cdsg(&te->header.val, 0, 0);
>  	do {
> +		old.val = prev.val;
> +		new.val = prev.val;
> +		*overflow = old.overflow;
> +		if (old.f) {
>  			/*
>  			 * SDB is already set by hardware.
>  			 * Abort and try to set somewhere
> @@ -1490,10 +1509,10 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
>  			 */
>  			return false;
>  		}
> +		new.a = 1;
> +		new.overflow = 0;
> +		prev.val = __cdsg(&te->header.val, old.val, new.val);
> +	} while (prev.val != old.val);


And while this case has an early exit, it only cares about a single bit
(although you made it a full word) and so also shouldn't care. If
aux_reset_buffer() returns false, @overflow isn't consumed.


So I really don't see the point of this patch.
