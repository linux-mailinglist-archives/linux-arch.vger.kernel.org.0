Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06452B1A41
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 12:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKMLqB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 06:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKMLph (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 06:45:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4273C0613D1;
        Fri, 13 Nov 2020 03:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jQU4qNuDdZU27a5ijyKvpcUU0ywYdFHyt7SQu4F9MLo=; b=r4jA8ox3PBkqEzLoXdgbxAa/u1
        M9GVXID7RRadO2bbX1dSPGBrKm+ZYbeUir6yHJ5kVUX09G/8sIaoOJOi/t2lYUXkv4Ih45WIpqZkd
        4HhOAx7bTE8HKhp9dN1n0sVzG20tT4HU/FPiHjFs9Rcx5fBqM1/kYuCxqC8yDkDc9RTcoq4oe8vay
        Tm/UBXI/w2xGCiApjzJzusxm0bDRb+7eMLczjdnxFk3s4WlzppapYQLtSCvwsL0SUeJdnuwAmgi4p
        3nSrC4fNDVH+z3uR6cwMiOSaPMJHfN9QaxLJ9DDl3kZtXEK8+6XJLYFfkcbCcoETdx9GNhbqwbnER
        wNmCBprA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdXVv-0003Al-Op; Fri, 13 Nov 2020 11:45:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5952B306102;
        Fri, 13 Nov 2020 12:45:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44BDC20A2A30E; Fri, 13 Nov 2020 12:45:10 +0100 (CET)
Date:   Fri, 13 Nov 2020 12:45:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com
Cc:     christophe.leroy@csgroup.eu, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org,
        willy@infradead.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 2/5] mm: Introduce pXX_leaf_size()
Message-ID: <20201113114510.GX2611@hirez.programming.kicks-ass.net>
References: <20201113111901.743573013@infradead.org>
 <20201113113426.465239104@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113113426.465239104@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 12:19:03PM +0100, Peter Zijlstra wrote:
> A number of architectures have non-pagetable aligned huge/large pages.
> For such architectures a leaf can actually be part of a larger TLB
> entry.
> 
> Provide generic helpers to determine the TLB size of a page-table
> leaf.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/pgtable.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1536,4 +1536,20 @@ typedef unsigned int pgtbl_mod_mask;
>  #define pmd_leaf(x)	0
>  #endif
>  
> +#ifndef pgd_leaf_size
> +#define pgd_leaf_size(x) PGD_SIZE

Argh, I lost a refresh, that should've been:

+#define pgd_leaf_size(x) (1ULL << PGDIR_SHIFT)


> +#endif
> +#ifndef p4d_leaf_size
> +#define p4d_leaf_size(x) P4D_SIZE
> +#endif
> +#ifndef pud_leaf_size
> +#define pud_leaf_size(x) PUD_SIZE
> +#endif
> +#ifndef pmd_leaf_size
> +#define pmd_leaf_size(x) PMD_SIZE
> +#endif
> +#ifndef pte_leaf_size
> +#define pte_leaf_size(x) PAGE_SIZE
> +#endif
> +
>  #endif /* _LINUX_PGTABLE_H */
> 
> 
