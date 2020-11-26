Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE22C5426
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 13:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbgKZMnS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 07:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388830AbgKZMnR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 07:43:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21071C0613D4;
        Thu, 26 Nov 2020 04:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pKrVE6zc93OJidYtg1Tk9er7IwVij5WnKymKVH0c11Q=; b=uXlIz/AQnWJAQb4mo0zqSPytQ8
        vUTXGCBIXQ16FUEJwIMrVwDiBzgydT1m9RDRWQG3B0NtirV7NVnEl0e1Ch31ezy2p06H86ZPKkB6J
        a7zH6Zms20X9hCDkGFYWkJQP1F8Ls12a05q/JFw2XdWYOgj/OZFZK1zhUjjf7xKxaJY5BpGndDpZA
        kbGOlwFW2CshbkwE2A0IZVxSC7BWP3w1oMevIvlQZNc0Qk1jvlQP/JaOStF/HzR2qh1SJW/250oN4
        Z2nEL8rnjudJnPwfqk4fwpWf1uVBXa0wNQZPvZTg+fc8yVhX9GNITXZWyI4kDj5mFEYpcCCfeuXEo
        yXq5dRdg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGc0-0002SI-Ra; Thu, 26 Nov 2020 12:43:00 +0000
Date:   Thu, 26 Nov 2020 12:43:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 1/6] mm/gup: Provide gup_get_pte() more generic
Message-ID: <20201126124300.GP4327@casper.infradead.org>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.036370527@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126121121.036370527@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 26, 2020 at 01:01:15PM +0100, Peter Zijlstra wrote:
> +#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
> +/*
> + * WARNING: only to be used in the get_user_pages_fast() implementation.
> + * With get_user_pages_fast(), we walk down the pagetables without taking any
> + * locks.  For this we would like to load the pointers atomically, but sometimes
> + * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
> + * we do have is the guarantee that a PTE will only either go from not present
> + * to present, or present to not present or both -- it will not switch to a
> + * completely different present page without a TLB flush in between; something
> + * that we are blocking by holding interrupts off.

I feel like this comment needs some love.  How about:

 * For walking the pagetables without holding any locks.  Some architectures
 * (eg x86-32 PAE) cannot load the entries atomically without using
 * expensive instructions.  We are guaranteed that a PTE will only either go
 * from not present to present, or present to not present -- it will not
 * switch to a completely different present page without a TLB flush
 * inbetween; which we are blocking by holding interrupts off.

And it would be nice to have an assertion that interrupts are disabled
in the code.  Because comments are nice, but nobody reads them.

> +static inline pte_t ptep_get_lockless(pte_t *ptep)
> +{
> +	pte_t pte;
> +
> +	do {
> +		pte.pte_low = ptep->pte_low;
> +		smp_rmb();
> +		pte.pte_high = ptep->pte_high;
> +		smp_rmb();
> +	} while (unlikely(pte.pte_low != ptep->pte_low));
> +
> +	return pte;
> +}
