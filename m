Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF71522773
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 01:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiEJXRq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 May 2022 19:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiEJXRp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2022 19:17:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3DC8CCF2;
        Tue, 10 May 2022 16:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47683B82019;
        Tue, 10 May 2022 23:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7FBC385D2;
        Tue, 10 May 2022 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652224661;
        bh=wNlnS0BAIcet/uV/acjIEyC1wJRqQktblKtGbHbJyzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X5KSmq8YJHrtreTrC2tpneJDDbMcaQohzE4+3wIEkbYk/2tm8uYP1ENrzLuzWeaQV
         O2pZL3OTQVnPa/9P/ZAHf7RzreY00Pyn71EBZXzNYrwCFqOtM+kURoCKeua+qPVQcb
         0zztX2CBZrN7N9asxGgQ6o8DklzY5th9OydWHzHw=
Date:   Tue, 10 May 2022 16:17:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, catalin.marinas@arm.com, will@kernel.org,
        songmuchun@bytedance.com, tsbogend@alpha.franken.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.osdn.me, dalias@libc.org, davem@davemloft.net,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue
 when migration
Message-Id: <20220510161739.fdea4d78dde8471033aab22b@linux-foundation.org>
In-Reply-To: <ea5abf529f0997b5430961012bfda6166c1efc8c.1652147571.git.baolin.wang@linux.alibaba.com>
References: <cover.1652147571.git.baolin.wang@linux.alibaba.com>
        <ea5abf529f0997b5430961012bfda6166c1efc8c.1652147571.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 10 May 2022 11:45:59 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb:
> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
> size specified.
> 
> When migrating a hugetlb page, we will get the relevant page table
> entry by huge_pte_offset() only once to nuke it and remap it with
> a migration pte entry. This is correct for PMD or PUD size hugetlb,
> since they always contain only one pmd entry or pud entry in the
> page table.
> 
> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
> since they can contain several continuous pte or pmd entry with
> same page table attributes. So we will nuke or remap only one pte
> or pmd entry for this CONT-PTE/PMD size hugetlb page, which is
> not expected for hugetlb migration. The problem is we can still
> continue to modify the subpages' data of a hugetlb page during
> migrating a hugetlb page, which can cause a serious data consistent
> issue, since we did not nuke the page table entry and set a
> migration pte for the subpages of a hugetlb page.
> 
> To fix this issue, we should change to use huge_ptep_clear_flush()
> to nuke a hugetlb page table, and remap it with set_huge_pte_at()
> and set_huge_swap_pte_at() when migrating a hugetlb page, which
> already considered the CONT-PTE or CONT-PMD size hugetlb.
> 
> ...
>
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1093,6 +1093,17 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
>  					pte_t *ptep, pte_t pte, unsigned long sz)
>  {
>  }
> +
> +static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> +					  unsigned long addr, pte_t *ptep)
> +{
> +	return ptep_get(ptep);
> +}
> +
> +static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> +				   pte_t *ptep, pte_t pte)
> +{
> +}
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  

This blows up nommu (arm allnoconfig):

In file included from fs/io_uring.c:71:
./include/linux/hugetlb.h: In function 'huge_ptep_clear_flush':
./include/linux/hugetlb.h:1100:16: error: implicit declaration of function 'ptep_get' [-Werror=implicit-function-declaration]
 1100 |         return ptep_get(ptep);
      |                ^~~~~~~~


huge_ptep_clear_flush() is only used in CONFIG_NOMMU=n files, so I simply
zapped this change.

--- a/include/linux/hugetlb.h~mm-rmap-fix-cont-pte-pmd-size-hugetlb-issue-when-migration-fix
+++ a/include/linux/hugetlb.h
@@ -1093,17 +1093,6 @@ static inline void set_huge_swap_pte_at(
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
 }
-
-static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-					  unsigned long addr, pte_t *ptep)
-{
-	return ptep_get(ptep);
-}
-
-static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-				   pte_t *ptep, pte_t pte)
-{
-}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
_

