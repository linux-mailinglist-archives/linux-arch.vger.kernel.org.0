Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F52B1242E3
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2019 10:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLRJTO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Dec 2019 04:19:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfLRJTO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Dec 2019 04:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QZGedylInCJfPCSf+kcRbP2/TdXT8x3ydBMR01xASqw=; b=OvGwwzXGyysGvPaaFYdQ0Dbfy
        raigUNsjkQYZ8tEmisXy2dBiU0NbvOG4c+s5sDXMgIy77YCnBMMaaJ7niNp1onJd1/Jmr51xOhWSh
        hTTlK4y+ZJqbdDUV2Wrcdqdo4376uXvgpixZXZZ0nKOJ6Os7x550zA8zk9yGlVoictxEWgyah5dxr
        norSBBfveOHywfnvsoPOfmbLaxPbX9ZpKrJt9E2FkmxRFuIagQsO0XEw+uiJQJ04CC5FNfPJduvLy
        FFiUk7IpB0vvMDOEErkRLu4NGZnr2+0yJRXodJEoPPR+bj8iuydqZvD9h7U56dR3JYgdWqunm4h24
        o3FYgNDWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihVU4-0004tc-BE; Wed, 18 Dec 2019 09:19:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1B7A304C1B;
        Wed, 18 Dec 2019 10:17:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C901D2B3E30F8; Wed, 18 Dec 2019 10:19:06 +0100 (CET)
Date:   Wed, 18 Dec 2019 10:19:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 3/3] asm-generic/tlb: Avoid potential double flush
Message-ID: <20191218091906.GP2844@hirez.programming.kicks-ass.net>
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
 <20191218053530.73053-3-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218053530.73053-3-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 18, 2019 at 11:05:30AM +0530, Aneesh Kumar K.V wrote:

> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -402,7 +402,12 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
>  
>  static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  {
> -	if (!tlb->end)
> +	/*
> +	 * Anything calling __tlb_adjust_range() also sets at least one of
> +	 * these bits.
> +	 */
> +	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
> +	      tlb->cleared_puds || tlb->cleared_p4ds))
>  		return;

FWIW I looked at the GCC generated assembly output for this (x86_64) and
it did a single load and mask as expected.
