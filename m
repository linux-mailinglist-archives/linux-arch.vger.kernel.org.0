Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AD67105B2
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 08:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjEYGbt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 02:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjEYGbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 02:31:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40124197;
        Wed, 24 May 2023 23:31:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1631E1042;
        Wed, 24 May 2023 23:32:30 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A4C43F762;
        Wed, 24 May 2023 23:31:43 -0700 (PDT)
Message-ID: <11c02123-4fd5-1f70-2791-2c793d45cef2@arm.com>
Date:   Thu, 25 May 2023 12:01:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 32/36] mm: Use flush_icache_pages() in do_set_pmd()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-33-willy@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230315051444.3229621-33-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/15/23 10:44, Matthew Wilcox (Oracle) wrote:
> Push the iteration over each page down to the architectures (many
> can flush the entire THP without iteration).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/memory.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c5f1bf906d0c..6aa21e8f3753 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4209,7 +4209,6 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>  	pmd_t entry;
> -	int i;
>  	vm_fault_t ret = VM_FAULT_FALLBACK;
>  
>  	if (!transhuge_vma_suitable(vma, haddr))
> @@ -4242,8 +4241,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	if (unlikely(!pmd_none(*vmf->pmd)))
>  		goto out;
>  
> -	for (i = 0; i < HPAGE_PMD_NR; i++)
> -		flush_icache_page(vma, page + i);
> +	flush_icache_pages(vma, page, HPAGE_PMD_NR);
>  
>  	entry = mk_huge_pmd(page, vma->vm_page_prot);
>  	if (write)
