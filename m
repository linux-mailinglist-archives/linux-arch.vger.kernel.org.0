Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90C651EE88
	for <lists+linux-arch@lfdr.de>; Sun,  8 May 2022 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiEHPaR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 May 2022 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiEHPaP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 May 2022 11:30:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C0CBBE
        for <linux-arch@vger.kernel.org>; Sun,  8 May 2022 08:26:25 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v11so10265470pff.6
        for <linux-arch@vger.kernel.org>; Sun, 08 May 2022 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wlb5sCv0vT9DKd6Y0pxChn3TRESHpDGd2RiWXJbPiOA=;
        b=A8uBy/esNOEbUqh4vOntGYm1YMVp8KTDNwiHyleMxFUxETUvcSv6DZ39zZIcwk5yYw
         86UrDKPKDKAZMR7dwUoHWD+jUB4gtgw1yCKhEiU7ARnW49msAlzrKSzQ8vYFlTYpNIt4
         hQLknIHiDmcV0B5wHAtIxy+UOOM5eEY20zDhI9WMiJaDrUjdvDVuVJ7iiy5qzG1y47jV
         5gEm227YJe0hvNojSjOoSAN3C1iYnEXrtZFcNuKVuuM/p8p/52As0MlF3Mk2EzYn6wr/
         J7bXPbCej7CVuXF4I6IX7/Rq1hiMYtnD6AFcfLgLxgY9EZUeI+It1LKO31oPmsw6uMey
         wxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wlb5sCv0vT9DKd6Y0pxChn3TRESHpDGd2RiWXJbPiOA=;
        b=arGJBbZ2xv8zXB/f4kAp5HsbQ9Y+WOPFGQp3CzJNb7sp6TSQ023olJnHj2B90tHzt1
         O82Quj9rVVUN1NTEB4glSybpBjYGM5T1sy9s0I4txU1AAeOoYOQEhBtwvEy28reyqA51
         G/w93fHiQ7xoyvqHEHT3Ed0wsC3EBujtT7YLbKOZnDvexxtF/1UZB3Mxqj6T38swY8YC
         jvkdzVOFkUyZ6slQj/q1UCb25tMa0JvaU+VJlLRW1DuM5Rbrt75ljtDBpzCfcExmYA5h
         FxMeg4IF8MKs/PRm0/k6uMWLjthjblmYJFs9IqJgoOCpAkuhmua23UEv27csuJne6vXA
         ONSA==
X-Gm-Message-State: AOAM533FQTFtNyS1idBnq2GBpJpXQoAIOrRHLj7UpujULiUBuUg5IPFd
        ljzjhhCDspGciuP9tkJTxgQBBg==
X-Google-Smtp-Source: ABdhPJwrAUBJu+P2n6cQJedLTi8BGUZ973hWDTaS8Y3nr73sK+kVeWZgWILLCvpX1mBPKLFMAkg+uw==
X-Received: by 2002:aa7:9d0d:0:b0:50d:4fcc:7cb1 with SMTP id k13-20020aa79d0d000000b0050d4fcc7cb1mr11948987pfp.41.1652023584948;
        Sun, 08 May 2022 08:26:24 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id a19-20020a170902b59300b0015e8d4eb229sm5253221pls.115.2022.05.08.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 08:26:24 -0700 (PDT)
Date:   Sun, 8 May 2022 23:26:21 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        mike.kravetz@oracle.com, akpm@linux-foundation.org, sj@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/3] Introduce new huge_ptep_get_access_flags()
 interface
Message-ID: <YnfhHejDgjgyqEcb@FVFYT0MHHV2J.usts.net>
References: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 08, 2022 at 04:58:51PM +0800, Baolin Wang wrote:
> Hi,
> 
> As Mike pointed out [1], the huge_ptep_get() will only return one specific
> pte value for the CONT-PTE or CONT-PMD size hugetlb on ARM64 system, which
> will not take into account the subpages' dirty or young bits of a CONT-PTE/PMD
> size hugetlb page. That will make us miss dirty or young flags of a CONT-PTE/PMD
> size hugetlb page for those functions that want to check the dirty or
> young flags of a hugetlb page. For example, the gather_hugetlb_stats() will
> get inaccurate dirty hugetlb page statistics, and the DAMON for hugetlb monitoring
> will also get inaccurate access statistics.
> 
> To fix this issue, one approach is that we can define an ARM64 specific huge_ptep_get()
> implementation, which will take into account any subpages' dirty or young bits.

IIUC, we could get the page size by page_size(pte_page(pte)).
So, how about the following implementation of huge_ptep_get()?
Does this work for you?

pte_t huge_ptep_get(pte_t *ptep)
{
	int ncontig, i;
	size_t pgsize;
	pte_t orig_pte = ptep_get(ptep);

	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
		return orig_pte;

	ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);

	for (i = 0; i < ncontig; i++, ptep++) {
		pte_t pte = ptep_get(ptep);

		if (pte_dirty(pte))
			orig_pte = pte_mkdirty(orig_pte);

		if (pte_young(pte))
			orig_pte = pte_mkyoung(orig_pte);
	}

	return orig_pte;
}

> However we should add a new parameter for ARM64 specific huge_ptep_get() to check
> how many continuous PTEs or PMDs in this CONT-PTE/PMD size hugetlb, that means we
> should convert all the places using huge_ptep_get(), meanwhile most places using
> huge_ptep_get() did not care about the dirty or young flags at all.
> 
> So instead of changing the prototype of huge_ptep_get(), this patch set introduces
> a new huge_ptep_get_access_flags() interface and define an ARM64 specific implementation,
> that will take into account any subpages' dirty or young bits for CONT-PTE/PMD size
> hugetlb page. And we can only change to use huge_ptep_get_access_flags() for those
> functions that care about the dirty or young flags of a hugetlb page.
> 
> [1] https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com/
> 
> Baolin Wang (3):
>   arm64/hugetlb: Introduce new huge_ptep_get_access_flags() interface
>   fs/proc/task_mmu: Change to use huge_ptep_get_access_flags()
>   mm/damon/vaddr: Change to use huge_ptep_get_access_flags()
> 
>  arch/arm64/include/asm/hugetlb.h |  2 ++
>  arch/arm64/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
>  fs/proc/task_mmu.c               |  3 ++-
>  include/asm-generic/hugetlb.h    |  7 +++++++
>  mm/damon/vaddr.c                 |  5 +++--
>  5 files changed, 38 insertions(+), 3 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 
